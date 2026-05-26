Class {
  #name : #ProducerConsumerNet,
  #superclass : #Object,
  #category : #'PetriSimulator-Examples'
}

ProducerConsumerNet class >> newNetWithBufferSize: bufferSize
  ^ (PetriNetBuilder new)
      name: 'ProducerConsumer';
      addPlaceNamed: 'ready' initialTokens: 1;
      addPlaceNamed: 'buffer' initialTokens: 0;
      addPlaceNamed: 'full' initialTokens: 0;
      addPlaceNamed: 'empty' initialTokens: bufferSize;
      addTransitionNamed: 'produce';
      addTransitionNamed: 'consume';
      addArcFrom: 'ready' to: 'produce';
      addArcFrom: 'empty' to: 'produce' weight: 1;
      addArcFrom: 'produce' to: 'buffer' weight: 1;
      addArcFrom: 'produce' to: 'full' weight: 1;
      addArcFrom: 'produce' to: 'ready';
      addArcFrom: 'full' to: 'consume' weight: 1;
      addArcFrom: 'consume' to: 'empty' weight: 1;
      addArcFrom: 'consume' to: 'ready';
      build.