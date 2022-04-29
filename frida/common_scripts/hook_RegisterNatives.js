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
