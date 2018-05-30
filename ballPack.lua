
-- This example shows simple usage of displaying a skeleton with queued animations.

local spine = require "spine-corona.spine"

local ballPack = {}
function ballPack.new (skeletonData)

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
	self.json.scale = 0.5
	self.skeletonData = self.json:readSkeletonDataFile("jsons/PacksScreen.json")

	self.skeleton = {}
	self.skeleton = spine.Skeleton.new(self.skeletonData)

	function self.skeleton:createImage (attachment)
		-- Customize where images are loaded.
		
		local newPart =  display.newImage("PacksScreen/" .. attachment.name .. ".png")

		
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
	self.stateData:setMix("Drop", "Spin", 1)
	--stateData:setMix("jump", "run", 0.2)

	-- AnimationState has a queue of animations and can apply them with crossfading.
	self.state = spine.AnimationState.new(self.stateData)
	-- state:setAnimationByName(0, "test")
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
	local isFirst = true
	local isSpecial = false
	local function handleFrame(event)
		-- Compute time in seconds since last frame.
		local currentTime = event.time / 1000
		local delta = currentTime - self.lastTime
		self.lastTime = currentTime

		if (isFirst) then
			delta = 0
			isFirst = false
		end	

		-- Bounding box hit detection.
		self.bounds:update(self.skeleton, true)
		
		-- Update the state with the delta time, apply it, and update the world transforms.
		--print(delta)
		if isSpecial then
			self.state:update(delta  )
		else	
			self.state:update(delta / 2  )
		end
		self.state:apply(self.skeleton)
		self.skeleton:updateWorldTransform()
	end


	function self:pause()
		Runtime:removeEventListener("enterFrame", handleFrame)
	end

	function self:init()	
		Runtime:addEventListener("enterFrame", handleFrame)
		self.state:setAnimationByName(0, "Empty", false, 1)
	end

	function self:open()	
		isFirst = true
		isSpecial = false
	
		self.state:setAnimationByName(0, "Open", false, 1)
	end

	function self:openSpecial()	
		isFirst = true
		isSpecial = true
	
		self.state:setAnimationByName(0, "Open", false, 1)
	end
	

	function self:drop()	
		isFirst = true
		isSpecial = false
		self.state:setAnimationByName(0, "NewBall", false, 1)
	--	self.state:setAnimationByName(0, "Spin", true, 0)

	end

	function self:spin()	
		isSpecial = false
		self.state:setAnimationByName(0, "Idel", true, 0)
	end


	function self:getSkeleton()
		return self.skeleton
	end



	return self
end
return ballPack