
-- This example shows simple usage of displaying a skeleton with queued animations.

local spine = require "spine-corona.spine"

local speedometer = {}
function speedometer.new (skeletonData)

	local self = {	
		skeleton = {} ,
		json = {} ,
		skeletonData = {} ,
		lastTime = 0, 
		bounds = nil ,
		stateData = nil ,
		state = nil
	}


	self.json = spine.SkeletonJson.new()
	self.json.scale = 0.25
	self.skeletonData = self.json:readSkeletonDataFile("Speedometer/Speedometer.json")

	self.skeleton = {}
	self.skeleton = spine.Skeleton.new(self.skeletonData)

	function self.skeleton:createImage (attachment)
		-- Customize where images are loaded.
		
		local newPart =  display.newImage("Speedometer/" .. attachment.name .. ".png")

		
	--	end
		return newPart
	end
	--self.skeleton.group.x = 0
	---self.skeleton.group.y = display.contentHeight * 0.85
	self.skeleton.flipX = false
	self.skeleton.flipY = false
	--skeleton.debug = true -- Omit or set to false to not draw debug lines on top of the images.
	--skeleton.debugAabb = true
	self.skeleton:setToSetupPose()

	self.bounds = spine.SkeletonBounds.new()

	-- AnimationStateData defines crossfade durations between animations.
	self.stateData = spine.AnimationStateData.new(self.skeletonData)
	--stateData:setMix("walk", "jump", 0.2)
	--stateData:setMix("jump", "run", 0.2)

	-- AnimationState has a queue of animations and can apply them with crossfading.
	self.state = spine.AnimationState.new(self.stateData)
	-- state:setAnimationByName(0, "test")
--	self.state:setAnimationByName(0, "speedometer", true, 0)
	--state:addAnimationByName(0, "run", true, 0)

	self.state.onStart = function (trackIndex)
		--print(trackIndex.." start: "..state:getCurrent(trackIndex).animation.name)
	end
	self.state.onEnd = function (trackIndex)
		--print(trackIndex.." end: "..state:getCurrent(trackIndex).animation.name)
	end
	self.state.onComplete = function (trackIndex, loopCount)
		--print(trackIndex.." complete: "..state:getCurrent(trackIndex).animation.name..", "..loopCount)
	end
	self.state.onEvent = function (trackIndex, event)
		--print(trackIndex.." event: "..state:getCurrent(trackIndex).animation.name..", "..event.data.name..", "..event.intValue..", "..event.floatValue..", '"..(event.stringValue or "").."'")
	end

	--local headSlot = skeleton:findSlot("head")

	local function handleFrame(event)
		-- Compute time in seconds since last frame.
		local currentTime = event.time / 1000
		local delta = currentTime - self.lastTime
		self.lastTime = currentTime

		-- Bounding box hit detection.
		self.bounds:update(self.skeleton, true)
		
		-- Update the state with the delta time, apply it, and update the world transforms.
		--print(delta)
		self.state:update(delta )
		self.state:apply(self.skeleton)
		self.skeleton:updateWorldTransform()
	end


	function self:pause()
		--Runtime:removeEventListener("enterFrame", handleFrame)
	end

	function self:init()	
		--Runtime:addEventListener("enterFrame", handleFrame)		
		self.state:setAnimationByName(0, "Clicks", true, 0) 
	end

	function self:swipeLeft()
		self.state:setAnimationByName(0, "SwipeLeft", true, 0) --
	end

	function self:swipeRight()
		self.state:setAnimationByName(0, "SwipeRight", true, 0) --
	end

	local needle = self.skeleton:findBone("Needle")
	function self:setSpeed(speed)
		--local scaledSpeed = (speed/10 - 0.4 ) * 0.6
		local scaledSpeed = nil
		--self.state:update(scaledSpeed)
		--self.state:setAnimationByName(0, "Clicks", true, 0) 
		--self.state:update(scaledSpeed)

		if (speed > 9) then
			needle.data.rotation = 130
		elseif (speed > 8) then
			needle.data.rotation = 100
		elseif (speed > 7) then
			needle.data.rotation = 80
		elseif (speed > 6) then
			needle.data.rotation = 60
 		elseif (speed > 5) then
			needle.data.rotation = 30
		else
			needle.data.rotation = 10
		end	

		--needle.data.rotation = (speed - 4) * 130/6
		self.state:apply(self.skeleton)
		self.skeleton:updateWorldTransform()
	end


	function self:tapLeft()
		self.state:setAnimationByName(0, "TapLeft", true, 0) --
	end


	function self:tapRight()
		self.state:setAnimationByName(0, "TapRight", true, 0) --
	end
	function self:getSkeleton()
		return self.skeleton
	end


	return self
end
return speedometer