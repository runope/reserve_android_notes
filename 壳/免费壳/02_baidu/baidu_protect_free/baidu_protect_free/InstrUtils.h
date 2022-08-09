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
  * Dalvik instruction utility functions.
  */
#ifndef _LIBDEX_INSTRUTILS
#define _LIBDEX_INSTRUTILS

#include "DexFile.h"
#include "OpCode.h"

typedef signed char InstructionWidth;
/*
 * Allocate and populate a 256-element array with instruction widths.  A
 * width of zero means the entry does not exist.
 */
void dexCreateInstrWidthTable(InstructionWidth*);

/*
 * Return the width of the specified instruction, or 0 if not defined.
 */
 //返回对应指令的长度
size_t dexGetInstrWidthAbs(const InstructionWidth* widths, OpCode opCode);

/*
 * Return the width of the specified instruction, or 0 if not defined.  Also
 * works for special OP_NOP entries, including switch statement data tables
 * and array data.
 */
size_t dexGetInstrOrTableWidthAbs(const InstructionWidth* widths, const u2* insns, const unsigned char *op_replace_array);



#endif /*_LIBDEX_INSTRUTILS*/
