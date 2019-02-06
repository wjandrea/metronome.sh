#!/bin/bash
# metronome.sh - Is a metronome.
# Usage: metronome.sh [beats per minute] [beats per measure]

# Set BPM and beats per measure.
bpm="${1-120}"
msr="${2-4}"

# Get seconds per beat using bc.
# "-0.004" accounts for approximate execution time.
beat_time="$(bc -l <<< "scale=5; 60/$bpm-0.004")"

echo "Metronome playing $bpm BPM, $msr beats per measure"
echo -n "Press Ctrl+C to quit."

while true; do
    for ((i=1; i<=$msr; i++)); do
        if [[ $i -eq 1 ]]; then
            # Accentuated beat.
            canberra-gtk-play --id='dialog-information' &
        else
            # Unaccentuated beat
            canberra-gtk-play --id='button-toggle-on' &
        fi
        # Wait before next beat. Will exit if beat time is invalid.
        sleep "$beat_time" || exit
    done
done
