
-- This example shows simple usage of displaying a skeleton with queued animations.

local spine = require "spine-corona.spine"

local chaser = {}
local json = spine.SkeletonJson.new()
json.scale = 0.35
local skeletonData = json:readSkeletonDataFile("ars.json")

chaser.skeleton = {}
chaser.skeleton = spine.Skeleton.new(skeletonData)
chaser.skeleton:setSkin("BadGuy01")
local fistObj = nil

function chaser.skeleton:createImage (attachment)
	-- Customize where images are loaded.
	
	local newPart = nil
		if (attachment.name == "HeroResized/DribbleGuySkin/Ball001") then
				
				
				 newPart =  display.newImage("balls/emptyBall.png")
		else		 
			 newPart =  display.newImage( attachment.name .. ".png")
		end
		
	
	
--	end
	return newPart
end
chaser.skeleton.group.x = 0
chaser.skeleton.group.y = display.contentHeight * 0.85
chaser.skeleton.flipX = false
chaser.skeleton.flipY = false
--skeleton.debug = true -- Omit or set to false to not draw debug lines on top of the images.
--skeleton.debugAabb = true
chaser.skeleton:setToSetupPose()

local bounds = spine.SkeletonBounds.new()

-- AnimationStateData defines crossfade durations between animations.
local stateData = spine.AnimationStateData.new(skeletonData)
--stateData:setMix("walk", "jump", 0.2)
--stateData:setMix("jump", "run", 0.2)

-- AnimationState has a queue of animations and can apply them with crossfading.
local state = spine.AnimationState.new(stateData)
-- state:setAnimationByName(0, "test")
state:setAnimationByName(0, "Run", true)
--state:addAnimationByName(0, "Chase", true, 3)
--state:addAnimationByName(0, "run", true, 0)

state.onStart = function (trackIndex)
	--print(trackIndex.." start: "..state:getCurrent(trackIndex).animation.name)
end
state.onEnd = function (trackIndex)
	--print(trackIndex.." end: "..state:getCurrent(trackIndex).animation.name)
end
state.onComplete = function (trackIndex, loopCount)
	--print(trackIndex.." complete: "..state:getCurrent(trackIndex).animation.name..", "..loopCount)
end
state.onEvent = function (trackIndex, event)
	--print(trackIndex.." event: "..state:getCurrent(trackIndex).animation.name..", "..event.data.name..", "..event.intValue..", "..event.floatValue..", '"..(event.stringValue or "").."'")
end

local walkSpeed = 5
local lastTime = 0
local touchX = 999999
local touchY = 999999
local isFirstFrame = false

--local headSlot = skeleton:findSlot("head")

local function handleFrame(event)
	-- Compute time in seconds since last frame.
	local currentTime = event.time / 1000
	local delta = currentTime - lastTime
	lastTime = currentTime
	if (isFirstFrame) then
			delta = 0
			isFirstFrame = false
	end

	-- Bounding box hit detection.
	bounds:update(chaser.skeleton, true)
	
	-- Update the state with the delta time, apply it, and update the world transforms.

	local deltaMulti = 1.3

	deltaMulti = walkSpeed/5

	state:update(delta * deltaMulti )
	state:apply(chaser.skeleton)
	chaser.skeleton:updateWorldTransform()
end


function chaser:pause()
	Runtime:removeEventListener("enterFrame", handleFrame)
end


function chaser:resume()
		
	lastTime = system.getTimer() / 1000
	Runtime:addEventListener("enterFrame", handleFrame)
end

function chaser:init()	
	Runtime:addEventListener("enterFrame", handleFrame)
end

function chaser:walk()
	state:setAnimationByName(0, "Run", true)
	state:apply(chaser.skeleton)
	chaser.skeleton:updateWorldTransform()
end

function chaser:stand()
	state:setAnimationByName(0, "EnemyStand", true)
	state:apply(chaser.skeleton)
	chaser.skeleton:updateWorldTransform()
end

function chaser:chase()
	-- state:setAnimationByName(0, "Chase", true)
	-- state:apply(chaser.skeleton)
	-- chaser.skeleton:updateWorldTransform()
end

function chaser:catch()
	isFirstFrame = false
	state:setAnimationByName(0, "EnemyCatch", false)
	state:apply(chaser.skeleton)
	chaser.skeleton:updateWorldTransform()
end



function chaser:getSkeleton()
	return chaser.skeleton
end

function chaser:getFist()
	return fistObj
end


function chaser:setWalkSpeed(newSpeed)
	walkSpeed = newSpeed
end


return chaser