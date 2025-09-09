mem_depth = 32
header = "memory_initialization_radix=16;\nmemory_initialization_vector=\n"

with open("mem_init.coe", "w") as f:
    f.write(header)

    for i in range(mem_depth-1):
        f.write(str(hex(i))[2:]+",\n")
    
    f.write(str(hex(mem_depth-1))[2:]+";\n")