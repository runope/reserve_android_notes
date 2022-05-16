#include <jni.h>
#include <string>

long test_inline_asm(long m) {
    long result = 0;
#if defined(__arm__)
    __asm__ __volatile__(
            "mov r0, %[m]\r\n"
            "add r0, r0\r\n"
            "mov %[result], r0\r\n"
            :[result] "=r" (result)
            :[m] "r" (m)
            );
#elif defined(__aarch64__)
    __asm__ __volatile__(
            "mov x0, %[m]\r\n"
            "lsl x0, x0, #2\r\n"
            "mov %[result], x0\r\n"
            :[result] "=r" (result)
            :[m] "r" (m)
            );
#endif
    return result;
}

#include <unistd.h>
// http://androidxref.com/9.0.0_r3/xref/bionic/libc/kernel/uapi/asm-arm/asm/unistd-common.h
#include <sys/syscall.h>
#include <fcntl.h>

// http://androidxref.com/9.0.0_r3/xref/bionic/libc/arch-arm/bionic/syscall.S
//__attribute__((naked))
//long asm_syscall(long number, ...) {
//    __asm__ __volatile__(
//            "MOV             R12, SP\r\n"
//            "PUSH            {R4-R7}\r\n"
//            "MOV             R7, R0\r\n"
//            "MOV             R0, R1\r\n"
//            "MOV             R1, R2\r\n"
//            "MOV             R2, R3\r\n"
//            "LDM             R12, {R3-R6}\r\n"
//            "SVC             0\r\n"
//            "POP             {R4-R7}\r\n"
//            "CMN             R0, #0x1000\r\n"
//            "MOV             PC, LR\r\n"
//            );
//}

extern "C" long asm_syscall(long __number, ...);
// syscall调用函数的asm：http://androidxref.com/8.1.0_r33/xref/bionic/libc/arch-arm/syscalls/

std::string test_syscall(const char* filePath) {
    // syscall https://man7.org/linux/man-pages/man2/syscall.2.html
    // openat https://man7.org/linux/man-pages/man2/open.2.html
    // read https://man7.org/linux/man-pages/man2/read.2.html
    std::string result = "";
//    long fd = syscall(__NR_openat, 0, filePath, O_RDONLY | O_CREAT, S_IRUSR);
    long fd = asm_syscall(__NR_openat, 0, filePath, O_RDONLY | O_CREAT, S_IRUSR);
    if (fd != -1) {
        char buffer[0x100] = {0};
//        syscall(__NR_read, fd, buffer, 0x100);
        asm_syscall(__NR_read, fd, buffer, 0x100);
        result = buffer;
//        syscall(__NR_close, fd);
        asm_syscall(__NR_close, fd);
    }

    return result;
}

extern "C" JNIEXPORT jstring JNICALL
Java_com_example_native_1asm_MainActivity_stringFromJNI(
        JNIEnv* env,
        jobject /* this */, jstring file_path) {
    const char* p_filePath = env->GetStringUTFChars(file_path, nullptr);
    std::string hello = "Hello from C++ " + std::to_string(test_inline_asm(10))
            + test_syscall(p_filePath);
    env->ReleaseStringUTFChars(file_path, p_filePath);
    return env->NewStringUTF(hello.c_str());
}