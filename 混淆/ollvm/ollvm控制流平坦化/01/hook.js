
var main = () => {
    hook_java();
    hook_native();
}

function print_hex(addr) {
    var base = Module.findBaseAddress("libhello-jni.so")
    console.log(hexdump(base.add(addr)))
}

var hook_java = () => {
    Java.perform(function() {
        var helloJni_class = Java.use("com.example.hellojni.HelloJni")
        helloJni_class.sign2.implementation = function(args) {
            var ret = this.sign2("0123456789abcde", "fedcba9876543210")
            console.log("[*] HelloJni.sign2() called, retval: " + ret)
            
            return ret;
        }
    })
}

var call_native = () => {
    var base = Module.findBaseAddress("libhello-jni.so");
    var func_ptr = base.add(0x14844);

    var func = new NativeFunction(func_ptr, 'pointer', ['pointer', 'pointer']);

    var input = Memory.allocUtf8String("hello");
    var reult = Memory.alloc(0x40);

    var ret = func(reult, input);
    hexdump(ret)
}

function hook_native() {

    var base = Module.findBaseAddress("libhello-jni.so");


    // Interceptor.attach(base.add(0x13558), {
    //     onEnter: function(args) {
    //         this.arg0 = args[0];
    //         this.arg1 = args[1];
    //         this.arg2 = args[2];
    //         console.log("[*] Enter 0x13558 called, from " + this.context.lr.sub(base),
    //             "\r\narg0: \r\n" + my_hexdump(this.arg0),
    //             "\r\narg1: \r\n" + my_hexdump(this.arg1),
    //             "\r\narg2: \r\n" + my_hexdump(this.arg2));
    //     }, 
    //     onLeave: function(retval) {
    //         console.log("[*] Leave 0x13558 called",
    //             "\r\narg0: \r\n" + my_hexdump(this.arg0),
    //             "\r\narg1: \r\n" + my_hexdump(this.arg1),
    //             "\r\narg2: \r\n" + my_hexdump(this.arg2));
    //     },
    // })

    
    // Interceptor.attach(base.add(0x12d70), {
    //     onEnter: function(args) {
    //         this.arg0 = args[0];
    //         this.arg1 = args[1];
    //         this.arg2 = args[2];
    //         console.log("[*] Enter 0x13558 called, from " + this.context.lr.sub(base),
    //             "\r\narg0: \r\n" + my_hexdump(this.arg0),
    //             "\r\narg1: \r\n" + my_hexdump(this.arg1),
    //             "\r\narg2: \r\n" + my_hexdump(this.arg2));
    //     }, 
    //     onLeave: function(retval) {
    //         console.log("[*] Leave 0x13558 called",
    //             "\r\narg0: \r\n" + my_hexdump(this.arg0),
    //             "\r\narg1: \r\n" + my_hexdump(this.arg1),
    //             "\r\narg2: \r\n" + my_hexdump(this.arg2));
    //     },
    // })

    hook_func(0x154d4, base);

}

function hook_func(offset_addr, base) {

    Interceptor.attach(base.add(offset_addr), {
        onEnter: function(args) {
            this.arg0 = args[0];
            this.arg1 = args[1];
            this.arg2 = args[2];
            console.log("[*] Enter " + ptr(offset_addr) + " called, from " + this.context.lr.sub(base),
                "\r\narg0: \r\n" + my_hexdump(this.arg0),
                "\r\narg1: \r\n" + my_hexdump(this.arg1),
                "\r\narg2: \r\n" + my_hexdump(this.arg2));
        }, 
        onLeave: function(retval) {
            console.log("[*] Leave " + ptr(offset_addr) + " called",
                "\r\narg0: \r\n" + my_hexdump(this.arg0),
                "\r\narg1: \r\n" + my_hexdump(this.arg1),
                "\r\narg2: \r\n" + my_hexdump(this.arg2),
                "\r\nretval: \r\n" + my_hexdump(retval));
        },
    })
}

function my_hexdump(input) {

    try {
        return hexdump(input)
    }catch {
        return input
    }
}

setImmediate(main)