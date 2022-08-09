var mprotect_cnt = 0
//配合hook_dlopen一起使用，因为frida注入的时候，libreactnativejni.so还没有加载
function hook_dlopen(module_name, fun) {
        var android_dlopen_ext = Module.findExportByName(null, "android_dlopen_ext");
        if (android_dlopen_ext) {
            Interceptor.attach(android_dlopen_ext, {
                onEnter: function (args) {
                    var pathptr = args[0];
                    if (pathptr) {
                        this.path = (pathptr).readCString();
                        if (this.path.indexOf(module_name) >= 0) {
                            this.canhook = true;
                            console.log("android_dlopen_ext:", this.path);
                        }
                    }
                },
                onLeave: function (retval) {
                    if (this.canhook) {
                        fun();
                    }
                }
            });
        }
}

function sleep(delay) {
    var start = (new Date()).getTime();
    while ((new Date()).getTime() - start < delay) {
      continue;
    }
}

function hook_elf_hook(){
    //0x53E30
    let base_secShell = Module.findBaseAddress("libSecShell.so");
    let elf_hook = base_secShell.add(0x53E30+1);
    let str1
    let str2
    Interceptor.attach(elf_hook, {
        onEnter: function(args) {
            console.log("hook_elf_hook")
            try {
                str2 = this.context.r1.readCString();
            } catch (e) {
                str2 = ""
            }
            if(str2){
                console.log(">>>>elf_hook " + " hook_func = " + str2," return addr = " + this.context.lr.sub(base_secShell))
            }

        },
        onLeave: function(){
        }
    })
}
function hook_15CF8(){
    let base_secShell = Module.findBaseAddress("libSecShell.so");
    let sub_1E3C8 = base_secShell.add(0x1E3C8+1);
    let sub_1E574 = base_secShell.add(0x1E574+1);
    Interceptor.attach(sub_1E3C8, {
        onEnter: function(args) {
            console.log("=======sub_1E3C8======")
            sleep(100000)
            // console.log(hexdump(this.context.r0,{length:16}))
            // console.log(hexdump(this.context.r1,{length:16}))
        },
        onLeave: function(){
            console.log("sub_1E3C8 leave")
        }
    })
    Interceptor.attach(sub_1E574, {
        onEnter: function(args) {
            console.log("=======sub_1E574======")
            sleep(100000)
            // console.log(hexdump(this.context.r0,{length:16}))
            // console.log(hexdump(this.context.r1,{length:16}))
        },
        onLeave: function(){
            console.log("sub_1E574 leave")
        }
    })
}

function hook_decode_str(){
    let base_secShell = Module.findBaseAddress("libSecShell.so");
    let decode_str = base_secShell.add(0x12B94+1);
    let decode_str2 = base_secShell.add(0x2D06C+1);
    let decode_31d68 = base_secShell.add(0x31D68+1);
    let decode_3B1B0 = base_secShell.add(0x3B1B0+1);
    let decode_str3 = base_secShell.add(0x4B854+1);
    let decode_59880 = base_secShell.add(0x59880+1);
    let decode_601ec = base_secShell.add(0x601EC+1)
    let pinjie = base_secShell.add(0x98F20+1);

    // Interceptor.attach(pinjie, {
    //     onEnter: function(args) {
    //         console.log("=======sprintf=========" + " return addr = " + this.context.lr.sub(base_secShell))
    //         this.args0 = args[0]
    //         this.args1 = args[1]
    //     },
    //     onLeave: function(){
    //         var str2
    //         try {
    //             str2 = this.args0.readCString();
    //         } catch (e) {
    //             str2 = ""
    //         }
    //         console.log("result = " + str2)
    //         // console.log(hexdump(args[0],{length:0x10}))
    //     }
    // })
    Interceptor.attach(decode_str, {
        onEnter: function(args) {
            console.log("=======decode_str========="+ " size = " + args[1] + " op = " + args[2]," return addr = " + this.context.lr.sub(base_secShell))
            this.args0 = args[0]
            this.args1 = args[1]
        },
        onLeave: function(){
            console.log(hexdump(this.args0,{length:this.args1.toInt32()}))
            // console.log(hexdump(args[0],{length:0x10}))
        }
    })

    // Interceptor.attach(decode_str2, {
    //     onEnter: function(args) {
    //         console.log("=======decode_str2========="+ " size = " + args[1] + " op = " + args[2]," return addr = " + this.context.lr.sub(base_secShell))
    //         this.args0 = args[0]
    //         this.args1 = args[1]
    //     },
    //     onLeave: function(){
    //         console.log(hexdump(this.args0,{length:this.args1.toInt32()}))
    //         // console.log(hexdump(args[0],{length:0x10}))
    //     }
    // })
    // Interceptor.attach(decode_31d68, {
    //     onEnter: function(args) {
    //         console.log("=======decode_31d68========="+ " size = " + args[1] + " op = " + args[2]," return addr = " + this.context.lr.sub(base_secShell))
    //         this.args0 = args[0]
    //         this.args1 = args[1]
    //     },
    //     onLeave: function(){
    //         console.log(hexdump(this.args0,{length:this.args1.toInt32()}))
    //         // console.log(hexdump(args[0],{length:0x10}))
    //     }
    // })
    // Interceptor.attach(decode_3B1B0, {
    //     onEnter: function(args) {
    //         console.log("=======decode_3B1B0========="+ " size = " + args[1] + " op = " + args[2]," return addr = " + this.context.lr.sub(base_secShell))
    //         this.args0 = args[0]
    //         this.args1 = args[1]
    //     },
    //     onLeave: function(){
    //         console.log(hexdump(this.args0,{length:this.args1.toInt32()}))
    //         // console.log(hexdump(args[0],{length:0x10}))
    //     }
    // })
    //4B854
    // Interceptor.attach(decode_str3, {
    //     onEnter: function(args) {
    //         console.log("=======decode_str3========="+ " size = " + args[1] + " op = " + args[2]," return addr = " + this.context.lr.sub(base_secShell))
    //         this.args0 = args[0]
    //         this.args1 = args[1]
    //     },
    //     onLeave: function(){
    //         console.log(hexdump(this.args0,{length:this.args1.toInt32()}))
    //         // console.log(hexdump(args[0],{length:0x10}))
    //     }
    // })
    // Interceptor.attach(decode_59880, {
    //     onEnter: function(args) {
    //         console.log("=======decode_59880========="+ " size = " + args[1] + " op = " + args[2]," return addr = " + this.context.lr.sub(base_secShell))
    //         this.args0 = args[0]
    //         this.args1 = args[1]
    //     },
    //     onLeave: function(){
    //         console.log(hexdump(this.args0,{length:this.args1.toInt32()}))
    //         // console.log(hexdump(args[0],{length:0x10}))
    //     }
    // })
    // Interceptor.attach(decode_601ec, {
    //     onEnter: function(args) {
    //         console.log("=======decode_601ec========="+ " size = " + args[1] + " op = " + args[2]," return addr = " + this.context.lr.sub(base_secShell))
    //         this.args0 = args[0]
    //         this.args1 = args[1]
    //     },
    //     onLeave: function(){
    //         console.log(hexdump(this.args0,{length:this.args1.toInt32()}))
    //         // console.log(hexdump(args[0],{length:0x10}))
    //     }
    // })


}
//892D0
function hook_dlsym(){
    let base_libc = Module.findBaseAddress("libdl.so");
    let base_secShell = Module.findBaseAddress("libSecShell.so");
    let dlsym = base_libc.add(0x1862+1);
    let str2
    let flag
    Interceptor.attach(dlsym, {
        onEnter: function(args) {
            try {
                str2 = this.context.r1.readCString();
            } catch (e) {
                str2 = ""
            }
            console.log(">>>>elf_hook " + " hook_func = " + str2," return addr = " + this.context.lr.sub(base_secShell))
            if(this.context.lr > base_secShell.add(0x10000) & this.context.lr < base_secShell.add(0x90000) & str2){
                console.log(">>>>elf_hook " + " hook_func = " + str2," return addr = " + this.context.lr.sub(base_secShell))
            }
            
        },
        onLeave: function(){

        }
    })
}

function hook_strcpy_a15(){
    let base_libc = Module.findBaseAddress("libc.so");
    let base_secShell = Module.findBaseAddress("libSecShell.so");
    let strcpy_a15 = base_libc.add(0x349DC+1);
    let str2
    let flag
    Interceptor.attach(strcpy_a15, {
        onEnter: function(args) {
            try {
                str2 = this.context.r1.readCString();
            } catch (e) {
                str2 = ""
            }
            
            if(this.context.lr > base_secShell.add(0x281B0) & this.context.lr < base_secShell.add(0x2A5FF)){
                console.log(">> "+ "strcpy: str = " + str2 + " return addr = " + this.context.lr.sub(base_secShell))
            }
            // if(this.context.lr.toInt32() > base_secShell.add(0x10000).toInt32() & this.context.lr.toInt32() < base_secShell.add(0x30000).toInt32()){
            //     console.log(">> "+ "strcmp: cmp1 = " + cmp1 + " cmp2 = " + cmp1 + " return addr = " + this.context.lr + " base = " + base_secShell)
            // }
            
        },
        onLeave: function(){

        }
    })
}
function hook_strcmp_a15(){
    let base_libc = Module.findBaseAddress("libc.so");
    let base_secShell = Module.findBaseAddress("libSecShell.so");
    let strcmp_a15 = base_libc.add(0x34708+1);
    let cmp1
    let cmp2
    let flag
    Interceptor.attach(strcmp_a15, {
        onEnter: function(args) {
            try {
                cmp1 = this.context.r0.readCString();
                cmp2 = this.context.r1.readCString();
            } catch (e) {
                cmp1 = ""
                cmp2 = ""
            }
            if(cmp1 & cmp2){
                flag = true
            }else{
                flag = false
            }
            if(this.context.lr > base_secShell.add(0x10000) & this.context.lr < base_secShell.add(0x20000)){
                console.log(">> "+ "strcmp: cmp1 = " + cmp1 + " cmp2 = " + cmp1 + " return addr = " + this.context.lr.sub(base_secShell))
            }
            // if(this.context.lr.toInt32() > base_secShell.add(0x10000).toInt32() & this.context.lr.toInt32() < base_secShell.add(0x30000).toInt32()){
            //     console.log(">> "+ "strcmp: cmp1 = " + cmp1 + " cmp2 = " + cmp1 + " return addr = " + this.context.lr + " base = " + base_secShell)
            // }
            
        },
        onLeave: function(){
            // if(flag){
            //     console.log(">> strcmp result = " + this.context.r0)
            // }
            
            // console.log(hexdump(args[0],{length:0x10}))
        }
    })
}

function hook_libc(){
    let base_libc = Module.findBaseAddress("libc.so")
    let base_secShell = Module.findBaseAddress("libSecShell.so")
    let mprotect = base_libc.add(0x70EEC)
    let access = base_libc.add(0x389EE+1)
    let memcmp = base_libc.add(0x33318)
    // Interceptor.attach(mprotect, {
    //     onEnter: function(args) {
    //         if(this.context.lr > base_secShell.add(0x10000) & this.context.lr < base_secShell.add(0x90000)){
    //             console.log(">> "+ "mprotect addr = " + this.context.r0 + " return addr = " + this.context.lr.sub(base_secShell))
    //         }
    //     },
    //     onLeave: function(){

    //     }
    // })
    Interceptor.attach(access, {
        onEnter: function(args) {
            let str1
            try {
                str1 = this.context.r0.readCString();
            } catch (e) {
                str1 = ""
            }
            if(this.context.lr > base_secShell.add(0x10000) & this.context.lr < base_secShell.add(0x90000)){
                console.log(">> "+ "access path = " + str1 + " mode = " + this.context.r1 + " return addr = " + this.context.lr.sub(base_secShell))
            }
        },
        onLeave: function(){
            console.log(">> access return = " + this.context.r0)
        }
    })

}


function hook_svc_mprotect() {
    let base_secShell = Module.findBaseAddress("libSecShell.so");
    if (base_secShell != null) {
        console.log("base_secShell : " + base_secShell)
    }else{
        return ;
    }
    let svc_mprotect = base_secShell.add(0xC0778);//32位
    // let svc_mprotect = base_secShell.add(0x1541A0);//64位
    //private native void jniLoadScriptFromAssets(AssetManager assetManager, String assetURL, boolean loadSynchronously);
    Interceptor.attach(svc_mprotect, {
        onEnter: function(args) {
            console.log("==========================================")
            
            console.log("svc_mprotect: start = " + args[0] + " , len = " + args[1] + " , ATTRIBUTES = " + args[2])
            mprotect_cnt += 1
            console.log(hexdump(base_secShell.add(0x281B4)))
        },
        onLeave: function(){
            console.log("svc_mprotect leave")
            console.log("==========================================")
            
            if(mprotect_cnt == 2){
                hook_decode_str()
                hook_15CF8()
                // hook_elf_hook()
                // sleep(1000000)
            }
        }
    })
}

function dis(address, number) {
    for (var i = 0; i < number; i++) {
        var ins = Instruction.parse(address);
        console.log("address:" + address + "--dis:" + ins.toString());
        address = ins.next;
    }
}

//libc->strstr()  从linker里面找到call_function的地址
function hook() {
//call_function("DT_INIT", init_func_, get_realpath());
    var linkermodule
    if (Process.pointerSize == 4) {
        linkermodule = Process.findModuleByName("linker");
    }else if (Process.pointerSize == 8) {
        linkermodule = Process.findModuleByName("linker64");

    }

    // var linkermodule = Process.getModuleByName("linker");
    var call_function_addr = null;
    var symbols = linkermodule.enumerateSymbols();
    for (var i = 0; i < symbols.length; i++) {
        var symbol = symbols[i];
        //LogPrint(linkername + "->" + symbol.name + "---" + symbol.address);
        if (symbol.name.indexOf("__dl__ZL13call_functionPKcPFviPPcS2_ES0_") != -1) {
            call_function_addr = symbol.address;
            //LogPrint("linker->" + symbol.name + "---" + symbol.address)

        }
    }
    Interceptor.attach(call_function_addr, {
        onEnter: function (args) {
            var type = ptr(args[0]).readUtf8String();
            var address = args[1];
            var sopath = ptr(args[2]).readUtf8String();
            console.log("loadso:" + sopath + "--addr:" + address + "--type:" + type);
            if (sopath.indexOf("libSecShell.so") != -1) {
                var libnativemodule = Process.getModuleByName("libSecShell.so");//call_function正在加载目标so，这时就拦截下来
                var base = libnativemodule.base;
                // hook_strcpy_a15()
                // hook_strcmp_a15()
                // hook_dlsym()
                hook_svc_mprotect()
                // hook_libc()
            }
        }
    })
}

function main() {
    hook();
}

setImmediate(main)
// setImmediate(hook_dlopen("libSecShell.so",hook_svc_mprotect))