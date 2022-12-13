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
				package: 'LLVMDissasembler-Tests' with: [ spec requires: #('LLVMDisassembler') ].
			spec
				group: 'Core' with: #('LLVMDisassembler');
				group: 'Tests' with: #('Core' 'LLVMDissasembler-Tests');
				group: 'default' with: #('Core') ]
]

{ #category : #accessing }
BaselineOfLLVMDisassembler >> project [

	^ super project
		loadType: #atomic;
		yourself
]
