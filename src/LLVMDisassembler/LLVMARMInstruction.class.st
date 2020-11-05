Class {
	#name : #LLVMARMInstruction,
	#superclass : #LLVMInstruction,
	#category : #LLVMDisassembler
}

{ #category : #accessing }
LLVMARMInstruction >> branchTargetAddress [
	
	| parts |
	parts := self assembly substrings.
		
	(#(b bl) includes: (parts first splitOn: $.) first)
		ifTrue: [ ^ self address + (self parseImmediate: parts last) ].
	
	^ nil.
]

{ #category : #private }
LLVMARMInstruction >> parseImmediate: aString [

	| immediateString |

	immediateString := aString first = $#
		                   ifTrue: [ aString allButFirst ]
		                   ifFalse: [ self halt ].
		
	^ immediateString asInteger
]
