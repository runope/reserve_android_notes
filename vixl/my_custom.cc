#include <stdio.h>

#include "examples.h"

using namespace vixl; 
using namespace vixl::aarch64;

class BufferDisassembler {
 Decoder decoder_;
 PrintDisassembler disasm_;
public:
 BufferDisassembler(uint8_t* buffer, size_t size): disasm_(stdout) {
   decoder_.AppendVisitor(&disasm_);
   uint32_t* instr = reinterpret_cast<uint32_t*>(buffer);
   for (; size > 0; size -= 4, instr++) {
     decoder_.Decode(reinterpret_cast<Instruction*>(instr));
     printf( "%08x\n", reinterpret_cast<Instruction*>(instr)->GetInstructionBits());
   }
  }
};

int main() {
 const size_t bufSize = 1024;
 uint8_t* buffer = new uint8_t[bufSize];
 Assembler asm_(buffer, bufSize);
 asm_.orr(w0, wzr, 0x10001);
 asm_.mov(x1, x0);
 asm_.FinalizeCode();
 BufferDisassembler disasm_(buffer, asm_.GetCursorOffset());
}


