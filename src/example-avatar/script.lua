local confetti = require("confetti")

confetti.registerMesh("spark", models.model.Spark)
confetti.registerSprite("leaf", textures["mytexture"], vec(0,5,4,9), 20)

function events.tick()

    -- Example 1
    confetti.newParticle(
        "spark",
        player:getPos()+vec(0,math.random(),0),
        vec((math.random()-0.5)*0.25,math.random()*0.25,(math.random()-0.5)*0.25),
        {
            acceleration=-0.013
        }
    )

    -- Example 2
    -- confetti.newParticle(
    --     "spark",
    --     player:getPos()+vec(0,math.random(),0),
    --     vec((math.random()-0.5)*0.2,math.random()*0.2,(math.random()-0.5)*0.2),
    --     {
    --         scale=3,
    --         scaleOverTime=-0.2,
    --     }
    -- )

    -- Example 3
    -- confetti.newParticle(
    --     "spark",
    --     player:getPos()+vec(0,math.random(),0),
    --     vec((math.random()-0.5)*0.3,math.random()*0.3,(math.random()-0.5)*0.3),
    --     {
    --         acceleration=vec(0,-0.04,0)
    --     }
    -- )

    -- Example 4
    -- confetti.newParticle(
    --     "spark",
    --     player:getPos()+vec(0,math.random(),0),
    --     vec((math.random()-0.5)*0.0001,math.random()*0.0001,(math.random()-0.5)*0.0001),
    --     {
    --         rotationOverTime=30,
    --         acceleration=0.03
    --     }
    -- )

    -- Example 5
    -- confetti.newParticle("spark",player:getPos()+vec(0,math.random(),0),vec(0,0,0))

    -- Example 6
    -- confetti.newParticle(
    --     "leaf",
    --     player:getPos()+vec(0,math.random(),0),
    --     vec((math.random()-0.5)*0.2,math.random()*0.2,(math.random()-0.5)*0.2),
    --     {
    --         billboard = true,
    --         scale=0.5+math.random()*0.5
    --     }
    -- )

    -- Example 7
    -- confetti.newParticle(
    --     "leaf",
    --     player:getPos()+vec(0,math.random()+3,0),
    --     vec((math.random()-0.5)*0.2,-math.random()*0.3,(math.random()-0.5)*0.2),
    --     {
    --         rotationOverTime=10+math.random()*5
    --     }
    -- )
end
