Class {
	#name : #BaselineOfLLVMDisassembler,
	#superclass : #BaselineOf,
	#category : #BaselineOfLLVMDisassembler
}

{ #category : #baseline }
BaselineOfLLVMDisassembler >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec package: 'LLVMDisassembler' ]
]

{ #category : #accessing }
BaselineOfLLVMDisassembler >> project [

	^ super project
		loadType: #atomic;
		yourself
]
