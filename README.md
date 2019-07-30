# LLVMDisassembler
Pharo bindings to the LLVM disassembler.

# Usage

To create a disassembler, you can use the #createDisassembler: method using a triple name as argument.

```smalltalk
LLVMDisassembler createDisassembler: 'x86_64'.
```

Or use one of the predefined factory methods in the class side such as:

```smalltalk
LLVMDisassembler i386.
LLVMDisassembler arm.
```

The main method of the disassembler is #disassembleInstructionIn:pc: which receives the bytes to disassemble and the current program counter. This method disassembles a single instructions and returns the disassembled text and the number of bytes of the instruction

```smalltalk
x86_CODE32 := #[ 16r41 ]. "INC ecx"
llvmDisassembler disassembleInstructionIn: x86_CODE32 pc: 0.
   => #('incl	%ecx' 1)
```

Alternatively, the convenience method #disassembleNext:instructionsIn:pc: disassembles the next N instructions in the byte array.
