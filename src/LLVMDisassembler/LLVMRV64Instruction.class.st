Class {
	#name : 'LLVMRV64Instruction',
	#superclass : 'LLVMInstruction',
	#category : 'LLVMDisassembler',
	#package : 'LLVMDisassembler'
}

{ #category : 'accessing' }
LLVMRV64Instruction >> branchTargetAddress [
	
	| parts |
	parts := self assembly substrings.
		
	(#(beq beqz bge bgeu bgez bgt bgtu bgtz ble bleu blt bltz bltu bne bnez j jal) includes: (parts first splitOn: $.) first)
		ifTrue: [ ^ self address + (self parseImmediate: parts last) ].
	
	^ nil.
]

{ #category : 'accessing' }
LLVMRV64Instruction >> parseImmediate: aString [

	^ aString asInteger
]
