function main() {
    hook_java();
    hook_native();
}

var print_hex = (addr) => {
    var base = Module.findBaseAddress("libhello-jni.so")
    console.log(hexdump(base.add(addr)))
}

var hook_java = () => {
    Java.perform(function() {
        var hello_jni_class = Java.use("com.example.hellojni.HelloJni");

        hello_jni_class.sign1.implementation = function(args) {
            var ret = this.sign1("0123456789abcdef");
            console.log("[+] sign1 ret: " + ret);
            return ret;
        }
    })
} 

var hook_native = () => {
    var base = Module.findBaseAddress("libhello-jni.so")

    Interceptor.attach(base.add(0x81D0), {
        onEnter: function(args) {
            this.arg0 = args[0];
            this.arg1 = args[1];
            console.log("[+] Enter 0x81D0 args0: \r\n" + 
            hexdump(this.arg0) + 
            "\r\nargs1: \r\n" + 
            hexdump(this.arg1));
        },
        onLeave: function(retval) {
            console.log("[+] Leave 0x81D0 args0: \r\n" + 
            hexdump(this.arg0) + 
            "\r\nargs1: \r\n" + 
            hexdump(this.arg1));
        }
    })
}

setImmediate(main);