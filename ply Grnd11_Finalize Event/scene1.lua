-----------------------------------------------------------------------------------------
--
-- Finalize Event blog
-- https://coronalabs.com/blog/2015/05/05/tutorial-the-finalize-api-an-unsung-hero/
-- Function and Table Listeners
-- https://docs.coronalabs.com/guide/events/detectEvents/index.html#function-and-table-listeners
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local object, mainImage

local function finalizeListener( self, event )
    -- do something when "self" is removed from the stage
    print( "Object removed from stage: "..tostring(self) )
end

local function removeIt()
	display.remove(object)
	-- object:removeSelf() 		-- 注意這個差別是 display.remove 會先檢查物件是否存在
	-- https://docs.coronalabs.com/api/type/DisplayObject/removeSelf.html
	-- https://forums.coronalabs.com/topic/66937-displayremoveobject-vs-objectremoveself/
	-- display.remove() does a little more than above.
	-- First it tests to see if the object exists.
	-- Then it checks to see if it has a member named removeSelf() and that it's a function
	-- but for all practical purposes it saves you checking the object before calling removeSelf()
	-- Rob 
end






-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    local backGroup = display.newGroup()
	sceneGroup:insert( backGroup )

	mainImage = display.newImageRect( backGroup, "ball.png", 256, 256  )
	mainImage.x = display.contentCenterX
    mainImage.y = display.contentCenterY -200
    
    object = display.newRect(backGroup, 300, 600, 250, 250)
    object.finalize = finalizeListener
	object:addEventListener( "finalize" )

	mainImage:addEventListener( "touch", removeIt)		-- 這個要寫在object都設定好的後面
	

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

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