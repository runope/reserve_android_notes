/*
 * Copyright (C) 2008 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

 /*
  * Access .dex (Dalvik Executable Format) files.  The code here assumes that
  * the DEX file has been rewritten (byte-swapped, word-aligned) and that
  * the contents can be directly accessed as a collection of C arrays.  Please
  * see docs/dalvik/dex-format.html for a detailed description.
  *
  * The structure and field names were chosen to match those in the DEX spec.
  *
  * It's generally assumed that the DEX file will be stored in shared memory,
  * obviating the need to copy code and constant pool entries into newly
  * allocated storage.  Maintaining local pointers to items in the shared area
  * is valid and encouraged.
  *
  * All memory-mapped structures are 32-bit aligned unless otherwise noted.
  */

#ifndef LIBDEX_DEXFILE_H_
#define LIBDEX_DEXFILE_H_

#ifndef LOG_TAG
# define LOG_TAG "libdex"
#endif

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <assert.h>

  /*
   * If "very verbose" logging is enabled, make it equivalent to ALOGV.
   * Otherwise, make it disappear.
   *
   * Define this above the #include "Dalvik.h" to enable for only a
   * single file.
   */
   /* #define VERY_VERBOSE_LOG */
#if defined(VERY_VERBOSE_LOG)
# define LOGVV      ALOGV
# define IF_LOGVV() IF_ALOGV()
#else
# define LOGVV(...) ((void)0)
# define IF_LOGVV() if (false)
#endif

/*
 * These match the definitions in the VM specification.
 */
typedef uint8_t             u1;
typedef uint16_t            u2;
typedef uint32_t            u4;
typedef uint64_t            u8;
typedef int8_t              s1;
typedef int16_t             s2;
typedef int32_t             s4;
typedef int64_t             s8;


/*
 * gcc-style inline management -- ensures we have a copy of all functions
 * in the library, so code that links against us will work whether or not
 * it was built with optimizations enabled.
 */
#ifndef _DEX_GEN_INLINES             /* only defined by DexInlines.c */
# define extern __inline__
#else
# define DEX_INLINE
#endif

 /* DEX file magic number */
#define DEX_MAGIC       "dex\n"

/* The version for android N, encoded in 4 bytes of ASCII. This differentiates dex files that may
 * use default methods.
 */
#define DEX_MAGIC_VERS_37  "037\0"

 /* The version for android O, encoded in 4 bytes of ASCII. This differentiates dex files that may
  * contain invoke-custom, invoke-polymorphic, call-sites, and method handles.
  */
#define DEX_MAGIC_VERS_38  "038\0"

  /* The version for android P, encoded in 4 bytes of ASCII. This differentiates dex files that may
   * contain const-method-handle and const-proto.
   */
#define DEX_MAGIC_VERS_39  "039\0"

   /* current version, encoded in 4 bytes of ASCII */
#define DEX_MAGIC_VERS  "036\0"

/*
 * older but still-recognized version (corresponding to Android API
 * levels 13 and earlier
 */
#define DEX_MAGIC_VERS_API_13  "035\0"

 /* same, but for optimized DEX header */
#define DEX_OPT_MAGIC   "dey\n"
#define DEX_OPT_MAGIC_VERS  "036\0"

#define DEX_DEP_MAGIC   "deps"

/*
 * 160-bit SHA-1 digest.
 */
enum {
	kSHA1DigestLen = 20,
	kSHA1DigestOutputLen = kSHA1DigestLen * 2 + 1
};

/* general constants */
enum {
	kDexEndianConstant = 0x12345678,    /* the endianness indicator */
	kDexNoIndex = 0xffffffff,           /* not a valid index value */
};

/*
 * Enumeration of all the primitive types.
 */
enum PrimitiveType {
	PRIM_NOT = 0,       /* value is a reference type, not a primitive type */
	PRIM_VOID = 1,
	PRIM_BOOLEAN = 2,
	PRIM_BYTE = 3,
	PRIM_SHORT = 4,
	PRIM_CHAR = 5,
	PRIM_INT = 6,
	PRIM_LONG = 7,
	PRIM_FLOAT = 8,
	PRIM_DOUBLE = 9,
};

/*
 * access flags and masks; the "standard" ones are all <= 0x4000
 *
 * Note: There are related declarations in vm/oo/Object.h in the ClassFlags
 * enum.
 */
enum {
	ACC_PUBLIC = 0x00000001,       // class, field, method, ic
	ACC_PRIVATE = 0x00000002,       // field, method, ic
	ACC_PROTECTED = 0x00000004,       // field, method, ic
	ACC_STATIC = 0x00000008,       // field, method, ic
	ACC_FINAL = 0x00000010,       // class, field, method, ic
	ACC_SYNCHRONIZED = 0x00000020,       // method (only allowed on natives)
	ACC_SUPER = 0x00000020,       // class (not used in Dalvik)
	ACC_VOLATILE = 0x00000040,       // field
	ACC_BRIDGE = 0x00000040,       // method (1.5)
	ACC_TRANSIENT = 0x00000080,       // field
	ACC_VARARGS = 0x00000080,       // method (1.5)
	ACC_NATIVE = 0x00000100,       // method
	ACC_INTERFACE = 0x00000200,       // class, ic
	ACC_ABSTRACT = 0x00000400,       // class, method, ic
	ACC_STRICT = 0x00000800,       // method
	ACC_SYNTHETIC = 0x00001000,       // field, method, ic
	ACC_ANNOTATION = 0x00002000,       // class, ic (1.5)
	ACC_ENUM = 0x00004000,       // class, field, ic (1.5)
	ACC_CONSTRUCTOR = 0x00010000,       // method (Dalvik only)
	ACC_DECLARED_SYNCHRONIZED =
	0x00020000,       // method (Dalvik only)
	ACC_CLASS_MASK =
	(ACC_PUBLIC | ACC_FINAL | ACC_INTERFACE | ACC_ABSTRACT
		| ACC_SYNTHETIC | ACC_ANNOTATION | ACC_ENUM),
	ACC_INNER_CLASS_MASK =
	(ACC_CLASS_MASK | ACC_PRIVATE | ACC_PROTECTED | ACC_STATIC),
	ACC_FIELD_MASK =
	(ACC_PUBLIC | ACC_PRIVATE | ACC_PROTECTED | ACC_STATIC | ACC_FINAL
		| ACC_VOLATILE | ACC_TRANSIENT | ACC_SYNTHETIC | ACC_ENUM),
	ACC_METHOD_MASK =
	(ACC_PUBLIC | ACC_PRIVATE | ACC_PROTECTED | ACC_STATIC | ACC_FINAL
		| ACC_SYNCHRONIZED | ACC_BRIDGE | ACC_VARARGS | ACC_NATIVE
		| ACC_ABSTRACT | ACC_STRICT | ACC_SYNTHETIC | ACC_CONSTRUCTOR
		| ACC_DECLARED_SYNCHRONIZED),
};

/* annotation constants */
enum {
	kDexVisibilityBuild = 0x00,     /* annotation visibility */
	kDexVisibilityRuntime = 0x01,
	kDexVisibilitySystem = 0x02,

	kDexAnnotationByte = 0x00,
	kDexAnnotationShort = 0x02,
	kDexAnnotationChar = 0x03,
	kDexAnnotationInt = 0x04,
	kDexAnnotationLong = 0x06,
	kDexAnnotationFloat = 0x10,
	kDexAnnotationDouble = 0x11,
	kDexAnnotationMethodType = 0x15,
	kDexAnnotationMethodHandle = 0x16,
	kDexAnnotationString = 0x17,
	kDexAnnotationType = 0x18,
	kDexAnnotationField = 0x19,
	kDexAnnotationMethod = 0x1a,
	kDexAnnotationEnum = 0x1b,
	kDexAnnotationArray = 0x1c,
	kDexAnnotationAnnotation = 0x1d,
	kDexAnnotationNull = 0x1e,
	kDexAnnotationBoolean = 0x1f,

	kDexAnnotationValueTypeMask = 0x1f,     /* low 5 bits */
	kDexAnnotationValueArgShift = 5,
};

/* map item type codes */
enum {
	kDexTypeHeaderItem = 0x0000,
	kDexTypeStringIdItem = 0x0001,
	kDexTypeTypeIdItem = 0x0002,
	kDexTypeProtoIdItem = 0x0003,
	kDexTypeFieldIdItem = 0x0004,
	kDexTypeMethodIdItem = 0x0005,
	kDexTypeClassDefItem = 0x0006,
	kDexTypeCallSiteIdItem = 0x0007,
	kDexTypeMethodHandleItem = 0x0008,
	kDexTypeMapList = 0x1000,
	kDexTypeTypeList = 0x1001,
	kDexTypeAnnotationSetRefList = 0x1002,
	kDexTypeAnnotationSetItem = 0x1003,
	kDexTypeClassDataItem = 0x2000,
	kDexTypeCodeItem = 0x2001,
	kDexTypeStringDataItem = 0x2002,
	kDexTypeDebugInfoItem = 0x2003,
	kDexTypeAnnotationItem = 0x2004,
	kDexTypeEncodedArrayItem = 0x2005,
	kDexTypeAnnotationsDirectoryItem = 0x2006,
};

/* auxillary data section chunk codes */
enum {
	kDexChunkClassLookup = 0x434c4b50,   /* CLKP */
	kDexChunkRegisterMaps = 0x524d4150,   /* RMAP */

	kDexChunkEnd = 0x41454e44,   /* AEND */
};

/* debug info opcodes and constants */
enum {
	DBG_END_SEQUENCE = 0x00,
	DBG_ADVANCE_PC = 0x01,
	DBG_ADVANCE_LINE = 0x02,
	DBG_START_LOCAL = 0x03,
	DBG_START_LOCAL_EXTENDED = 0x04,
	DBG_END_LOCAL = 0x05,
	DBG_RESTART_LOCAL = 0x06,
	DBG_SET_PROLOGUE_END = 0x07,
	DBG_SET_EPILOGUE_BEGIN = 0x08,
	DBG_SET_FILE = 0x09,
	DBG_FIRST_SPECIAL = 0x0a,
	DBG_LINE_BASE = -4,
	DBG_LINE_RANGE = 15,
};

/*
 * Direct-mapped "header_item" struct.
 */
struct DexHeader {
	u1  magic[8];       //ȡֵ�������ַ��� "dex\n035\0" �����ֽ�byte���� {0x64 0x65 0x78 0x0a 0x30 0x33 0x35 0x00}
	u4  checksum;       //�ļ����ݵ�У���,������magic���Լ�,��Ҫ���ڼ���ļ��Ƿ���
	u1  signature[kSHA1DigestLen];      //ǩ����Ϣ,������ magic\checksum���Լ�
	u4  fileSize;       //�����ļ��ĳ���,��λΪ�ֽ�,�������е�����
	u4  headerSize;     //Ĭ����0x70���ֽ�
	u4  endianTag;      //��С�˱�ǩ����׼.dex�ļ�ΪС�ˣ�����һ��̶�Ϊ0x12345678����
	u4  linkSize;       //�������ݵĴ�С
	u4  linkOff;        //�������ݵ�ƫ��ֵ
	u4  mapOff;         //map item��ƫ�Ƶ�ַ����item����data��������ݣ�ֵҪ���ڵ���dataOff�Ĵ�С
	u4  stringIdsSize;      //DEX���õ��������ַ������ݵĴ�С*
	u4  stringIdsOff;       //DEX���õ��������ַ������ݵ�ƫ����
	u4  typeIdsSize;        //DEX���������ݽṹ�Ĵ�С
	u4  typeIdsOff;         //DEX���������ݽṹ��ƫ��ֵ
	u4  protoIdsSize;       //DEX�е�Ԫ������Ϣ���ݽṹ�Ĵ�С
	u4  protoIdsOff;        //DEX�е�Ԫ������Ϣ���ݽṹ��ƫ��ֵ
	u4  fieldIdsSize;       //DEX���ֶ���Ϣ���ݽṹ�Ĵ�С
	u4  fieldIdsOff;        //DEX���ֶ���Ϣ���ݽṹ��ƫ��ֵ
	u4  methodIdsSize;      //DEX�з�����Ϣ���ݽṹ�Ĵ�С
	u4  methodIdsOff;       //DEX�з�����Ϣ���ݽṹ��ƫ��ֵ
	u4  classDefsSize;      //DEX�е�����Ϣ���ݽṹ�Ĵ�С
	u4  classDefsOff;       //DEX�е�����Ϣ���ݽṹ��ƫ��ֵ
	u4  dataSize;           //DEX����������Ľṹ��Ϣ�Ĵ�С
	u4  dataOff;            //DEX����������Ľṹ��Ϣ��ƫ��ֵ
};

/*
 * Direct-mapped "map_item".
 */
struct DexMapItem {
	u2 type;              /* type code (see kDexType* above) */
	u2 unused;
	u4 size;              /* count of items of the indicated type */
	u4 offset;            /* file offset to the start of data */
};

/*
 * Direct-mapped "map_list".
 */
struct DexMapList {
	u4  size;               /* #of entries in list */
	DexMapItem list[1];     /* entries */
};

/*
 * Direct-mapped "string_id_item".
 */
struct DexStringId {
	//����ָ�� string_data_item λ���ļ���λ��
	u4 stringDataOff;      /* file offset to string_data_item */
};

/*
 * Direct-mapped "type_id_item".
 */
struct DexTypeId {
	u4  descriptorIdx;      /* ָ��string_ids������ */
};

/*
 * Direct-mapped "field_id_item".
 */
struct DexFieldId {
	u2  classIdx;           /* field������class���ͣ�class_idx��ֵʱtype_ids��һ��index��ָ���������� */
	u2  typeIdx;            /* field�����ͣ�ֵ��type_ids��һ��index */
	u4  nameIdx;            /* field�����ƣ�����ֵ��string_ids��һ��index */
};

/*
 * Direct-mapped "method_id_item".
 */
struct DexMethodId {
	u2  classIdx;           /* method������class���ͣ�class_idx��ֵ��type_ids��һ��index������ָ��һ��class���� */
	u2  protoIdx;           /* method��ԭ�ͣ�ָ��proto_ids��һ��index */
	u4  nameIdx;            /* method�����ƣ�ֵΪstring_ids��һ��index */
};

/*
 * Direct-mapped "proto_id_item".
 */
struct DexProtoId {
	u4  shortyIdx;          /* ֵΪһ��string_ids��index�ţ�����˵����methodԭ�� */
	u4  returnTypeIdx;      /* ֵΪһ��type_ids��index����ʾ��methodԭ�͵ķ���ֵ���� */
	u4  parametersOff;      /* ָ��methodԭ�͵Ĳ����б�type_list����methodû�в�������ֵΪ0. �����ĸ�ʽ��type_list */
};

/*
 * Direct-mapped "class_def_item".
 */
struct DexClassDef {
	u4  classIdx;           /* ���������class���ͣ�ֵ��type_ids��һ��index��ֵ������һ��class���ͣ�������������߻������� */
	u4  accessFlags;        /* ����class�ķ������ͣ���public,final,static�� */
	u4  superclassIdx;      /* ������������ͣ�ֵ������һ��class���ͣ��������������˹����߻������� */
	u4  interfacesOff;      /* ֵΪƫ�Ƶ�ַ����ָ������ݽṹΪtype_list��class��û��interfaces��ֵΪ0 */
	u4  sourceFileIdx;      /* ��ʾԴ�����ļ�����Ϣ��ֵΪstring_ids��һ��index����������Ϣ��ʧ�����ֵΪNO_INDEX=0xFFFFFFFF */
	u4  annotationsOff;     /* ֵΪƫ�Ƶ�ַ��ָ��������Ǹ�class��ע�⣬λ����data������ʽΪannotations_directory_item����û�д��ֵΪ0 */
	u4  classDataOff;       /* ֵΪƫ�Ƶ�ַ��ָ��������Ǹ�class��ʹ�õ������ݣ�λ����data������ʽΪclass_data_item����żû�д����ֵΪ0 */
	u4  staticValuesOff;    /* ֵΪƫ�Ƶ�ַ��ָ��data�����һ���б���ʽΪencoded_array_item����û�д��ֵΪ0. */
};

/*
 * Direct-mapped "call_site_id_item"
 */
struct DexCallSiteId {
	u4  callSiteOff;        /* file offset to DexEncodedArray */
};

/*
 * Enumeration of method handle type codes.
 */
enum MethodHandleType {
	STATIC_PUT = 0x00,
	STATIC_GET = 0x01,
	INSTANCE_PUT = 0x02,
	INSTANCE_GET = 0x03,
	INVOKE_STATIC = 0x04,
	INVOKE_INSTANCE = 0x05,
	INVOKE_CONSTRUCTOR = 0x06,
	INVOKE_DIRECT = 0x07,
	INVOKE_INTERFACE = 0x08
};

/*
 * Direct-mapped "method_handle_item"
 */
struct DexMethodHandleItem {
	u2 methodHandleType;    /* type of method handle */
	u2 reserved1;           /* reserved for future use */
	u2 fieldOrMethodIdx;    /* index of associated field or method */
	u2 reserved2;           /* reserved for future use */
};

/*
 * Direct-mapped "type_item".
 */
struct DexTypeItem {
	u2  typeIdx;            /* index into typeIds */
};

/*
 * Direct-mapped "type_list".
 */
struct DexTypeList {
	u4  size;               /* #of entries in list */
	DexTypeItem list[1];    /* entries */
};

/*
 * ������Ŀ
 *
 *  (1) һ�� .dex �ļ����ֳ��� 9 ���� ��������һ������������class_defs �� ������ .dex �����õ��� class ���Լ������ class ������ ��
 *  (2) class_defs �� �� ������ʵ��class_def_item �ṹ ������ṹ�������� LHello; �ĸ�����Ϣ ���������� ��superclass , access flag��
 *       interface �� ��class_def_item ����һ��Ԫ�� class_data_off , ָ��data �����һ�� class_data_item �ṹ ��
 *       �������� class ʹ�õ��ĸ������� ���Դ��Ժ�Ľṹ������ data���� ��
 *  (3) class_data_item �ṹ ��������ֵ�� class ��ʹ�õ��� static field , instance field , direct_method ���� virtual_method
 *      ����Ŀ������ ������ Hello.dex �� ��ֻ�� 2 �� direct_method , ����� field ��method ����Ŀ��Ϊ 0 ������ direct_method �Ľṹ��
 *      �� encoded_method ����������ϸ����ĳ�� method�� ��
 *  (4) encoded_method �ṹ ������ĳ�� method �� method ���� �� access flags ��һ��ָ�� code_item��ƫ�Ƶ�ַ �������ŵ��Ǹ� method
 *      �ľ���ʵ�� ��
 *  (5) code_item ���ṹ��������ĳ�� method �ľ���ʵ�� ��
 *
 */
struct DexCode {
	u2  registersSize;  /* ���δ���ʹ�õ��ļĴ�����Ŀ */
	u2  insSize;        /* method�����������Ŀ */
	u2  outsSize;       /* ���δ��������������ʱ��Ҫ�Ĳ������� */
	u2  triesSize;      /* try_item�ṹ�ĸ��� */
	u4  debugInfoOff;       /* ƫ�Ƶ�ַ��ָ�򱾶δ����debug��Ϣ���λ�ã���һ��debug_info_item�ṹ */
	u4  insnsSize;          /* ָ���б�Ĵ�С����16-bitΪ��λ��insns��instructions����д */
	u2  insns[1];           /*  insns���� */
	/* followed by optional u2 padding */
	/* followed by try_item[triesSize] */
	/* followed by uleb128 handlersSize */
	/* followed by catch_handler_item[handlersSize] */
};

/*
 * Direct-mapped "try_item".
 */
struct DexTry {
	u4  startAddr;          /* start address, in 16-bit code units */
	u2  insnCount;          /* instruction count, in 16-bit code units */
	u2  handlerOff;         /* offset in encoded handler data to handlers */
};

/*
 * Link table.  Currently undefined.
 */
struct DexLink {
	u1  bleargh;
};


/*
 * Direct-mapped "annotations_directory_item".
 */
struct DexAnnotationsDirectoryItem {
	u4  classAnnotationsOff;  /* offset to DexAnnotationSetItem */
	u4  fieldsSize;           /* count of DexFieldAnnotationsItem */
	u4  methodsSize;          /* count of DexMethodAnnotationsItem */
	u4  parametersSize;       /* count of DexParameterAnnotationsItem */
	/* followed by DexFieldAnnotationsItem[fieldsSize] */
	/* followed by DexMethodAnnotationsItem[methodsSize] */
	/* followed by DexParameterAnnotationsItem[parametersSize] */
};

/*
 * Direct-mapped "field_annotations_item".
 */
struct DexFieldAnnotationsItem {
	u4  fieldIdx;
	u4  annotationsOff;             /* offset to DexAnnotationSetItem */
};

/*
 * Direct-mapped "method_annotations_item".
 */
struct DexMethodAnnotationsItem {
	u4  methodIdx;
	u4  annotationsOff;             /* offset to DexAnnotationSetItem */
};

/*
 * Direct-mapped "parameter_annotations_item".
 */
struct DexParameterAnnotationsItem {
	u4  methodIdx;
	u4  annotationsOff;             /* offset to DexAnotationSetRefList */
};

/*
 * Direct-mapped "annotation_set_ref_item".
 */
struct DexAnnotationSetRefItem {
	u4  annotationsOff;             /* offset to DexAnnotationSetItem */
};

/*
 * Direct-mapped "annotation_set_ref_list".
 */
struct DexAnnotationSetRefList {
	u4  size;
	DexAnnotationSetRefItem list[1];
};

/*
 * Direct-mapped "annotation_set_item".
 */
struct DexAnnotationSetItem {
	u4  size;
	u4  entries[1];                 /* offset to DexAnnotationItem */
};

/*
 * Direct-mapped "annotation_item".
 *
 * NOTE: this structure is byte-aligned.
 */
struct DexAnnotationItem {
	u1  visibility;
	u1  annotation[1];              /* data in encoded_annotation format */
};

/*
 * Direct-mapped "encoded_array".
 *
 * NOTE: this structure is byte-aligned.
 */
struct DexEncodedArray {
	u1  array[1];                   /* data in encoded_array format */
};

/*
 * Lookup table for classes.  It provides a mapping from class name to
 * class definition.  Used by dexFindClass().
 *
 * We calculate this at DEX optimization time and embed it in the file so we
 * don't need the same hash table in every VM.  This is slightly slower than
 * a hash table with direct pointers to the items, but because it's shared
 * there's less of a penalty for using a fairly sparse table.
 */
struct DexClassLookup {
	int     size;                       // total size, including "size"
	int     numEntries;                 // size of table[]; always power of 2
	struct {
		u4      classDescriptorHash;    // class descriptor hash code
		int     classDescriptorOffset;  // in bytes, from start of DEX
		int     classDefOffset;         // in bytes, from start of DEX
	} table[1];
};

/*
 * Header added by DEX optimization pass.  Values are always written in
 * local byte and structure padding.  The first field (magic + version)
 * is guaranteed to be present and directly readable for all expected
 * compiler configurations; the rest is version-dependent.
 *
 * Try to keep this simple and fixed-size.
 */
struct DexOptHeader {
	u1  magic[8];           /* includes version number */

	u4  dexOffset;          /* file offset of DEX header */
	u4  dexLength;
	u4  depsOffset;         /* offset of optimized DEX dependency table */
	u4  depsLength;
	u4  optOffset;          /* file offset of optimized data tables */
	u4  optLength;

	u4  flags;              /* some info flags */
	u4  checksum;           /* adler32 checksum covering deps/opt */

	/* pad for 64-bit alignment if necessary */
};

#define DEX_OPT_FLAG_BIG            (1<<1)  /* swapped to big-endian */

#define DEX_INTERFACE_CACHE_SIZE    128     /* must be power of 2 */

/*
 * Structure representing a DEX file.
 *
 * Code should regard DexFile as opaque, using the API calls provided here
 * to access specific structures.
 */
struct DexFile {
	/* directly-mapped "opt" header */
	//const DexOptHeader* pOptHeader;

	/*
		��Ӧ��ϵ����
		DexHeader*    pHeader   ---->struct header_item dex_header
		DexStringId*  pStringIds---->struct string_id_list dex_string_ids
		DexTypeId*    pTypeIds  ---->struct type_id_list dex_type_ids
		DexFieldId*   pFieldIds ---->struct field_id_list dex_field_ids
		DexMethodId*  pMethodIds---->struct method_id_list dex_method_ids
		DexProtoId*   pProtoIds ---->struct proto_id_list dex_proto_ids
		DexClassDef*  pClassDefs---->struct class_def_item_list dex_class_defs
		DexLink*      pLinkData ---->struct map_list_type dex_map_list
	 */

	 /* pointers to directly-mapped structs and arrays in base DEX */
	DexHeader*    pHeader;        //DEX �ļ�ͷ����¼��һЩ��ǰ�ļ�����Ϣ�Լ��������ݽṹ���ļ��е�ƫ����
	DexStringId*  pStringIds;     //����,Ԫ������Ϊstring_id_item,�洢�ַ�����ص���Ϣ
	DexTypeId*    pTypeIds;       //����,�洢������ص���Ϣ
	DexFieldId*   pFieldIds;      //����,�洢��Ա������Ϣ,���������������͵�
	DexMethodId*  pMethodIds;     //����,�洢��Ա������Ϣ���������� �����ͷ���ֵ����
	DexProtoId*   pProtoIds;      //����,����ԭ��������������¼�˷����������ַ������������ͺͲ����б�
	DexClassDef*  pClassDefs;     //����,�洢�����Ϣ
	DexLink*      pLinkData;      //Dex�ļ���Ҫ���������ݶ�����data������,һЩ���ݽṹ��ͨ���� xx_off�����ĳ�Ա����ֻ���ļ���ĳ��λ��,�Ӹ�λ�ÿ�ʼ,�洢�˶�Ӧ�����ݽṹ������,��xx_off��λ��һ������data������

   /*
	* These are mapped out of the "auxillary" section, and may not be
	* included in the file.
	*/
	const DexClassLookup* pClassLookup;
	const void*         pRegisterMapPool;       // RegisterMapClassPool

	/* points to start of DEX file data */
	const u1*           baseAddr;

	/* track memory overhead for auxillary structures */
	int                 overhead;

	/* additional app-specific data structures associated with the DEX */
	//void*               auxData;
};


#endif  // LIBDEX_DEXFILE_H_
