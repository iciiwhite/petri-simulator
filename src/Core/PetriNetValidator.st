Class {
  #name : #PetriNetValidator,
  #superclass : #Object,
  #instVars : [
    'net'
  ],
  #category : #'PetriSimulator-Core'
}

PetriNetValidator >> on: aPetriNet
  net := aPetriNet.

PetriNetValidator >> validate
  | errors |
  errors := OrderedCollection new.
  net places do: [ :p | 
    (p tokens < 0) ifTrue: [ errors add: 'Place ', p name, ' has negative tokens' ].
    (p capacity notNil and: [ p tokens > p capacity ]) ifTrue: [ 
      errors add: 'Place ', p name, ' exceeds capacity' ] ].
  net transitions do: [ :t | 
    (t incomingArcs isEmpty and: [ t outgoingArcs isEmpty ]) ifTrue: [ 
      errors add: 'Transition ', t name, ' is isolated' ] ].
  net arcs do: [ :a | 
    (a weight <= 0) ifTrue: [ errors add: 'Arc weight must be positive' ] ].
  ^ errors.

PetriNetValidator >> hasDeadTransitions
  ^ net transitions anySatisfy: [ :t | (net isEnabled: t) not ].

PetriNetValidator >> hasLiveTransitions
  ^ net transitions anySatisfy: [ :t | net isEnabled: t ].

PetriNetValidator >> printErrors
  (self validate) do: [ :e | Transcript show: e; cr ].