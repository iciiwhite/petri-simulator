Class {
  #name : #AnimationController,
  #superclass : #Object,
  #instVars : [
    'simulator',
    'animations'
  ],
  #category : #'PetriSimulator-GUI'
}

AnimationController >> on: aSimulator
  simulator := aSimulator.
  animations := OrderedCollection new.

AnimationController >> animateFiring: aTransition
  | anim |
  anim := [ 
    aTransition incomingArcs do: [ :arc | self animateArc: arc ].
    aTransition outgoingArcs do: [ :arc | self animateArc: arc ] ].
  animations add: anim.
  anim fork.

AnimationController >> animateArc: anArc
  | sourcePos targetPos steps delay |
  sourcePos := self positionOf: anArc source.
  targetPos := self positionOf: anArc target.
  steps := 10.
  delay := 20.
  1 to: steps do: [ :i | 
    | t |
    t := i / steps.
    self showTokenAt: (sourcePos * (1 - t) + (targetPos * t)).
    (Delay forMilliseconds: delay) wait ].
  self hideToken.

AnimationController >> positionOf: aNode
  ^ 0 @ 0.

AnimationController >> showTokenAt: aPoint
  ^ self.

AnimationController >> hideToken
  ^ self.