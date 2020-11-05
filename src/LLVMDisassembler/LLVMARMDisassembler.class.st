Class {
	#name : #LLVMARMDisassembler,
	#superclass : #LLVMDisassembler,
	#category : #LLVMDisassembler
}

{ #category : #disassembling }
LLVMARMDisassembler >> disassembleInstructionBytes: instructionBytes address: startAddress pc: pc [

	| result |

		[ result := self disassembleInstructionIn: instructionBytes pc: pc ]
			on: LLVMInvalidInstructionError
			do: [ ^ self newInvalidInstruction: instructionBytes address: startAddress ].
		
		result address: startAddress.
		
		^ result
]

{ #category : #factory }
LLVMARMDisassembler >> newInstruction [

	^ LLVMARMInstruction new
]

{ #category : #factory }
LLVMARMDisassembler >> newInvalidInstruction: bytes address: address [ 
	
	| instruction |

	instruction := self newInstruction.
	instruction address: address.
	instruction size: 4.
	instruction assembly: '.inst undefined ', (bytes integerAt: 1 size: 4 signed: false) hex.

	^ instruction 
	
]
