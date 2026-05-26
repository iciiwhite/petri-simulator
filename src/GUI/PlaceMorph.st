Class {
  #name : #PlaceMorph,
  #superclass : #EllipseMorph,
  #instVars : [
    'place',
    'labelMorph',
    'tokenLabel'
  ],
  #category : #'PetriSimulator-GUI'
}

PlaceMorph >> initialize
  super initialize.
  self extent: 40 @ 40.
  self color: Color yellow.
  self borderWidth: 2.
  labelMorph := StringMorph new.
  labelMorph position: self position + (10 @ -20).
  self addMorph: labelMorph.
  tokenLabel := StringMorph new.
  tokenLabel position: self position + (10 @ 45).
  self addMorph: tokenLabel.

PlaceMorph >> place: aPlace
  place := aPlace.
  labelMorph contents: place name.
  self updateTokens.

PlaceMorph >> updateTokens
  tokenLabel contents: place tokens printString.

PlaceMorph >> mouseDown: anEvent
  anEvent shiftPressed ifTrue: [ 
    place addTokens: 1.
    self updateTokens.
    ^ self ].
  anEvent ctrlPressed ifTrue: [ 
    place removeTokens: 1.
    self updateTokens ].
  super mouseDown: anEvent.

PlaceMorph >> position: aPoint
  super position: aPoint.
  labelMorph position: aPoint + (10 @ -20).
  tokenLabel position: aPoint + (10 @ 45).