Class {
  #name : #Token,
  #superclass : #Object,
  #instVars : [
    'color'
  ],
  #category : #'PetriSimulator-Core'
}

Token >> initialize
  super initialize.
  color := #black.

Token >> color: aSymbol
  color := aSymbol.

Token >> color
  ^ color.

Token >> printOn: aStream
  super printOn: aStream.
  aStream nextPutAll: ' (', color, ')'.