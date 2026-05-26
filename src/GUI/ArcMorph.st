Class {
  #name : #ArcMorph,
  #superclass : #LineMorph,
  #instVars : [
    'weightLabel',
    'weight'
  ],
  #category : #'PetriSimulator-GUI'
}

ArcMorph >> from: startMorph to: endMorph
  self from: startMorph center to: endMorph center.
  weightLabel := StringMorph new.
  weightLabel position: self center.
  self addMorph: weightLabel.

ArcMorph >> weight: anInteger
  weight := anInteger.
  weightLabel contents: weight printString.

ArcMorph >> updatePosition
  super updatePosition.
  weightLabel position: self center.