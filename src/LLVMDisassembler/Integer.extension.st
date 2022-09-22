Extension { #name : #Integer }

{ #category : #'*LLVMDisassembler' }
Integer >> aarch64Disassembled [
	
	^ self disassembleWith: LLVMARMDisassembler aarch64
]

{ #category : #'*LLVMDisassembler' }
Integer >> disassembleWith: aLLVMDisassembler [ 
	
	"Create a byte array big enough to encode the instruction"
	| array |
	array := ByteArray new: 4.
	array integerAt: 1 put: self size: array size signed: false.
	^ aLLVMDisassembler disassembleInstructionIn: array pc: 0
]

{ #category : #'*LLVMDisassembler' }
Integer >> riscv32Disassembled [
	
	^ self disassembleWith: LLVMDisassembler riscv32
]

{ #category : #'*LLVMDisassembler' }
Integer >> riscv64Disassembled [
	
	^ self disassembleWith: LLVMDisassembler riscv64
]
