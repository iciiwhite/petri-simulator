Class {
  #name : #PetriNetEditor,
  #superclass : #SystemWindow,
  #instVars : [
    'netMorph',
    'simulator',
    'toolbar'
  ],
  #category : #'PetriSimulator-GUI'
}

PetriNetEditor >> initialize
  super initialize.
  self extent: 900 @ 700.
  self title: 'Petri Net Editor'.
  self createToolbar.
  self createCanvas.

PetriNetEditor >> createToolbar
  toolbar := PanelMorph new.
  toolbar layoutPolicy: RowLayout new.
  toolbar extent: 900 @ 40.
  toolbar color: Color lightGray.
  self addMorph: toolbar atIndex: 1.
  self addButton: 'Step' action: [ simulator step ].
  self addButton: 'Start' action: [ simulator start ].
  self addButton: 'Stop' action: [ simulator stop ].
  self addButton: 'Reset' action: [ simulator reset ].

PetriNetEditor >> addButton: label action: aBlock
  | btn |
  btn := SimpleButtonMorph new.
  btn label: label.
  btn target: aBlock.
  btn actionSelector: #value.
  toolbar addMorph: btn.

PetriNetEditor >> createCanvas
  netMorph := PetriNetMorph new.
  netMorph setProperty: #simulator toValue: simulator.
  self addMorph: netMorph fullFrame: LayoutFrame identity.

PetriNetEditor >> loadNet: aPetriNet
  netMorph net: aPetriNet.
  simulator ifNotNil: [ simulator stop ].
  simulator := PetriNetSimulator on: aPetriNet.
  simulator addSubscriber: netMorph.
  netMorph setProperty: #simulator toValue: simulator.