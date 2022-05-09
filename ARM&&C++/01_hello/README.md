# 0x01 use android clang toolchains
1. Install android ndk by android studio or install ndk directly
2. Add environment variables, `$NDK/toolchains/llvm/prebuilt/$HOST_TAG/bin/clang++`
3. Developer guide: [android developers: ndk](https://developer.android.com/ndk/guides/other_build_systems?hl=zh-cn)

# 0x02 clang
1. Preprocessing, clang -E. eg: `clang -target arm-linux-android21 -E .\hello.c -o hello.i`
2. Compilation, clang -S. eg: `clang -target arm-linux-android21 -S .\hello.i -o hello.s`
3. Assemble, clang -c. eg: `clang -target arm-linux-android21 -c .\hello.s -o hello.o`
4. Linking, clang. eg: `clang -target arm-linux-android21 .\hello.o -o hello`
5. Of course, you could directly generate executable file by use clang {src} -o {dst}

# 0x03 push elf to android
1. use clang generate elf
2. push elf to android
3. chmod -x file
4. eg: 
```shell
all:
	clang -target arm-linux-android21 arm_hello.s -o arm_hello
	adb push arm_hello /data/local/tmp/arm_hello
	adb shell chmod +x /data/local/tmp/arm_hello
	adb shell /data/local/tmp/arm_hello 
```

# 0x3 gdb
1. if gdb dont debug arm, install gdb from source
2. use `export LDFLAGS="-rdynamic" ./configure --target=arm-linux --with-libexpat-prefix --with-python=/home/kali/.pyenv/versions/3.8.0/`. expat library need install yourself
3. make
4. if error `Could not load the Python gdb module from `/usr/local/share/gdb/python'.`. we can copy from `/usr/share/gdb to /usr/local/share/
5. if use gef, use 'gef-remote localhost:6666' to connect remote gdbserver
6. if you use kali, directly apt install gdb-multiarch

# 0x4 android debug
1. ndk include gdbserver, that put in android
2. in android `./gdbserver :6666 ./arm_hello`
3. tcp forward tcp:6666 tcp:6666
4. running gdb, target remote localhost:6666