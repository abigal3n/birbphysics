
local trumx = 500
local trumy = 200
local birbx = 0
local birby = 500
local birbVx = 50
local birbVy = -100
local birbMass = 5
local groundMass = 1000000000
local gravity = 9.8
local birbYAccel = 0
local birbXAccel = 0
local birbGroundNormal = gravity * birbMass
local groundCoefficient = 0.3
local frictionForce = birbGroundNormal * groundCoefficient
local birbGroundAccel = 0
local posbirbGroundAccel = frictionForce / birbMass
local negbirbGroundAccel = -frictionForce / birbMass
local Fy = 0 --newtons
local Fx = 0
local yAcceleration = Fy / birbMass
local xAcceleration = Fx / birbMass

function love.load()
    trum = love.graphics.newImage("trum.png")
    birb = love.graphics.newImage("birb.png")
end

-- function love.update(dt)
--     -- if love.keyboard.isDown("right") then
--     --     trumx = trumx + 100 * dt
--     -- end
--     -- if love.keyboard.isDown("left") then
--     --     trumx = trumx - 100 * dt
--     -- end
--     -- if love.keyboard.isDown("down") then
--     --     trumy = trumy + 100 * dt
--     -- end
--     -- if love.keyboard.isDown("up") then
--     --     trumy = trumy - 100 * dt
--     -- end
--     if love.keyboard.isDown("d") then
--         --upForce = -birbMass * gravity * 1.2 * dt
--         Fx = 100
--     elseif love.keyboard.isDown("a") then
--         Fx = -100
--     else
--         Fx = 0
--     end
--     if love.keyboard.isDown("w") then
--         --upFo-rce = -birbMass * gravity * 1.2 * dt
--         Fy = -100
--     elseif love.keyboard.isDown("s") then
--         Fy = 100
--     else
--         Fy = 0
--     end
--     xAcceleration = Fx / birbMass
--     yAcceleration = Fy / birbMass
--     if love.keyboard.isDown("a") then
--         birbVx = birbVx + 10 * dt
--     end
--     if birbVx > 0 then
--         birbGroundAccel = -birbGroundAccel
--     else if birbVx < 0 then
--         birbGroundAccel = birbGroundAccel
--     end
--     if birby < 2300 then
--         birbYAccel = gravity - yAcceleration
--         birbXAccel = xAcceleration --will eventually be air resistance
--     else
--         if birbVx > 0 then
--             birbXAccel = -birbGroundAccel
--         else
--             birbVx = 0
--         end
--         birbXAccel = xAcceleration + birbGroundAccel
--         birbYAccel = gravity - gravity + yAcceleration
--         birbVy = (birbVy*birbMass) / (birbMass + groundMass)
--     end
--     birbVx = birbVx + (birbXAccel) * dt
--     birbVy = birbVy + (birbYAccel) * dt
--     birbx = birbx + birbVx * dt
--     birby = birby + birbVy * dt
-- end

function love.update(dt)
    if love.keyboard.isDown("d") then
        --upForce = -birbMass * gravity * 1.2 * dt
        Fx = 100
    elseif love.keyboard.isDown("a") then
        Fx = -100
    else
        Fx = 0
    end
    if love.keyboard.isDown("w") then
        --upFo-rce = -birbMass * gravity * 1.2 * dt
        Fy = -100
    elseif love.keyboard.isDown("s") then
        Fy = 100
    else
        Fy = 0
    end
    xAcceleration = Fx / birbMass
    yAcceleration = Fy / birbMass
    if birby < 2300 then
        birbYAccel = gravity + yAcceleration
        birbXAccel = xAcceleration --will eventually be air resistance
        birb = love.graphics.newImage("flyingbirb.png")
    else
        if birbVx > 0.5 then
            birbGroundAccel = negbirbGroundAccel
        elseif birbVx < -0.5 then
            birbGroundAccel = posbirbGroundAccel
        else
            birbGroundAccel = 0
        end
        birbXAccel = xAcceleration + birbGroundAccel
        birbYAccel = gravity - gravity + yAcceleration
        birbVy = (birbVy*birbMass) / (birbMass + groundMass)
        birb = love.graphics.newImage("birb.png")
    end
    birbVx = birbVx + birbXAccel * dt
    birbVy = birbVy + birbYAccel * dt
    birbx = birbx + birbVx * dt
    birby = birby + birbVy * dt
end

function love.draw()
    love.graphics.print("Hello World", 300, 300)
    love.graphics.print(tostring(birbYAccel), 500, 500)
    love.graphics.print(tostring(birbXAccel), 700, 500)
    love.graphics.scale(0.2, 0.2)
    love.graphics.draw(trum, trumx, trumy)
    love.graphics.draw(birb, birbx, birby)
    love.graphics.scale(1,1)
end