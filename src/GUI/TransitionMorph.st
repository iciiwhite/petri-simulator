Class {
  #name : #TransitionMorph,
  #superclass : #RectangleMorph,
  #instVars : [
    'transition',
    'labelMorph'
  ],
  #category : #'PetriSimulator-GUI'
}

TransitionMorph >> initialize
  super initialize.
  self extent: 30 @ 50.
  self color: Color gray.
  self borderWidth: 1.
  labelMorph := StringMorph new.
  labelMorph position: self position + (0 @ -15).
  self addMorph: labelMorph.

TransitionMorph >> transition: aTransition
  transition := aTransition.
  labelMorph contents: transition name.

TransitionMorph >> updateEnabled
  | sim |
  sim := self owner ifNotNil: [ self owner valueOfProperty: #simulator ].
  sim ifNil: [ ^ self ].
  (sim isEnabled: transition) ifTrue: [ 
    self color: Color green ]
  ifFalse: [ 
    self color: Color gray ].

TransitionMorph >> mouseDown: anEvent
  | sim |
  sim := self owner ifNotNil: [ self owner valueOfProperty: #simulator ].
  sim ifNotNil: [ sim fireTransition: transition ].