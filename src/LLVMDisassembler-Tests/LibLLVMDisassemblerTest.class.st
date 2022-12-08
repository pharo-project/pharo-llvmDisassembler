"
A LibLLVMDisassemblerTest is a test class for testing the behavior of LibLLVMDisassembler
"
Class {
	#name : #LibLLVMDisassemblerTest,
	#superclass : #TestCase,
	#instVars : [
		'llvmDisasm'
	],
	#category : #'LLVMDisassembler-Tests'
}

{ #category : #running }
LibLLVMDisassemblerTest >> setUp [

	super setUp.
	llvmDisasm := LibLLVMDisassembler uniqueInstance.
]

{ #category : #tests }
LibLLVMDisassemblerTest >> testKnownMacPaths [

	self assert: (llvmDisasm knownMacPaths isKindOf: Collection).
	self assert: llvmDisasm knownMacPaths notEmpty.
	self assert: llvmDisasm knownMacPaths anyOne notEmpty.
	self assert: llvmDisasm knownMacPaths anyOne isString.

]

{ #category : #tests }
LibLLVMDisassemblerTest >> testMacModuleName [

	(Smalltalk os isMacOSX or: [ Smalltalk os isMacOS ])
		ifFalse: [ self skip ].
	self assert: (llvmDisasm macModuleName isKindOf: String).
	self deny: llvmDisasm macModuleName isEmpty.
]
