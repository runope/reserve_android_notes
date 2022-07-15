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
  * Functions for interpreting LEB128 (little endian base 128) values
  */

#ifndef _LIBDEX_LEB128
#define _LIBDEX_LEB128

#include "DexFile.h"

  /*
   * Reads an unsigned LEB128 value, updating the given pointer to point
   * just past the end of the read value. This function tolerates
   * non-zero high-order bits in the fifth encoded byte.
   */
   //读取一个LEB128编码的无符号数，参数指针也会移动
unsigned int readUnsignedLeb128(const unsigned char **pStream);


/*
 * Reads a signed LEB128 value, updating the given pointer to point
 * just past the end of the read value. This function tolerates
 * non-zero high-order bits in the fifth encoded byte.
 */
 //读取一个LEB128编码的有符号数，参数指针也会移动
int readSignedLeb128(const unsigned char **pStream);


/*
 * Writes a 32-bit value in unsigned ULEB128 format.
 *
 * Returns the updated pointer.
 */
unsigned char *writeUnsignedLeb128(unsigned char*ptr, u4 data);

/*
 * Returns the number of bytes needed to encode "val" in ULEB128 form.
 */
int unsignedLeb128Size(u4 data);

#endif
