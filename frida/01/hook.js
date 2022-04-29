function main() {
    hook_java();
    // hook_native();
    // hook_libc();
}

function write_data() {

    var file = new File("/sdcard/reg.dat", "w");
    file.write("EoPAoY62@ElRD");
    file.flush();
    file.close();
}

function write_data2() {

    // 先找到c函数相应的函数指针
    var addr_fopen = Module.findExportByName("libc.so", "fopen");
    var addr_fputs = Module.findExportByName("libc.so", "fputs");
    var addr_fclose = Module.findExportByName("libc.so", "fclose");

    console.log("addr_fopen: ", addr_fopen, "addr_fputs: ", addr_fputs, "addr_fclose: ", addr_fclose);
    // 创建相应的native函数
    var fopen = new NativeFunction(addr_fopen, "pointer", ["pointer", "pointer"]);
    var fputs = new NativeFunction(addr_fputs, "int", ["pointer", "pointer"]);
    var fclose = new NativeFunction(addr_fclose, "int", ["pointer"]);

    var filename = Memory.allocUtf8String("/sdcard/reg.dat");
    var open_mode = Memory.allocUtf8String("w+");
    var file = fopen(filename, open_mode);

    var data = Memory.allocUtf8String("EoPAoY62@ElRD");
    var ret = fputs(data, file);
    console.log("fputs ret: ", ret);

    fclose(file);
}

function hook_java() {
    Java.perform(function() {
        var process_class = Java.use("android.os.Process");

        process_class.killProcess.implementation = function(pid) {
            console.log("[+] killProcess pid: " + pid);
        }

        var MyApp = Java.use("com.gdufs.xman.MyApp");
        // hook java 层的jni函数 
        MyApp.saveSN.implementation = function (str) {
            console.log("MyApp.saveSN:", str);
            this.saveSN("201608Am!2333");
        };
    })
}

function call_signSN() {
    Java.perform(function() {

        // Java.choose("com.gdufs.xman.MyApp", {
        //     onMatch: function(instance) {
        //         instance.saveSN("201608Am!2333");
        //     }
        // })

        var MyApp = Java.use("com.gdufs.xman.MyApp").$new();
        // hook java 层的jni函数 
        MyApp.saveSN("hello");
    })
}

// function hook_libc() {
//     //hook libc的函数
//     var strcmp = Module.findExportByName("libc.so", "strcmp");
//     console.log("strcmp:", strcmp);
//     Interceptor.attach(strcmp, {
//         onEnter: function (args) {
//             var str_2 = ptr(args[1]).readCString();
//             // if (str_2 == "EoPAoY62@ElRD") {
//                 console.log("strcmp:", ptr(args[0]).readCString(),
//                     ptr(args[1]).readCString());
//             // }
//         }, onLeave: function (retval) {
//         }
//     });

// }

// function hook_dlopen() {
//     var dlopen = Module.findExportByName(null, "dlopen");
//     Interceptor.attach(dlopen, {
//         onEnter: function (args) {
//             this.call_hook = false;
//             var so_name = ptr(args[0]).readCString();
//             if (so_name.indexOf("libhello-jni.so") >= 0) {
//                 console.log("dlopen:", ptr(args[0]).readCString());
//                 this.call_hook = true;
//             }

//         }, onLeave: function (retval) {
//             if (this.call_hook) {
//                 inline_hook();
//             }
//         }
//     });
//     // 高版本Android系统使用android_dlopen_ext
//     var android_dlopen_ext = Module.findExportByName(null, "android_dlopen_ext");
//     Interceptor.attach(android_dlopen_ext, {
//         onEnter: function (args) {
//             this.call_hook = false;
//             var so_name = ptr(args[0]).readCString();
//             if (so_name.indexOf("libhello-jni.so") >= 0) {
//                 console.log("android_dlopen_ext:", ptr(args[0]).readCString());
//                 this.call_hook = true;
//             }

//         }, onLeave: function (retval) {
//             if (this.call_hook) {
//                 inline_hook();
//             }
//         }
//     });
// }

// function inline_hook() {
//     var base_hello_jni = Module.findBaseAddress("libhello-jni.so");
//     console.log("base_hello_jni:", base_hello_jni);
//     if (base_hello_jni) {
//         console.log(base_hello_jni);
//         //inline hook
//         var addr_07320 = base_hello_jni.add(0x07320);
//         Interceptor.attach(addr_07320, {
//             onEnter: function (args) {
//                 console.log("addr_07320 x13:", this.context.x13);
//             }, onLeave: function (retval) {
//             }
//         });
//     }
// }

// var hook_native = () => {
//     var strcmp = Module.findExportByName("libc.so", "strcmp");
//     console.log("[+] strcmp: " + strcmp);
//     Interceptor.attach(strcmp, {
//         onEnter: function(args) {
//             this.arg0 = args[0];
//             this.arg1 = args[1];
//             if(this.arg1 == "EoPAoY62@ElRD") {
//                 console.log("[+] Enter strcmp args0: " + this.arg0.readCString() + ", args1: " + this.arg1this.arg0.readCString());

//             }
//         },
//         onLeave: function(retval) {
//             if(this.arg1 == "EoPAoY62@ElRD") {
//                 return 0;
//             }
            
//         }
//     })
// }

setImmediate(main);