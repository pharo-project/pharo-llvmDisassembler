Class {
	#name : #LibLLVMDisassembler,
	#superclass : #FFILibrary,
	#category : #LLVMDisassembler
}

{ #category : #'accessing platform' }
LibLLVMDisassembler >> knownMacPaths [
	"Answer a <Collection> of <String> each one representing known libLLVM locations (not necessarily present in the current system"
	
	^ { 
		(LibC resultOfCommand: 'llvm-config --libdir') trimBoth .
		'/usr/local/opt/llvm/lib' 
		}
]

{ #category : #'accessing platform' }
LibLLVMDisassembler >> macModuleName [
	"Answer a <String> with the full path to the LLVM library"
	
	^ FFIMacLibraryFinder new
		userPaths: self knownMacPaths;
		findLibrary: 'libLLVM.dylib'
]

{ #category : #'accessing platform' }
LibLLVMDisassembler >> unixModuleName [
	^ 'libLLVM-9.so'
]

{ #category : #'accessing platform' }
LibLLVMDisassembler >> win32ModuleName [
	^ 'libLLVM.dll'
]
