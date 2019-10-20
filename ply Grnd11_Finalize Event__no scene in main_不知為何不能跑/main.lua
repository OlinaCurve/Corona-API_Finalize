-----------------------------------------------------------------------------------------
--
-- Finalize Event blog
-- https://coronalabs.com/blog/2015/05/05/tutorial-the-finalize-api-an-unsung-hero/
-- Function and Table Listeners
-- https://docs.coronalabs.com/guide/events/detectEvents/index.html#function-and-table-listeners
-----------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )



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



local mainImage = display.newImageRect( "ball.png", 256, 256  )
mainImage.x = display.contentCenterX
mainImage.y = display.contentCenterY -200

local object = display.newRect( 300, 600, 250, 250)
object.finalize = finalizeListener
object:addEventListener( "finalize" )

mainImage:addEventListener( "touch", removeIt)		-- 這個要寫在object都設定好的後面