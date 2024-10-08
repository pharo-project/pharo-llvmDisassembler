Class {
	#name : 'LLVMInstruction',
	#superclass : 'Object',
	#instVars : [
		'assembly',
		'size',
		'address',
		'offset'
	],
	#category : 'LLVMDisassembler',
	#package : 'LLVMDisassembler'
}

{ #category : 'accessing' }
LLVMInstruction >> address [
	^ address
]

{ #category : 'accessing' }
LLVMInstruction >> address: anObject [
	address := anObject
]

{ #category : 'accessing' }
LLVMInstruction >> assembly [
	^ assembly
]

{ #category : 'accessing' }
LLVMInstruction >> assembly: aString [ 
	assembly := aString
]

{ #category : 'accessing' }
LLVMInstruction >> assemblyCodeString [
	
	^ assembly
]

{ #category : 'accessing' }
LLVMInstruction >> branchTargetAddress [
	
	^ nil
]

{ #category : 'accessing' }
LLVMInstruction >> codeBytes: memory [
	
	^ memory copyFrom: address to: address + size - 1
]

{ #category : 'accessing' }
LLVMInstruction >> codeBytesString: memory [
	
	^ (self codeBytes: memory) printString
]

{ #category : 'accessing' }
LLVMInstruction >> offset [
	^ offset
]

{ #category : 'accessing' }
LLVMInstruction >> offset: anObject [
	offset := anObject
]

{ #category : 'accessing' }
LLVMInstruction >> printOn: aStream [

	aStream
		print: (address ifNotNil: [(address printStringBase: 16 length: 8 padded: true)]);
		nextPutAll: ':';
		tab;
		nextPutAll: assembly
]

{ #category : 'accessing' }
LLVMInstruction >> size [
	^ size
]

{ #category : 'accessing' }
LLVMInstruction >> size: anInteger [ 
	size := anInteger
]
