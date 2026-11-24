# cs3110_g7
CS3110 Fall 26 Group Project
Willow Chen, wc697
Mylan Pham, mtp72
Gurnoor Makkad, gm626
Sree Vaishnavi Bachiraju, sb2763


## Running the game

### Start the server

From the project root:
```
dune build
dune exec bin/main.exe
```

Choose a role for the server's player (`d`, `c`, `f` or `a`) and press Enter.
When you see `Listening. Press q to stop.`, players can join. Move with
W/A/S/D. Pressing `q` in the server window shuts the server down.

> **Mac users:** if the server crashes with `Unix.EADDRINUSE`, port 5000 is
> being used by AirPlay Receiver. Turn it off in System Settings → General →
> AirDrop & Handoff → AirPlay Receiver.

### Join as a player

Open a new terminal for each player and run:

```
stty -icanon min 1 -echo; nc 127.0.0.1 5000; stty sane
```

This makes each keypress go to the server right away, without pressing Enter.
Type a role letter from the list and press Enter (what you type won't be
shown). Then move with W/A/S/D. Press Ctrl+C to leave.

To join from another computer, replace `127.0.0.1` with the server computer's
IP address. Both computers must be on the same network.