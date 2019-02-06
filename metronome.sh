#!/bin/bash
# metronome.sh - Is a metronome.
# See _usage and _help for more info.

# Accentuated and unaccentuated sound IDs, respectively.
tick='dialog-information'
tock='button-toggle-on'

# Default BPM and beats per measure.
bpm=120
msr=4

# Valid range for BPM.
bpm_min=1
bpm_max=600

# Valid range for beats per measure.
msr_min=1
msr_max=16

_error(){
    # Handle errors: print error message, print usage, and exit.
    echo "$0: $*" >&2
    _usage >&2
    exit 1
}

_help(){
    _usage
    echo "
Is a metronome.

Originally posted on Ask Ubuntu: https://askubuntu.com/a/815010/301745

Options:
    -h, --help
            Show this help message and exit.

Arguments:
    BPM     Beats per minute. Default 120. Valid range: [$bpm_min, $bpm_max]
    MSR     Beats per measure. Default 4. Valid range: [$msr_min, $msr_max]

Sound IDs used:
    Accentuated beat (tick): $tick
    Unaccentuated beat (tock): $tock

Exit status:
    1 - Invalid arguments
    0 - Otherwise"
}

_usage(){
    echo "Usage: metronome.sh [-h] [bpm [msr]]"
}

is_int(){
    [[ $1 =~ ^[0-9]+$ ]]
}

int_in_range(){
    local int="$1"
    local min="$2"
    local max="$3"

    [[ $min -le $int && $int -le $max ]]
}

# Help
case $1 in
-h|--help)
    _help
    exit
    ;;
esac

# BPM argument
if [[ $# -ne 0 ]]; then
    bpm="$1"
    shift

    if ! is_int "$bpm"; then
        _error "BPM not an integer: $bpm."
    elif ! int_in_range $bpm $bpm_min $bpm_max; then
        _error "BPM not in range [$bpm_min, $bpm_max]: $bpm"
    fi
fi

# Beats per measure argument
if [[ $# -ne 0 ]]; then
    msr="$1"
    shift

    if ! is_int "$msr"; then
        _error "Beats per measure not an integer: $msr."
    elif ! int_in_range $msr $msr_min $msr_max; then
        _error "Beats per measure not in range [$msr_min, $msr_max]: $msr"
    fi
fi

# Get seconds per beat using bc.
# "-0.004" accounts for approximate execution time.
beat_time="$(bc -l <<< "scale=5; 60/$bpm-0.004")"

echo "Metronome playing $bpm BPM, $msr beats per measure"
echo -n "Press Ctrl+C to quit."

while true; do
    for ((i=1; i<=$msr; i++)); do
        if [[ $i -eq 1 ]]; then
            # Accentuated beat.
            canberra-gtk-play --id="$tick" &
        else
            # Unaccentuated beat
            canberra-gtk-play --id="$tock" &
        fi
        # Wait before next beat. Will exit if beat time is invalid.
        sleep "$beat_time" || exit
    done
done
