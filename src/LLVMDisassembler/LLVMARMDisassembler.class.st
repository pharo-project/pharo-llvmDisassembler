Class {
	#name : 'LLVMARMDisassembler',
	#superclass : 'LLVMDisassembler',
	#category : 'LLVMDisassembler',
	#package : 'LLVMDisassembler'
}

{ #category : 'factory' }
LLVMARMDisassembler >> newInstruction [

	^ LLVMARMInstruction new
]

{ #category : 'factory' }
LLVMARMDisassembler >> newInvalidInstruction: bytes address: address [

	| instruction hex |
	instruction := self newInstruction.
	instruction address: address.
	instruction size: 4.

	hex := bytes size >= 4
		       ifTrue: [ (bytes integerAt: 1 size: 4 signed: false) hex ]
		       ifFalse: [ bytes hex ].
	instruction assembly: '.inst undefined ' , hex.

	^ instruction
]
