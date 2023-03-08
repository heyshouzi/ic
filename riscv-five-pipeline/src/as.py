# 导入必要的库
import sys

# 定义RISC-V指令的操作码
opcode = {
    "add": "0110011",
    "sub": "0110011",
    "and": "0110011",
    "or": "0110011",
    "xor": "0110011",
    "sll": "0110011",
    "srl": "0110011",
    "sra": "0110011",
    "slt": "0110011",
    "sltu": "0110011",
    "addi": "0010011",
    "andi": "0010011",
    "ori": "0010011",
    "xori": "0010011",
    "slti": "0010011",
    "sltiu": "0010011",
    "lb": "0000011",
    "lh": "0000011",
    "lw": "0000011",
    "lbu": "0000011",
    "lhu": "0000011",
    "sb": "0100011",
    "sh": "0100011",
    "sw": "0100011",
    "beq": "1100011",
    "bne": "1100011",
    "blt": "1100011",
    "bge": "1100011",
    "bltu": "1100011",
    "bgeu": "1100011",
    "jal": "1101111",
    "jalr": "1100111",
    "lui": "0110111",
    "auipc": "0010111",
}

# 定义RISC-V指令的寄存器编号
registers = {
    "x0": "00000",
    "x1": "00001",
    "x2": "00010",
    "x3": "00011",
    "x4": "00100",
    "x5": "00101",
    "x6": "00110",
    "x7": "00111",
    "x8": "01000",
    "x9": "01001",
    "x10": "01010",
    "x11": "01011",
    "x12": "01100",
    "x13": "01101",
    "x14": "01110",
    "x15": "01111",
    "x16": "10000",
    "x17": "10001",
    "x18": "10010",
    "x19": "10011",
    "x20": "10100",
    "x21": "10101",
    "x22": "10110",
    "x23": "10111",
    "x24": "11000",
    "x25": "11001",
    "x26": "11010",
    "x27": "11011",
    "x28": "11100",
    "x29": "11101",
    "x30": "11110",
    "x31": "11111"
}

# 定义一个函数，将指令转换为二进制代码
def assemble(instruction):
    # 将指令分成操作符和操作数
    parts = instruction.strip().split(" ")
    op = parts[0]
    
    # 生成二进制代码
    if op in ["add", "sub", "and", "or", "xor", "sll", "srl", "sra", "slt", "sltu"]:
        # R-type指令
        func3 = {"add": "000", "sub": "000", "and": "111", "or": "110", "xor": "100", "sll": "001", "srl": "101", "sra": "101", "slt": "010", "sltu": "011"}[op]
        rd, rs1, rs2 = [registers[p] for p in parts[1:]]
        return f"{int(func3, 2):03b}{rs2}{rs1}000{rd}{opcode[op]}"
    
    elif op in ["addi", "andi", "ori", "xori", "slti", "sltiu"]:
        # I-type指令
        func3 = {"addi": "000", "andi": "111", "ori": "110", "xori": "100", "slti": "010", "sltiu": "011"}[op]
        rd, rs1, imm = [registers[p] if "x" in p else f"{int(p):012b}" for p in parts[1:]]
        return f"{imm[-12:]}{rs1}{func3}{rd}{opcode[op]}"
    
    elif op in ["lb", "lh", "lw", "lbu", "lhu", "sb", "sh", "sw"]:
        # I-type指令，访问内存
        func3 = {"lb": "000", "lh": "001", "lw": "010", "lbu": "100", "lhu": "101", "sb": "000", "sh": "001", "sw": "010"}[op]
        imm, rs1, rd = [registers[p] if "x" in p else f"{int(p):012b}" for p in parts[1:]]
        imm = f"{int(imm, 2) + int(parts[2]):012b}" if op in ["lb", "lh", "lw", "lbu", "lhu"] else imm
        return f"{imm[-12:]}{rs1}{func3}{rd}{opcode[op]}"
    
    elif op in ["beq", "bne", "blt", "bge", "bltu", "bgeu"]:
        # B-type指令，分支
        func3 = {"beq": "000", "bne": "001", "blt": "100", "bge": "101", "bltu": "110","bgeu":"111"}[op]
                rs1, rs2 = [registers[p] for p in parts[1:3]]
        offset = f"{int(parts[3]) - instruction.index(instruction) - 1:012b}"
        return f"{offset[-12]}{offset[2:8]}{rs2}{rs1}{func3}{offset[8]}{opcode[op]}"
    
    elif op == "jal":
        # JAL指令
        rd, offset = [registers[p] if "x" in p else f"{int(p):020b}" for p in parts[1:]]
        return f"{offset[-20]}{offset[1:11]}{offset[11]}{offset[12:20]}{rd}{opcode[op]}"
    
    elif op == "jalr":
        # JALR指令
        rd, rs1, imm = [registers[p] if "x" in p else f"{int(p):012b}" for p in parts[1:]]
        return f"{int(imm, 2):012b}{rs1}000{rd}{opcode[op]}"
    
    elif op == "lui":
        # LUI指令
        rd, imm = [registers[p] if "x" in p else f"{int(p):020b}" for p in parts[1:]]
        return f"{imm}{rd}{opcode[op]}"
    
    elif op == "auipc":
        # AUIPC指令
        rd, imm = [registers[p] if "x" in p else f"{int(p):020b}" for p in parts[1:]]
        return f"{imm}{rs1}{opcode[op]}"

    else:
        raise Exception(f"Invalid instruction: {instruction}")



# 定义一个函数，处理输入和输出文件
def main(input_file, output_file):
    # 读入输入文件中的汇编代码
    with open(input_file, "r") as f:
        instructions = f.readlines()

    # 将每条指令转换为二进制代码
    binary_instructions = [assemble(instruction) for instruction in instructions]

    # 将结果写入输出文件
    with open(output_file, "w") as f:
        f.write("\n".join(binary_instructions))
