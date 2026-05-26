Class {
  #name : #FiringRule,
  #superclass : #Object,
  #instVars : [
    'pre',
    'post'
  ],
  #category : #'PetriSimulator-Core'
}

FiringRule >> initialize
  super initialize.
  pre := Dictionary new.
  post := Dictionary new.

FiringRule >> pre: placeName tokens: anInteger
  pre at: placeName put: anInteger.

FiringRule >> post: placeName tokens: anInteger
  post at: placeName put: anInteger.

FiringRule >> pre
  ^ pre.

FiringRule >> post
  ^ post.

FiringRule >> isEnabledIn: aPetriNet
  pre keysAndValuesDo: [ :pName :required | 
    | place |
    place := aPetriNet placeNamed: pName.
    place ifNil: [ ^ false ].
    (place tokens < required) ifTrue: [ ^ false ] ].
  ^ true.

FiringRule >> fireIn: aPetriNet
  pre keysAndValuesDo: [ :pName :required | 
    | place |
    place := aPetriNet placeNamed: pName.
    place removeTokens: required ].
  post keysAndValuesDo: [ :pName :added | 
    | place |
    place := aPetriNet placeNamed: pName.
    place addTokens: added ].