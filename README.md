# MicroLab_lab01

M4	Programming	Manual:
    http://www.st.com/content/ccc/resource/technical/document/programming_manual/6c/3a/cb/e7/e4/ea/44/9b/DM00046982.pdf/files/DM00046982.pdf/jcr:content/translations/en.DM00046982.pdf

10.6. Convert between integer and float

    vcvt_f32_s32(Sd, Sm) Sd = float(Sm)
    vcvt_s32_f32(Sd, Sm) Sd = int(Sm)

fault:
    ▪ HardFault: is the default exception and can be triggered because of an error during exception
    processing, or because an exception cannot be managed by any other exception mechanism.
    ▪ MemManage: detects memory access violations to regions that are defined in the Memory
    Management Unit (MPU); for example, code execution from a memory region with read/write access
    only.
    ▪ BusFault: detects memory access errors on instruction fetch, data read/write, interrupt vector fetch,
    and register stacking (save/restore) on interrupt (entry/exit).
    ▪ UsageFault: detects execution of undefined instructions, unaligned memory access for load/store
    multiple. When enabled, divide-by-zero and other unaligned memory accesses are detected. 
