Class {
  #name : #PetriNet,
  #superclass : #Object,
  #instVars : [
    'places',
    'transitions',
    'arcs',
    'name'
  ],
  #category : #'PetriSimulator-Core'
}

PetriNet >> initialize
  places := Dictionary new.
  transitions := Dictionary new.
  arcs := OrderedCollection new.
  name := ''.

PetriNet >> name: aString
  name := aString.

PetriNet >> name
  ^ name.

PetriNet >> addPlace: aPlace
  places at: aPlace name put: aPlace.

PetriNet >> addTransition: aTransition
  transitions at: aTransition name put: aTransition.

PetriNet >> addArc: anArc
  arcs add: anArc.
  anArc source = nil ifFalse: [ 
    (anArc source isKindOf: Place) ifTrue: [ 
      anArc source addOutgoingArc: anArc ].
    (anArc source isKindOf: Transition) ifTrue: [ 
      anArc source addOutgoingArc: anArc ] ].
  anArc target = nil ifFalse: [ 
    (anArc target isKindOf: Place) ifTrue: [ 
      anArc target addIncomingArc: anArc ].
    (anArc target isKindOf: Transition) ifTrue: [ 
      anArc target addIncomingArc: anArc ] ].

PetriNet >> placeNamed: aString
  ^ places at: aString ifAbsent: [ nil ].

PetriNet >> transitionNamed: aString
  ^ transitions at: aString ifAbsent: [ nil ].

PetriNet >> places
  ^ places values.

PetriNet >> transitions
  ^ transitions values.

PetriNet >> arcs
  ^ arcs.

PetriNet >> isEnabled: aTransition
  ^ aTransition isEnabledIn: self.

PetriNet >> fireTransition: aTransition
  (self isEnabled: aTransition) ifFalse: [ ^ false ].
  aTransition fireIn: self.
  ^ true.

PetriNet >> step
  | enabled |
  enabled := self transitions select: [ :t | self isEnabled: t ].
  enabled ifEmpty: [ ^ false ].
  self fireTransition: enabled anyOne.
  ^ true.

PetriNet >> currentMarking
  | marking |
  marking := Marking new.
  self places do: [ :p | marking at: p put: p tokens ].
  ^ marking.

PetriNet >> reset
  self places do: [ :p | p reset ].

PetriNet >> printOn: aStream
  super printOn: aStream.
  aStream nextPutAll: ' (', name, ')'.