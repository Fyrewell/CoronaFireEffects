-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local pex = require "com.ponywolf.pex"

local particle = pex.load("particle.pex","texture.png")

local emitter = display.newEmitter(particle)
emitter.x = display.contentCenterX
emitter.y = display.contentCenterY

local function myTouchListener( event )
    if ( event.phase == "began" ) then
    	emitter:stop();
    	emitter = display.newEmitter(particle)
    	emitter.x = event.x;
    	emitter.y = event.y;
    elseif ( event.phase == "moved" ) then
    	emitter:stop();
    	emitter = display.newEmitter(particle)
    	emitter.x = event.x;
    	emitter.y = event.y;
    elseif ( event.phase == "ended" ) then
    	emitter:stop();
    	emitter = display.newEmitter(particle)
    	emitter.x = event.x;
    	emitter.y = event.y;
    end
    return true
end

Runtime:addEventListener( "touch", myTouchListener )

-------------------------------------------------

local widget = require( "widget" )

btnStyle = {
        label = "button",
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 160,
        height = 60,
        cornerRadius = 2,
        fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 4,
        fontSize = 30,
        onEvent = changeSource
    };

local actualParticle = 0
local actualColor = { numb = 0, startColorRed = 1, startColorGreen = 0, startColorBlue = 0, startColorAlpha = 1 }
local actualSize = 70
local actualMode = 0

local function changeSource (event)
	if ( "ended" == event.phase ) then
		if (actualParticle==0) then
        	particle = pex.load("particle.pex","star.png")
    	end
    	if (actualParticle==1) then
    		particle = pex.load("particle.pex","blob.png")
		end
		if (actualParticle==2) then
			particle = pex.load("particle.pex","hearth.png")
		end
		if (actualParticle==3) then
			particle = pex.load("particle.pex","texture.png")
		end
    	actualParticle = actualParticle + 1;
    	if (actualParticle>3) then
    		actualParticle=0;
		end
		event.x = display.contentCenterX;
		event.y = display.contentCenterY;
		particle.startColorRed = actualColor.startColorRed
	    particle.startColorBlue = actualColor.startColorBlue
	    particle.startColorGreen = actualColor.startColorGreen
	    particle.startColorAlpha = actualColor.startColorAlpha
		myTouchListener(event);
    end
end


local timer_1, timer_2, timer_3
local xP = 0
local yP = 0
function A(event)
    event.name = "touch"
    event.phase = "began"
    xP = xP +100
    if (xP > display.contentWidth) then
    	xP = 0
    end
    yP = yP +100
    if (yP > display.contentHeight) then
    	yP = 0
    end
    event.x = xP
    event.y = yP
    myTouchListener(event);
    if(timer_1)then timer.cancel(timer_1) end
    if(timer_3)then timer.cancel(timer_3) end
    timer_2 = timer.performWithDelay(50, B, 1) 
end

function B(event)
    event.name = "touch"
    event.phase = "began"
    xP = xP +100
    if (xP > display.contentWidth) then
    	xP = 0
    end
    yP = yP +100
    if (yP > display.contentHeight) then
    	yP = 0
    end
    event.x = xP
    event.y = yP
    myTouchListener(event);
    if(timer_2)then timer.cancel(timer_2) end
    timer_3 = timer.performWithDelay(50, A, 1)

end


local function changeMode (event)
	if ( "ended" == event.phase ) then
		if (actualMode==0) then
			event.name = "touch";
			particle.startParticleSize = actualSize
			timer_1 = timer.performWithDelay(50, A, 1) 
			actualMode=1
		else
			actualMode=0
			timer.cancel(timer_1)
			timer.cancel(timer_2)
			timer.cancel(timer_3)
			event.x = display.contentCenterX;
			event.y = display.contentCenterY;
		 	myTouchListener(event);
		end
		particle.startColorRed = actualColor.startColorRed
	    particle.startColorBlue = actualColor.startColorBlue
	    particle.startColorGreen = actualColor.startColorGreen
	    particle.startColorAlpha = actualColor.startColorAlpha
		particle.startParticleSize = actualSize
    end
end

local function changeColor ( event )
	if ( "ended" == event.phase ) then
		if (actualColor.numb==0) then
			actualColor = { numb = 1, startColorRed = 0, startColorGreen = 1, startColorBlue = 0, startColorAlpha = 1 }
    	elseif (actualColor.numb==1) then
        	actualColor = { numb = 2, startColorRed = 0, startColorGreen = 0, startColorBlue = 1, startColorAlpha = 1 }
    	elseif (actualColor.numb==2) then
        	actualColor = { numb = 3, startColorRed = 1, startColorGreen = 1, startColorBlue = 0, startColorAlpha = 1 }
    	elseif (actualColor.numb==3) then
        	actualColor = { numb = 4, startColorRed = 0, startColorGreen = 1, startColorBlue = 1, startColorAlpha = 1 }
    	elseif (actualColor.numb==4) then
        	actualColor = { numb = 5, startColorRed = 1, startColorGreen = 1, startColorBlue = 1, startColorAlpha = 1 }
    	elseif (actualColor.numb==5) then
        	actualColor = { numb = 0, startColorRed = 1, startColorGreen = 0.31, startColorBlue = 0, startColorAlpha = 1 }
    	end

    	particle.startColorRed = actualColor.startColorRed
	    particle.startColorBlue = actualColor.startColorBlue
	    particle.startColorGreen = actualColor.startColorGreen
	    particle.startColorAlpha = actualColor.startColorAlpha
	    particle.startParticleSize = actualSize
	    event.x = display.contentCenterX;
		event.y = display.contentCenterY;
	    myTouchListener(event);
    end
end

local function changeSize ( event )
	if ( "ended" == event.phase ) then
		if (actualSize==70) then
        	particle.startParticleSize = 150
        	actualSize=150
    	elseif (actualSize==150) then
        	particle.startParticleSize = 200
        	actualSize=200
    	elseif (actualSize==200) then
        	particle.startParticleSize = 300
        	actualSize=300
    	elseif (actualSize==300) then
        	particle.startParticleSize = 40
        	actualSize=40
    	elseif (actualSize==40) then
        	particle.startParticleSize = 70
        	actualSize=70
    	end
    	event.x = display.contentCenterX;
		event.y = display.contentCenterY;
		myTouchListener(event);
    end
end

-------------------------------------------------

btnStyle.onEvent = changeSource;
local button1 = widget.newButton( btnStyle )
btnStyle.onEvent = changeColor;
local button2 = widget.newButton( btnStyle )
btnStyle.onEvent = changeSize;
local button3 = widget.newButton( btnStyle )
btnStyle.onEvent = changeMode;
local button4 = widget.newButton( btnStyle )

button1.x = 100
button1.y = display.contentHeight
button2.x = 270
button2.y = display.contentHeight
button3.x = 440
button3.y = display.contentHeight
button4.x = 610
button4.y = display.contentHeight

button1:setLabel( "Source" )
button2:setLabel( "Color" )
button3:setLabel( "Size" )
button4:setLabel( "Mode" )
