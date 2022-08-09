// There is no open function to gain FILE* in frida tinycc. Use fp from js to cmodule.
var fp = Memory.alloc(8);

const arm64CM = new CModule(`
#include <gum/gumstalker.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


extern void on_message(const gchar *message);
static void log(const gchar *format, ...);
static void on_arm64_before(GumCpuContext *cpu_context, gpointer user_data);
static void on_arm64_after(GumCpuContext *cpu_context, gpointer user_data);

void hello() {
    on_message("Hello form CModule");
}

gpointer shared_mem[] = {0, 0};

gpointer 
get_shared_mem() 
{
    return shared_mem;
}

static void
log(const gchar *format, ...)
{
    gchar *message;
    va_list args;

    va_start(args, format);
    message = g_strdup_vprintf(format, args);
    va_end(args);

    on_message(message);
    g_free(message);
}


void transform(GumStalkerIterator *iterator,
               GumStalkerOutput *output,
               gpointer user_data)
{
    // fp from js to cmodule
    extern FILE * fp;

    cs_insn *insn;

    gpointer base = *(gpointer*)user_data;
    gpointer end = *(gpointer*)(user_data + sizeof(gpointer));
    
    while (gum_stalker_iterator_next(iterator, &insn))
    {
        gboolean in_target = (gpointer)insn->address >= base && (gpointer)insn->address < end;
        if(in_target)
        {
            // log("%p\t%s\t%s", (gpointer)insn->address, insn->mnemonic, insn->op_str);
            fprintf(fp, "%p\t%s\t%s\n", (gpointer)insn->address, insn->mnemonic, insn->op_str);
            gum_stalker_iterator_put_callout(iterator, on_arm64_before, (gpointer) insn->address, NULL);
        }
        fflush(fp);
        gum_stalker_iterator_keep(iterator);
    }
}


const gchar * cpu_format = "
0x%llx\t0x%llx\t0x%llx\t0x%llx\t0x%llx
0x%llx\t0x%llx\t0x%llx\t0x%llx\t0x%llx
0x%llx\t0x%llx\t0x%llx\t0x%llx\t0x%llx
0x%llx\t0x%llx\t0x%llx\t0x%llx\t0x%llx
0x%llx\t0x%llx\t0x%llx\t0x%llx\t0x%llx
0x%llx\t0x%llx\t0x%llx\t0x%llx\t0x%llx
0x%llx\t0x%llx\t0x%llx
";

static void
on_arm64_before(GumCpuContext *cpu_context,
        gpointer user_data)
{
    fprintf(fp, cpu_format, cpu_context -> pc, cpu_context -> sp, cpu_context -> fp, cpu_context -> lr, cpu_context -> x[0], cpu_context -> x[1], 
        cpu_context ->x[2], cpu_context -> x[3], cpu_context -> x[4], cpu_context -> x[5], cpu_context -> x[6], cpu_context -> x[7], 
        cpu_context -> x[8], cpu_context -> x[9], cpu_context -> x[10], cpu_context -> x[11], cpu_context -> x[12], cpu_context -> x[13],
        cpu_context -> x[14], cpu_context -> x[15], cpu_context -> x[16], cpu_context -> x[17], cpu_context -> x[18], cpu_context -> x[19],
        cpu_context -> x[20], cpu_context -> x[21], cpu_context -> x[22], cpu_context -> x[23], cpu_context -> x[24], cpu_context -> x[25],
        cpu_context -> x[26], cpu_context -> x[27], cpu_context -> x[28]);
    // log(cpu_format, cpu_context);
}


`, {
    on_message: new NativeCallback(messagePtr => {
        const message = messagePtr.readUtf8String();
        console.log(message)
        // send(message)
    }, 'void', ['pointer']),
    fp
});

// function init_fd() {

//     // 先找到c函数相应的函数指针
//     var addr_fopen = Module.findExportByName("libc.so", "fopen");
//     var addr_fputs = Module.findExportByName("libc.so", "fputs");
//     var addr_fflush = Module.findExportByName("libc.so", "fflush");
//     var addr_fclose = Module.findExportByName("libc.so", "fclose");

//     // console.log("addr_fopen: ", addr_fopen, "addr_fputs: ", addr_fputs, "addr_fclose: ", addr_fclose);
//     // 创建相应的native函数
//     var fopen = new NativeFunction(addr_fopen, "pointer", ["pointer", "pointer"]);
//     var fputs = new NativeFunction(addr_fputs, "int", ["pointer", "pointer"]);
//     var fclose = new NativeFunction(addr_fclose, "int", ["pointer"]);
//     var fflush = new NativeFunction(addr_fflush, "void", ["pointer"])
//     // var time_now = new Date().Format("yyyyMMdd_HHmmss"); 
//     var time_now = new Date().getTime().toString()
//     // var filename = Memory.allocUtf8String("/data/local/tmp/trace_log/" + time_now + ".txt");
//     // var filename = Memory.allocUtf8String("/data/data/com.kanxue.ollvm_ndk_9/trace_");

//     var open_mode = Memory.allocUtf8String("a+");
//     var file = fopen(filename, open_mode);
//     fputs(filename, file);
//     fflush(file);
//     fclose(file);
//     // var set_fd = new NativeFunction(arm64CM.set_fd, "void", ["pointer"]);
//     // set_fd(file);
// }

// // 1. 传fopen函数指针
// const fopen_ptr = Module.findExportByName(null, "fopen");
// const cm = new CModule(`
//     extern FILE * fopen(const char *path, const char *mode);
//     FILE * fp = fopen("/data/local/tmp/trace_log/test.txt", "a+");
// `, {fopen: fopen_ptr})

// 2. 传FILE*参数指针
function init_fd() {

    var addr_fopen = Module.findExportByName("libc.so", "fopen");
    var fopen = new NativeFunction(addr_fopen, "pointer", ["pointer", "pointer"]);

    // var time_now = new Date().Format("yyyyMMdd_HHmmss"); 
    var time_now = new Date().getTime().toString();
    // var filename = Memory.allocUtf8String("/data/local/tmp/trace_log/" + time_now + ".txt");
    var filename = Memory.allocUtf8String("/data/data/com.kanxue.ollvm_ndk_9/trace_" + time_now + ".log");
    // var filename = Memory.allocUtf8String("/data/data/com.example.hellojni_sign2/trace_" + time_now + ".log");

    var open_mode = Memory.allocUtf8String("a+");
    var file = fopen(filename, open_mode);
    fp.writePointer(new NativePointer(file))
}

const userData = Memory.alloc(Process.pageSize);
function stalkerTraceRangeC(tid, base, size) {
    // const hello = new NativeFunction(cm.hello, 'void', []);
    // hello();
    init_fd()
    userData.writePointer(base)
    const pointerSize = Process.pointerSize;
    userData.add(pointerSize).writePointer(base.add(size))
    
    Stalker.follow(tid, {
        transform: arm64CM.transform,
        // onEvent: cm.process,
        data: userData /* user_data */
    })
}

function stalkerTraceRange(tid, base, size) {
    Stalker.follow(tid, {
        transform: (iterator) => {
            const instruction = iterator.next();
            const startAddress = instruction.address;
            const isModuleCode = startAddress.compare(base) >= 0 && 
                startAddress.compare(base.add(size)) < 0;
            // const isModuleCode = true;
            do {
                iterator.keep();
                if (isModuleCode) {
                    send({
                        type: 'inst',
                        tid: tid,
                        block: startAddress,
                        val: JSON.stringify(instruction)
                    })
                    iterator.putCallout((context) => {
                            send({
                                type: 'ctx',
                                tid: tid,
                                val: JSON.stringify(context)
                            })
                    })
                }
            } while (iterator.next() !== null);
        }
    })
}


function traceAddr(addr) {
    let moduleMap = new ModuleMap();    
    let targetModule = moduleMap.find(addr);
    console.log(JSON.stringify(targetModule))
    let exports = targetModule.enumerateExports();
    let symbols = targetModule.enumerateSymbols();
    // send({
    //     type: "module", 
    //     targetModule
    // })
    // send({
    //     type: "sym",
    

    // })
    Interceptor.attach(addr, {
        onEnter: function(args) {
            this.tid = Process.getCurrentThreadId()
            stalkerTraceRangeC(this.tid, targetModule.base, targetModule.size)
            // stalkerTraceRange(this.tid, targetModule.base, targetModule.size)
        },
        onLeave: function(ret) {
            Stalker.unfollow(this.tid);
            Stalker.garbageCollect()
            send({
                type: "fin",
                tid: this.tid
            })
        }
    })
}

(() => {

    console.log(`----- start trace -----`);
    
    const libname = "libnative-lib.so"
    // const libname = "libhello-jni.so"
    const targetModule = Process.getModuleByName(libname);
    let targetAddress = targetModule.findExportByName("Java_com_kanxue_ollvm_1ndk_MainActivity_UUIDCheckSum");
    // let targetAddress = targetModule.findExportByName("Java_com_example_hellojni_HelloJni_sign2");
    traceAddr(targetAddress)
    // com.kanxue.ollvm_ndk_9
})()