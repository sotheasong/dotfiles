#!/usr/bin/env bash
# Focus the nearest floating window in a given direction (west|east|north|south).
# Works in yabai's `layout float` mode, where the built-in `--focus <dir>`
# refuses to act because no window is "managed".
#
# Usage: focus-direction.sh west|east|north|south

dir="$1"

yabai -m query --windows | DIR="$dir" python3 -c '
import sys, json, os

dir = os.environ["DIR"]
wins = json.load(sys.stdin)

cur = next((w for w in wins if w.get("has-focus")), None)
if cur is None:
    sys.exit(0)

# Only consider windows on the same space, visible, not minimized, not self.
cands = [
    w for w in wins
    if w["id"] != cur["id"]
    and w["space"] == cur["space"]
    and w.get("is-visible", True)
    and not w.get("is-minimized", False)
]

def center(w):
    f = w["frame"]
    return (f["x"] + f["w"] / 2.0, f["y"] + f["h"] / 2.0)

cx, cy = center(cur)

def score(w):
    x, y = center(w)
    dx, dy = x - cx, y - cy
    if dir == "west"  and dx < 0: return abs(dx) + abs(dy) * 2
    if dir == "east"  and dx > 0: return abs(dx) + abs(dy) * 2
    if dir == "north" and dy < 0: return abs(dy) + abs(dx) * 2
    if dir == "south" and dy > 0: return abs(dy) + abs(dx) * 2
    return None  # wrong direction

scored = [(s, w["id"]) for w in cands if (s := score(w)) is not None]
if scored:
    scored.sort()
    print(scored[0][1])
' | while read -r wid; do
    [ -n "$wid" ] && yabai -m window "$wid" --focus
done
