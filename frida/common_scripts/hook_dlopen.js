function hook_dlopen() {
    var dlopen = Module.findExportByName(null, "dlopen");
    Interceptor.attach(dlopen, {
        onEnter: function (args) {
            this.call_hook = false;
            var so_name = ptr(args[0]).readCString();
            if (so_name.indexOf("libhello-jni.so") >= 0) {
                console.log("dlopen:", ptr(args[0]).readCString());
                this.call_hook = true;
            }

        }, onLeave: function (retval) {
            if (this.call_hook) {
                inline_hook();
            }
        }
    });
    // 高版本Android系统使用android_dlopen_ext
    var android_dlopen_ext = Module.findExportByName(null, "android_dlopen_ext");
    Interceptor.attach(android_dlopen_ext, {
        onEnter: function (args) {
            this.call_hook = false;
            var so_name = ptr(args[0]).readCString();
            if (so_name.indexOf("libhello-jni.so") >= 0) {
                console.log("android_dlopen_ext:", ptr(args[0]).readCString());
                this.call_hook = true;
            }

        }, onLeave: function (retval) {
            if (this.call_hook) {
                inline_hook();
            }
        }
    });
}