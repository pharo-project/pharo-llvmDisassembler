Class {
	#name : 'LLVMRV64Disassembler',
	#superclass : 'LLVMDisassembler',
	#category : 'LLVMDisassembler',
	#package : 'LLVMDisassembler'
}

{ #category : 'instance creation' }
LLVMRV64Disassembler >> newInstruction [ 

	^ LLVMRV64Instruction new
]
