require "physics"
physics.start()
physics.setGravity(0, 9.8)
physics.setDrawMode("hybrid")

local touchBox = display.newRect(300, 300, 150, 150)
touchBox:setFillColor(0, 255, 0)
physics.addBody(touchBox, "dynamic", { bounce=0.2 })

local staticBox = display.newRect( display.contentCenterX, 860, display.contentWidth, 80 )
staticBox:setFillColor(0.2, 0.2, 1)
physics.addBody(staticBox, "static", { bounce=0 })

function onTouch(event)
	if event.phase == "began" then
		touchJoint = physics.newJoint("touch", touchBox, event.x, event.y)
		return true
	elseif event.phase == "moved" then
		touchJoint:setTarget(event.x, event.y)
		return true
	elseif event.phase == "ended" or event.phase == "cancelled" then
		touchJoint:removeSelf()
		touchJoint = nill
		return false
	end
end

Runtime:addEventListener("touch", onTouch)