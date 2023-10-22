---- *Confetti* Custom Particle Library by Manuel_ ----
modName = "manuel_.confetti"

---@class Confetti
local Confetti = {}

local Particles = {}
local Instances = {}

-- Check if particles bbmodel exists
if models.particles == nil or models.particles.Instances == nil then
    error("Confetti requires a \"particles.bbmodel\" file with an empty group called \"Instances\"!")
else
    models.particles:addChild(models.particles.Instances:copy("SpriteTaskTemplate"))
    models.particles.Instances:setParentType("World")
end

---@class ParticleOptions
---@field lifetime number|nil Lifetime in ticks
---@field acceleration Vector3|number|nil Vector in world space or a number which accelerates forwards (positive) or backwards (negative) in the current movement direction
---@field scale Vector3|number|nil Initial scale when spawning
---@field scaleOverTime Vector3|number|nil Change of scale every tick
---@field rotation Vector3|number|nil Initial rotation when spawning
---@field rotationOverTime Vector3|number|nil Change of rotation every tick
---@field billboard boolean|nil Whether the Sprite should always face the camera, only affects Sprite particles
local ParticleOptions = {}

--- Register a Mesh Particle
---@param name string
---@param mesh ModelPart
---@param lifetime number|nil Lifetime in ticks
---@return nil
function Confetti.registerMesh(name, mesh, lifetime)
    Particles[name] = {mesh=mesh,lifetime=lifetime or 20}
    mesh:setVisible(false)
end

--- Register a Sprite Particle
---@param name string
---@param sprite Texture The texture file to use
---@param bounds Vector4 (x,y,z,w) with x,y top left corner (inclusive) and z,w bottom right corner (inclusive), in pixels
---@param lifetime number|nil Lifetime in ticks
---@return nil
function Confetti.registerSprite(name, sprite, bounds, lifetime)
    Particles[name] = {sprite=sprite,bounds=bounds,lifetime=lifetime or 20}
end

--- Spawn a registered custom particle
---@param name string
---@param pos Vector3 Position in world coordinates
---@param vel Vector3|nil Velocity vector
---@param options ParticleOptions|nil
---@return nil
function Confetti.newParticle(name, pos, vel, options)
    -- Handle Overloads
    if vel == nil then
        vel = vec(0,0,0)
    end
    if options == nil then
        options = {}
    end
    local scale = options.scale or vec(1,1,1)
    local rotation = options.rotation or vec(0,0,0)
    -- Spawn Particle
    local meshInstance = nil
    if Particles[name].mesh ~= nil then
        meshInstance = Particles[name].mesh:copy("a")
        meshInstance:setVisible(true)
        models.particles.Instances:addChild(meshInstance)
    else
        meshInstance = models.particles["SpriteTaskTemplate"]:copy("a")
        local taskholder = models.particles["SpriteTaskTemplate"]:copy("a")
        if options.billboard then taskholder:setParentType("Camera") end
        meshInstance:addChild(taskholder)
        models.particles.Instances:addChild(meshInstance)
        local task = taskholder:newSprite("a")
        task:setTexture(Particles[name].sprite)
        task:setDimensions(Particles[name].sprite:getDimensions())
        task:setUVPixels(Particles[name].bounds.x,Particles[name].bounds.y)
        task:setRegion(Particles[name].bounds.z+1-Particles[name].bounds.x,Particles[name].bounds.w+1-Particles[name].bounds.y)
        task:setSize(Particles[name].bounds.z+1-Particles[name].bounds.x,Particles[name].bounds.w+1-Particles[name].bounds.y)
    end
    local particle = {
        mesh=meshInstance,
        sprite=Particles[name].sprite,
        bounds=Particles[name].bounds,
        lifetime=options.lifetime or Particles[name].lifetime,
        options=options,
        position = pos,
        _position = pos,
        velocity = vel,
        scale=scale,
        _scale=scale,
        rotation=rotation,
        _rotation=rotation
    }
    table.insert(Instances,particle)
end

function events.TICK()
    local deleted = {}
    for i, value in ipairs(Instances) do
        value._position = value.position
        value._rotation = value.rotation
        value._scale = value.scale

        if value.options.acceleration ~= nil then
            if type(value.options.acceleration) == "number" then
                value.velocity = value.velocity + value.velocity:normalized()*value.options.acceleration
            else
                value.velocity = value.velocity + value.options.acceleration
            end
        end

        value.position = value.position + value.velocity

        if value.options.scaleOverTime ~= nil then
            if type(value.options.scaleOverTime) == "number" then
                value.scale = value.scale + vec(value.options.scaleOverTime,value.options.scaleOverTime,value.options.scaleOverTime)
            else
                value.scale = value.scale + value.options.scaleOverTime
            end
        end

        if value.options.rotationOverTime ~= nil then
            if type(value.options.rotationOverTime) == "number" then
                value.rotation = value.rotation + vec(value.options.rotationOverTime,value.options.rotationOverTime,value.options.rotationOverTime)
            else
                value.rotation = value.rotation + value.options.rotationOverTime
            end
        end

        value.lifetime = value.lifetime - 1
        if value.lifetime <= 0 then
            table.insert(deleted,i)
            models.particles.Instances:removeChild(value.mesh)
        end
    end
    for i, key in ipairs(deleted) do
        table.remove(Instances, key-(i-1))
    end
end

function events.RENDER(delta)
    for i, value in ipairs(Instances) do
        if value.mesh ~= nil then
            value.mesh:setPos((math.lerp(value._position,value.position,delta))*16)
            value.mesh:setRot(math.lerp(value._rotation,value.rotation,delta))
            value.mesh:setScale(math.lerp(value._scale,value.scale,delta))
        end
    end
end

return Confetti