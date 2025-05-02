
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
user = { x = 100, y = 200, theta = 90}
function love.load()
    birb = love.graphics.newImage("birb.png")
    flyingbirb = love.graphics.newImage("flyingbirb.png")
    local activebirb
    titleFont = love.graphics.newFont(100)
    basicFont = love.graphics.newFont(15)
end

function love.update(dt)
    -- if love.keyboard.isDown("up") then
        
    -- end
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end
    if love.keyboard.isDown("d") then
        --upForce = -birbMass * gravity * 1.2 * dt
        Fx = 200
    elseif love.keyboard.isDown("a") then
        Fx = -200
    else
        Fx = 0
    end
    if love.keyboard.isDown("w") then
        --upFo-rce = -birbMass * gravity * 1.2 * dt
        Fy = -200
    elseif love.keyboard.isDown("s") then
        Fy = 200
    else
        Fy = 0
    end
    xAcceleration = Fx / birbMass
    yAcceleration = Fy / birbMass
    if birby < 2300 then
        birbYAccel = gravity + yAcceleration
        birbXAccel = xAcceleration --will eventually be air resistance
        activebirb = flyingbirb
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
        activebirb = birb
    end
    birbVx = birbVx + birbXAccel * dt
    birbVy = birbVy + birbYAccel * dt
    birbx = birbx + birbVx * dt
    birby = birby + birbVy * dt
end

function love.draw()
    love.graphics.setBackgroundColor(0.871,0.365,0.639)
    love.graphics.setFont(titleFont)
    love.graphics.print("BIRB PHYSICS", 100, 300)
    love.graphics.setFont(basicFont)
    love.graphics.print(tostring(birbYAccel), 500, 500)
    love.graphics.print(tostring(birbXAccel), 700, 500)
    love.graphics.scale(0.2, 0.2)
    -- love.graphics.draw(trum, trumx, trumy)
    love.graphics.draw(activebirb, birbx, birby)
    love.graphics.scale(1,1)
end