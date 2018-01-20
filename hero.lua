
-- This example shows simple usage of displaying a skeleton with queued animations.
local commonData = require( "commonData" )
local Bone = require "spine-lua.Bone"
local Slot = require "spine-lua.Slot"
local IkConstraint = require "spine-lua.IkConstraint"

local spine = require "spine-corona.spine"
require "catalog"

local hero = {}
local skinSlots = {}
 skinSlots["ArmBackBottom"] = true
 skinSlots["ArmBackPalm"] = true
 skinSlots["ArmBackTop"] = true
 skinSlots["ArmFrontBottom"] = true
 skinSlots["ArmFrontPalm"] = true
 skinSlots["ArmFrontTop"] = true
 skinSlots["Neck"] = true
 skinSlots["Head"] = true
 skinSlots["Face"] = true
 skinSlots["Ear"] = true
-- ]

local shirtSlots = {}
 shirtSlots["ArmFrontSleeve"] = true
 shirtSlots["ArmBackSleeve"] = true
 shirtSlots["BodyTop"] = true


local lefttSlots = {}
 shirtSlots["ArmFrontSleeve"] = true
 shirtSlots["ArmBackSleeve"] = true
 shirtSlots["BodyTop"] = true

  


function hero.new (scale, showBall, isFromShop , avatar, isFromMenu)

	local self = {	
		skeleton = {} ,
		json = {} ,
		lastTime = 0, 
		bounds = nil ,
		stateData = nil ,
		state = nil,
		pScale = scale,
		isShop = isFromShop,
		isMenu = isFromMenu,
		displayGroup = nil,	
	}

	local forceShowBall = false

		local json = spine.SkeletonJson.new()
		json.scale = scale
		local skeletonData = nil

		local skinToDisplay = nil
		

		if (self.isShop) then
			skinToDisplay = commonData.shopSkin
			
		else
			skinToDisplay = commonData.selectedSkin
			
		end	

		if avatar then
			
			skinToDisplay = nil

			

			for i=1,#items.skins do
				if items.skins[i].id == avatar.skin then
					skinToDisplay = avatar.skin
					break
				end	
			end

			local isExists = false
			for i=1,#items.pants do
				if items.pants[i].id == avatar.pants then					
					isExists = true
					break
				end	
			end

			if not isExists then
				avatar.pants = "defaultPants"
			end	

			local isExists = false
			for i=1,#items.shirts do
				if items.shirts[i].id == avatar.shirt then					
					isExists = true
					break
				end	
			end

			if not isExists then
				avatar.shirt = "defaultShirt"
			end	

			local isExists = false
			for i=1,#items.shoes do
				if items.shoes[i].id == avatar.shoes then					
					isExists = true
					break
				end	
			end

			if not isExists then
				avatar.shoes = "Default"
			end	

			local isExists = false
			for i=1,#items.balls do
				if items.balls[i].id == avatar.ball then					
					isExists = true
					break
				end	
			end

			if not isExists then
				avatar.ball = "Ball001"
			end	

		end

		if not skinToDisplay then
			skinToDisplay = "littleDribbler"
			if avatar then
				avatar.skin = "littleDribbler"
			end	
		end	

		json.scale = scale *  1.05
		skeletonData = json:readSkeletonDataFile("Hero.json")
		-- print(skinToDisplay)
		-- if (skinToDisplay == "littleDribbler") then
		-- 	skeletonData = json:readSkeletonDataFile("Hero.json")
		-- elseif (skinToDisplay == "Rolando") then
			
		-- 	json.scale = scale *  1.1

		-- 	skeletonData = json:readSkeletonDataFile("RolandoSkin/Rolando.json")
			
		-- elseif (skinToDisplay == "Nessi") then
			
		-- 	json.scale = scale *  1.1

		-- 	skeletonData = json:readSkeletonDataFile("MessiSkin/Messi.json")
			
		-- end
		
		self.skeleton = {}
		self.skeleton = spine.Skeleton.new(skeletonData)

		if (skinToDisplay == "littleDribbler") then
			self.skeleton:setSkin("DribbleGuy")

		elseif (skinToDisplay == "DribbleGirl") then
			self.skeleton:setSkin("DribbleGirl")
		
		elseif (skinToDisplay == "Rolando") then
			
			self.skeleton:setSkin("Ronaldo")
		
		elseif (skinToDisplay == "Nessi") then
			
			self.skeleton:setSkin("Messi")
		elseif (skinToDisplay == "PewDiePie") then
			
			self.skeleton:setSkin("PDP")
		elseif 	skinToDisplay then
			self.skeleton:setSkin(skinToDisplay)
		end
		local headObj = nil
		local leftShoeObj = nil
		local rightShoeObj = nil
		local rightTopObj = nil
		local rightBottomObj = nil
		
		function self.skeleton:createImage (attachment)
			-- Customize where images are loaded.
			
			--print(attachment.name)
			local attachmentImg =  attachment.name
			
			
			local skinToDisplay = nil
			local ballToDisplay = nil
			local shoeToDisplay = nil
			local pantsToDisplay = nil
			local shirtToDisplay = "default"

			if (isFromShop) then
				skinToDisplay = commonData.shopSkin
				ballToDisplay = commonData.shopBall
				shoeToDisplay = commonData.shopShoes
				pantsToDisplay = commonData.shopPants
				shirtToDisplay = commonData.shopShirt
			
			else
				skinToDisplay = commonData.selectedSkin
				ballToDisplay = commonData.selectedBall
				shoeToDisplay = commonData.selectedShoes
				pantsToDisplay = commonData.selectedPants
				shirtToDisplay = commonData.selectedShirt			
			end	


			if avatar then
				skinToDisplay = avatar.skin				
				ballToDisplay = avatar.ball
				shoeToDisplay = avatar.shoes
				pantsToDisplay = avatar.pants
				shirtToDisplay = avatar.shirt			

			end

			if not skinToDisplay then
				skinToDisplay = "littleDribbler"
			end	
			if not ballToDisplay then
				ballToDisplay = "Ball001"
			end	
			if not shoeToDisplay then
				shoeToDisplay = "Default"
			end	
			if not pantsToDisplay then
				pantsToDisplay = "defaultPants"
			end	
			if not shirtToDisplay then
				shirtToDisplay = "defaultShirt"
			end	

			--print(skinToDisplay)

			local newPart =  nil

			if isFromMenu and  ( string.ends(attachment.name , "LegFrontBottom")  or  string.ends(attachment.name , "BodyTop")   ) then
				
				attachmentImg = attachmentImg .. "_Menu"
				
			end	 
			
			if (attachment.name == "HeroResized/DribbleGuySkin/Ball001") then
				if (showBall or forceShowBall ) then
					attachmentImg = ballToDisplay
				else
					attachmentImg = "emptyBall"
					
				end
				
				 newPart =  display.newImage("balls/" .. attachmentImg .. ".png")
						
			elseif string.ends(attachment.name , "Shoe") then				
				newPart = display.newImage( attachmentImg .. ".png")
				if 	string.ends(attachment.name , "LegFrontShoe")  then
					
					-- if skinToDisplay == "DribbleBot" then
					-- 	newPart =  display.newImage("HeroResized/Dribblebot/Shoe.png")
					-- else
					-- 	newPart =  display.newImage("shoes/" .. shoeToDisplay .. "/LegFrontShoe.png")
					-- end
					rightShoeObj = newPart
					
				else

					-- if skinToDisplay == "DribbleBot" then
					-- 	newPart =  display.newImage("HeroResized/Dribblebot/Shoe.png")
					-- else
					-- 	newPart =  display.newImage("shoes/" .. shoeToDisplay .. "/LegBackShoe.png")
					-- end	
					leftShoeObj = newPart

					
				end	

				 		
			else
	
				 newPart = display.newImage( attachmentImg .. ".png")
				
			end
			 
			if (string.ends(attachment.name , "Head")) then
				--borderCollisionFilter = { categoryBits = 1, maskBits = 2 } -- collides with ball
				--local defenderOutline = graphics.newOutline( 2, "Skin/" .. attachment.name .. ".png" )
				--borderBodyElement = { friction=0.4, bounce=0.1, filter=borderCollisionFilter , outline = defenderOutline }

				--newPart.name = "leg"
				headObj = newPart
		--		local physics = require("physics")
			--	physics.addBody( newPart, "static", borderBodyElement )
			
			elseif string.ends(attachment.name , "LegFrontBottom") or string.ends(attachment.name , "LegFrontBotom") then				
				rightBottomObj  = newPart	
			elseif string.ends(attachment.name , "LegFrontTop") then
				
				rightTopObj  = newPart	
			end
			

		
			return newPart
		end



		self.skeleton.group.x = display.contentWidth * 0.25
		if (commonData.selectedSkin ~= "littleDribbler") then
			self.skeleton.group.x = self.skeleton.group.x  - 3
		end
		self.skeleton.group.y = display.contentHeight * 0.85
		self.skeleton.flipX = false
		self.skeleton.flipY = false
		--self.skeleton.debug = true -- Omit or set to false to not draw debug lines on top of the images.
		--self.skeleton.debugAabb = true
		self.skeleton:setToSetupPose()

		local bounds = spine.SkeletonBounds.new()

		-- AnimationStateData defines crossfade durations between animations.
		local stateData = spine.AnimationStateData.new(skeletonData)
		--stateData:setMix("walk", "jump", 0.2)
		--stateData:setMix("jump", "run", 0.2)

		-- AnimationState has a queue of animations and can apply them with crossfading.
		self.state = spine.AnimationState.new(stateData)
		-- state:setAnimationByName(0, "test")
		
		stateData:setMix("Walk", "Jump", 0)
		stateData:setMix("Jump", "Walk", 0)
		
		--state:addAnimationByName(0, "run", true, 0)

		self.state.onStart = function (trackIndex)
			--print(trackIndex.." start: "..self.state:getCurrent(trackIndex).animation.name)
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

		local walkSpeed = 5
		local lastTime = 0
		local touchX = 999999
		local touchY = 999999
		--local headSlot = skeleton:findSlot("head")
		local headSlot = self.skeleton:findSlot("Head")
		local armSlot = self.skeleton:findSlot("ArmFrontBottom")

		local leftLeg1 = self.skeleton:findSlot("LegBackBottom") 
		local leftLeg2 = self.skeleton:findSlot("LegBackTop") 

		local rightLeg1 = self.skeleton:findSlot("LegFrontBottom") 
		local rightLeg2 = self.skeleton:findSlot("LegFrontTop") 

		--local headSlot = skeleton:findSlot("head")
		--local rear_thigh = skeleton:findBone("rear_thigh")
		local right_leg = self.skeleton:findBone("LegFrontTop")
		local left_leg = self.skeleton:findBone("LegBackTop")
		local right_knee = self.skeleton:findBone("LegFrontBottom")
		local left_knee = self.skeleton:findBone("LegBackBottom")
		local hip = self.skeleton:findBone("Hip")
		local legAngle = -82
		local isJumping = false
		local isFalling = false
		local isLeftLeg = false
		local isKicking = false
		local isWalking = false
		local walkTime = 0
		local kickTime = 10

		local isPaused = false
		local isFirstFrame = false
		local leftOriginalRot = left_leg.data.rotation
		local rightOriginalRot = right_leg.data.rotation

		local leftKneeOriginalRot = left_knee.data.rotation
		local rightKneeOriginalRot = right_knee.data.rotation


		-- right_leg.inheritRotation = false
		-- left_leg.inheritRotation = false
		-- right_knee.inheritRotation = false
		-- left_knee.inheritRotation = false

		local function handleFrame(event)
			-- Compute time in seconds since last frame.
			local currentTime = event.time / 1000
			local delta = currentTime - lastTime
			lastTime = currentTime


			if (isFirstFrame) then
				delta = 0
				isFirstFrame = false
			end	

				
			if (isKicking) then
				
				hip.data.rotation= 0 
				if (isLeftLeg) then 
					left_leg.data.rotation= legAngle
										
					left_knee.data.rotation= 0 
						
					right_leg.data.rotation=rightOriginalRot
				else	
					right_leg.data.rotation= legAngle
										
					right_knee.data.rotation= 0 
					
					left_leg.data.rotation=leftOriginalRot
				end
			else
				left_leg.data.rotation=leftOriginalRot
				right_leg.data.rotation=rightOriginalRot
				left_knee.data.rotation= leftKneeOriginalRot
				right_knee.data.rotation= rightKneeOriginalRot
			end	
			-- Update the state with the delta time, apply it, and update the world transforms.

			local deltaMulti = 1.3
			if (not isJumping) then
				deltaMulti = walkSpeed/5
			end

			-- if (isFalling) then	
			-- 	hip.data.rotation = -90 
			-- else
			-- 	hip.data.rotation = 0 
			-- end

			--if (not isKicking) then
				self.state:update(delta * deltaMulti )

				if isKicking then
					--kickTime = kickTime + delta * deltaMulti
					walkTime = walkTime + delta * deltaMulti
					--print (kickTime)
				elseif isWalking then
					walkTime = walkTime + delta * deltaMulti

				end	
			--end
			
			self.state:apply(self.skeleton)
			self.skeleton:updateWorldTransform()
			
		end


		function self:pause()
			Runtime:removeEventListener("enterFrame", handleFrame)
			isPaused = true
		end

		function self:resume()
				
			lastTime = system.getTimer() / 1000
			Runtime:addEventListener("enterFrame", handleFrame)
			isPaused = false
		end


		function self:fallObstecale()
			isFalling = true
			isKicking = false
			
			legAngle = -82
			self.skeleton:setToSetupPose()
			isFirstFrame = true

			
			if (math.random(2) == 1)  then
				self.state:setAnimationByName(0, "FallRollOver", false)	
			else
				self.state:setAnimationByName(0, "FallRollOver2", false)	
			end
			
			
			self.state:apply(self.skeleton)
			self.skeleton:updateWorldTransform()
			
		end

		function self:caught()
			isFalling = true
			legAngle = -82
			isFirstFrame = true
			isKicking = false
			
			self.skeleton:setToSetupPose()
			self.state:setAnimationByName(0, "FallRollOver", false)	

	
			self.state:apply(self.skeleton)
			self.skeleton:updateWorldTransform()
			
		end

		function self:gameOver()
			isFalling = true
			isKicking = false
			
			legAngle = -82
			isFirstFrame = true
			local rnd = math.random(2)
			if (rnd == 1)  then
				self.state:setAnimationByName(0, "Bummer01", true)	
				
			else
				self.state:setAnimationByName(0, "Bummer02", false)								
			end
			
			
			self.state:apply(self.skeleton)
			self.skeleton:updateWorldTransform()
			walkTime = 0
		end


		function self:init()
			walkTime = 0
			isFalling =  false
			Runtime:addEventListener("enterFrame", handleFrame)
			self.skeleton:setToSetupPose()
			self:applyColor()
			isPaused = false
		end

		
		function self:startKick(pIsLeftLeg,pIsBadKick)
			

			isKicking = true
			isWalking = false
			
			self.skeleton:setToSetupPose()

		

			if commonData.selectedSkin == "Zombie" then
					if pIsLeftLeg then
						self.state:setAnimationByName(0, "ZombieDribbleLeft", true)
					else
						self.state:setAnimationByName(0, "ZombieDribbleRight", true)
					end
			elseif commonData.selectedSkin == "DribbleBot" then
					if pIsLeftLeg then
						self.state:setAnimationByName(0, "BotDribbleLeft", true)
					else
						self.state:setAnimationByName(0, "BotDribbleRight", true)
					end
			else	

				if walkSpeed > 6 then				
					if pIsLeftLeg then
						self.state:setAnimationByName(0, "DribbleRunLeft", true)
					else
						self.state:setAnimationByName(0, "DribbleRunRight", true)
					end
				else	
					if pIsLeftLeg then
						self.state:setAnimationByName(0, "DribbleLeft", true)
					else
						self.state:setAnimationByName(0, "DribbleRight", true)
					end
				end
			end

			

			if (walkTime > 0 ) then 			
				 self.state:update( walkTime )		
				-- walkTime = 0		 
			end
			self.state:apply(self.skeleton)
			self.skeleton:updateWorldTransform()
				
		end	

		
		function self:walk( )
			--self.skeleton.group.x = display.contentWidth * 0.25 

			

			self.skeleton:setToSetupPose()
			if (not isFalling) then
				
				self.skeleton.group.x = display.contentWidth * 0.25

				-- if (selectedSkin ~= "littleDribbler" ) then
				self.skeleton.group.x = self.skeleton.group.x  - 3
				-- end

				if commonData.selectedSkin == "Zombie" then
					self.state:setAnimationByName(0, "ZombieWalk", true)
				elseif commonData.selectedSkin == "DribbleBot" then
					self.state:setAnimationByName(0, "BotWalk", true)
				else		

					if walkSpeed > 6 then				
					--self.state:setAnimationByName(0, "Walk", true)
						self.state:setAnimationByName(0, "Run", true)
					else
						self.state:setAnimationByName(0, "Walk", true)
					end
				end

				legAngle = -82
				isJumping = false
				isKicking = false
				isWalking = true

				-- if (isLeftLeg) then 
				-- 	self.state:update(0.2)
				-- else	
				-- 	self.state:update(1.1)
				-- end
				
				
				 if (walkTime > 0 ) then 
				 	
				 	self.state:update(walkTime)		
				 --	print("kickTime - " .. kickTime)
				 --	kickTime = 0

				 	
				 end

				self.state:apply(self.skeleton)
				self.skeleton:updateWorldTransform()
				
			end
		end

		function self:jump( )
			
		--	self.skeleton.group.x = display.contentWidth * 0.25 + 20
			
			self.skeleton:setToSetupPose()
			legAngle = -82
			
			local lowDuration = 0
			if commonData.selectedSkin == "DribbleBot" then
				self.state:setAnimationByName(0, "BotJump", false)			
			else	
				local rnd = 1--math.random(2)
				if (rnd == 1)  then
					self.state:setAnimationByName(0, "Jump", false)
					lowDuration = skeletonData:findAnimation("Jump").duration * 1000
				else			
					self.state:setAnimationByName(0, "Jump2", false)			
					lowDuration = skeletonData:findAnimation("Jump2").duration * 1000
				end
			end


			-- timer.performWithDelay( lowDuration/ 20  , function ()
		 -- 		self.skeleton.group.x = self.skeleton.group.x -1 
		 -- 		print(self.skeleton.group.x)
			
		 -- 	end, 20)
		 	
			
			isJumping = true
			isKicking = false
			--skeleton.group.x = display.contentWidth * 0.25 + 10
			return lowDuration / 1.3
		end


		function self:saltaJump( )
			
			
			self.skeleton:setToSetupPose()
			legAngle = -82
			local lowDuration = 0
			
			if commonData.selectedSkin == "DribbleBot" then
				self.state:setAnimationByName(0, "BotSalta", false)			
			else	
				self.state:setAnimationByName(0, "Jump3", false)
				lowDuration = skeletonData:findAnimation("Jump3").duration * 1000
			end
			
			isJumping = true
			isKicking = false
			--skeleton.group.x = display.contentWidth * 0.25 + 10
			return lowDuration / 1.3
		end

		local replayHandle =nil
		
	  local function idle1()
			isFirstFrame = true
			replayHandle = nil
			local animationName = "MenuIdle"

			local rnd = math.random(5)
			if  rnd == 1 then
				animationName = "MenuDribble"
			elseif rnd == 2 then		
				animationName = "MenuDribble2"
			elseif rnd == 3 then		
				animationName = "MenuDribble3"
			end	

			local skinToDisplay = nil
	
			if (self.isShop) then
				skinToDisplay = commonData.shopSkin
			else
				skinToDisplay = commonData.selectedSkin
			end	


			--print(right_leg.data.rotation)
			self.state:setAnimationByName(0, animationName, false)
			local animation = skeletonData:findAnimation(animationName)

			--print(animation.duration )		

			  
			if not isPaused  then
		 		replayHandle = timer.performWithDelay(animation.duration * 1000, idle1, 1)
		 	end

		 	local memUsed = (collectgarbage("count"))
             local texUsed = system.getInfo( "textureMemoryUsed" ) / 1048576 -- Reported in Bytes
           
            
   --         print( string.format("%.00f", texUsed) .. " / " .. memUsed)

		end

	 

		function self:menuIdle( )
			

		--	self.skeleton:setToSetupPose()
		--	self:applyColor()
		--	legAngle = -82
			
			-- MenuDribble 
			if not replayHandle then
				idle1()
			end
			isJumping = false
			isKicking = false
			--skeleton.group.x = display.contentWidth * 0.25 + 10
		end

		
		function self:stand(botAllowed )
			

		--	self.skeleton:setToSetupPose()
			isFirstFrame = true
			replayHandle = nil
			local animationName = "MenuIdle"

			if commonData.selectedSkin == "DribbleBot" and botAllowed then
				animationName = "BotIdel"
			end	
			
			self.state:setAnimationByName(0, animationName, true)
			
		end

		function self:hideBall()			
			
			for i,slotData in ipairs(self.skeleton.slots) do
				if slotData.attachment and slotData.attachment.name then
				
					if string.ends(slotData.attachment.name , "Ball001") then
				

						local image = self.skeleton.images[slotData]	

						if image then						
							display.remove(image)
							self.skeleton.images[slotData] = nil
						end
					end
				end

			end
			forceShowBall = false
		end



		function self:getSkeleton()
			return self.skeleton
		end

		function self:getHead()
			return headObj
		end

		function self:getLeftShoe()
			return leftShoeObj
		end

		function self:getRightShoe()
			return rightShoeObj
		end



		function self:setWalkSpeed(newSpeed)
			
			if (not isJumping) then
				if newSpeed  > 6 and walkSpeed <=6 then				
				--self.state:setAnimationByName(0, "Walk", true)
					self.state:setAnimationByName(0, "Run", true)
				end

				if newSpeed  < 6 and walkSpeed >=6 then						
					self.state:setAnimationByName(0, "Walk", true)
				end
			end				
			
			walkSpeed = newSpeed
		end

		function self:setKickAngle(newAngle , pIsLeftLeg, distanceFromPerfect)
			if (not isKicking) then 
				--self:startKick()
			isKicking = true	

			--	self.state:setAnimationByName(0, "DribbleHop", false)
			end


			legAngle = newAngle
			isLeftLeg = pIsLeftLeg
		end

		function self:cancelKick(pIsLeftLeg)

			
			
			isKicking = false
			isWalking = true
			--if pIsLeftLeg then
				left_leg.data.rotation=leftOriginalRot
		--	else
				right_leg.data.rotation=rightOriginalRot
				
			--end	
				self.state:apply(self.skeleton)
				self.skeleton:updateWorldTransform()
		end

		function self:markBadKick(pIsLeftLeg)

			
			if pIsLeftLeg then
				leftLeg1:setColor (1, 0, 0, 1)
				leftLeg2:setColor (1, 0, 0, 1)
			else	
				rightLeg1:setColor (1, 0, 0, 1)
				rightLeg2:setColor (1, 0, 0, 1)
			end	
		end	

		function self:markGoodKick()
			
				leftLeg1:setColor (leftLeg1.data.r, leftLeg1.data.g, leftLeg1.data.b, leftLeg1.data.a)
				leftLeg2:setColor (leftLeg2.data.r, leftLeg2.data.g, leftLeg2.data.b, leftLeg2.data.a)
			
				rightLeg1:setColor (rightLeg1.data.r, rightLeg1.data.g, rightLeg1.data.b, rightLeg1.data.a)
				rightLeg2:setColor (rightLeg2.data.r, rightLeg2.data.g, rightLeg2.data.b, rightLeg2.data.a)
			
		end	


		function self:applyColor()

			--headSlot:setColor (1, 0, 0, 1)

			-- local skinToDisplay = nil
			-- if (self.isShop) then
			-- 	skinToDisplay = shopSkin
			
			-- else
			-- 	skinToDisplay = selectedSkin
			-- end	

			-- local shouldUseDefaultColor = false

			-- if (skinToDisplay == "littleDribbler" or 
			-- 	skinToDisplay == "DribbleGirl") then


			-- 	local shirtColor = nil
			-- 	if (self.isShop) then
			-- 		shirtColor = shopShirt.color
				
			-- 	else
			-- 		shirtColor = selectedShirt.color
			-- 	end	

			-- 	if shirtColor then
			-- 		for i,slot in ipairs(self.skeleton.drawOrder) do
			-- 			if (shirtSlots[slot.data.name]) then
			-- 				slot:setColor (shirtColor.r, shirtColor.g, shirtColor.b, 1)
			-- 			end	
			-- 		end
			-- 	else
			-- 		shouldUseDefaultColor = true
			-- 	end
			-- else
			-- 	shouldUseDefaultColor = true
			-- end

			-- if shouldUseDefaultColor then
			-- 		for i,slot in ipairs(self.skeleton.drawOrder) do
			-- 			if (shirtSlots[slot.data.name]) then
			-- 				slot:setColor (slot.data.r, slot.data.g, slot.data.b, slot.data.a)
			-- 			end	
			-- 		end	
			-- end		
			
		end


		function self:reload()

			
		local skeletonData = nil
		local skinToDisplay = nil
		if (self.isShop) then
			skinToDisplay = commonData.shopSkin
		
		else
			skinToDisplay = commonData.selectedSkin
		end	


		if avatar then
			skinToDisplay = avatar.skin
		end

		-- print("reloaddd")
					
			-- TODO: add cache
		-- print(skinToDisplay)
		if (skinToDisplay == "littleDribbler") then
			self.skeleton:setSkin("DribbleGuy")
			
		elseif (skinToDisplay == "DribbleGirl") then
			self.skeleton:setSkin("DribbleGirl")
		
		elseif (skinToDisplay == "Rolando") then
			
			self.skeleton:setSkin("Ronaldo")
		
		elseif (skinToDisplay == "Nessi") then
			
			self.skeleton:setSkin("Messi")
		elseif (skinToDisplay == "PewDiePie") then
			
			self.skeleton:setSkin("PDP")
		elseif 	skinToDisplay then
			self.skeleton:setSkin(skinToDisplay)
		end
		

		-- for i,slotData in ipairs(self.skeleton.slots) do
		-- 	if (not self.skeleton.drawOrder[slotData.name]) then
				
		-- 		table.insert(self.skeleton.drawOrder, slotData)
		-- 	end	
		-- end

		for i,slotData in ipairs(self.skeleton.slots) do
			if slotData.attachment and slotData.attachment.name then
			
				if (
					string.ends(slotData.attachment.name , "BodyBottom") or 
					string.ends(slotData.attachment.name , "LegBackBottom")  or
					string.ends(slotData.attachment.name , "LegBackTop") or 
					string.ends(slotData.attachment.name , "LegFrontBottom")  or
					string.ends(slotData.attachment.name , "LegFrontTop") or 
					string.ends(slotData.attachment.name , "ArmBackSleeve") or
					string.ends(slotData.attachment.name , "ArmFrontSleeve") or
					string.ends(slotData.attachment.name , "BodyTop") or
					string.ends(slotData.attachment.name , "Ball001") or
					string.ends(slotData.attachment.name , "LegFrontShoe") or
					string.ends(slotData.attachment.name , "LegBackShoe")) then
			

					local image = self.skeleton.images[slotData]	

					if image then						
						display.remove(image)
						self.skeleton.images[slotData] = nil
					end
				end
			end
		end


		-- self.skeleton:updateCache()
		-- self.skeleton:setToSetupPose()
		 self:applyColor()
		
		
			
		end

	return self
end
return hero