# sempra
dynamic melody sequencer

![Untitled_Artwork](https://user-images.githubusercontent.com/86270534/163466922-d158e6ea-3f9e-4987-bccf-c313ad90263d.png)

![sempra 2](https://user-images.githubusercontent.com/86270534/163468550-ff110ad5-9edb-42d2-a742-12d328363ed5.png)


# what is this?

a dynamic melody sequencer for norns, 16n and a varibright grid 128. there is no engine built in - to hear sound, connect norns to midi, crow, w/syn and/or just friends.

two sequences run in parallel, each with up to 8 steps. swap out sequences from a shared bank on the fly, edit durations and repeats per step, combine sequences together for awake-style phasing.

# how do i use this?

sempra contains a bank of 16 sequences. the 2 identical tracks run in parallel, each one pulling data from one of the 16 available sequences. you can switch out which sequence is routed to which track on the fly with simple key presses.

* place your 16n directly above the grid, so each fader lines up with a grid column.
* the top half of the grid controls step duration, from 1 to 4 ticks per step.
* the bottom half of the grid controls step trigger behavior. from the bottom up:
* * off: bypass the step.
* * single trigger: trigger only when the sequencer advances to this step.
* * multiple trigger: trigger every time the sequencer ticks while on this step.
* * hold: holds / ties the gate for the duration of the step.
* the 16n fader above sets the pitch for that step.

* k1: shift key
* k2: enter selection mode for track 1
* k3: enter selection mode for track 2
* enc1: nothing
* enc2: change sequence length for track 1
* shift + enc2: change clock division for track 1
* enc3: change sequence lenth for track 2
* * shift + enc3: change clock division for track 2
* enc4 (fates only): nothing
