# Confetti

A particle library for the Figura Minecraft mod

Spawn Mesh and Sprite particles with options like acceleration, scale or rotation.

Setup:
1) Add the library lua file
2) Add a `particles.bbmodel` file with an empty group called `Instances`
3) Import library, define particles with name and lifetime
```lua
confetti = require("confetti")
confetti.registerMesh("myMeshParticle", models.model.MyParticle, 15)
confetti.registerSprite("mySpriteParticle", textures["mytexture"], vec(0,0,5,5), 10)
```
4) Spawn particles
```lua
confetti.newParticle(name, pos, vel, options)
```
Options is a table with the following supported fields:
```elm
lifetime number "Lifetime in ticks"
acceleration Vector3|number "Vector in world space or a number which accelerates forwards (positive) or backwards (negative) in the current movement direction"
scale Vector3|number "Initial scale when spawning"
scaleOverTime Vector3|number "Change of scale every tick"
rotation Vector3|number "Initial rotation when spawning"
rotationOverTime Vector3|number "Change of rotation every tick"
billboard boolean "Whether the Sprite should always face the camera, only affects Sprite particles"
```
If you find bugs please tell me in [the discord post](https://discord.com/channels/1129805506354085959/1132326640718970990/1132326640718970990) as this has been made in just a few hours with little testing. Feel free to drop some feature ideas too if you want, but dont be surprised if it doesnt get added :stuck_out_tongue: 
