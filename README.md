## Sempra

a continuous dynamic melody sequencer for grid+16n

https://www.youtube.com/watch?v=ylj5nLv6IEg


### Requirements

* grid
* 16n or other controller
### Optional
* crow
* midi voice
* just friends
* w/

### Roadmap
* crow envelope outs
* copy and paste sequences
* clock multiplication
* slides
* save sequences
* arc support
* an engine
* visual representation of gate length

# sempra
dynamic melody sequencer

![sempra 2](https://user-images.githubusercontent.com/86270534/163468550-ff110ad5-9edb-42d2-a742-12d328363ed5.png)


# what is this?

a dynamic melody sequencer for norns, 16n and a varibright grid 128. there is no engine built in - to hear sound, connect norns to midi, crow, w/syn and/or just friends.

two sequencers run in parallel, each with up to 8 steps. swap out phrases from a shared bank on the fly, edit durations and repeats per step, combine sequences together in modular for awake-style phasing.

inspired by metropolis, kria, awake, er-101, m18s and skylines.

# how do i use this?

sempra contains a bank of 16 phrases. the 2 identical tracks run in parallel, each one pulling data from one of the 16 available phrases. you can switch out which phrase is routed to which track on the fly with simple key presses.

## grid and 16n

![Untitled_Artwork 2](https://user-images.githubusercontent.com/86270534/163574156-d6be6215-b607-48e5-a887-7e23f5bdd8f9.png)


* place your 16n directly above the grid, so each fader lines up with a grid column.
* the top half of the grid controls step duration, from 1 to 4 ticks per step.
* the bottom half of the grid controls step trigger behavior. from the bottom up:
* * off: bypass the step.
* * single trigger: trigger only when the sequencer advances to this step.
* * multiple trigger: trigger every time the sequencer ticks while on this step.
* * hold: holds / ties the gate for the duration of the step.
* the 16n fader above sets the pitch for that step.

## keys and encoders

![Untitled_Artwork 6](https://user-images.githubusercontent.com/86270534/163586984-978d713b-b27f-455e-941c-e11c6510811b.png)

* k1: shift key
* k2: enter selection mode for track 1
* k3: enter selection mode for track 2
* enc1: gate length for track 1
* enc2: change phrase length for track 1
* enc3: change phrase lenth for track 2
* enc4 (fates only): gate length for track 2

## shift functions

![Untitled_Artwork 5](https://user-images.githubusercontent.com/86270534/163586775-3a537fde-2155-4f45-90dd-2deb88451ed7.png)

* enc1: gate length for track 2 (for 3-encoder norns)
* enc2: time division for track 1
* enc3: time division for track 2

## selecting phrases

![Untitled_Artwork 3](https://user-images.githubusercontent.com/86270534/163580612-ac021183-de85-4122-a99d-84057d87276e.png)


pressing k2 or k3 opens the selector pane for tracks 1 and 2 respectively. in this mode, the opposite track is covered up by a 4x4 grid of phrases to choose from. pressing any phrase assigns it to the track. when you do, the selector pane will disappear again.

* to latch the selector pane, hold shift while selecting a phrase. press k2/k3 to unlatch.
* to exit the selector pane without selecting anything, press k2/k3 again, or press the currently selected phrase (much brighter than the others)

all changes to the previous phrase are automatically saved and can be returned to instantly at any time. phrases are either switched to immediately, or queued to start when the current phrase ends - change this behavior in the params global section.

## params

each track has a few params in the norns menu that you can't access from the main interface.

* **output**: sets the track output. sempra currently supports crow, w/syn, just friends and midi gear. you can also route a track to transpose another. 
* **midi out device**: sets the midi destination, if a midi output is selected
* **transpose**: transpose the track (not phrase) by x semitones.
* **fader range**: sets the range of each fader, in semitones.
* **root note**: sets the root note for the track.
* **scale**: sets a musical scale for the track.


### Download

v1.0.5 - `;install https://github.com/zjb-s/sempra`

https://github.com/zjb-s/sempra/tree/main

this is my first fully-documented, full-release norns script! woohoo! let me know if anything is broken and i'll fix it asap. PRs and feature requests are more than welcome.
