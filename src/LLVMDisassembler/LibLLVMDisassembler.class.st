Class {
	#name : #LibLLVMDisassembler,
	#superclass : #FFILibrary,
	#category : #LLVMDisassembler
}

{ #category : #'accessing platform' }
LibLLVMDisassembler >> macModuleName [
	^ 'libLLVM.dylib'
]

{ #category : #'accessing platform' }
LibLLVMDisassembler >> unixModuleName [
	^ 'libLLVM-9.so'
]

{ #category : #'accessing platform' }
LibLLVMDisassembler >> win32ModuleName [
	^ 'libLLVM.dll'
]
