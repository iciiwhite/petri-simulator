# Petri Net Simulator for Smalltalk

A complete Petri net simulation and analysis environment written in Pharo Smalltalk.

## Features

- Place/Transition nets with weighted arcs
- Step‑by‑step or automatic simulation
- Graphical editor using Morphic (places, transitions, arcs)
- Token animation during firing
- Reachability graph explorer
- P‑invariant and T‑invariant analysis (via incidence matrix)
- Liveness and deadlock checking
- JSON and PNML import/export
- Built‑in examples (simple net, conflict, loop, dining philosophers, producer‑consumer)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourname/petri-simulator.git
```

1. Open Pharo (version 8+ recommended).
2. Drag all .st files from src/ into the Pharo image in order:
   · Core/ first
   · then Analysis/, IO/, Examples/
   · then GUI/
   · finally Tests/
3. (Optional) Run tests:
   ```smalltalk
   PetriNetTest suite run.
   SimulatorTest suite run.
   IOTest suite run.
   ```

Quick Start

```smalltalk
net := ExampleNets simpleNet.
editor := PetriNetEditor new.
editor loadNet: net.
editor openInWorld.
```

Or from code:

```smalltalk
sim := PetriNetSimulator on: net.
sim step. "fire one enabled transition"
sim start. "auto‑step"
sim stop.
```

GUI Usage

· Step – fire one random enabled transition.
· Start – run simulation continuously.
· Stop – pause auto‑step.
· Reset – return all places to initial token counts.
· Click a place with Shift to add a token, Ctrl to remove a token.
· Click a transition to manually fire it (if enabled).

Export/Import

Save a net to JSON:

```smalltalk
PetriNetJsonExporter new export: net toFile: 'net.json'.
```

Load from JSON:

```smalltalk
importer := PetriNetJsonImporter new.
net := importer importFromFile: 'net.json'.
```

PNML (Petri Net Markup Language) is also supported.

Analysis

```smalltalk
checker := LivenessChecker on: net.
checker check. "true if no dead transitions"
explorer := ReachabilityExplorer on: net.
explorer explore.
explorer reachableNodes. "collection of markings"
```

Requirements

· Pharo 8 or later
· No external dependencies (Morphic, STONJSON, XMLParser are built‑in)

License

MIT – do whatever you want.

Author

Your Name – built as a random language challenge.