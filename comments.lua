local commonData = require( "commonData" )

-- This example shows simple usage of displaying a skeleton with queued animations.

local spine = require "spine-corona.spine"

local comments = {}
local swooshsound  = audio.loadSound( "Comments/WordSwoosh.mp3" )
function comments.new (skeletonData)

	local self = {	
		skeleton = {} ,
		json = {} ,
		skeletonData = {} ,
		lastTime = 0, 
		bounds = nil ,
		stateData = nil ,
		state = nil
	}
	self.rewards = {}

	self.rewards[1] = {}
	self.rewards[2] = {}
	self.rewards[3] = {}
	self.rewards[4] = {}
	self.rewards[5] = {}
	self.rewards[6] = {}

	self.rewards[1].animation = "Amazing"
	self.rewards[2].animation = "Awesome"
	self.rewards[3].animation = "Cool"
	self.rewards[4].animation = "Nice"
	self.rewards[5].animation = "Superb"
	self.rewards[6].animation = "Wow"

	
	self.rewards[1].sound = audio.loadSound( "Comments/Amazing 2.mp3" )
	self.rewards[2].sound = audio.loadSound( "Comments/Awesome 2.mp3" )
	self.rewards[3].sound = audio.loadSound( "Comments/Cool 2.mp3" )
	self.rewards[4].sound = audio.loadSound( "Comments/Nice 2.mp3" )
	self.rewards[5].sound = audio.loadSound( "Comments/Superb 2.mp3" )	
	self.rewards[6].sound = audio.loadSound( "Comments/Wow 2.mp3" )
	
	self.json = spine.SkeletonJson.new()
	self.json.scale = 0.15
	self.skeletonData = self.json:readSkeletonDataFile("Comments/comments.json")

	self.skeleton = {}
	self.skeleton = spine.Skeleton.new(self.skeletonData)

	function self.skeleton:createImage (attachment)
		-- Customize where images are loaded.
		
		local newPart =  display.newImage("Comments/" .. attachment.name .. ".png")

		
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
--	self.state:setAnimationByName(0, "comments", true, 0)
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
	local deltaMulti = 1


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
		self.state:update(delta * deltaMulti )
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
		
	end

	local function localPlaySound(event)	
		 local params = event.source.params           
         commonData.playSound( params.sound )
		
	end

	local lastReward = nil
	function self:showReward()	
		--Runtime:addEventListener("enterFrame", handleFrame)
		Runtime:addEventListener("enterFrame", handleFrame)		
		isFirst = true
		deltaMulti = 1

		self.skeleton:setToSetupPose()
		self.skeleton.group.alpha =1
		local rnd = math.random(6)

		if (rnd == lastReward) then
			rnd = rnd % 6 + 1 
		end

		lastReward = rnd
		commonData.playSound(swooshsound)
		local ts = timer.performWithDelay(500, localPlaySound, 1)
        ts.params = {sound = self.rewards[rnd].sound}

		
		--playSound(self.rewards[rnd].sound)   
		local  animationName = self.rewards[rnd].animation		
		self.state:setAnimationByName(0, animationName, true, 0) --  commentsYell
		local animation = self.skeletonData:findAnimation(animationName)
		timer.performWithDelay(animation.duration * 1000, pauseAnimation, 1)
		
	end

	function self:resume()	
		--Runtime:addEventListener("enterFrame", handleFrame)
		Runtime:addEventListener("enterFrame", handleFrame)		
		isFirst = true
		self.skeleton:setToSetupPose()
		self.skeleton.group.alpha =1
		deltaMulti = 1.5

		local  animationName = "Resume"
		self.state:setAnimationByName(0, animationName, true, 0) --  commentsYell
		local animation = self.skeletonData:findAnimation(animationName)

		local duration = animation.duration / deltaMulti
		timer.performWithDelay(duration * 1000, pauseAnimation, 1)
		
		return duration 
	end


	function self:getSkeleton()
		return self.skeleton
	end


	return self
end
return comments