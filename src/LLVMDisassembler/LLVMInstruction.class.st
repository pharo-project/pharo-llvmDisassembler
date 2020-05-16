Class {
	#name : #LLVMInstruction,
	#superclass : #Object,
	#instVars : [
		'assembly',
		'size',
		'address',
		'offset'
	],
	#category : #LLVMDisassembler
}

{ #category : #accessing }
LLVMInstruction >> address [
	^ address
]

{ #category : #accessing }
LLVMInstruction >> address: anObject [
	address := anObject
]

{ #category : #accessing }
LLVMInstruction >> assembly [
	^ assembly
]

{ #category : #accessing }
LLVMInstruction >> assembly: aString [ 
	assembly := aString
]

{ #category : #accessing }
LLVMInstruction >> assemblyCodeString [
	
	^ assembly
]

{ #category : #accessing }
LLVMInstruction >> offset [
	^ offset
]

{ #category : #accessing }
LLVMInstruction >> offset: anObject [
	offset := anObject
]

{ #category : #accessing }
LLVMInstruction >> printOn: aStream [

	aStream
		nextPutAll: (address printStringBase: 16 length: 8 padded: true);
		nextPutAll: ':';
		tab;
		nextPutAll: assembly
]

{ #category : #accessing }
LLVMInstruction >> size [
	^ size
]

{ #category : #accessing }
LLVMInstruction >> size: anInteger [ 
	size := anInteger
]
