Extension { #name : 'Integer' }

{ #category : '*LLVMDisassembler' }
Integer >> riscv32Disassembled [
	
	^ self disassembleWith: LLVMDisassembler riscv32
]

{ #category : '*LLVMDisassembler' }
Integer >> riscv64Disassembled [
	
	^ self disassembleWith: LLVMDisassembler riscv64
]
