
local trumx = 500
local trumy = 200
local birbx = 100
local birby = 100
local birbVx = 0
local birbVy = 0
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
local xAirResistance = 0
local yAirResistance = 0
local activebirb
local mousex = 100
local mousey = 100
local launchForce = 50
local LFx = 0
local LFy = 0
forceArrow = {mode="fill", x=100, y=100, length=100,width=20, theta=math.rad(-90)}
user = { x = 100, y = 200, theta = 90}
function getForceArrowAngle(Xi, Yi, Xf, Yf)
    Dx = Xf - Xi
    Dy = Yf - Yi
    theta = math.atan(Dy/Dx)
    return theta
end
function getForceArrowMagnitude(Xi, Yi, Xf, Yf)
    Dx = Xf - Xi
    Dy = Yf - Yi
    mag = math.sqrt(Dy*Dy + Dx*Dx)
    return mag
end
function drawRotatedRectangle(mode,x,y,w,h,theta)
    love.graphics.push()
	love.graphics.translate(x, y)
	love.graphics.rotate(theta)
	love.graphics.rectangle(mode, 0, 0, w, h)
    love.graphics.pop()
end
function love.load()
    birb = love.graphics.newImage("birb.png")
    flyingbirb = love.graphics.newImage("flyingbirb.png")
    activebirb = flyingbirb
    titleFont = love.graphics.newFont(100)
    basicFont = love.graphics.newFont(15)
end

function love.update(dt)
    -- if love.keyboard.isDown("up") then
    -- end
    LFx = launchForce*forceArrow.length*math.cos(forceArrow.theta)
    LFy = launchForce*forceArrow.length*math.sin(forceArrow.theta)
    if love.keyboard.isDown('r') then
        Fx = 0
        Fy = 0
        birbx = 100
        birby = 100
        birbVx = 0
        birbVy = 0
    end
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
    if love.keyboard.isDown("l") then
        Fx = LFx
        Fy = LFy
    end
    xAcceleration = Fx / birbMass
    yAcceleration = Fy / birbMass
    --xAirResistance = (0.5 * 1.293 * 0.4 * birbVx*birbVx * activebirb:getWidth() * activebirb:getWidth())
    --yAirResistance = (0.5 * 1.293 * 0.4 * birbVy*birbVy * activebirb:getWidth()* activebirb:getWidth())
    if birby == 100 and birbx == 100 then
        gravity = 0
    else
        gravity = 9.8
    end
    if birby < 500 then
        birbYAccel = gravity + yAcceleration -- yAirResistance
        birbXAccel = xAcceleration --- xAirResistance--will eventually be air resistance
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
    --love.graphics.scale(0.2, 0.2)
    -- love.graphics.draw(trum, trumx, trumy)
    drawRotatedRectangle(forceArrow.mode,forceArrow.x,forceArrow.y,forceArrow.width,forceArrow.length,forceArrow.theta-math.rad(90))
    love.graphics.draw(activebirb, birbx, birby, 0, 0.1, 0.1)
    --love.graphics.scale(1,1)
end

function love.mousepressed(x,y,button,istouch)
    if button == 1 then
        mousex = x
        mousey = y
    end
    forceArrow.length = getForceArrowMagnitude(forceArrow.x, forceArrow.y, mousex, mousey)
    forceArrow.theta = getForceArrowAngle(forceArrow.x, forceArrow.y, mousex, mousey)
end