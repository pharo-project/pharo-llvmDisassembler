Class {
	#name : #LibLLVMDisassembler,
	#superclass : #FFILibrary,
	#category : #LLVMDisassembler
}

{ #category : #'accessing platform' }
LibLLVMDisassembler >> knownMacPaths [
	"Answer a <Collection> of <String> each one representing known libLLVM locations (not necessarily present in the current system"
	
	^ { 
		"Try finding the one using llvm-config"
		(LibC resultOfCommand: 'llvm-config --libdir') trimBoth .
		
		"New versions of homebrew put llvm in the following path,
		not globally visible to avoid conflicts with the XCode's installation"
		'/opt/homebrew/opt/llvm/lib'.
		
		"Old homebrew versions"
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
