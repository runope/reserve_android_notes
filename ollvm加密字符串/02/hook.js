function main() {
    hook_java();
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

setImmediate(main);