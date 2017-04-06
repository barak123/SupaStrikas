
-- This example shows simple usage of displaying a skeleton with queued animations.

local spine = require "spine-corona.spine"

local coach = {}
local json = spine.SkeletonJson.new()
json.scale = 0.25
local skeletonData = json:readSkeletonDataFile("Coach.json")

coach.skeleton = {}
coach.skeleton = spine.Skeleton.new(skeletonData)
local fistObj = nil

coach.skeleton:setSkin("Coach")

function coach.skeleton:createImage (attachment)
	-- Customize where images are loaded.
	if 
		attachment.name== "HeroResized/DribbleGuySkin/Ball001" then
		return nil
	end	

	local newPart =  display.newImage( attachment.name .. ".png")

	

	-- if (attachment.name == "ArmBackOpen" or attachment.name == "ArmBackFist") then
	-- 	--borderCollisionFilter = { categoryBits = 1, maskBits = 2 } -- collides with ball
	-- 	--local defenderOutline = graphics.newOutline( 2, "Skin/" .. attachment.name .. ".png" )
	-- 	--borderBodyElement = { friction=0.4, bounce=0.1, filter=borderCollisionFilter , outline = defenderOutline }

	-- 	--newPart.name = "leg"
	-- 	fistObj = newPart
	-- end
--	end
	return newPart
end

function coach.skeleton:getName ()
	return "coach"
end
coach.skeleton.group.x = 0
coach.skeleton.group.y = display.contentHeight * 0.75
coach.skeleton.flipX = false
coach.skeleton.flipY = false
--skeleton.debug = true -- Omit or set to false to not draw debug lines on top of the images.
--skeleton.debugAabb = true
coach.skeleton:setToSetupPose()

local bounds = spine.SkeletonBounds.new()

-- AnimationStateData defines crossfade durations between animations.
local stateData = spine.AnimationStateData.new(skeletonData)
--stateData:setMix("walk", "jump", 0.2)
--stateData:setMix("jump", "run", 0.2)

-- AnimationState has a queue of animations and can apply them with crossfading.
local state = spine.AnimationState.new(stateData)
-- state:setAnimationByName(0, "test")
--state:setAnimationByName(0, "Run", true)

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
	bounds:update(coach.skeleton, true)
	
	-- Update the state with the delta time, apply it, and update the world transforms.

	local deltaMulti = 1.3

	deltaMulti = walkSpeed/5

	state:update(delta * deltaMulti )
	state:apply(coach.skeleton)
	coach.skeleton:updateWorldTransform()
end


function coach:pause()
	Runtime:removeEventListener("enterFrame", handleFrame)
end


function coach:resume()
		
	lastTime = system.getTimer() / 1000
	Runtime:addEventListener("enterFrame", handleFrame)
end

function coach:init()	
	Runtime:addEventListener("enterFrame", handleFrame)
	state:setAnimationByName(0, "Run", true)
end

function coach:walk()
	state:setAnimationByName(0, "Run", true)
	state:apply(coach.skeleton)
	coach.skeleton:updateWorldTransform()
end

function coach:stand()
	state:setAnimationByName(0, "EnemyStand", true)
	state:apply(coach.skeleton)
	coach.skeleton:updateWorldTransform()
end

function coach:good()
	state:setAnimationByName(0, "Bummer02", false)
	state:apply(coach.skeleton)
	coach.skeleton:updateWorldTransform()
end



function coach:catch()
	isFirstFrame = false
	state:setAnimationByName(0, "Catch", false)
	state:apply(coach.skeleton)
	coach.skeleton:updateWorldTransform()
end



function coach:getSkeleton()
	return coach.skeleton
end

function coach:getFist()
	return fistObj
end


function coach:setWalkSpeed(newSpeed)
	walkSpeed = newSpeed
end


return coach