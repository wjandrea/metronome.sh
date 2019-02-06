# Simple Bash metronome

Originally posted on Ask Ubuntu as an answer to [Where can I find a metronome for music practice?](https://askubuntu.com/a/815010/301745)

## Usage

    metronome.sh [beats per minute] [beats per measure]

## Info

- It plays at 120 bpm in 4 by default
- Maximum 600 bpm in 16, minimum 1 bpm in 1
- The first beat is accentuated.
- You can replace the sound IDs if you want. I just picked ones that sounded good from the Ubuntu 14.04 sound bank. A full list of IDs (names) can be found in the [Sound Naming Specification](http://0pointer.de/public/sound-naming-spec.html#names) of the [freedesktop.org Sound Theme Spec](https://www.freedesktop.org/wiki/Specifications/sound-theme-spec/)
- On my system, it's accurate to within about 1.5ms per beat, which is not noticeable. (Though I can't remember now how I tested this.)

## For example

    metronome.sh
    metronome.sh 75     # 75 BPM
    metronome.sh 120 3  # 120 BPM, 3 beats per measure
