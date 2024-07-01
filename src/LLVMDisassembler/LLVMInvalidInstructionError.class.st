Class {
	#name : 'LLVMInvalidInstructionError',
	#superclass : 'Error',
	#instVars : [
		'instruction'
	],
	#category : 'LLVMDisassembler',
	#package : 'LLVMDisassembler'
}

{ #category : 'accessing' }
LLVMInvalidInstructionError >> instruction [
	^ instruction
]

{ #category : 'accessing' }
LLVMInvalidInstructionError >> instruction: anInteger [ 
	instruction := anInteger
]
