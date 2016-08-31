local composer = require( "composer" )
local scene = composer.newScene()

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
display.setStatusBar(display.HiddenStatusBar)

 hero =  require ("hero")
 chaser =  require ("chaser")
 require ("game_config")

 -- skeleton = getSkeleton()
--skelton:scale(0.5,0.5)
system.activate( "multitouch" )
local physics = require("physics")
physics.start()
--physics.setDrawMode( "hybrid" )   

physics.setScale( 60 )

local imgsheetSetupDef = 
{
width = 115,
height = 126,
numFrames = 4
}

--local spriteSheet = graphics.newImageSheet("images/monsterSpriteSheet.png", imgsheetSetup);

local spriteSheetDef = graphics.newImageSheet("images/defenderSprite.png", imgsheetSetupDef);

--Now we create a table that holds the sequence data for our animations

local sequenceDataDef = 
{
{ name = "running", start = 1, count = 4, time = 600, loopCount = 0}
}



--these 2 variables will be the checks that control our event system.
 inEvent = 0
 eventRun = 0

ballon = display.newImage("images/red_balloon.png")
ballon.name = "ballon"
ballon.x = 160
ballon.y = 20

ballon:scale(0.8,0.8)

ballon.isFixedRotation = true
ignoreClick = false
isLeftLeg = false
leftStart = 0
rightStart = 0



--adds an image to our game centered at x and y coordinates
backbackground = display.newImage("images/background.png")
backbackground.x = 240
backbackground.y = 160
 
backgroundfar = display.newImage("images/bgfar1.png")
backgroundfar.x = 480
backgroundfar.y = 160

backgroundnear1 = display.newImage("images/bgnear2.png")
backgroundnear1.x = 240
backgroundnear1.y = 170
 
backgroundnear2 = display.newImage("images/bgnear2.png")
backgroundnear2.x = 760
backgroundnear2.y = 170
backgroundnear1:scale(0.5,0.5)
backgroundnear2:scale(0.5,0.5)


shadow = display.newImage("Skin/Shadow.png")
shadow.x = 160
shadow.y = 273
shadow:scale(0.3,0.3)


--create a new group to hold all of our blocks
blocks = display.newGroup()
player = display.newGroup()
screen = display.newGroup()
ghosts = display.newGroup()
--cones = display.newGroup()
coins = display.newGroup()
coinsSpine = display.newGroup()

--variable to hold our game's score
score = 0
--scoreText is another variable that holds a string that has the score information
--when we update the score we will always need to update this string as well
--*****Note for android users, you may need to include the file extension of the font
-- that you choose here, so it would be BorisBlackBloxx.ttf there******
--scoreText = display.newText("score: " .. score, 0, 0, "BorisBlackBloxx.ttf", 50)
scoreText = display.newText("score: " .. score, 0, 0)
--This is important because if you dont have this line the text will constantly keep
--centering itself rather than aligning itself up neatly along a fixed point
--scoreText: sequenceData ReferencePoint(display.CenterLeftReferencePoint)
scoreText.x = 100
scoreText.y = 30

coinsCountText = display.newText("Coins: ",0,0)
coinsCount = 0

coinsCountText.x = 300
coinsCountText.y = 30

kickPos = display.newText( "", 0, 0, native.systemFontBold, 20 )

kickPos.x = 80
kickPos.y = 300
kickPos:setFillColor(red)

currSpeed = display.newText("spped: ",0,0)

currSpeed.x = 400
currSpeed.y = 300


--setup some variables that we will use to position the ground

groundLevel = 360
speed = 5;

shotPower = 1
kickStart = 0; 
--this for loop will generate all of your ground pieces, we are going to
--make 8 in all.
for a = 1, 8, 1 do
isDone = false
 
--get a random number between 1 and 2, this is what we will use to decide which
--texture to use for our ground sprites. Doing this will give us random ground
--pieces so it seems like the ground goes on forever. You can have as many different
--textures as you want. The more you have the more random it will be, just remember to
--up the number in math.random(x) to however many textures you have.
numGen = math.random(2)
local newBlock
print (numGen)
if(a % 2 == 1 and isDone == false) then
newBlock = display.newImage("images/ground4.png")
isDone = true
end
 
if(a % 2 == 0 and isDone == false) then
newBlock = display.newImage("images/ground5.png")
isDone = true
end
 
--now that we have the right image for the block we are going
--to give it some member variables that will help us keep track
--of each block as well as position them where we want them.
newBlock.name = ("block" .. a)
newBlock.id = a
 newBlock:scale(0.5,0.5)
--because a is a variable that is being changed each run we can assign
--values to the block based on a. In this case we want the x position to
--be positioned the width of a block apart.
newBlock.x = (a * 79) - 79
newBlock.y = groundLevel
blocks:insert(newBlock)
end

--And assign it to the object hero using the display.newSprite function
-- monster = display.newSprite(spriteSheet, sequenceData);

-- --these are 2 variables that will control the falling and jumping of the monster
-- monster.gravity = -6
-- monster.accel = 0
-- monster.isAlive = true
-- monster.kickTimer =0
-- monster.alpha = defualtAlpha
-- monster.name = "monster"
-- --monster:scale(0.5,0.5)

borderCollisionFilter = { categoryBits = 1, maskBits = 2 } -- collides with ball
borderBodyElement = { isSensor=true, filter=borderCollisionFilter }
gameOverElement = { friction=0.4, bounce=0.4, filter=borderCollisionFilter }
upperGameOverElement = {isSensor=true, filter=borderCollisionFilter }

local ballFilter = { categoryBits = 2, maskBits = 51 } -- collides with leg , border and defender 
local redBody = { density=0.2, friction=0.1, bounce=0, radius=13.0, filter=ballFilter }

coneCollisionFilter = { categoryBits = 4, maskBits = 9 } -- collides with leg and hero
coneElement = { friction=0.4, bounce=0.1, filter=coneCollisionFilter }

-- local letterOutline = graphics.newOutline( 2, spriteSheet, 6 )
-- heroCollisionFilter = { categoryBits = 8, maskBits = 4 } -- collides cone
-- heroElement = { friction=0.4, bounce=0.1, filter=heroCollisionFilter, outline=letterOutline }

local defenderOutline = graphics.newOutline( 2, spriteSheetDef, 4 )

defenderCollisionFilter = { categoryBits = 16, maskBits = 2 } 
defenderBodyElement = { friction=0.4, bounce=0.1, filter=defenderCollisionFilter, outline=defenderOutline }



refereeBodyElement = { friction=0.4, bounce=0.1, filter=coneCollisionFilter}

coinCollisionFilter = { categoryBits = 16, maskBits = 2 } 
-- radius=10.0,

local coinOutline = graphics.newOutline( 2, "images/coin.png" )
    --borderBodyElement = { friction=0.4, bounce=0.1, filter=borderCollisionFilter , outline = defenderOutline }

coinBodyElement = { isSensor=true,  filter=defenderCollisionFilter ,  outline = coinOutline }

birdCollisionFilter = { categoryBits = 32, maskBits = 10 } -- collides with ball and hero
birdBodyElement = { friction=0.4, bounce=0.1, filter=birdCollisionFilter }



defualtAlpha = 0
 local playButton = display.newImage("images/playButton.png")
 playButton.scale = 0.5
     playButton.x = 240
     if ( "simulator" == system.getInfo("environment")) then
      playButton.y = 220
      defualtAlpha = 1
     else     
      playButton.y = 720
    end
--rectangle used for our collision detection
--it will always be in front of the monster sprite
--that way we know if the monster hit into anything
collisionRect = display.newRect(36, 30, 50,1)
collisionRect.strokeWidth = 1
collisionRect:setFillColor(140, 140, 140)
collisionRect:setStrokeColor(180, 180, 180)
collisionRect.alpha = defualtAlpha
collisionRect.name = "header"


lShoeRect = display.newRect( 36, 30, 20,1)
lShoeRect.strokeWidth = 1
lShoeRect:setFillColor(140, 140, 140)
lShoeRect:setStrokeColor(180, 180, 180)
lShoeRect.alpha = defualtAlpha
lShoeRect.name = "leg"

rShoeRect = display.newRect( 36, 30, 20,1)
rShoeRect.strokeWidth = 1
rShoeRect:setFillColor(140, 140, 140)
rShoeRect:setStrokeColor(180, 180, 180)
rShoeRect.alpha = defualtAlpha
rShoeRect.name = "leg"


--physics.addBody( collisionRect, "static", borderBodyElement )
physics.addBody( collisionRect, "static", borderBodyElement )
physics.addBody( lShoeRect, "static", borderBodyElement )
physics.addBody( rShoeRect, "static", borderBodyElement )
physics.addBody( ballon, redBody )
--physics.addBody( monster, "kinematic" , heroElement )


local gameOverRect = display.newRect(100 , 300, 150,10)
gameOverRect.strokeWidth = 1
gameOverRect:setFillColor(140, 140, 140)
gameOverRect:setStrokeColor(180, 180, 180)
gameOverRect.alpha = defualtAlpha
gameOverRect.name = "gameOver"
physics.addBody( gameOverRect, "kinematic", gameOverElement )

local gameOverRect2 = display.newRect(100 , -30, 150,10)
gameOverRect2.strokeWidth = 1
gameOverRect2.alpha = defualtAlpha
gameOverRect2.name = "gameOver"
physics.addBody( gameOverRect2, "kinematic", upperGameOverElement )



--monster.alpha = defualtAlpha
       --create cones
--  for a = 1, 1, 1 do
    --  cones:insert(cone)
  --end
  coinSpineAn = require "coin"

  for a = 1, 3, 1 do
      coin = display.newImage("images/coin.png")

      coin.name = "coin"
      
      coin.id = a
      coin.x = 900
      coin.y = 500
      coin.alpha = 0 
      --coin.spine = coinSpine

      coin.isAlive = false
       physics.addBody( coin, "kinematic" , coinBodyElement )
      coin.gravityScale=0
      coins:insert(coin)

      coinSpine = {}
      coinSpine = coinSpineAn.new()

      coin.spine =  coinSpine
      print("boooooooooooooo")
      coinsSpine:insert(coinSpine.skeleton.group)
      print(coinsSpine[a])
  end

  chaserRect = display.newRect(20, 235 , 1,50)
  chaserRect.strokeWidth = 1
  chaserRect:setFillColor(140, 140, 140)
  chaserRect:setStrokeColor(180, 180, 180)
  chaserRect.alpha = defualtAlpha
  chaserRect.name = "chaser"



       
  chaserRect.x = 20
  chaserRect.y = 235
  chaserRect.speed = 3
  chaserRect.isAlive = false
  physics.addBody( chaserRect, "dynamic" , refereeBodyElement )
  chaserRect.gravityScale=0
 --defenders = display.newGroup()

 obstecales = display.newGroup()


smallDefender  = display.newSprite(spriteSheetDef, sequenceDataDef);
smallDefender:scale(0.5,0.5)
medDefender  = display.newSprite(spriteSheetDef, sequenceDataDef);
bigDefender  = display.newSprite(spriteSheetDef, sequenceDataDef);
bigDefender:scale(0.5,1.5)

obstecales:insert(smallDefender)
obstecales:insert(medDefender)
obstecales:insert(bigDefender)


--        obstecales:insert(smallDefender)
--      obstecales:insert(medDefender)
--    obstecales:insert(bigDefender)
--  obstecales:insert(cones[1])



for i = 1, obstecales.numChildren, 1 do
  obstecales[i].name = "defender"              
  obstecales[i].x = 900
  obstecales[i].y = 500
  obstecales[i].isAlive = false
  physics.addBody( obstecales[i], "kinematic" , defenderBodyElement )
  obstecales[i].gravityScale=0
  
end

cone = display.newImage("images/cone.png")

cone.name = "cone"

cone.id = a
cone.x = 900
cone.y = 500
cone:scale(1,2)
cone.isAlive = false
physics.addBody( cone, "dynamic" , coneElement )
cone.gravityScale=0


obstecales:insert(cone)

bird = display.newImage("images/bird.png")

bird.name = "bird"

bird.id = a
bird.x = 900
bird.y = 500
bird.isAlive = false
physics.addBody( bird, "dynamic" , birdBodyElement )
bird.gravityScale=0
bird.isFixedRotation = true

DOG_INDEX = 1
KID_INDEX = 2
TALL_KID_INDEX = 3
BANANA_INDEX = 4
CAN_INDEX = 4
BIRD_INDEX = 5

obstecales:insert(bird)



coinSound = audio.loadSound( "coin.wav" )
olleSound = audio.loadSound( "olle.wav" )

badKickSound = audio.loadSound( "Ball_Kick_Bad.wav" )
goodKickeSound = audio.loadSound( "Ball_Kick_Good.wav" )
perfectKickSound = audio.loadSound( "Ball_Kick_Perfect.wav" )
jumpSound = audio.loadSound( "Kid_Jump.wav" )
ballFallSound = audio.loadSound( "Ball_fall1.wav" )
glassBreakSound =  audio.loadSound( "glass_break.wav" )
crashConeSound = audio.loadSound( "Crash_Cone.wav" )


-- Play the laser on any available channel
             
--used to put everything on the screen into the screen group
--this will let us change the order in which sprites appear on
--the screen if we want. The earlier it is put into the group the
--further back it will go
sceneGroup:insert(backbackground)
sceneGroup:insert(backgroundfar)
sceneGroup:insert(backgroundnear1)
sceneGroup:insert(backgroundnear2)
sceneGroup:insert(blocks)
--sceneGroup:insert(cones)
--sceneGroup:insert(defenders)
sceneGroup:insert(obstecales)
sceneGroup:insert(coins)


--sceneGroup:insert(monster)
sceneGroup:insert(chaserRect)
sceneGroup:insert(chaser.skeleton.group)
sceneGroup:insert(hero.skeleton.group)
sceneGroup:insert(collisionRect)
sceneGroup:insert(lShoeRect)
sceneGroup:insert(rShoeRect)
sceneGroup:insert(shadow)
sceneGroup:insert(gameOverRect)
sceneGroup:insert(gameOverRect2)
sceneGroup:insert(ballon)
sceneGroup:insert(scoreText)
sceneGroup:insert(coinsCountText)
sceneGroup:insert(currSpeed)
sceneGroup:insert(kickPos)
sceneGroup:insert(playButton)
sceneGroup:insert(coinsSpine)
local function update( event )
--updateBackgrounds will call a function made specifically to handle the background movement
  --dateSpeed()
     updateBackgrounds()
     
    
    updateMonster()
    updateBlocks()
    updateObstecales()
    updateCoins()
    updateReferee()
    checkCollisions()
     
end

mainTimer = timer.performWithDelay(1, update, -1)
timer.pause(mainTimer)

     local function buttonListener( event )
          --director:changeScene( "game", "downFlip" )
          
          if (onGround) then
           -- monster.accel = 20
            --onGround = false
            shotPower = 1.2

            hero:jump()
            kickEnded = true
            isJumping = true
          end
          return true
     end
     --this is a little bit different way to detect touch, but it works
     --well for buttons. Simply add the eventListener to the display object
     --that is the button send the event "touch", which will call the function
     --buttonListener everytime the displayObject is touched.

     playButton:addEventListener("touch", buttonListener )


local function localOnCollision( event )
     onCollision(event)
end

local function localTouched( event )
     touched(event)
end

Runtime:addEventListener( "collision", localOnCollision )
--his is how we call the update function, make sure that this line comes after the
--actual function or it will not be able to find it
--timer.performWithDelay(how often it will run in milliseconds, function to call,
--how many times to call(-1 means forever))

Runtime:addEventListener("touch", localTouched, -1)

function box_muller()
    return math.sqrt(-2 * math.log(math.random())) * math.cos(2 * math.pi * math.random()) / 2
end

function randNormal(num)
  local bm = box_muller()
  --print("box ".. bm)
  return math.floor((num * bm  + num ) / 2)
end

nextObsecalePos = 0
function getNextObstecalePos(min , range)  
      nextObsecalePos = math.floor( score + randNormal(range ) + min)
end

nextCoinPos = 0
function getNextCoinPos(min , range)  
      nextCoinPos = math.floor( score + randNormal(range ) + min)
   --  nextCoinPos = math.floor( score + 2)
end

firstStage = 0
secondStage = 0


--thirdStage = secondStage + randNormal( 100 ) + 50
function restartGame()

     isGameActive = true
     isJumping = false
       --reset the score
     score = 0
     --reset the game speed
     speed = 6
     --reset the monster
     ballon.y = 10
     ballon.x = 160
     ballon.angularVelocity = 0
     ballon:setLinearVelocity(0,0  ) 
     ballon.alpha = 1

     -- monster.isAlive = true
     -- monster.x = 120
     -- monster.y = 285
     -- monster:setSequence("running")
     -- monster:play()
     -- monster.rotation = 0
     -- monster.kickTimer =0
     chaserRect.x = 20
     chaserRect.y = 235
     chaserRect.speed = REFEREE_START_SPEED
     chaser.skeleton.group.x = 0
     
     for a = 1, blocks.numChildren, 1 do
          blocks[a].x = (a * 79) - 79
          blocks[a].y = groundLevel
     end

     for a = 1, coins.numChildren, 1 do
          coins[a].y = 600
          coins[a].isAlive = false
          coins[a].spine:pause()
          coinsSpine[a].y = 700
          
     end
    
      for a = 1, obstecales.numChildren, 1 do
          obstecales[a].x =900
         -- obstecales[a].y = 500
          obstecales[a].isAlive = false            
          obstecales[a].rotation = 0
          obstecales[a]:applyTorque(0)
          obstecales[a]:setLinearVelocity( 0, 0 )
     end
     --reset the backgrounds
     backgroundfar.x = 480
     backgroundfar.y = 160
     backgroundnear1.x = 120
     backgroundnear1.y = 170
     backgroundnear2.x = 480
     backgroundnear2.y = 170

      getNextObstecalePos(15,15)
      getNextCoinPos(5,25)

      gameStats = {}
      gameStats.coins = 0
      gameStats.gameScore =0 
      gameStats.bounces = 0
      gameStats.bouncesPerfect = 0
      gameStats.bouncesGood = 0
      gameStats.bouncesEarly = 0
      gameStats.bouncesLate = 0
      gameStats.jumps = 0
      scoreText.text = "score: " .. score

lShoeRect.y = 230
rShoeRect.y = 230

firstStage = randNormal( 100 ) + 50
secondStage = firstStage + randNormal( 100 ) + 50

      sombreroCount = 0
      consecutivePerfects = 0
      hero:init()
      hero:walk()
      chaser:init()
timer.resume(mainTimer)
    
    end
end

-- "scene:show()"
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
      --takes away the display bar at the top of the screen

      if(event.params and event.params.gameData) then
       coinsCount = gameData.coins  
       coinsCountText.text = "Coins:" .. coinsCount
      end
      restartGame()
 --this is what gets called when playButton gets touched
     --the only thing that is does is call the transition
     --from this scene to the game scene, "downFlip" is the
     --name of the transition that the director uses

--the update function will control most everything that happens in our game
--this will be called every frame(30 frames per second in our case, which is the Corona SDK default)

function getObstecaleIndexes()
  newIndexes = {}

  if (score > EASY_MODE_LENGTH) then
    -- 5 normal obs + 2 logical index for compund - bird + kid
    local rnd = math.random(7)
    if (rnd < 6) then 
      newIndexes[1] = rnd
    else  
      newIndexes[1] =  math.random(2)
      newIndexes[2] = BIRD_INDEX -- bird idx
     end  
  else

    local totalProbability =  P_BANANA + P_CAN + P_BIRD + P_DOG + P_KID  + P_TALL_KID + P_BIRD_DOG + P_BIRD_KID  
    local easyRnd = math.random(totalProbability)


    if (easyRnd <= P_BANANA) then
      newIndexes[1]  = BANANA_INDEX
    elseif  (easyRnd <= P_BANANA + P_CAN) then
      newIndexes[1]  = CAN_INDEX
    elseif  (easyRnd <= P_BANANA + P_CAN + P_BIRD) then
      newIndexes[1]  = BIRD_INDEX
    elseif  (easyRnd <= P_BANANA + P_CAN + P_BIRD + P_DOG) then
      newIndexes[1]  = DOG_INDEX
    elseif  (easyRnd <= P_BANANA + P_CAN + P_BIRD + P_DOG + P_KID) then
      newIndexes[1]  = KID_INDEX
    elseif  (easyRnd <= P_BANANA + P_CAN + P_BIRD + P_DOG + P_KID + P_TALL_KID) then
      newIndexes[1]  = TALL_KID_INDEX
    elseif  (easyRnd <= P_BANANA + P_CAN + P_BIRD + P_DOG + P_KID + P_TALL_KID + P_BIRD_DOG) then
      newIndexes[1] = DOG_INDEX
      newIndexes[2] = BIRD_INDEX -- bird idx      
    elseif  (easyRnd <= P_BANANA + P_CAN + P_BIRD + P_DOG + P_KID + P_TALL_KID + P_BIRD_DOG +  P_BIRD_KID) then  
      newIndexes[1] = KID_INDEX
      newIndexes[2] = BIRD_INDEX -- bird idx      
    end  

  end

  return newIndexes
  
end  

function updateBlocks()

      --273

      local shadowScale = SHADOW_MAX_SCALE *  (1 - ((shadow.y  - ballon.y  ) / shadow.y))


      --shadow:scale(shadowScale,shadowScale)
      shadow.xScale = shadowScale
      shadow.yScale = shadowScale


      lShoeRect.x=  hero:getLeftShoe().x + 120
      rShoeRect.x=  hero:getRightShoe().x + 120
      lShoeRect.y=   hero:getLeftShoe().y   + 265
      rShoeRect.y=   hero:getRightShoe().y   + 265

     for a = 1, blocks.numChildren, 1 do
          if(a > 1) then
               newX = (blocks[a - 1]).x + 79
          else
               newX = (blocks[8]).x + 79 - speed
          end
          if((blocks[a]).x < -60) then
               
               --scoreText:setReferencePoint(display.CenterLeftReferencePoint)
               --scoreText.x = 0
               --scoreText.y = 30

               (blocks[a]).x, (blocks[a]).y = newX, groundLevel

               score = score + 1
               scoreText.text = "score: " .. score

               if (score % 20 == 0 and score > 0  ) then
                  chaserRect.speed = chaserRect.speed + REFEREE_ACCELERATION
                  if (chaserRect.speed > REFEREE_MAX_SPEED ) then
                    chaserRect.speed = REFEREE_MAX_SPEED
                  end  
                 -- kickPos.text = referee.speed
                end

               -- isObstecaleAlive = cones[1].isAlive

              isObstecaleAlive = false

                    for a=1, obstecales.numChildren, 1 do

                                 if(obstecales[a].isAlive) then
                                 --do nothing
                                    isObstecaleAlive = true
                                 break
                               end
                   end
                
               --by setting up the cones this way we are guaranteed to
               --only have 3 cones out at most at a time.

               --print(isObstecaleAlive)
               --print(inEvent)
               --if (not isObstecaleAlive and inEvent == 12) then
               if (inEvent == 12) then
                
                       obsIndexs = getObstecaleIndexes()

                       skipCompund =false

                       for index, obsIndex in pairs( obsIndexs ) do
                      
                             if (obstecales[obsIndex].isAlive) then
                                obsIndex = obsIndex - 1
                                if ( obsIndex == 0) then
                                  obsIndex = 5
                                end 

                                skipCompund = true
                             end

                             if (index >1 and skipCompund) then
                              break
                             end

                             obstecales[obsIndex].isAlive = true 
                             obstecales[obsIndex].x = newX

                             if (obstecales[obsIndex].name=="cone") then
                              obstecales[obsIndex].y=275

                             elseif (obstecales[obsIndex].name=="bird") then
                                if (index == 1 ) then
                                      obstecales[obsIndex].y=math.random(120)
                                else
                                    obstecales[obsIndex].y=math.random(50)
                                end  
                             else -- defenders 

                               obstecales[obsIndex].y = 235
                               obstecales[obsIndex]:setSequence("running");
                               obstecales[obsIndex]:play()
                             end 
                        end

                end
                         -- create new coin
                if(inEvent == 14) then
                       for a=1, coins.numChildren, 1 do
                               if(coins[a].isAlive == true) then
                               --do nothing
                               else
                               coins[a].isAlive = true
                               coins[a].y = math.random(200)
                               coins[a].x = newX

                              -- print ("Coin " .. a) 
                              -- print(coinsSpine[a]) 
                               coinsSpine[a].y = coins[a].y
                               coinsSpine[a].x = coins[a].x
                               coins[a].spine:init()

                              -- local multiCoinsRnd = math.random(100)
                               local multiCoinsRnd = 70

                               if (multiCoinsRnd > 94 and a < 4) then
                                 coins[a+1].isAlive = true
                                 coins[a+1].y = math.random(200)
                                 coins[a+1].x = newX + math.random(100) 

                                 coinsSpine[a + 1].y = coins[a +1].y
                                 coinsSpine[a + 1].x = coins[a + 1].x
                                 coins.spine[a + 1]:init()

                                 if (multiCoinsRnd > 99) then
                                    coins[a+2].isAlive = true
                                   coins[a+2].y = math.random(200)
                                   coins[a+2].x = coins[a+1].x + math.random(100) 

                                   coinsSpine[a + 2].y = coins[a + 2].y
                                   coinsSpine[a + 2].x = coins[a + 2].x
                                   coins.spine[a + 2]:init()

                                 end 
                               end

                               break
                           end
                       end
               end

               checkEvent()
          else
               (blocks[a]):translate(speed * -1, 0)
          end
     end
end

--check to see if the cones are alive or not, if they are
--then update them appropriately
function updateObstecales()
    for a = 1, obstecales.numChildren, 1 do
        if(obstecales[a].isAlive == true) then

            
            (obstecales[a]):translate(speed * -1, 0)
            if(obstecales[a].x < -80) then
                obstecales[a].x = 900
                obstecales[a].y = 500
                obstecales[a].isAlive = false

                if ( obstecales[a].name == "defender" ) then
                  obstecales[a]:pause()
                end
            end

            if ( obstecales[a].name == "defender" ) then
               if((obstecales[a].x <= hero.skeleton.group.x) and (obstecales[a].x >= hero.skeleton.group.x - speed) and onGround ) then
                   audio.play( olleSound )

                   sombreroCount =  sombreroCount + 1
                end 
            end 
        end
    end
end


function updateCoins()
    for a = 1, coins.numChildren, 1 do
        if(coins[a].isAlive == true) then
            (coins[a]):translate(speed * -1, 0)
            coinsSpine[a].x =  coins[a].x

            if(coins[a].x < -80) then
                coins[a].x = 900
                coins[a].y = 500
                coins[a].isAlive = false
            end
        end
        end
end

function updateReferee()
    local prevX =  chaser.skeleton.group.x
    chaser.skeleton.group:translate(chaserRect.speed - speed ,0) 
    if (chaser.skeleton.group.x < -50) then
      chaser.skeleton.group.x = -50
    end  

    if (chaser.skeleton.group.x < 0  and prevX >= 0 ) then 

      chaser:walk()
    elseif (chaser.skeleton.group.x >= 0  and prevX < 0 ) then 
      chaser:chase()
    end  

    chaserRect.x = chaser:getFist().x + chaser.skeleton.group.x
    
end


function updateBackgrounds()
--far background movement
backgroundfar.x = backgroundfar.x - (speed/55)
 
--near background movement
backgroundnear1.x = backgroundnear1.x - (speed/5)
if(backgroundnear1.x < -239) then
backgroundnear1.x = 680
end
 
backgroundnear2.x = backgroundnear2.x - (speed/5)
if(backgroundnear2.x < -239) then
backgroundnear2.x = 680
end
end

	
function checkCollisions()
     wasOnGround = onGround

     onGround = (lShoeRect.y > 245 or rShoeRect.y > 245 or not kickEnded) 

     if (not onGround ) then
        print("jump")
        print(hero.isJumping)
     end
     --this is where we check to see if the monster is on the ground or in the air, if he is in the air then he can't jump(sorry no double
     --jumping for our little monster, however if you did want him to be able to double jump like Mario then you would just need
     --to make a small adjustment here, by adding a second variable called something like hasJumped. Set it to false normally, and turn it to
     --true once the double jump has been made. That way he is limited to 2 hops per jump.
     --Again we cycle through the blocks group and compare the x and y values of each.
  --   for a = 1, blocks.numChildren, 1 do
  --        if(monster.y >= blocks[a].y - 125 and blocks[a].x < monster.x + 60 and blocks[a].x > monster.x - 60) then
   --            monster.y = blocks[a].y - 126
    --           onGround = true
     --          break
      --    else
       --        onGround = false
       --   end
    -- end

end



function checkEvent()
     --first check to see if we are already in an event, we only want 1 event going on at a time
     if(eventRun > 0) then
          --if we are in an event decrease eventRun. eventRun is a variable that tells us how
          --much longer the event is going to take place. Everytime we check we need to decrement
          --it. Then if at this point eventRun is 0 then the event has ended so we set inEvent back
          --to 0.
          eventRun = eventRun - 1
          if(eventRun == 0) then
               inEvent = 0
          end
     end
     --if we are in an event then do nothing
     if(inEvent > 0 and eventRun > 0) then
          --Do nothing
     else
          --if we are not in an event check to see if we are going to start a new event. To do this
          --we generate a random number between 1 and 100. We then check to see if our 'check' is
          --going to start an event. We are using 100 here in the example because it is easy to determine
          --the likelihood that an event will fire(We could just as easilt chosen 10 or 1000).
          --For example, if we decide that an event is going to
          --start everytime check is over 80 then we know that everytime a block is reset there is a 20%
          --chance that an event will start. So one in every five blocks should start a new event. This
          --is where you will have to fit the needs of your game.
          check = math.random(100)
 
          --this first event is going to cause the elevation of the ground to change. For this game we
          --only want the elevation to change 1 block at a time so we don't get long runs of changing
          --elevation that is impossible to pass so we set eventRun to 1.
          if(check > 80 and check < 99) then
               --since we are in an event we need to decide what we want to do. By making inEvent another
               --random number we can now randomly choose which direction we want the elevation to change.
               inEvent = math.random(10)
               eventRun = 1
          end
                    --the more frequently you want events to happen then
          --greater you should make the checks
          if(score == nextObsecalePos) then
                  inEvent = 12
                  eventRun = 1

                  local minPos = 8 - score /100
                  if (minPos < 3) then
                    minPos = 3
                  end

                  local nextObstecaleRnd =  math.random(10)
                  if (score < firstStage) then
                    if (nextObstecaleRnd >1 ) then
                      getNextObstecalePos(minPos ,4)
                    else
                      getNextObstecalePos(4 , minPos )
                    end  
                  elseif (score < secondStage) then
                    if (nextObstecaleRnd > 3 ) then
                      getNextObstecalePos(minPos ,4)
                    else
                      getNextObstecalePos(4 , minPos )
                    end
                  else
                    if (nextObstecaleRnd > 5 ) then
                      getNextObstecalePos(minPos ,4)
                    else
                      getNextObstecalePos(4 , minPos )
                    end
                  end  

                  
                  --getNextObstecalePos(minPos ,10)
                  --getNextObstecalePos(8  ,1)
          end
                    --ghost event
          if(score == nextCoinPos) then
                  inEvent = 14
                  eventRun = 1
                  getNextCoinPos(20 ,10)

          end
     end
     --if we are in an event call runEvent to figure out if anything special needs to be done
     if(inEvent > 0) then
          runEvent()
     end
end
--this function is pretty simple it just checks to see what event should be happening, then
--updates the appropriate items. Notice that we check to make sure the ground is within a
--certain range, we don't want the ground to spawn above or below whats visible on the screen.
function runEvent()
--     if(inEvent < 6) then
  --        groundLevel = groundLevel + 40
--     end
--     if(inEvent > 5 and inEvent < 11) then
--          groundLevel = groundLevel - 40
--     end
--     if(groundLevel < groundMax) then
--          groundLevel = groundMax
--     end
  --   if(groundLevel > groundMin) then
    --      groundLevel = groundMin
--     end
  
end
local kickEnded = false
local wasRunning = false
function updateMonster()

         --if our monster is jumping then switch to the jumping animation
     --if not keep playing the running animation
--     if(monster.isAlive == true) then
     	  if (isJumping) then
              -- if (wasOnGround) then
              --     monster:setSequence("jumping")
              --     monster:play()
                  
              
              --  end 
     	  	   
               collisionRect.width = 50
               collisionRect.x=hero.skeleton.group.x + 36
             --  collisionRect.y=monster.y - 36
               collisionRect.y = hero:getHead().y + 255
               collisionRect.alpha = defualtAlpha
              

          else
	    	
       --     collisionRect.y =0 
              collisionRect.width = 0
                  collisionRect.x=0
          end

          if (onGround) then 
	           	if (not wasOnGround or kickEnded) then
                kickEnded = false
                  
                    -- monster:setSequence("running")
                    -- monster:play()
                    hero:walk()
                    isJumping = false
	           end 
          end
      

--           monster.kickTimer = monster.kickTimer -1

          -- if(monster.accel > 0) then
          --      monster.accel = monster.accel - 1
          -- end
          -- monster.y = monster.y - monster.accel
          -- monster.y = monster.y - monster.gravity
         

          --skeleton.y = skeleton.y - monster.accel
          --skeleton.y = skeleton.y - monster.gravity

     -- else
     --      monster:rotate(5)
     -- end
     -- --update the collisionRect to stay in front of the monster
     
end

isGameActive = true
local function stopGame()
      isGameActive = false
                        --this simply pauses the current animation
                        -- monster:pause()
                         speed = 0
         timer.pause(mainTimer)
         hero:pause()
         chaser:pause()
          gameStats.gameScore = score

         local options = { isModal = true,
                            effect = "fade",
                            params = {results = gameStats}}
      composer.showOverlay( "gameOver" , options )
  end

--the only difference in the touched function is now if you touch the
--right side of the screen the monster will fire off a little blue bolt

local lastTime =0 
local lastY =0
local startY =0
local touchIDs = {}

function touched( event )

-- print(ignoreClick)

     
           if ( event.phase == "ended" ) then
                   table.remove(touchIDs,table.indexOf(touchIDs, event.id))
           		   if (ignoreClick) then
          				ignoreClick = false
          		   else 

	                  --local line = display.newLine( event.xStart, event.yStart, event.x, event.y )
	                  --line.strokeWidth = 5
	
	                
                    -- monster.kickTimer = 0

                     kickEnded = true
	               end
              end
          
               if(event.phase == "began") then
                     table.insert(touchIDs,event.id)

                     --- jump
                      if (table.maxn(touchIDs) > 1 )then
                         if (onGround) then
                              isAnyLeg = true
                              --monster.accel = 20
                              onGround = false
                              shotPower = 0.2
                              collisionRect.width = 50
                             collisionRect.x=hero.skeleton.group.x + 36
                             --collisionRect.y=monster.y - 36
                              collisionRect.alpha= defualtAlpha
                              audio.play( jumpSound )   
                              gameStats.jumps =  gameStats.jumps
                              hero:jump()
                              kickEnded = true
                              isJumping = true

                              
                            end
                      else

                  
                          kickStart = event.time; 

                          print ("ffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
                          isLeftLeg = (event.x < 241)

                          if (isLeftLeg) then
                            leftStart = event.y
                          else
                            rightStart = event.y   
                          end

                          ignoreClick = not onGround
                          --monster.kickTimer = 1
                          kickEnded = false
                      end  
                      startY = event.yStart
               end

                 if(event.phase == "moved") then
              
                  if ( onGround) then
                       lastTime =event.time
               --        monster:setSequence("kicking")
                --       monster:play()
                 --      collisionRect.alpha=defualtAlpha

                   --    collisionRect.width = 50
                     --   collisionRect.x=monster.x + 36
                       -- collisionRect.y = monster.y  + 35
                       
                         lastY =  event.y
                         local deltaYm = event.y - event.yStart
                        -- collisionRect.y = 230  + 39 + deltaYm/6
                         local ang = -1 * deltaYm/3 -35
                         hero:setKickAngle(ang,isLeftLeg)

              --           if (isLeftLeg ) then
                --           collisionRect.y = hero:getLeftShoe().y   + 265
                  --        else
                    --       collisionRect.y =  hero:getRightShoe().y + 265
                      --    end

                         if (lastTime - kickStart > KICK_TIMEUOT_DURATION) then
                            hero:fall()
                            timer.performWithDelay(1000, stopGame, 1)
                      --      monster.kickTimer = 0    
                            kickEnded = true


                          end
                         
                   end 

               end
               
end


local isPrevLeft = false
local isAnyLeg = true
--consecutivePerfects  = 0
shotPowerDebug = nil



local function kickBall()
--  collisionRect.x = 0
   --monster.kickTimer = 0
   --shotPower = 0.35
    local kickRange = startY - lastY
    incSpeed = 1 - speed / MAX_SPEED
    decSpeed = speed / MAX_SPEED

    local isPerfectKcick = false

    if (onGround) then
        gameStats.bounces =  gameStats.bounces + 1
        ballon.angularVelocity = 200 - math.random(1000) 
    else
        ballon.angularVelocity = 0
    end


    ballon:setLinearVelocity(0,-500 * shotPower )  
    --ballon:setLinearVelocity(0,-550 )  
    --ballon:applyLinearImpulse(0,shotPower,ballon.x,ballon.y)

    --print(ballon:getLinearVelocity())
    kickEnded = true
   -- kickPos.text = "kickPos:" .. collisionRect.y
    if (isLeftLeg == isPrevLeft and not isAnyLeg) then
        speed = speed - decSpeed
         audio.play( badKickSound )   
    elseif (kickRange >= PERFECT_POSITION - PERFECT_MARGIN and kickRange <= PERFECT_POSITION + PERFECT_MARGIN ) then
        speed = speed + incSpeed
        kickPos.text = "P"
        audio.play( perfectKickSound )   
        gameStats.bouncesPerfect =  gameStats.bouncesPerfect + 1
        isPerfectKcick = true
       
    elseif ((kickRange >= PERFECT_POSITION - PERFECT_MARGIN - GOOD_RANGE  and kickRange <= PERFECT_POSITION - PERFECT_MARGIN ) or
           (kickRange >=  PERFECT_POSITION + PERFECT_MARGIN   and kickRange <=  PERFECT_POSITION + PERFECT_MARGIN + GOOD_RANGE)) then   
       kickPos.text = "G"
        if (shotPower < 0.5 and shotPower > 0.4) then
             speed = speed + incSpeed
        end                       
        audio.play( perfectKickSound )   
        gameStats.bouncesGood =  gameStats.bouncesGood + 1


    elseif (kickRange >= PERFECT_POSITION + PERFECT_MARGIN + GOOD_RANGE  ) then
      kickPos.text = "TL"
      speed = speed - decSpeed/2
      audio.play( badKickSound )   
       gameStats.bouncesLate =  gameStats.bouncesLate + 1

    elseif (kickRange <=  PERFECT_POSITION - PERFECT_MARGIN - GOOD_RANGE   ) then       
      kickPos.text = "TE"
      speed = speed - decSpeed/2
      if (onGround) then
        audio.play( badKickSound ) 
         gameStats.bouncesEarly =  gameStats.bouncesEarly + 1

      else
         audio.play( perfectKickSound )  
      end    
    end                    
    
    if (isPerfectKcick) then
       consecutivePerfects = consecutivePerfects + 1
    end


    --speed = speed + 0.7
    if (speed > MAX_SPEED) then
      speed = MAX_SPEED
    end 

    if (speed< MIN_SPEED) then
      speed = MIN_SPEED
    end
    kickPos.text = shotPowerDebug
    --speed =8
    hero:setWalkSpeed(speed)
    isPrevLeft = isLeftLeg
    currSpeed.text = speed
    isAnyLeg = false
--          print(ballon.y - collisionRect.y)
end



local function handleCoin( event )
    -- Access "params" table by pointing to "event.source" (the timer handle)
    local params = event.source.params    
    coinsCount = coinsCount  + 1
    coinsCountText.text = "Coins:" .. coinsCount    
    params.coinObj.isAlive = false
    params.coinObj.y = 700
    params.coinObj.spine.skeleton.group.y = 700
    audio.play( coinSound )   
    gameStats.coins = gameStats.coins + 1
end

function onCollision( event )

--for k,v in pairs(event.object1) do
  --print(k,v)
--end  
--print(event.object1)
--print(event.object1.name)
-- print( event.phase .. event.object1.name .. " and " .. event.object2.name )

    if ( event.phase == "began" ) then

               if ( event.object1.name == "leg" or  event.object2.name == "leg") then 
                 
                    --  print(event.time )
                    --local deltaY =   270  -  collisionRect.y  
                   if (onGround) then
                        local deltaY = startY - lastY                     
                         local kickDuration = lastTime - kickStart
                         local ignoreKick  = false


                     --kickPos.text = collisionRect.y 
                          
                    
                       ignoreKick =  (kickDuration < 10) 
                       
                       shotPower = (deltaY / kickDuration) * 1.5
                        --print("kickStart" .. shotPower)
                       --kickPos.text =  shotPower
                       shotPowerDebug = kickDuration
                       if (shotPower > 1.5) then
                          shotPower = 1.5
                       
                       elseif (shotPower > 0.8) then
                          shotPower = 0.8 + (shotPower - 0.8) *3/7   

                      elseif (shotPower < MINIMAL_SHOT_POWER) then
                            shotPower = 0
                       elseif (shotPower < WEAK_SHOT_POWER) then     
                          shotPower = WEAK_SHOT_POWER
                       end
                    if (not ignoreKick) then  
                        timer.performWithDelay(0, kickBall, 1)
                    end
                 
                           
                         -- kickStart = lastTime
                      end

                   
                elseif ( event.object1.name == "header" or  event.object2.name == "header") then 
                  if (not onGround) then

                    if (collisionRect.y < ballon.y) then
                          shotPower = 0
                        else  
                          shotPower = collisionRect.y / 180 
                        end
                    timer.performWithDelay(0, kickBall, 1)  
                  end
                elseif ( event.object1.name == "coin" or  event.object2.name == "coin") then              
                        ts = timer.performWithDelay(0, handleCoin, 1) 
                        ts.params = {coinObj = event.object1}
                elseif (isGameActive) then                     
                  if ( event.object1.name == "gameOver" or  event.object2.name == "gameOver") then                           
                          timer.performWithDelay(1000, stopGame, 1)

                          if (event.object1.y < 0) then
                             audio.play( glassBreakSound )  
                             ballon.alpha = 0
                          else
                            audio.play( ballFallSound )       
                          end
                          isGameActive = false
                        
                  elseif ( event.object1.name == "cone" or  event.object2.name == "cone") then
                          timer.performWithDelay(0, stopGame, 1)  
                          audio.play( crashConeSound )     
                  elseif ( event.object1.name == "defender" or  event.object2.name == "defender") then
                          timer.performWithDelay(0, stopGame, 1)  
                  elseif ( event.object1.name == "chaser" or  event.object2.name == "chaser") then
                          timer.performWithDelay(0, stopGame, 1)        
                  elseif ( event.object1.name == "bird" or  event.object2.name == "bird") then
                        timer.performWithDelay(0, stopGame, 1)        
                  end

                end  
                     
    elseif ( event.phase == "ended" ) then
    --local vx, vy = ballon:getLinearVelocity() 
      --    print("vy"..vy)
        --  if  (vy > -400 ) then
          --  print(ballon.y - collisionRect.y)
           -- print(lastY)
        --end 
                    
        
    end
end


   end
end

-- "scene:hide()"
function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end

-- "scene:destroy()"
function scene:destroy( event )

   local sceneGroup = self.view

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene