
-- This example shows simple usage of displaying a skeleton with queued animations.

local spine = require "spine-corona.spine"

local ars = {}
local kidTypes = {}

local  skinIdx = 1

kidTypes[1] = {}
kidTypes[1].json = "ars.json"
kidTypes[1].skin = "BadGuy01"
kidTypes[1].scale = 0.4
kidTypes[1].anim = "EnemyCrouch"

kidTypes[2] = {}
kidTypes[2].json = "ars.json"
kidTypes[2].skin = "BadGuy03"
kidTypes[2].scale = 0.4
kidTypes[2].anim = "EnemyCrouch2"

kidTypes[3] = {}
kidTypes[3].json = "ars.json"
kidTypes[3].skin = "BadGuy01"
kidTypes[3].scale = 0.35
kidTypes[3].anim = "EnemyStand"

kidTypes[4] = {}
kidTypes[4].json = "ars.json"
kidTypes[4].skin = "BadGuy03"
kidTypes[4].scale = 0.4
kidTypes[4].anim = "EnemySlide"


kidTypes[5] = {}
kidTypes[5].json = "ars.json"
kidTypes[5].skin = "BadGuy02"
kidTypes[5].scale = 0.4
kidTypes[5].anim = "EnemyTall"

-- 		EnemyStand
-- - EnemySlide
-- - EnemyCrouch
-- - EnemyCrouch2
-- - EnemyTall


-- kidTypes[2].json = "AnnoyingKid02.json"
-- kidTypes[2].path = "defender2"
-- kidTypes[2].scale = 0.3
-- kidTypes[3] = {}
-- kidTypes[3].json = "AnnoyingKid03.json"
-- kidTypes[3].path = "defender3"
-- kidTypes[3].scale = 0.37


function ars.new (kidType)


	local self = {	
		skeleton = {} ,
		json = {} ,
		skeletonData = {} ,
		lastTime = 0, 
		bounds = nil ,
		stateData = nil ,
		skinIdx = nil ,
		state = nil
	}
	
	self.json = spine.SkeletonJson.new()
	self.json.scale = kidTypes[kidType].scale
	self.skeletonData = self.json:readSkeletonDataFile(kidTypes[kidType].json)

	self.skeleton = {}
	self.skeleton = spine.Skeleton.new(self.skeletonData)

	self.skeleton:setSkin(kidTypes[kidType].skin)

	function self.skeleton:createImage (attachment)
		-- Customize where images are loaded.
		
		local newPart = nil
		if (attachment.name == "HeroResized/DribbleGuySkin/Ball001") then
				
				
				 newPart =  display.newImage("balls/emptyBall.png")
		elseif (string.ends(attachment.name , "Face") and  skinIdx >2 ) then
			newPart = display.newImage("balls/emptyBall.png")
		else		 
			 newPart =  display.newImage( attachment.name .. ".png")
		end


		--local newPart =  display.newImage(kidTypes[kidType].path .. "/" .. attachment.name .. ".png")

--print(attachment.name )
		
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
--	self.state:setAnimationByName(0, "ars", true, 0)
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
		Runtime:removeEventListener("enterFrame", handleFrame)
	end

	function self:init()	
		Runtime:addEventListener("enterFrame", handleFrame)
		self.skeleton:setToSetupPose()

		if kidType ~= 5  then
			skinIdx = math.random( 5)

			if (skinIdx == 2 ) then
				skinIdx = 6
			end		

			for i,slotData in ipairs(self.skeleton.slots) do
						

							local image = self.skeleton.images[slotData]	

							if image then						
								display.remove(image)
								self.skeleton.images[slotData] = nil
							end
						
					
				end

			self.skeleton:setSkin("BadGuy0" .. skinIdx)

			for i,slotData in ipairs(self.skeleton.slots) do
						

							local image = self.skeleton.images[slotData]	

							if image then						
								display.remove(image)
								self.skeleton.images[slotData] = nil
							end
						
					
				end
		else	
			skinIdx = 2
		end

		self.state:setAnimationByName(0, kidTypes[kidType].anim, true, 0) --  arsYell

	end

	function self:fail()	
		
		self.state:setAnimationByName(0, kidTypes[kidType].anim, true, 0) --  arsYell

	end

	function self:getSkeleton()
		return self.skeleton
	end


	return self
end
return ars