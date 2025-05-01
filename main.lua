
local trumx = 500
local trumy = 200
local birbx = 0
local birby = 500
local birbVx = 50
local birbVy = -100
local birbMass = 5
local gravity = 9.8
local birbYAccel = 0
local birbGroundNormal = gravity * birbMass
local groundCoefficient = 0.3
local frictionForce = birbGroundNormal * groundCoefficient
local birbGroundAccel = frictionForce / birbMass
local upForce = 0 --newtons
local upAcceleration = upForce / birbMass

function love.load()
    trum = love.graphics.newImage("trum.png")
    birb = love.graphics.newImage("birb.png")
end
function love.update(dt)
    -- if love.keyboard.isDown("right") then
    --     trumx = trumx + 100 * dt
    -- end
    -- if love.keyboard.isDown("left") then
    --     trumx = trumx - 100 * dt
    -- end
    -- if love.keyboard.isDown("down") then
    --     trumy = trumy + 100 * dt
    -- end
    -- if love.keyboard.isDown("up") then
    --     trumy = trumy - 100 * dt
    -- end
    if love.keyboard.isDown("f") then
        upForce = -birbMass * gravity * 1.2 * dt
    else
        upForce = 0
    end
    if love.keyboard.isDown("a") then
        birbVx = birbVx + 10 * dt
    end
    if birby < 2300 then
        birbVy = birbVy + (gravity + upAcceleration) * dt
    else
        if birbVx > 0 then
            birbVx = birbVx - birbGroundAccel * dt
        else
            birbVx = 0
        end
        birbVy = 0
    end
    birbx = birbx + birbVx * dt
    birby = birby + birbVy * dt
end
function love.draw()
    love.graphics.print("Hello World", 300, 300)
    love.graphics.scale(0.2, 0.2)
    love.graphics.draw(trum, trumx, trumy)
    love.graphics.draw(birb, birbx, birby)
    love.graphics.scale(1,1)
end
