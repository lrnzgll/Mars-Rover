# Mars-Rover Program

A program to command rovers around Mars.

* Mars is modelled as a grid with size x * y
* The program reads the inputs, update the robots and print out the final state of the robots
* Each robot has a position (X,Y) and an orientation (N,E,S,W)
* Each robot can move forward (F), rotate left by 90 degrees (L) and rotate right by 90 degrees (R)
* If the robot leaves the world's grid is marked as lost

Input examples:

World grid `X Y`
```
What is the size of the world?
example: 4 8

5 5
```

Rover initial position, orientation and list of commands `(X,Y, orientation) [L|F|R]`

```
Please add initial position, heading and sequence of movements for the rover
example: (4, 4, E) LFRL

(2, 2, N) FFF
```

## Getting Started

You'll need to have ruby installed to run this program: https://www.ruby-lang.org/en/documentation/installation/

1. Clone the repository

2. `bundle install`

3. `irb -r './main'`
