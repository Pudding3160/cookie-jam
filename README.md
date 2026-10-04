# Distractions
## Distraction controller
All distractions need their own controller which can be created with the `DistractionControllerBase` node. This node defines the distraction's check interval, it's difficulty, the maximum number it can roll during random number generation, and a reference to the actual distraction.
When all checks pass successfully, a controller will instantiate the referenced distraction as its child.
## Distractions
Controllers are only responsible for creating the distraction. It's an individual distraction's job to handle any minigame logic and, eventually, destroying themselves.
Distractions can use control (UI) nodes, but all control nodes must have the `Mouse->Filter` setting set to `Ignore` so mouse events can pass to any other necessary nodes.
