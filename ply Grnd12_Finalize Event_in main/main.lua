-----------------------------------------------------------------------------------------
--
-- Finalize Event blog
-- https://coronalabs.com/blog/2015/05/05/tutorial-the-finalize-api-an-unsung-hero/
-- 
-- Function and Table Listeners
-- https://docs.coronalabs.com/guide/events/detectEvents/index.html#function-and-table-listeners
-- 相關問題的 forum post : How to delete runtime event on a child in a dipslay group? 
-- https://forums.coronalabs.com/topic/70032-how-to-delete-runtime-event-on-a-child-in-a-dipslay-group/
-----------------------------------------------------------------------------------------

-- forward declare functions
local onEnterFrame, finalizeListener, touchListener, createCircle

-- function to calculate distance between two points
local function getDistance ( x1, y1, x2, y2 )
   local dx = x1 - x2
   local dy = y1 - y2
   return math.sqrt ( dx * dx + dy * dy )
end

-- enterFrame listener
function onEnterFrame( self, event )
   local distance = getDistance( self.x, self.y, display.contentCenterX, display.contentCenterY )
   local scale = 1 - distance*.005
   self.xScale, self.yScale = scale, scale
end

-- finalize listener
function finalizeListener( self, event )
   Runtime:removeEventListener( "enterFrame", self )
   print( "Removed enterFrame Listener for "..tostring(self) )
   timer.performWithDelay( 1000, createCircle )			-- 一秒之後再重新使用enterFrame畫圓
end

-- touch listener
function touchListener( self, event )
   if event.phase == "began" then
      display.getCurrentStage():setFocus( self, event.id )
      self.hasFocus = true
   elseif self.hasFocus then
      self.x, self.y = event.x, event.y
      if event.phase == "ended" or event.phase == "cancelled" then
         self.hasFocus = false
         display.getCurrentStage():setFocus( nil, event.id )
         display.remove( self )
      end
   end
end

-- function to create a new circle and add listeners to it
function createCircle()
   local circle = display.newCircle( display.contentCenterX, display.contentCenterY, display.contentHeight*.075 )
   circle.finalize = finalizeListener			-- 如果沒有在物件被重畫之前做點事，每次enterFrame的時候就會找不到
   circle:addEventListener( "finalize" )

   circle.enterFrame = onEnterFrame				-- 注意這兩行是 table listener的寫法～
   Runtime:addEventListener( "enterFrame", circle )

   circle.touch = touchListener
   circle:addEventListener( "touch" )
end

-- create the first circle
createCircle()