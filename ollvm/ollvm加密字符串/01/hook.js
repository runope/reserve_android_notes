function main() {
    hook_libart();
    hook_java();
    hook_native();
}

setImmediate(main);

var print_hex = (addr) => {
    var base = Module.findBaseAddress("libhello-jni.so")
    console.log(hexdump(base.add(addr)))
}

var hook_native = () => {
    var base = Module.findBaseAddress("libhello-jni.so")

    // Interceptor.attach(base.add(0x103F0), {
    //     onEnter: function(args) {
    //         this.arg0 = args[0];
    //         this.arg1 = args[1];
    //         this.arg2 = args[2];
    //         console.log("[+] Enter 0x103F0 args0: " + this.arg0 + ", args1: " + this.arg1 + ", args2: " + this.arg2);
    //     },
    //     onLeave: function(retval) {
    //         console.log("[+] Leave 0x103F0 args0: " + this.arg0.readCString() + ", args1: " + this.arg1 + ", args2: \n" + hexdump(this.arg2, {length: parseInt(this.arg1)}));
    //     }
    // })



    Interceptor.attach(base.add(0xF008), {
        onEnter: function(args) {
            this.arg0 = args[0];
            this.arg1 = args[1];
            // this.arg2 = args[2];
            console.log("[+] From " + this.context.lr.sub(base) + " Enter 0xF008 args0: \r\n" + 
                hexdump(this.arg0) + 
                "\r\nargs1: \r\n" + 
                hexdump(this.arg1));
        },
        onLeave: function(retval) {
            console.log("[+] Leave 0x103F0 args0: \r\n" + 
                hexdump(this.arg0) + 
                "\r\nargs1: \r\n" + 
                hexdump(this.arg1) + 
                "\r\nretval: " + retval.readCString());
        }
    })
}

function hook_libart() {
    var module_libart = Process.findModuleByName("libart.so")
    var symbols_libart = module_libart.enumerateSymbols();

    let addr_RegisterNatives = null;

    for(var i = 0; i < symbols_libart.length; i++) {
        var name = symbols_libart[i].name;
        if(name.indexOf("art") >= 0) {
            if(name.indexOf("CheckJNI") == -1 && name.indexOf("JNI") >= 0) {
                if(name.indexOf("RegisterNatives") >= 0) {
                    addr_RegisterNatives = symbols_libart[i].address;
                    console.log("[+] " + name + " : " + addr_RegisterNatives);
                }
            }
        }
    }

    if(addr_RegisterNatives != null) {
        Interceptor.attach(addr_RegisterNatives, {
            onEnter: function(args) {
                var jclass = Java.vm.tryGetEnv().getClassName(args[1]);
                var methods = args[2];
                var method_count = parseInt(args[3]);
                console.log("[+] " + jclass + " RegisterMethod count: " + method_count);

                for(var i = 0; i < method_count; i++) {
                    var method_name = methods.add(i * Process.pointerSize * 3).readPointer().readCString();
                    var method_signature = methods.add(i * Process.pointerSize * 3 + Process.pointerSize).readPointer().readCString();
                    var method_fnPtr = methods.add(i * Process.pointerSize * 3 + Process.pointerSize * 2).readPointer();
                 
                    var base_ptr = Process.findModuleByAddress(method_fnPtr).base;

                    console.log("[+] RegisterJni -> " + method_name + " " + method_signature + " !" + method_fnPtr.sub(base_ptr));
                }
            }
        })
    }
}

var hook_java = () => {
    Java.perform(function() {
        var class_helloJni = Java.use("com.example.hellojni.HelloJni");
        class_helloJni.sign1.implementation = function(args) {
            var ret = this.sign1("0123456789abcdef");
            console.log("[+] sign1 args: " + args + ", ret: " + ret);
            return ret;
        }
    })
}