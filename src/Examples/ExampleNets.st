Class {
  #name : #ExampleNets,
  #superclass : #Object,
  #category : #'PetriSimulator-Examples'
}

ExampleNets class >> simpleNet
  ^ (PetriNetBuilder new)
      name: 'SimpleNet';
      addPlaceNamed: 'p1' initialTokens: 1;
      addPlaceNamed: 'p2' initialTokens: 0;
      addTransitionNamed: 't1';
      addArcFrom: 'p1' to: 't1';
      addArcFrom: 't1' to: 'p2';
      build.

ExampleNets class >> conflictNet
  ^ (PetriNetBuilder new)
      name: 'Conflict';
      addPlaceNamed: 'p1' initialTokens: 1;
      addTransitionNamed: 't1';
      addTransitionNamed: 't2';
      addPlaceNamed: 'p2' initialTokens: 0;
      addPlaceNamed: 'p3' initialTokens: 0;
      addArcFrom: 'p1' to: 't1';
      addArcFrom: 'p1' to: 't2';
      addArcFrom: 't1' to: 'p2';
      addArcFrom: 't2' to: 'p3';
      build.

ExampleNets class >> loopNet
  ^ (PetriNetBuilder new)
      name: 'Loop';
      addPlaceNamed: 'p1' initialTokens: 1;
      addTransitionNamed: 't1';
      addArcFrom: 'p1' to: 't1';
      addArcFrom: 't1' to: 'p1';
      build.