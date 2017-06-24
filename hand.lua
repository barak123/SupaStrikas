
-- This example shows simple usage of displaying a skeleton with queued animations.

local spine = require "spine-corona.spine"

local hand = {}
function hand.new (skeletonData)

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
	self.skeletonData = self.json:readSkeletonDataFile("NewTutorial/TutorialHand.json")

	self.skeleton = {}
	self.skeleton = spine.Skeleton.new(self.skeletonData)

	local arrowHandle = nil
	local arrowHandle2 = nil
	function self.skeleton:createImage (attachment)
		-- Customize where images are loaded.
		
		local newPart =  display.newImage("NewTutorial/" .. attachment.name .. ".png")

	
			if (string.ends(attachment.name , "TutorialArrowUp") ) then
				arrowHandle = newPart
			end
			if (string.ends(attachment.name , "TutorialArrowUp+Down") ) then
				arrowHandle2 = newPart
			end
			
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
--	self.state:setAnimationByName(0, "hand", true, 0)
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

	local arrow = self.skeleton:findBone("Arrow")
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

	local isPaused = nil
	function self:pause()
		Runtime:removeEventListener("enterFrame", handleFrame)
		isPaused = true
	end

	function self:init()	
		Runtime:addEventListener("enterFrame", handleFrame)	
		isPaused = false	
	end

	function self:swipeLeft()
		self.state:setAnimationByName(0, "HandUpDown", true, 0) --
		if (arrowHandle2) then
			arrowHandle2.alpha = 1
		end 

	
	end

	function self:swipeRight()
		self.state:setAnimationByName(0, "HandUpDown", true, 0) --
		if (arrowHandle2) then
			arrowHandle2.alpha = 1
		end 

	
	end

	function self:handUp()
		self.state:setAnimationByName(0, "HandUp", true, 0) --

		if (arrowHandle) then
			arrowHandle.alpha = 1
		end 

	end


	function self:tapLeft()
		self.state:setAnimationByName(0, "HandJump", true, 0) --

		if (arrowHandle) then
			arrowHandle.alpha = 0
		end

		if (arrowHandle2) then
			arrowHandle2.alpha = 0
		end 


		-- for i,slotData in ipairs(self.skeleton.slots) do
		-- 	if slotData.attachment and slotData.attachment.name then
			
		-- 		if (
		-- 			string.ends(slotData.attachment.name , "TutorialArrowUp+Down") ) then
			

		-- 			local image = self.skeleton.images[slotData]	

		-- 			if image then						
		-- 				image.alpha = 0 
		-- 			end
		-- 		end
		-- 	end
		-- end

	end


	function self:tapRight()
		self.state:setAnimationByName(0, "HandJump", true, 0) --
		if (arrowHandle) then
			arrowHandle.alpha = 0
		end

		if (arrowHandle2) then
			arrowHandle2.alpha = 0
		end 

	end

	local replayHandle =nil
	local isLeft = true
	local rightX = 400
	local leftX = 50
	
	  local function idle1()
		isFirstFrame = true
		replayHandle = nil
		local animationName = nil

		if isLeft then
			animationName = "HandJump"
			self.skeleton.group.x  = leftX
		else
			animationName = "HandJump"
			self.skeleton.group.x  = rightX
		end	
		--print(right_leg.data.rotation)
		self.state:setAnimationByName(0, animationName, false)
		local animation = self.skeletonData:findAnimation(animationName)
	  
		if not isPaused  then
	 		replayHandle = timer.performWithDelay(animation.duration * 1000, idle1, 1)
	 	end

	 	isLeft = not isLeft
	end


	function self:legByLeg(right,left )
		-- rightX = right
		-- leftX = left
		

		if not replayHandle then
			idle1()
		end
	end
	function self:cancelLegByLeg()
		
		if replayHandle then
			timer.cancel(replayHandle)
			replayHandle = nil
		end
	end

	function self:getSkeleton()
		return self.skeleton
	end


	return self
end
return hand