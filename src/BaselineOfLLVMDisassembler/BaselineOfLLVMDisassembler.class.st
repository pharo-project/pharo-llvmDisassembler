Class {
	#name : #BaselineOfLLVMDisassembler,
	#superclass : #BaselineOf,
	#category : #BaselineOfLLVMDisassembler
}

{ #category : #baselines }
BaselineOfLLVMDisassembler >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			spec 
				package: 'LLVMDisassembler';
				package: 'LLVMDisassembler-Tests' with: [ spec requires: #('LLVMDisassembler') ].
			spec
				group: 'Core' with: #('LLVMDisassembler');
				group: 'Tests' with: #('Core' 'LLVMDisassembler-Tests');
				group: 'default' with: #('Core') ]
]

{ #category : #accessing }
BaselineOfLLVMDisassembler >> project [

	^ super project
		loadType: #atomic;
		yourself
]
