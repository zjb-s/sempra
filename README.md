# sempra
dynamic melody sequencer

![Untitled_Artwork](https://user-images.githubusercontent.com/86270534/163466922-d158e6ea-3f9e-4987-bccf-c313ad90263d.png)

![sempra 2](https://user-images.githubusercontent.com/86270534/163468550-ff110ad5-9edb-42d2-a742-12d328363ed5.png)


# what is this?

a dynamic melody sequencer for norns, 16n and a varibright grid 128. there is no engine built in - to hear sound, connect norns to midi, crow, w/syn and/or just friends.

two sequencers run in parallel, each with up to 8 steps. swap out phrases from a shared bank on the fly, edit durations and repeats per step, combine sequences together for awake-style phasing.

# how do i use this?

sempra contains a bank of 16 phrases. the 2 identical tracks run in parallel, each one pulling data from one of the 16 available phrases. you can switch out which phrase is routed to which track on the fly with simple key presses.

## grid and 16n

* place your 16n directly above the grid, so each fader lines up with a grid column.
* the top half of the grid controls step duration, from 1 to 4 ticks per step.
* the bottom half of the grid controls step trigger behavior. from the bottom up:
* * off: bypass the step.
* * single trigger: trigger only when the sequencer advances to this step.
* * multiple trigger: trigger every time the sequencer ticks while on this step.
* * hold: holds / ties the gate for the duration of the step.
* the 16n fader above sets the pitch for that step.

## keys and encoders

* k1: shift key
* k2: enter selection mode for track 1
* k3: enter selection mode for track 2
* enc1: nothing
* enc2: change phrase length for track 1
* shift + enc2: change clock division for track 1
* enc3: change phrase lenth for track 2
* * shift + enc3: change clock division for track 2
* enc4 (fates only): nothing

## selecting phrases
pressing k2 or k3 opens the selector pane for tracks 1 and 2 respectively. in this mode, the opposite track is covered up by a 4x4 grid of phrases to choose from. pressing any phrase assigns it to the track. when you do, the selector pane will disappear again.

* to latch the selector pane, hold shift while selecting a phrase. press k2/k3 to unlatch.
* to exit the selector pane without selecting anything, press k2/k3 again, or press the currently selected phrase (much brighter than the others)

phrase are selected immediately when you press them. all changes to the previous phrase are automatically saved and can be returned to instantly at any time.

## params

each track has a few params in the norns menu that you can't access from the main interface.

* transpose: transpose the track (not phrase) by x semitones.
* output: sets the track output. sempra currently supports crow, w/syn, just friends and midi gear. you can also route a track to transpose another.

# roadmap
* implement midi out
* quantization
* track transpose other track
* crow envelope outs
* copy and paste sequences
