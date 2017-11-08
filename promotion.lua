
-- This example shows simple usage of displaying a skeleton with queued animations.

local spine = require "spine-corona.spine"

local promotion = {}


function promotion.new (promotionType)


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
	self.json.scale = 0.33
	self.skeletonData = self.json:readSkeletonDataFile("Promotion Wings/PromoWings.json")

	self.skeleton = {}
	self.skeleton = spine.Skeleton.new(self.skeletonData)
	
	function self.skeleton:createImage (attachment)
		-- Customize where images are loaded.
			
		local newPart =   display.newImage( "Promotion Wings/" .. attachment.name .. ".png")

		
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
	
	--state:addAnimationByName(0, "run", true, 0)
	self.time =0

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
	local animation = self.skeletonData:findAnimation("animation")

	local isFirst = true
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
		self.state:update(delta)
		self.state:apply(self.skeleton)
		self.skeleton:updateWorldTransform()
	end


	function self:pause()
		
		Runtime:removeEventListener("enterFrame", handleFrame)
		self.skeleton.group.alpha =0 
	end

	local function pauseAnimation()
		self:pause()
	end
	function self:init()

	
		isFirst = true
		self.skeleton:setToSetupPose()
		self.skeleton.group.alpha =1
			Runtime:addEventListener("enterFrame", handleFrame)
		self.state:setAnimationByName(0, "animation", false)

		--local animation = self.skeletonData:findAnimation("animation")
		--self.time =0
	--	self.lastTime = 0
		 self.state:apply(self.skeleton)
		 self.skeleton:updateWorldTransform()--self.lastTime = system.getTimer()
		 --timer.performWithDelay(animation.duration * 1000, pauseAnimation, 1)
		 --timer.performWithDelay( 1160, pauseAnimation, 1)
   
		 
	end

	function self:getSkeleton()
		return self.skeleton
	end

	

	return self
end
return promotion