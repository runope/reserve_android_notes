__int64 __fastcall sub_B3B4(__int64 a1, int a2)
{
  const char *v2; // x0
  void *v3; // x19
  const char *v4; // x0
  const char *v5; // x0
  const char *v6; // x0
  const char *v7; // x0
  const char *v8; // x0
  const char *v9; // x0
  const char *v10; // x0
  const char *v11; // x0
  const char *v12; // x0
  const char *v13; // x0
  const char *v14; // x0
  const char *v15; // x0
  const char *v16; // x0
  const char *v17; // x0
  const char *v18; // x0
  const char *v19; // x0
  const char *v20; // x0
  const char *v21; // x0
  const char *v22; // x0
  const char *v23; // x0
  const char *v24; // x0
  const char *v25; // x0
  const char *v26; // x0
  const char *v27; // x0
  const char *v28; // x0
  const char *v29; // x0
  const char *v30; // x0
  const char *v31; // x0
  const char *v32; // x0
  const char *v33; // x0
  const char *v34; // x0
  const char *v35; // x0
  const char *v36; // x0
  const char *v37; // x0
  const char *v38; // x0
  const char *v39; // x0
  const char *v40; // x0
  const char *v41; // x0
  const char *v42; // x0
  const char *v43; // x0
  const char *v44; // x0
  const char *v45; // x0
  const char *v46; // x0
  const char *v47; // x0
  const char *v48; // x0
  const char *v49; // x0
  const char *v50; // x0
  const char *v51; // x0
  const char *v52; // x0
  const char *v53; // x0
  const char *v54; // x0
  const char *v55; // x0
  const char *v56; // x0
  const char *v57; // x0
  const char *v58; // x0
  const char *v59; // x0
  const char *v60; // x0
  const char *v61; // x0
  const char *v62; // x0
  const char *v63; // x0
  const char *v64; // x0
  const char *v65; // x0
  const char *v66; // x0
  const char *v67; // x0
  const char *v68; // x0

  if ( a2 != 1 )
    return 0LL;
  v2 = (const char *)sub_28AD0("libc.so");
  v3 = dlopen(v2, 1);
  if ( !v3 )
    exit(1);
  v4 = (const char *)sub_25E78("_exit");
  qword_BE238 = (__int64)dlsym(v3, v4);
  v5 = (const char *)sub_25F24("exit");
  qword_BE240 = (__int64)dlsym(v3, v5);
  v6 = (const char *)sub_25FD0("pthread_create");
  qword_BE248 = (__int64)dlsym(v3, v6);
  v7 = (const char *)sub_2607C("pthread_join");
  qword_BE250 = (__int64)dlsym(v3, v7);
  v8 = (const char *)sub_26128("memcpy");
  qword_BE258 = (__int64)dlsym(v3, v8);
  v9 = (const char *)sub_261D4("malloc");
  qword_BE260 = (__int64)dlsym(v3, v9);
  v10 = (const char *)sub_26280("calloc");
  qword_BE268 = (__int64)dlsym(v3, v10);
  v11 = (const char *)sub_2632C("memset");
  qword_BE270 = (__int64)dlsym(v3, v11);
  v12 = (const char *)sub_263D8("fopen");
  qword_BE278 = (__int64)dlsym(v3, v12);
  v13 = (const char *)sub_26484("fclose");
  qword_BE280 = (__int64)dlsym(v3, v13);
  v14 = (const char *)sub_26530("fgets");
  qword_BE288 = (__int64)dlsym(v3, v14);
  v15 = (const char *)sub_265DC("strtoul");
  qword_BE290 = (__int64)dlsym(v3, v15);
  v16 = (const char *)sub_26688("strtoull");
  qword_BE298 = (__int64)dlsym(v3, v16);
  v17 = (const char *)sub_26734("strstr");
  qword_BE2A0 = (__int64)dlsym(v3, v17);
  v18 = (const char *)sub_267E0("ptrace");
  qword_BE2A8 = (__int64)dlsym(v3, v18);
  v19 = (const char *)sub_2688C("mprotect");
  qword_BE2B0 = (__int64)dlsym(v3, v19);
  v20 = (const char *)sub_26938("strlen");
  qword_BE2B8 = (__int64)dlsym(v3, v20);
  v21 = (const char *)sub_269E4("sscanf");
  qword_BE2C0 = (__int64)dlsym(v3, v21);
  v22 = (const char *)sub_26A90("free");
  qword_BE2C8 = (__int64)dlsym(v3, v22);
  v23 = (const char *)sub_26B3C("strdup");
  qword_BE2D0 = (__int64)dlsym(v3, v23);
  v24 = (const char *)sub_26BE8("strcmp");
  qword_BE2D8 = (__int64)dlsym(v3, v24);
  v25 = (const char *)sub_26C94("strcasecmp");
  qword_BE2E0 = (__int64)dlsym(v3, v25);
  v26 = (const char *)sub_26D40("utime");
  qword_BE2E8 = (__int64)dlsym(v3, v26);
  v27 = (const char *)sub_26DEC("mkdir");
  qword_BE2F0 = (__int64)dlsym(v3, v27);
  v28 = (const char *)sub_26E98("open");
  qword_BE2F8 = (__int64)dlsym(v3, v28);
  v29 = (const char *)sub_26F44("close");
  qword_BE300 = (__int64)dlsym(v3, v29);
  v30 = (const char *)sub_26FF0("unlink");
  qword_BE308 = (__int64)dlsym(v3, v30);
  v31 = (const char *)sub_2709C("stat");
  qword_BE310 = (__int64)dlsym(v3, v31);
  v32 = (const char *)sub_27148("time");
  qword_BE318 = (__int64)dlsym(v3, v32);
  v33 = (const char *)sub_271F4("snprintf");
  qword_BE320 = (__int64)dlsym(v3, v33);
  v34 = (const char *)sub_272A0("strchr");
  qword_BE328 = (__int64)dlsym(v3, v34);
  v35 = (const char *)sub_2734C("strncmp");
  qword_BE330 = (__int64)dlsym(v3, v35);
  v36 = (const char *)sub_273F8("pthread_detach");
  qword_BE338 = (__int64)dlsym(v3, v36);
  v37 = (const char *)sub_274A4("pthread_self");
  qword_BE340 = (__int64)dlsym(v3, v37);
  v38 = (const char *)sub_27550("opendir");
  qword_BE348 = (__int64)dlsym(v3, v38);
  v39 = (const char *)sub_275FC("readdir");
  qword_BE350 = (__int64)dlsym(v3, v39);
  v40 = (const char *)sub_276A8("closedir");
  qword_BE358 = (__int64)dlsym(v3, v40);
  v41 = (const char *)sub_27754("mmap");
  qword_BE360 = (__int64)dlsym(v3, v41);
  v42 = (const char *)sub_27800("munmap");
  qword_BE368 = (__int64)dlsym(v3, v42);
  v43 = (const char *)sub_278AC("lseek");
  qword_BE370 = (__int64)dlsym(v3, v43);
  v44 = (const char *)sub_27958("fstat");
  qword_BE378 = (__int64)dlsym(v3, v44);
  v45 = (const char *)sub_27A04("read");
  qword_BE380 = (__int64)dlsym(v3, v45);
  v46 = (const char *)sub_27AB0("select");
  qword_BE388 = (__int64)dlsym(v3, v46);
  v47 = (const char *)sub_27B5C("bsd_signal");
  qword_BE390 = (__int64)dlsym(v3, v47);
  v48 = (const char *)sub_27C08("fork");
  qword_BE398 = (__int64)dlsym(v3, v48);
  v49 = (const char *)sub_27CB4("prctl");
  qword_BE3A0 = (__int64)dlsym(v3, v49);
  v50 = (const char *)sub_27D60("setrlimit");
  qword_BE3A8 = (__int64)dlsym(v3, v50);
  v51 = (const char *)sub_27E0C("getppid");
  qword_BE3B0 = (__int64)dlsym(v3, v51);
  v52 = (const char *)sub_27EB8("getpid");
  qword_BE3B8 = (__int64)dlsym(v3, v52);
  v53 = (const char *)sub_27F64("waitpid");
  qword_BE3C0 = (__int64)dlsym(v3, v53);
  v54 = (const char *)sub_28010("kill");
  qword_BE3C8 = (__int64)dlsym(v3, v54);
  v55 = (const char *)sub_280BC("flock");
  qword_BE3D0 = (__int64)dlsym(v3, v55);
  v56 = (const char *)sub_28168("write");
  qword_BE3D8 = (__int64)dlsym(v3, v56);
  v57 = (const char *)sub_28214("execve");
  qword_BE3E0 = (__int64)dlsym(v3, v57);
  v58 = (const char *)sub_282C0("execv");
  qword_BE3E8 = (__int64)dlsym(v3, v58);
  v59 = (const char *)sub_2836C("execl");
  qword_BE3F0 = (__int64)dlsym(v3, v59);
  v60 = (const char *)sub_28418("sysconf");
  qword_BE3F8 = (__int64)dlsym(v3, v60);
  v61 = (const char *)sub_284C4("__system_property_get");
  qword_BE400 = (__int64)dlsym(v3, v61);
  v62 = (const char *)sub_28570("ftruncate");
  qword_BE408 = (__int64)dlsym(v3, v62);
  v63 = (const char *)sub_2861C("gettid");
  qword_BE410 = (__int64)dlsym(v3, v63);
  v64 = (const char *)sub_286C8("pread64");
  qword_BE418 = (__int64)dlsym(v3, v64);
  v65 = (const char *)sub_28774("pwrite64");
  qword_BE420 = (__int64)dlsym(v3, v65);
  v66 = (const char *)sub_28820("pread");
  qword_BE428 = (__int64)dlsym(v3, v66);
  v67 = (const char *)sub_288CC("pwrite");
  qword_BE430 = (__int64)dlsym(v3, v67);
  v68 = (const char *)sub_28A24("statvfs");
  qword_BE440 = (__int64)dlsym(v3, v68);
  return 1LL;
}