Class {
  #name : #PetriSimulationPanel,
  #superclass : #PanelMorph,
  #instVars : [
    'simulator',
    'stepButton',
    'startButton',
    'stopButton',
    'resetButton',
    'speedSlider'
  ],
  #category : #'PetriSimulator-GUI'
}

PetriSimulationPanel >> initialize
  super initialize.
  self layoutPolicy: RowLayout new.
  self extent: 400 @ 30.
  self color: Color lightGray.
  stepButton := SimpleButtonMorph new.
  stepButton label: 'Step'.
  stepButton action: [ simulator step ].
  startButton := SimpleButtonMorph new.
  startButton label: 'Start'.
  startButton action: [ simulator start ].
  stopButton := SimpleButtonMorph new.
  stopButton label: 'Stop'.
  stopButton action: [ simulator stop ].
  resetButton := SimpleButtonMorph new.
  resetButton label: 'Reset'.
  resetButton action: [ simulator reset ].
  speedSlider := SliderMorph new.
  speedSlider target: self.
  speedSlider actionSelector: #changeSpeed:.
  self addMorph: stepButton.
  self addMorph: startButton.
  self addMorph: stopButton.
  self addMorph: resetButton.
  self addMorph: speedSlider.

PetriSimulationPanel >> simulator: aSimulator
  simulator := aSimulator.

PetriSimulationPanel >> changeSpeed: aNumber
  simulator stepDelay: (aNumber * 1000) asInteger max: 50.