-----------------------------------------------------------------------------------------
--
-- gameScene.lua
--
-- Created By: Amin Zeina 
-- Created On: May 2018
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local physics = require( "physics" )
local json = require( "json" )
local tiled = require( "com.ponywolf.ponytiled" )

local scene = composer.newScene()

-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    physics.start()
	physics.setGravity( 0, 20 )

    -- show map 
    local filename = "assets/maps/level0.json"
    local mapData = json.decodeFile( system.pathForFile( filename, system.ResourceDirectory ) )
    map = tiled.new( mapData, "assets/maps" )

    local sheetOptionsIdleBoy = require( "assets.spritesheets.ninjaBoy.ninjaBoyIdle" )
    local sheetBoyIdle = graphics.newImageSheet( "./assets/spritesheets/ninjaBoy/ninjaBoyIdle.png", sheetOptionsIdleBoy:getSheet() )

    local sheetOptionsRunBoy = require( "assets.spritesheets.ninjaBoy.ninjaBoyRun" )
    local sheetBoyRun = graphics.newImageSheet( "./assets/spritesheets/ninjaBoy/ninjaBoyRun.png", sheetOptionsRunBoy:getSheet() )

    local sequence_data = {
        {
            name = "idleBoy",
            start = 1, 
            count = 10,
            time = 800, 
            loopCount = 0,
            sheet = sheetBoyIdle
        },
        {
            name = "runBoy",
            start = 1, 
            count = 10,
            time = 800, 
            loopCount = 0,
            sheet = sheetBoyRun
        }
        
    }


    -- show ninjaBoy
    local ninjaBoy = display.newSprite( sheetBoyIdle, sequence_data )
    ninjaBoy.x = display.contentWidth / 2 
    ninjaBoy.y = 0
    ninjaBoy.isFixedRotation = true
    ninjaBoy.id = "ninja Boy"
    physics.addBody( ninjaBoy, "dynamic", { 
        friction = 0.5, 
        bounce = 0.3 
        } )
    ninjaBoy:setSequence( "idleBoy" )
    ninjaBoy:play()

    sceneGroup:insert( map )
    sceneGroup:insert( ninjaBoy )

end

-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
	 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene