Class {
  #name : #PetriNetSimulator,
  #superclass : #Object,
  #instVars : [
    'net',
    'isRunning',
    'stepDelay',
    'subscribers'
  ],
  #category : #'PetriSimulator-Core'
}

PetriNetSimulator >> on: aPetriNet
  net := aPetriNet.
  isRunning := false.
  stepDelay := 500.
  subscribers := OrderedCollection new.

PetriNetSimulator >> step
  | result |
  result := net step.
  self notifySubscribers.
  ^ result.

PetriNetSimulator >> autoStep
  [ isRunning ] whileTrue: [ 
    (self step) ifFalse: [ isRunning := false ].
    (Delay forMilliseconds: stepDelay) wait ].

PetriNetSimulator >> start
  isRunning := true.
  [ self autoStep ] fork.

PetriNetSimulator >> stop
  isRunning := false.

PetriNetSimulator >> reset
  net reset.
  self notifySubscribers.

PetriNetSimulator >> stepDelay: milliseconds
  stepDelay := milliseconds.

PetriNetSimulator >> stepDelay
  ^ stepDelay.

PetriNetSimulator >> addSubscriber: anObject
  subscribers add: anObject.

PetriNetSimulator >> removeSubscriber: anObject
  subscribers remove: anObject.

PetriNetSimulator >> notifySubscribers
  subscribers do: [ :sub | sub updateSimulator: self ].