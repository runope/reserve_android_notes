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
  * Functions to deal with class definition structures in DEX files
  */

#ifndef _LIBDEX_DEXCLASS
#define _LIBDEX_DEXCLASS

#include "DexFile.h"
#include "Leb128.h"

  /* expanded form of a class_data_item header */
typedef struct DexClassDataHeader
{
	u4 staticFieldsSize;//静态字段个数
	u4 instanceFieldsSize;//实例字段个数
	u4 directMethodsSize;//直接方法个数
	u4 virtualMethodsSize;//虚方法个数
} DexClassDataHeader;

/* expanded form of encoded_field */
typedef struct DexField
{
	u4 fieldIdx; //DexFile.pFieldIds中的索引
	u4 accessFlags;
} DexField;

/* expanded form of encoded_method */
typedef struct DexMethod
{
	u4 methodIdx; //DexFile.pMethodIds的索引
	u4 accessFlags;//方法的权限
	u4 codeOff; //方法code的文件偏移
} DexMethod;

/* expanded form of class_data_item. Note: If a particular item is
 * absent (e.g., no static fields), then the corresponding pointer
 * is set to NULL. */
typedef struct DexClassData
{
	DexClassDataHeader header;
	DexField *staticFields;
	DexField *instanceFields;
	DexMethod *directMethods;
	DexMethod *virtualMethods;
} DexClassData;




/* Read the header of a class_data_item without verification. This
 * updates the given data pointer to point past the end of the read
 * data. */
 //解析类的静态字段、实例字段、直接方法、虚方法个数
void dexReadClassDataHeader(const u1 **pData, DexClassDataHeader *pHeader);

#endif
