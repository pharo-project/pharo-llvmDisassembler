Class {
	#name : #LLVMARMInstructionTest,
	#superclass : #TestCase,
	#category : #'LLVMDisassembler-Tests'
}

{ #category : #utils }
LLVMARMInstructionTest >> disassemble: bytes [ 

	^ LLVMARMDisassembler aarch64 disassembleInstructionIn: bytes pc: 0

]

{ #category : #tests }
LLVMARMInstructionTest >> testBranchEqualsRelativeHasCorrectAddress [

	| inst |
	"b.ne #-44"
	inst := self disassemble: #[161 254 255 84].
	inst address: 16r10000.
	
	self assert: inst branchTargetAddress equals: 16r10000 - 44
]

{ #category : #tests }
LLVMARMInstructionTest >> testNopInstructionDoesNotHaveBranchTargetAddress [

	| inst |
	inst := self disassemble: #[31 32 3 213].
	self assert: inst branchTargetAddress equals: nil
]
