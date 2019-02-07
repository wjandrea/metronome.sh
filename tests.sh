#!/bin/bash
# Basic tests to make sure the script fails for invalid input and
# that normal usage works.

name="./metronome.sh"

test_failure(){
    # If "$name" succeeds, that's bad.
    if $name "$@" 2>/dev/null; then
        echo '>> Failed! <<'
        exit 1
    fi
}

test_success(){
    # If "$name" fails, that's bad.
    if ! $name "$@" >/dev/null; then
        echo '>> Failed! <<'
        exit 1
    fi
}

echo '>> Testing invalid input... <<'
set -v
test_failure foo  # Invalid BPM
test_failure 120 bar  # Invalid beats
test_failure 0  # BPM too low
test_failure 601  # BPM too high
test_failure 120 0  # Beats too low
test_failure 120 17  # Beats to high
set +v
echo '>> Success <<'

echo '>> Testing normal operation... <<'
set -v
test_success -h  # Help text
test_success  # Default operation - you need to manually cancel this
set +v
echo '>> Success <<'
