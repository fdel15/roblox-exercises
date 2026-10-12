# Game Mechanics

https://www.youtube.com/watch?v=vZkAbeMLcvc

The Youtube video above states that every object in game development have the same building blocks.

- Input
- Detection
- Transformation
- Communication
- State & Logic

My idea is to create a framework that uses these building blocks for everything. Every game player, NPC, or game object should all respond to {Thing}.{BuildingBlock}. They can all inherit from a base class in which these building blocks are defined as nothing more than a text description of their purpose. They can then be extended so you can do things like:

Charaacter.Input.Text("input text goes here")

If this pattern works, it could really help to organize agentic workflows to build games in a way that preserves the overall system design.

I also feel like it will surface patterns that can be used across multiple objects.

## Input

How something is controlled.

An action a game player can take to interact with the object. 

Example: Player presses key to open chest.


## Detection

How something knows what is happening around it.

A way for the object to determine how far away a player is.

Example: A player can only open an object if it is within

## Transformation

How something moves or changes.

A way to change the physical appearance of an object.

Example: The chest transforms from closed to open.

## Communication

How objects interact with other objects by references, signals, or function calls.

A way for the object to accept the input and respond back to the game player.

Example: A player opens a chest and collects a reward.

## State & Logic

The rules and decisions of our objects.

A way to connect all of the other blocks together and serve as memory for the object.

Example: A chest transitions to an open state and can no longer be opened by a game player or distribute another reward.