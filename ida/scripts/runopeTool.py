import sys
sys.path.append('H:\[P.Y.G]IDA Pro 7.5 SP3(x86, x64, ARM, ARM64, PPC, PPC64, MIPS)\myCustomTool')
from runopehook import RunopeHook

def PLUGIN_ENTRY():
    return RunopeHook()
