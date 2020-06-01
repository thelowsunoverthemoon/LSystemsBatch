# LSystemsBatch
L-Systems in pure Batch
. You can set each value in "parameters" to whatever you like:

Angle : The starting angle from 1-4. (1 is 90, 2 is 0, 3 is 270, 4 is 360)
Iterate : The number of generations. Note that because of the limit of how many characters can be in a variable, 2-3 generations is the max for most systems.
Chars : The letters you are using other than constants
Axiom : The starting rule
Rules : Can be multiple. Surround each in quotes. (ie "F=F++K")
Here are what the characters mean:

A-Z : You can use pretty much any character that's not a constant and as many as you want. Each letter moves it once in the set direction.
+ : Turn 90 degrees right
- : Turn 90 degrees left
[ : Save current cursor position
] : Restore saved cursor position
{ : Switch colour to blue
} : Switch colour to purple
And here are some neat L-Systems to see:

SET "chars=A"
SET "axiom=A"
SET rules="A=A-A+A+A-A"

::2 iterations is max for this one
SET "chars=Z"
SET "axiom=Z+Z+Z+Z"
SET rules="Z=Z{+Z-Z-ZZZ+Z+Z}-Z"

SET "chars=X Y"
SET "axiom=X{+[Y-X-Y-YYY}Y]"
SET rules="X=X+[Y-X-{Y-YYYY}Y]" "Y=-YYX"

::The "Dragon Curve". Try 7 iterations for this one
SET "chars=U Q E"
SET "axiom=UQ"
SET rules="Q=Q+{EU+" "E=-UQ-}E"

::Hilbert Curve. Try 4 iterations.
SET "chars=A B C"
SET "axiom=A"
SET rules="A=-BC{+ACA+CB-" "B=+AC-}BCB-CA+"
