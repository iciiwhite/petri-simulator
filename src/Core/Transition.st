Class {
  #name : #Transition,
  #superclass : #Object,
  #instVars : [
    'name',
    'guardBlock',
    'incomingArcs',
    'outgoingArcs'
  ],
  #category : #'PetriSimulator-Core'
}

Transition >> initialize
  super initialize.
  incomingArcs := OrderedCollection new.
  outgoingArcs := OrderedCollection new.

Transition >> name: aString
  name := aString.

Transition >> name
  ^ name.

Transition >> guard: aBlock
  guardBlock := aBlock.

Transition >> guard
  ^ guardBlock.

Transition >> addIncomingArc: anArc
  incomingArcs add: anArc.

Transition >> addOutgoingArc: anArc
  outgoingArcs add: anArc.

Transition >> incomingArcs
  ^ incomingArcs.

Transition >> outgoingArcs
  ^ outgoingArcs.

Transition >> isEnabledIn: aPetriNet
  | enabled |
  guardBlock ifNotNil: [ (guardBlock valueWithPossibleArguments: {aPetriNet}) ifFalse: [ ^ false ] ].
  incomingArcs do: [ :arc | 
    (arc isEnabledIn: aPetriNet) ifFalse: [ ^ false ] ].
  ^ true.

Transition >> fireIn: aPetriNet
  incomingArcs do: [ :arc | arc fireIn: aPetriNet ].
  outgoingArcs do: [ :arc | arc fireIn: aPetriNet ].

Transition >> printOn: aStream
  super printOn: aStream.
  aStream nextPutAll: ' (', name, ')'.