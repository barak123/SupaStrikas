local commonData = require( "commonData" )

local composer = require( "composer" )
local widget = require( "widget" )
require "translation"
local scene = composer.newScene()

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------
local mFloor = math.floor
local mRandom = math.random
local displayActualContentWidth =  display.actualContentWidth

local gameStatus ={
    isGameActive = true, 
    isConfirmationRequired =false,
    isGamePaused = false , 
    isTutorial = false ,
    preventJump = false ,
    preventKick = false ,
    kickEnded = false ,
    isUltraMode = false,
    kickStart = 0 ,
    lastTime = 0 ,
    speed = 6,
    sombreroCount = 0 ,
    chaserLocation = 0 ,
    heightFactor = 1,
    prevStage = 0,
    stageCounter = 1,
    prevScore1 = 0 ,
    prevScore2 = 0,
    isSalta = false,
    mainTimer = nil,
    inEvent = 0, 
    eventRun = 0,
    ignoreClick = false,
    isLeftLeg = false,
    isAnyLeg = true,
    lastY = 0 , 
    startY = 0,
    ignoreHeader = false,
    firstStage = 0 , 
    secondStage = 0,
    goalInARow = 0,
    isPrevLeft = false,
    shakeamount = 0,
    shakeamount2 = 0,
    kickOverShowed = false,
    jumpOverShowed = false,
    isStaticBall = false,
    newScore = 0,
    kicksMulti = 0,
    sreeCount = 0


}


local sounds ={
 CristianoGoalSound = nil,
 MessiGoalSound = nil,
 ZlatanGoalSound = nil,
 PewdsGoalSound = nil,
 neymarGoalSound = nil,
 stephGoalSound = nil,
 rooneyGoalSound = nil,
 catchSound = nil,
 coinSound = nil,
 perfectKickSound = nil,
 fireKickSound = nil,
 perfectSpreeSound = nil,
 perfectSpreeSound2 = nil,
 crashConeSound = nil,
 crashTrashSound = nil,
 trophieGoalSound = nil,
 coinsGoalSound = nil,
 goalPostSound = nil,
 birdHitSound = nil,
 
 arsSound = nil,
 twoBoysSound = nil,
 kidSound = nil,
 badKickSound = nil,
 jumpSound = nil,
 heroFallSound = nil,
 saltaSound = nil,
 ballFallSound = nil,
 glassBreakSound =  nil,
 kickTimeoutSound = nil,
 badKickBrainzSound = nil,
 goodKickBrainzSound = nil,
 goalBrainzSound = nil,
 basketballSound = nil,
 watermelonSound = nil,
 botKickSound = nil,
 challengeUnlockedSound = nil,
 stephPerfectSpreeSound = nil,
 --transitionSound = nil,


}


local ob = {
  
  shadow = nil,
  pausedOverlay = nil,
  goalDummy = nil,
  tutorialOkBtn = nil,
  groundLevel = 280,
  tutorialReadyFails = 4,
  tutorialConeFails = 3,
  rewards = nil,
  defualtAlpha = 0,
  
  
  jumpLeg = nil,
  obstecaleSpines = nil,
  DOG_INDEX = 1,
  KID_INDEX = 2,
  TALL_KID_INDEX = 3,
  DOUBLE_KIDS_INDEX = 4,
  TALL_INDEX = 5,
  CAN_INDEX = 6,
  CONE_INDEX = 7,
  BIRD_INDEX = 8,
  GOAL_INDEX = 9,
  goalBarL = nil,
  goalBarR = nil,
  goalBarU = nil,
  goalNet = nil,
  goalBarLEdge = nil,
  goalBarREdge = nil,
  goalSpine = nil,
  
  backgroundMusicHdl = nil,
  
  nextObsecalePos = 0,
  nextCoinPos = 0,
  coinsCount = 0 ,
  wasOnGround = true,
  onGround = true,
  tutorialKicksCount = 0,
  tutorialStage = 1,
  ultraCoinsCollected = 0,
  
  tutorialReplay = nil,
  dontForget = nil ,
  kickOver = nil, 
  foregrounds = nil , 
  boosterMsgSpine =  nil,
  boosterMsg = nil,
  boosterButton = nil,
  notification = nil,
  jumpOverImg = nil,
  kickOverImg = nil,
  redRect = nil,
  stageGroup = nil,
  scoreTextMove = nil,
  scoreBg = nil, 
  
}

if ( "simulator" == system.getInfo("environment"))  then
  ob.isSimulator = true
end

local actualHeightInches = system.getInfo( "androidDisplayHeightInInches" )
local heightInches = 2.56

gameStatus.heightFactor = 1

if actualHeightInches then
   gameStatus.heightFactor = actualHeightInches/heightInches
end  

if ( system.getInfo("model") == "iPad"  ) then
  gameStatus.heightFactor = 2
end  

local newChallegeText = nil
local tutorialConfirm = nil
local score = 0
local ballon = {}
local ultraBall = nil
local ballSkin= nil
local monster = {}
local chaserRect = {}
local blocks = {}
local coins = {}

local obstecales = {}
local gameStats = {}
local kickToStart = nil
--local gameStatus.sombreroCount = 0
local consecutivePerfects = 0

local pauseButton = nil

local backgrounds = nil




local touchIDs = {}

local collisionRect = nil
local ultraRect = nil
local exitUltraModeHandle = nil
local advanceUltraModeHandle = nil

local hero = nil
local fire = nil
local ballSkinGroup = nil
local newChallengeGroup = nil
local houses =nil
local dirt = nil
local scoreText = nil
local coinsCountText = nil
local coinsShadowText = nil
local trophieCountText = nil
local trophieShadowText = nil
local multiText = nil
local coinsSpine = nil


--local fireBubbleObj= nil
local ultraWave= nil
--local ultraFloor= nil
--coinsCoun

local comments = nil
local goal = nil



local shotPower = 1


local speedCircle = nil
local speedCircle2 = nil

local speedCircleImg = nil
local coinImg = nil
local trophieImg = nil
local tutorialScales = nil
local leftHand = nil
local rightHand = nil

-- "scene:create()"


local function buttonListener( event )
          
          if (ob.onGround and not gameStatus.preventJump) then
            monster.accel = 19
            if gameStatus.preventKick then

               leftHand:pause()
               rightHand:pause()
               leftHand.skeleton.group.alpha = 0
               rightHand.skeleton.group.alpha = 0                                         
               gameStatus.preventKick = false
           end


            if mRandom(1) == 2 then
              hero:saltaJump()
              gameStatus.isSalta = true
              commonData.playSound( sounds.saltaSound )   
            else
              hero:jump()
              gameStatus.isSalta = false
            end
            
            commonData.playSound( sounds.jumpSound )   
            ob.onGround = false
            --shotPower = 1.2
            gameStatus.lastTime = system.getTimer()
            gameStatus.kickStart =  gameStatus.lastTime - 20 
            gameStatus.ignoreHeader = false
          end


          return true
     end

function scene:create( event )

  
   local sceneGroup = self.view


   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
display.setStatusBar(display.HiddenStatusBar)

 local heroSpine =  require ("hero")
 hero = heroSpine.new(0.33 , false)
 ob.chaser =  require ("chaser")
 ob.coach =  require ("coach")
 ob.bubble =  require ("bubble").new()
 require ("game_config")
 require ("achivmentsManager")

comments = require("comments").new()
comments.skeleton.group.x = 240
comments.skeleton.group.y = 160
 -- skeleton = getSkeleton()
--skelton:scale(0.5,0.5)
system.activate( "multitouch" )
local physics = require("physics")
physics.start()
--physics.setDrawMode( "hybrid" )   

physics.setScale( 60 )
--physics.setPositionIterations( 32 )
initAchivments(commonData.gameData.unlockedAchivments ) 
initChallenges(commonData.gameData.unlockedChallenges ) 

ob.notification = display.newGroup()


local function boosterButtonListener( event )

     if ( "ended" == event.phase ) then
      ob.boosterMsg:pause()       
      ob.notification.alpha = 0 
      gameStatus.isConfirmationRequired = false
      gameStatus.ignoreClick = false
      --notificationRect.alpha = 0
     end 
    return true
end


 local function notificationRectListener( event )   
        
          return true
     end

local  notificationRect = display.newRect(240, 160, 700,400)
    notificationRect:setFillColor(0, 0, 0)
    notificationRect.alpha = 0.7
    notificationRect:addEventListener("touch", notificationRectListener )


ob.boosterMsgSpine =  require ("boosterMsg")
ob.boosterMsg = ob.boosterMsgSpine.new(0.8, true)

ob.boosterMsg.skeleton.group.x = 190
ob.boosterMsg.skeleton.group.y = 320

ob.boosterButton = widget.newButton
      {
          x = 190,
          y = 280,
          id = "boosterButton",
          defaultFile = "images/OKUp.png",
          overFile = "images/OKDown.png",
          onEvent = boosterButtonListener
      }
 ob.boosterButton.xScale =  (display.actualContentWidth*0.2) / ob.boosterButton.width
 ob.boosterButton.yScale = ob.boosterButton.xScale  
 ob.boosterButton.alpha = 0

 ob.jumpOverImg = display.newImage("images/JumpOver.png")
 ob.kickOverImg = display.newImage("images/KickBallOver.png")
 ob.tipCircle = display.newImage("images/TipCircle.png")

ob.tipCircle:scale(0.7,0.7)
ob.tipCircle.x = 200
ob.tipCircle.y = 140
 

ob.kickOverImg:scale(0.7,0.7)
ob.kickOverImg.x = 200
ob.kickOverImg.y = 140


ob.jumpOverImg:scale(0.7,0.7)
ob.jumpOverImg.x = 200
ob.jumpOverImg.y = 140

                    

ob.notification:insert(notificationRect)
ob.notification:insert(ob.boosterMsg.skeleton.group)
ob.notification:insert(ob.jumpOverImg)
ob.notification:insert(ob.kickOverImg)
ob.notification:insert(ob.tipCircle)

ob.notification:insert(ob.boosterButton)
ob.notification.alpha = 0
ob.notification.x =   ob.notification.x  + (display.actualContentWidth - display.contentWidth)/2  

local imgsheetSetup = 
{
width = 50,
height = 82,
numFrames = 6
}

local firesheetSetup = 
{
width = 138,
height = 100,
numFrames = 23,
sheetContentWidth = 3174,
  sheetContentHeight = 100
}


local ultraSheetSetup = 
{
width = 256,
height = 145,
numFrames = 51,
 sheetContentWidth = 2048,
--sheetContentHeight = 1024
}

local kickOverSetup = 
{
width = 300,
height = 313,
numFrames = 7,
 -- sheetContentWidth = 2100,
-- sheetContentHeight = 313
}

local kickToSetup = 
{
width = 121,
height = 187,
numFrames = 13,
-- sheetContentWidth = 1573,
-- sheetContentHeight = 187
}



--local spriteSheet = graphics.newImageSheet("images/monsterSpriteSheet.png", imgsheetSetup);

local spriteSheet = graphics.newImageSheet("images/soccerSprite.png", imgsheetSetup);

--local fireBubbleSheet = graphics.newImageSheet("images/fireBubble.png", firesheetSetup);

--local ultraFloorSheet = graphics.newImageSheet("images/UltraFloorSheet.png", ultraSheetSetup);



--Now we create a table that holds the sequence data for our animations

local sequenceData = 
{
{ name = "running", start = 1, count = 4, time = 600, loopCount = 0},
{ name = "jumping", start = 6, count = 1, time = 1, loopCount = 1 },
{ name = "kicking", start = 5, count = 1, time = 1, loopCount = 1 }
}

local bubbleData = 
{
{ name = "start", start = 1, count = 9, time = 600, loopCount = 1},
{ name = "fire", start = 10, count = 13, time = 500, loopCount =0 }
}


local ultraData = 
{
{ name = "start", start = 1, count = 40, time = 1000, loopCount = 1},
{ name = "advance", start = 41, count = 8, time = 800, loopCount = 0}
}

-- local ultraData = 
-- {
-- { name = "start", start = 1, count = 20, time = 1000, loopCount = 1},
-- { name = "advance", start = 38, count = 13, time = 800, loopCount = 0}
-- }


local kickOverData = 
{
{ name = "start", start = 1, count = 7, time = 1000, loopCount = 0}
}




local kickToData = 
{
{ name = "start", start = 1, count = 13, time = 600, loopCount = 0}
}

local kickToSheet = graphics.newImageSheet("images/KickToStartAnimation.png", kickToSetup);


kickToStart = display.newSprite(kickToSheet, kickToData);
kickToStart:setSequence("start")
kickToStart:play()  

kickToStart.x = BALL_X
kickToStart.y = 235

kickToStart:scale(0.45,0.45)


local obstacleArrowData = 
{
{ name = "start", start = 1, count = 34, time = 600, loopCount = 0}
}

local obstacleArrowSetup = 
{
width = 95,
height = 155,
numFrames = 34,
-- sheetContentWidth = 1573,
-- sheetContentHeight = 187
}
local obstacleArrowDataSheet = graphics.newImageSheet("images/ObstacleArrow.png", obstacleArrowSetup);


ob.obstacleArrow = display.newSprite(obstacleArrowDataSheet, obstacleArrowData);
ob.obstacleArrow:setSequence("start")
ob.obstacleArrow:play()  

ob.obstacleArrow.x = BALL_X
ob.obstacleArrow.y = 235

ob.obstacleArrow:scale(0.45,0.45)

--these 2 variables will be the checks that control our event system.
gameStatus.inEvent = 0
gameStatus.eventRun = 0

ballon = display.newImage("balls/NormalBall.png")


        
ballon.name = "ballon"
ballon.x = BALL_X
ballon.y = 20

ballon:scale(0.23,0.23)

ballon.isFixedRotation = true



-- ultraBall = display.newImage("images/UltraBall.png")
-- ultraBall.name = "fire"
-- ultraBall.x = BALL_X
-- ultraBall.y = 20

-- ultraBall:scale(0.5,0.5)
-- ultraBall.fill.blendMode = "normal"
-- --ultraBall:setFillColor(1,168/255,90/255)
-- ultraBall:setFillColor(1,1,1)

-- ultraBall.isFixedRotation = true


local body_radius = 5

ballSkinGroup = display.newGroup()
newChallengeGroup = display.newGroup()
ob.multiGroup = display.newGroup()
ob.scoreboard = display.newGroup()
ob.pausedGroup = display.newGroup()

ob.leftCtrl =  display.newImage("images/Touchpad.png")
--ob.leftCtrl:setFillColor(1,0,0)
--ob.leftCtrl.alpha  = 0.5
ob.leftCtrl.x = 60
ob.leftCtrl.y = 250
ob.leftCtrl:scale(0.8,0.8)

ob.leftCtrl.x = ob.leftCtrl.x  - (displayActualContentWidth - display.contentWidth) /2

ob.rightCtrl = display.newImage("images/Touchpad.png")
--ob.rightCtrl:setFillColor(1,0,0)
--ob.rightCtrl.alpha  = 0.5
ob.rightCtrl.x = 420
ob.rightCtrl.y = 250
ob.rightCtrl:scale(0.8,0.8)
ob.rightCtrl.x = ob.rightCtrl.x  + (displayActualContentWidth - display.contentWidth) /2

ob.leftTimer =  display.newImage("images/TouchpadTimer.png")
--ob.leftCtrl:setFillColor(1,0,0)
--ob.leftCtrl.alpha  = 0.5
ob.leftTimer.x = 60
ob.leftTimer.y = 250
ob.leftTimer:scale(0.4,0.4)

ob.leftTimer.x = ob.leftTimer.x  - (displayActualContentWidth - display.contentWidth) /2

ob.rightTimer = display.newImage("images/TouchpadTimer.png")
--ob.rightCtrl:setFillColor(1,0,0)
--ob.rightCtrl.alpha  = 0.5
ob.rightTimer.x = 420
ob.rightTimer.y = 250
ob.rightTimer:scale(0.6,0.6)
ob.rightTimer.x = ob.rightTimer.x  + (displayActualContentWidth - display.contentWidth) /2



fire = display.newGroup()
fire.x = display.contentWidth / 6
fire.y = 0
fire.name = "fire"
-- local c = display.newCircle( 0, 0, body_radius )
--fire:insert( c )
local particleDesigner = require( "particleDesigner" )

local emitter1 = particleDesigner.newEmitter( "images/levelemitters/FieldLevelEmitter.json" )
emitter1.x = 240
emitter1.y = 160

local emitter2 = particleDesigner.newEmitter( "images/levelemitters/GlacierLevelEmitter.json" )
emitter2.x = 440
emitter2.y = 120


-- emitter1:scale(0.05,0.05)
-- local emitter1 = particleDesigner.newEmitter( "fire1.json" )
-- emitter1:scale(0.05,0.05)

-- local emitter3 = particleDesigner.newEmitter( "fire3.json" )
-- emitter3:scale(0.05,0.05)

-- -- local emitter2 = particleDesigner.newEmitter( "fire2.json" )
-- -- emitter2:scale(0.05,0.05)


-- local emitter4 = particleDesigner.newEmitter( "fire4.json" )
-- emitter4:scale(0.05,0.05)


--  local emitter = particleDesigner.newEmitter( "fire.json" )

-- fire:insert( emitter1 )

-- -- fire:insert( emitter4 )
-- -- fire:insert( emitter3 )
-- fire:insert( emitter2 )
-- --fire:insert( emitter )

--local emitterParams = particleDesigner.loadParams(  "fire.json"  )

-- local selectedBooster = "ultraBall"
-- for i=1,#boostersConfig[selectedBooster] do
--   local emitter = display.newEmitter( boostersConfig[selectedBooster][i] )
--   emitter:scale(0.005,0.005)
--   fire:insert( emitter )
-- end


--emitterParams.textureFileName = 
-- local emitter1 = display.newEmitter( icyParams )

-- local emitter2 = display.newEmitter( smokeParams )
--local emitter = display.newEmitter( yellowParams )

-- emitter:scale(0.005,0.005)
-- emitter1:scale(0.005,0.005)
-- emitter2:scale(0.005,0.005)


-- emitter1.textureFileName = "images/boostparticles/SmokeParticle.jpg"
-- emitter2.textureFileName = "images/boostparticles/SmokeParticle.jpg"
-- emitter3.textureFileName = "images/boostparticles/SmokeParticle.jpg"
-- emitter4.textureFileName = "images/boostparticles/SmokeParticle.jpg"
-- emitter.startColorRed = 0
-- emitter.endColorRed = 0
-- emitter.startColorGreen = 0
-- emitter.endColorGreen = 0
-- emitter.startColorBlue = 1
-- emitter.endColorBlue = 1

-- emitter1.startColorRed = 105/255
-- emitter1.endColorRed = 105/255
-- emitter1.startColorGreen = 105/255
-- emitter1.endColorGreen = 105/255
-- emitter1.startColorBlue = 105/255
-- emitter1.endColorBlue = 105/255


-- emitter2.startColorRed = 1
-- emitter2.endColorRed = 1
-- emitter2.startColorGreen = 0
-- emitter2.endColorGreen = 0
-- emitter2.startColorBlue = 0
-- emitter2.endColorBlue = 0

-- emitter3.startColorRed = 0
-- emitter3.endColorRed = 0
-- emitter3.startColorGreen = 0
-- emitter3.endColorGreen = 0
-- emitter3.startColorBlue = 1
-- emitter3.endColorBlue = 1

-- emitter4.startColorRed = 0
-- emitter4.endColorRed = 0
-- emitter4.startColorGreen = 0
-- emitter4.endColorGreen = 0
-- emitter4.startColorBlue = 1
-- emitter4.endColorBlue = 1

-- fire:insert( emitter1 )

-- -- fire:insert( emitter4 )
-- -- fire:insert( emitter3 )
-- fire:insert( emitter2 )
-- --fire:insert( emitter )


-- local emitter = particleDesigner.newEmitter( "trippy.json" )
-- emitter:scale(0.05,0.005)


fire.isFixedRotation = true

gameStatus.ignoreClick = false
gameStatus.isLeftLeg = false


ob.stageGroup = display.newGroup()
ob.stageGroup.alpha = 1
ob.stageGroup.isGroup = true
ob.stageGroup.backgroundStage="GAME"

local mask = graphics.newMask( "images/whitemask.png" )

ob.stageGroup:setMask( mask )

ob.stageGroup.maskX = 240
ob.stageGroup.maskY = 160


 ultraWave = display.newRect(240, 160, 800,600)
 ultraWave:setFillColor(0, 0, 0)
 ultraWave.alpha = 0.7
    
--ultraWave = display.newSprite(ultraWaveSheet, ultraData);
--ultraWave:scale(2.5,2)


ultraWave.xScale = 1.1 * display.actualContentWidth / ultraWave.contentWidth 
ultraWave.yScale = 1.1 * display.actualContentHeight  / ultraWave.contentHeight

-- ultraFloor = display.newSprite(ultraFloorSheet, ultraData);
-- ultraFloor:scale(2.5,2.5)


local flashGroup = display.newGroup()
flashGroup:insert(emitter1)


local glaciarGroup = display.newGroup()
glaciarGroup:insert(emitter2)

local backgroundData = {
   --{path="images/blackmask.png" , speedFactor = nil , y  = 160 , isfull = true, level = 1  },
   -- {path="images/StadiumSmall.png" , speedFactor = 35 , y  = 120 , scale = 0.65 , level = 1  },
   --  {path="images/GrassBig.png" , speedFactor = 25 , y  = 230 , scale = 0.5 , level = 1 ,top = 180 },
   --  {path="images/Goal.png" , speedFactor = 25 , y  = 183 , scale = 0.5 , level = 1 , top = 180},
   {path="images/SoccerField Test/Stadium.png" , speedFactor = 15 , y  = 85 , scale = 0.9 , level = 1  },
   {displayGroup= flashGroup , level = 1},
    {path="images/SoccerField Test/GrassBack.png" , speedFactor = 10 , y  = 230 , scale = 0.8 , level = 1 ,top = 180 },
    {path="images/SoccerField Test/Goal.png" , speedFactor = 10 , y  = 183 , scale = 1 , level = 1 , top = 165},

   
   {path="images/Glacier/IceSky.png" , speedFactor = 100 , y  = 85 , scale = 1 , level = 2},
   {path="images/Glacier/IceBack.png" , speedFactor = 35 , y  = 230 , scale = 1 , level = 2 , top = 180 },
  {path="images/Glacier/IceBergs.png" , speedFactor = 25 , y  = 187 , scale = 1 , level = 2 , top = 155}, 
  
  

  {path="images/Desert/DesertSky.png" , speedFactor = 100 , y  = 85 , scale = 1 , level = 4},
   {path="images/Desert/DesertBack.png" , speedFactor = 15 , y  = 230 , scale = 1 , level = 4 ,top = 185},

   {path="images/Glacier/IceSky.png" , speedFactor = 100 , y  = 85 , scale = 1 , level = 3},
   {path="images/Castle/Ice mountains.png" , speedFactor = 15 , y  = 230 , scale = 1, level = 3 ,top = 60},
   {path="images/Castle/Castle.png" , speedFactor = 10 , y  = 230 , scale = 0.9 , level = 3 ,top = 10},

   {path="images/EagleField/EagleSky.png" , speedFactor = 100 , y  = 85 , scale = 1  , level = 5},
   {path="images/EagleField/EagleBG.png" , speedFactor = 35 , y  = 65 , scale = 1  , level = 5},
   
   {path="images/EagleField/GrassBig.png" , speedFactor = 10 , y  = 230 , scale = 1 , level = 5 ,top = 190 },
   {path="images/EagleField/Stadium.png" , speedFactor = 15 , y  = 130 , scale = 0.8, level = 5  },
    {path="images/EagleField/Goal.png" , speedFactor = 10 , y  = 183 , scale = 1 , level = 5 , top = 195},
   
   --{displayGroup = ultraWave} , 
  
  --{path="images/Houses/HousesFar.png" , speedFactor = 20 , y  = 130 , scale = 0.3, alpha = 0.4 , isFirstStage = true },  
  --{path="images/GrassBG Tile.png" , speedFactor = 10 , y  = 190 , scale = 1.4 , isFirstStage = true},
  --{path="images/100mBG.png" , speedFactor = 10 , y  = 175 , scale = 0.6 , startPos = 90 , endPos = 130 , isShowOnce = true },
  
  --{displayGroup = houses , backgroundStage="GAME" , isFirstStage = true } , --  , startPos = 0 , endPos = 37
  -- {path="images/BrokenWall.png" , speedFactor = 1 , y  = 210 , scale = 0.37 , backgroundStage="GAME" , startPos = 40 , endPos = 3120},   --  speedFactor = 1.5
  -- {path="images/BrokenWallTransission.png" , speedFactor = 1 , y  = 210 , scale = 0.37 ,  isShowOnce = true ,
  --          backgroundStage="GAME" , startPos = 40 , endPos = 50},   --  speedFactor = 1.5
  -- {path="images/background.png" , speedFactor = 1 , y  = 160 , scale = 1 , isfull = true , startPos = 96 , endPos = 30, showAndRotate = true},
  -- {path="images/bgfar1.png" , speedFactor = 1 , y  = 80 , scale = 1.3, startPos = 96 , endPos = 30, showAndRotate = true },  
  -- {path="images/Houses/HousesFar.png" , speedFactor = 1 , y  = 130 , scale = 0.3, alpha = 0.4 , startPos = 96 , endPos = 30, showAndRotate = true },  
  -- {path="images/GrassBG Tile.png" , speedFactor = 1 , y  = 190 ,  alpha = 1, scale = 1.4 , startPos = 96 , endPos = 30, showAndRotate = true},
  
  
  --{path="images/WallBright.jpg" , speedFactor = 1 , y  = 210 , scale = 0.37 , backgroundStage="GAME" ,isFirstStage = true },   --  speedFactor = 1.5  startPos = 0 , endPos = 30
  -- {path="images/Beach/Water.png" ,  backgroundStage="GAME"  , speedFactor = 20 , y  = 150 , scale = 0.7, alpha = 1 , startPos = 97 , endPos = 1200, showAndRotate = true },  
  -- {path="images/GrassBG Tile.png" , backgroundStage="GAME"  ,  speedFactor = 10 , y  = 190 , scale = 1.4  ,startPos = 197 , endPos = 1830 , showAndRotate = true},
  -- {path="images/100mBG.png" , backgroundStage="GAME"  , speedFactor = 10 , y  = 175 , scale = 0.6 , startPos = 197 , endPos = 1830 , showAndRotate = true },
  -- {path="images/BrokenWall.png" , speedFactor = 1 , y  = 210 , scale = 0.37 , backgroundStage="GAME" , startPos = 197 , endPos = 3120,showAndRotate = true},   --  speedFactor = 1.5
  
  --{path="images/FenceTile.png" , speedFactor = 1 , y  = 210 , scale = 0.45 , backgroundStage="TUTORIAL"  , isFirstStage = true  },  
  
}

backgrounds = display.newGroup()


local foregroundData = {  
  -- {path="images/TransitionHouse.png" , speedFactor = 1 , y  = 160 , isfull = true , isShowOnce = true , 
  --         scale = 0.85 , alpha = 0, backgroundStage="GAME" , startPos = 30 , endPos = 40},
  -- {path="images/Beach/FoorSeaDeck.jpg" , speedFactor = 1 , y  = 275 ,
  --         scale = 0.5 , alpha = 1, backgroundStage="GAME" , startPos = 96 , endPos = 200 },
  -- {path="images/GrassBig.png" , speedFactor = 1 , y  = 280 , level = 1,  top  = 240,
  --         scale = 0.6 , scaleY = -0.6 , alpha = 1 },
  {path="images/SoccerField Test/GrassFront.png" , speedFactor = 1 , y  = 280 , level = 1,  top  = 240,
          scale = 1 , scaleY = 1.2 , alpha = 1 },        
          
{path="images/Glacier/IceFront.png" , speedFactor = 1 , y  = 300 , level = 2, top  = 240,
          scale = 1.2  , alpha = 1  },   
{displayGroup= glaciarGroup , level = 2},
  {path="images/Castle/Floor.png" , speedFactor = 1 , y  = 280 , level = 3 ,top  = 220,
          scale = 1.2  , alpha = 1  },  

  {path="images/Desert/DesertFront.png" , speedFactor = 1 , y  = 280 , level = 4 ,top  = 240,
          scale = 1.2 , alpha = 1  },               
  {path="images/EagleField/GrassBigFront.png" , speedFactor = 1 , y  = 280 , level = 5,  top  = 240,
          scale = 1.2 , alpha = 1 },               
--{displayGroup = ultraFloor} ,           

  -- {path="images/TransitionEffect.png" , speedFactor = 1 , y  = 160 , isShowOnce = true , isTransition = true, label = "100M" , 
  --         scale = 0.5 , alpha = 1, backgroundStage="GAME" , startPos = 95 , endPos = 30 , isEraser = true},
  -- {path="images/TransitionEffect.png" , speedFactor = 1 , y  = 160 , isShowOnce = true , isTransition = true, label = "200M" , 
  --         scale = 0.5 , alpha = 1, backgroundStage="GAME" , startPos = 195 , endPos = 30},
        


             --  speedFactor = 1.5  
}

ob.foregrounds = display.newGroup()

local function buildBackground(disGroup, data)
  -- body

          for k,v in pairs(data) do
              if (v.displayGroup ) then
                  disGroup:insert(v.displayGroup)        
                  v.displayGroup.isGroup = true
                  v.displayGroup.backgroundStage = v.backgroundStage
                  v.displayGroup.originalAlpha  = v.displayGroup.alpha 
                  v.displayGroup.startPos = v.startPos
                  v.displayGroup.endPos = v.endPos
                  v.displayGroup.level = v.level

                  if v.isFirstStage then
                  ob.stageGroup:insert(v.displayGroup)
                 end 
              else  
                local yScale = v.scale
                if v.scaleY then
                  yScale = v.scaleY
                end  

               local img = display.newImage(v.path)
               if  v.isfull then
                img.x = 240
                img.y = 160
                img.xScale = displayActualContentWidth / img.contentWidth 
                img.yScale = display.actualContentHeight  / img.contentHeight
               else 

                
                 img:scale(v.scale , yScale)

                 if v.top then
                  v.y = v.top + img.contentHeight / 2
                 end

                 if v.bottom then
                  v.y = v.bottom - img.contentHeight /2
                 end
                 
                 img.y = v.y
                 img.x = img.contentWidth  / 2  - (displayActualContentWidth - display.contentWidth) /2   
               end
               img.constWidth = img.width * img.xScale
               img.internalIdx = 0
               img.speedFactor = v.speedFactor
               img.startPos = v.startPos
               img.endPos = v.endPos               
               
               if v.alpha then
                img.alpha = v.alpha               
               end 

               img.originalAlpha = img.alpha
               disGroup:insert(img)
             
               img.backgroundStage = v.backgroundStage
               img.isShowOnce = v.isShowOnce
               img.isTransition = v.isTransition
               img.label = v.label
               img.level = v.level
                
               img.showAndRotate = v.showAndRotate
               
               img.isEraser  = v.isEraser
               img.groupCount = 1
               
               if v.isFirstStage then
                ob.stageGroup:insert(img)
               end 
             
               if (v.speedFactor and not v.isShowOnce) then
                local img2 = display.newImage(v.path)

                 if  v.isfull then                  
                  img2.xScale = displayActualContentWidth / img2.contentWidth 
                  img2.yScale = display.actualContentHeight  / img2.contentHeight
                else 

                  img2:scale(v.scale , yScale)
                end
                img2.constWidth = img2.width * img2.xScale
                img2.y = v.y
                img2.x = (img2.contentWidth  / 2) + img2.contentWidth - (displayActualContentWidth - display.contentWidth) /2
                img2.internalIdx = 1
                img2.speedFactor = v.speedFactor
                img2.backgroundStage = v.backgroundStage
                img2.startPos = v.startPos
                img2.endPos = v.endPos
                img2.showAndRotate = v.showAndRotate
                img2.level = v.level
               
             

                 if v.alpha then
                  img2.alpha = v.alpha                
                 end 

                 img2.originalAlpha = img2.alpha
                 img.groupCount = 2
                 img2.groupCount = 2


                disGroup:insert(img2)


                  if v.isFirstStage then
                   ob.stageGroup:insert(img2)
                 end 

                if (img.contentWidth < displayActualContentWidth) then
                  local additionalCount = math.floor(displayActualContentWidth/img.contentWidth) + 1
                 
                  for i=1,additionalCount do
                    local img3 = display.newImage(v.path)
                    if  v.isfull then                  
                      img3.xScale = displayActualContentWidth / img3.contentWidth 
                      img3.yScale = display.actualContentHeight  / img3.contentHeight
                    else 
                      img3:scale(v.scale , yScale)
                    end
                    
                    img3.constWidth = img3.width * img3.xScale
                    img3.y = v.y
                    img3.x = (img3.contentWidth  / 2) + (img3.contentWidth *(i+1)) - (displayActualContentWidth - display.contentWidth) /2
                    
                    img3.internalIdx = i+1
                    img3.speedFactor = v.speedFactor
                    img3.backgroundStage = v.backgroundStage
                    img3.startPos = v.startPos
                    img3.endPos = v.endPos
                    img.groupCount = additionalCount + 2
                    img2.groupCount = additionalCount + 2
                    img3.groupCount = additionalCount + 2
                    img3.showAndRotate = v.showAndRotate
                    img3.level = v.level

                     if v.alpha then
                      img3.alpha = v.alpha
                      
                     end 

                     img3.originalAlpha = img3.alpha
                    disGroup:insert(img3)


                    if v.isFirstStage then
                     ob.stageGroup:insert(img3)
                    end 
                  end
                  
                end

               end
             end
          end
   end       

buildBackground(backgrounds, backgroundData)
buildBackground(ob.foregrounds, foregroundData)



ob.shadow = display.newImage("HeroResized/DribbleGuySkin/Shadow.png")
ob.shadow.x = BALL_X
ob.shadow.y = 273
ob.shadow:scale(0.3,0.3)

ob.ultraGlow = display.newImage("images/UltraHighlight.png") 
ob.ultraGlow.x = hero.skeleton.group.x
ob.ultraGlow.y = 273
--ob.ultraGlow:scale(0.3,0.3)
ob.ultraGlow.alpha = 0


ob.holdDevice = display.newImage("images/HoldDevice.png")
ob.holdDevice.x = 240
ob.holdDevice.y = 190
ob.holdDevice:scale(0.6,0.6)
ob.holdDevice.alpha = 0



ob.scoreBg = display.newImage("images/Scoreboard/ScoreBG.png")
ob.scoreBg:scale(0.5,0.5)
ob.scoreBg.x = 255 
ob.scoreBg.y = display.screenOriginY +  ob.scoreBg.contentHeight/2 - 3


ob.scoreFull = display.newImage("images/Scoreboard/SpreeUnitsFull.png")
ob.scoreFull:scale(0.5,0.5)
ob.scoreFull.x = 238
ob.scoreFull.y = ob.scoreBg.y + 18
ob.scoreFull.alpha = 0 

local prevStreeX = 166 
for a = 1, 8, 1 do
  local sreeUnit = display.newImage("images/Scoreboard/SreeUnit" .. a .. ".png")
  sreeUnit:scale(0.5,0.5)
  sreeUnit.y = ob.scoreBg.y + 18
  sreeUnit.x = prevStreeX +  sreeUnit.contentWidth / 2
  sreeUnit.alpha = 0
  ob.scoreboard:insert(sreeUnit )
  prevStreeX = prevStreeX + sreeUnit.contentWidth - (math.abs(4-a)) 

  
end


scoreText = display.newText("", 0, 0 , "UnitedSansRgHv" , 18)

multiText = display.newText("", 0, 0 , "UnitedItalicRgHv" , 22)
multiText.y = ob.scoreBg.y + 8
multiText.x = ob.scoreBg.x + 100
multiText:setFillColor(1,206/255,0)

ob.scoreTextMove = display.newText("", 0, 0 , "troika" , 32)
ob.scoreTextMove.alpha = 0
ob.scoreTextMove:setFillColor(1,206/255,0)

--This is important because if you dont have this line the text will constantly keep
--centering itself rather than aligning itself up neatly along a fixed point
--scoreText: sequenceData ReferencePoint(display.CenterLeftReferencePoint)
scoreText.x = 240
scoreText.y = 15

ob.scoreTextMove.x = 840
ob.scoreTextMove.y = 20


 local function boosterRectListener( event )   

    if ( event.phase == "ended"  ) then
      gameStatus.isConfirmationRequired = false
      ob.holdDevice.alpha = 0      
      ob.holdDeviceBlocker.alpha = 0

    end
      return true
 end

ob.holdDeviceBlocker = display.newRect(240, 160, 700,400)
ob.holdDeviceBlocker:setFillColor(0, 0, 0)
ob.holdDeviceBlocker.alpha = 0
ob.holdDeviceBlocker:addEventListener("touch", boosterRectListener )
ob.holdDevice:addEventListener("touch", boosterRectListener )


ob.instructionBlocker = display.newRect(240, 160, 700,400)
ob.instructionBlocker:setFillColor(0, 0, 0)
ob.instructionBlocker.alpha = 0






blocks = display.newGroup()

--cones = display.newGroup()
coins = display.newGroup()
coinsSpine = display.newGroup()

--variable to hold our game's score
score = 0
gameStatus.newScore = 0
--scoreText is another variable that holds a string that has the score information
--when we update the score we will always need to update this string as well
--*****Note for android users, you may need to include the file extension of the font


coinImg  = display.newImage("Coin/Coin.png")
coinImg.x = 20
coinImg.y = 23
coinImg:scale(0.25,0.25)

local coinTextOptions = 
{
    --parent = textGroup,
    text = "",     
    x = 100,
    y = 23,
    width = 120,     --required for multi-line and alignment
    font = "troika",   
    fontSize = 20,
    align = "left"  --new alignment parameter
}


coinsCountText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
coinsShadowText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)

--coinsCount = 0
coinsCountText:setFillColor(1,206/255,0)
coinsShadowText:setFillColor(128/255,97/255,40/255)
coinsShadowText.y = coinsCountText.y + 2

coinImg.x = coinImg.x - (displayActualContentWidth - display.contentWidth) /2
coinsCountText.x = coinsCountText.x - (displayActualContentWidth - display.contentWidth) /2
coinsShadowText.x = coinsShadowText.x - (displayActualContentWidth - display.contentWidth) /2

trophieImg  = display.newImage("TrophieReward/Trophie.png")
trophieImg.x = coinImg.x
trophieImg.y = 53
trophieImg:scale(0.07,0.07)

trophieCountText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
trophieShadowText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)

trophieCountText:setFillColor(1,206/255,0)
trophieShadowText:setFillColor(128/255,97/255,40/255)

trophieCountText.y = 53
trophieCountText.x = coinsCountText.x 
trophieShadowText.y = 55
trophieShadowText.x = trophieCountText.x 



 ultraWave.x = 240
ultraWave.y = 160

-- ultraFloor.x = 240
-- ultraFloor.y = 170

ob.groundLevel = 280
gameStatus.speed = 5;

shotPower = 1
gameStatus.kickStart = 0; 
--this for loop will generate all of your ground pieces, we are going to
--make 8 in all.

local isDone = false
local numGen = 0
for a = 1, 10, 1 do
  isDone = false
   
  numGen = mRandom(2)
  local newBlock
  
  if(a % 2 == 1 and isDone == false) then
      newBlock = display.newImage("images/red1.jpg")
      isDone = true
  end
   
  if(a % 2 == 0 and isDone == false) then
      newBlock = display.newImage("images/white1.jpg")
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
  newBlock.x = (a * newBlock.contentWidth) - newBlock.contentWidth
  newBlock.y = ob.groundLevel
  blocks:insert(newBlock)
end

dirt = display.newGroup()
--dirt.alpha = 0

local dirtImages = {}
dirtImages[1] = "images/SpeedLines.png"
-- dirtImages[2] = "images/cracks02.png"
-- dirtImages[3] = "images/crap01.png"
-- dirtImages[4] = "images/crap02.png"
-- dirtImages[5] = "images/grass01.png"
-- dirtImages[6] = "images/grass02.png"
-- dirtImages[7] = "images/grass03.png"
-- dirtImages[8] = "images/paper.png"
-- dirtImages[9] =  "images/sewer.png"


for i = 1, 9, 1 do
  local img = display.newImage(dirtImages[1])
  img.isAlive = false
  img.alpha = 0.2
  img:scale(0.5,0.4)
  dirt:insert(img)
  
end


--And assign it to the object hero using the display.newSprite function
monster = display.newSprite(spriteSheet, sequenceData);

--And assign it to the object hero using the display.newSprite function

--these are 2 variables that will control the falling and jumping of the monster
monster.gravity = -6


monster.accel = 0
monster.isAlive = true
monster.kickTimer =0
monster.name = "monster"
--monster:scale(0.5,0.5)


local borderCollisionFilter = { categoryBits = 1, maskBits = 2 } -- collides with ball
local borderBodyElement = { density=0.01, friction=0.01, bounce=0, isSensor=true, filter=borderCollisionFilter }
local gameOverElement = { friction=0.4, bounce=0.4, filter=borderCollisionFilter }
local upperGameOverElement = {isSensor=true, filter=borderCollisionFilter }

local ballFilter = { categoryBits = 2, maskBits = 57 } -- collides with leg , border and defender 110001
local fireFilter = { categoryBits = 64, maskBits = 0 } -- collides with leg , border and defender 110001

local redBody = { density=3, friction=0.1, bounce=0, radius=13.0, filter=ballFilter }

local coneOutline = graphics.newOutline( 2, "images/ConeHitbox.png" )
local trashOutline = graphics.newOutline( 2, "images/Barrel_Hitbox.png" )

local coneCollisionFilter = { categoryBits = 4, maskBits = 9 } -- collides with leg and hero
local coneElement = { friction=0.4, bounce=0.1, filter=coneCollisionFilter , outline=coneOutline }
local trashElement = { friction=0.4, bounce=0.1, filter=coneCollisionFilter , outline=trashOutline }
local birdOutline = graphics.newOutline( 2, "WaterBot/Hitbox.png" )
--local birdCollisionFilter =  {categoryBits = 4, maskBits = 9 } --- collides with ball and hero
local birdBodyElement = { friction=0.4, bounce=0.3, filter=coneCollisionFilter ,  outline = birdOutline }

 

local letterOutline = graphics.newOutline( 2, spriteSheet, 6 )
local heroCollisionFilter = { categoryBits = 8, maskBits = 6 } -- collides cone
local heroElement = { friction=0.4, bounce=0.1, filter=heroCollisionFilter, outline=letterOutline }
local jumpLegElement = { friction=0.4, bounce=0.1, filter=heroCollisionFilter }


local defenderCollisionFilter = { categoryBits = 16, maskBits = 2 } 
local defenderBodyElement = { friction=0.4, bounce=0.1, filter=defenderCollisionFilter} --, outline=defenderOutline }


local refereeBodyElement = { friction=0.4, bounce=0.1, filter=coneCollisionFilter}

local coinCollisionFilter = { categoryBits = 16, maskBits = 2 } 
-- radius=10.0,

local coinOutline = graphics.newOutline( 2, "images/coin.png" )
    
local coinBodyElement = { isSensor=true,  filter=defenderCollisionFilter ,  outline = coinOutline }




ob.defualtAlpha = 0
 local playButton = display.newImage("images/playButton.png")
 playButton:scale(0.3,0.3)
     playButton.x = 240
     if ( "simulator" == system.getInfo("environment")) then
      playButton.y = 220
      ob.defualtAlpha = 0

      
     else     
      playButton.y = 720
    end


monster.alpha = ob.defualtAlpha

--rectangle used for our collision detection
--it will always be in front of the monster sprite
--that way we know if the monster hit into anything
collisionRect = display.newRect(BALL_X, monster.y +30, 3,1)
collisionRect.strokeWidth = 1
collisionRect:setFillColor(140, 140, 140)
collisionRect:setStrokeColor(180, 180, 180)
collisionRect.alpha = ob.defualtAlpha
collisionRect.name = "leg"

local screenBorder  = display.newRect(240, -20 , 800, 40)
screenBorder:setFillColor(0, 0, 0)

ob.jumpLeg = display.newRect(monster.x + 36, monster.y +30, 20,1)
ob.jumpLeg.strokeWidth = 1
ob.jumpLeg:setFillColor(140, 140, 140)
ob.jumpLeg:setStrokeColor(180, 180, 180)
ob.jumpLeg.alpha = ob.defualtAlpha
ob.jumpLeg.name = "leg"
ob.jumpLeg.isJumpLeg = true


physics.addBody( collisionRect, "static", borderBodyElement )
physics.addBody( ballon, redBody )

physics.addBody( fire, "dynamic", {  density=0.2, friction=0.1, bounce=0, radius=13.0,filter=fireFilter } )
-- physics.addBody( ultraBall, "dynamic", {  density=0.2, friction=0.1, bounce=0, radius=13.0,filter=fireFilter } )

physics.addBody( monster, "kinematic" , heroElement )
physics.addBody( ob.jumpLeg, "kinematic" , jumpLegElement )
ob.jumpLeg.isSensor = true
monster.isSensor = true


ob.redRect = display.newRect(240 , 280, 600,84)
ob.redRect:setFillColor(1, 0, 0)

local gameOverRect = display.newRect(240 , 280, 600,10)


gameOverRect.strokeWidth = 1
gameOverRect:setFillColor(140, 140, 140)
gameOverRect:setStrokeColor(180, 180, 180)
gameOverRect.alpha = ob.defualtAlpha
gameOverRect.name = "gameOver"
physics.addBody( gameOverRect, "kinematic", gameOverElement )

local gameOverRect2 = display.newRect(100 , -30, 150,10)
gameOverRect2.strokeWidth = 1
gameOverRect2.alpha = ob.defualtAlpha
gameOverRect2.name = "gameOver"
gameOverRect2.shouldStopGame = false
physics.addBody( gameOverRect2, "kinematic", upperGameOverElement )



monster.alpha = ob.defualtAlpha
       --create cones
--  for a = 1, 1, 1 do
    --  cones:insert(cone)
  --end
  local coinSpineAn = require "coin"

  for a = 1, 10, 1 do
      local coin = display.newImage("images/coin.png")

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

      
      coin.spine =  coinSpineAn.new()
      
      coinsSpine:insert(coin.spine.skeleton.group)
      
  end

  chaserRect = display.newRect(20, 235 , 1,50)
  chaserRect.strokeWidth = 1
  chaserRect:setFillColor(140, 140, 140)
  chaserRect:setStrokeColor(180, 180, 180)
  chaserRect.alpha = ob.defualtAlpha
  chaserRect.name = "chaser"



       
  chaserRect.x = 20
  chaserRect.y = 235
  chaserRect.speed = 0
  chaserRect.isAlive = false
  physics.addBody( chaserRect, "dynamic" , refereeBodyElement )
  chaserRect.gravityScale=0
 --defenders = display.newGroup()


 obstecales = display.newGroup()
ob.obstecaleSpines = display.newGroup()

--smallDefender  = display.newSprite(spriteSheetDef, sequenceDataDef);
--smallDefender:scale(0.5,0.5)
-- local smallDefender = display.newRect(500, 900 , 60,50)
-- smallDefender.strokeWidth = 1
-- smallDefender:setFillColor(140, 140, 140)
-- smallDefender:setStrokeColor(180, 180, 180)
-- smallDefender.alpha = ob.defualtAlpha
-- smallDefender.isDog = true
-- --smallDefender.alpha = 0 
-- smallDefender.spine = dogSpineAn.new()


-- --medDefender  = display.newSprite(spriteSheetDef, sequenceDataDef);
-- obstecales:insert(smallDefender)
-- ob.obstecaleSpines:insert(smallDefender.spine.skeleton.group)
-- physics.addBody( obstecales[1], "kinematic" , defenderBodyElement )

local arsSpineAn = require "ars"

--ars = display.newRect(500, 900 , 30,65)


for i = 1, 5, 1 do

    local ars = display.newImage("images/AnnoyingKid0".. i .."Hitbox.png")
    ars.alpha = ob.defualtAlpha

    --ars = display.newImage("images/ars.png")

    ars.name = "ars"

   
    ars.x = 900
    ars.y = 1500
    ars.isAlive = false
    ars.isKid = true
    --ars:scale(0.5,0.5)
    --physics.addBody( ars, "dynamic" , arsBodyElement )
    ars.gravityScale=0
    ars.isFixedRotation = true
    ars.alpha = ob.defualtAlpha


    ars.spine =  arsSpineAn.new(i)
    ars.spine.skeleton.group.xScale = -1
    ob.obstecaleSpines:insert(ars.spine.skeleton.group)
    obstecales:insert(ars)
    local arsOutline = graphics.newOutline( 2, "images/AnnoyingKid0" .. i .."Hitbox.png" )
    local arsBodyElement =  { friction=0.4, bounce=0.1, filter=defenderCollisionFilter, outline=arsOutline } 
   physics.addBody(ars , "kinematic" , arsBodyElement )
 
end


local rewardsSpineAn = require "reward"

--ars = display.newRect(500, 900 , 30,65)
ob.rewards = {}

for i = 1, 3, 1 do

   

    ob.rewards[i] = rewardsSpineAn.new(i)
    
    
end



for i = 1, obstecales.numChildren, 1 do
  obstecales[i].name = "defender"              
  obstecales[i].x = 900
  obstecales[i].y = 500
  obstecales[i].isAlive = false
  obstecales[i].gravityScale=0
  
end

local cone = display.newImage("images/Cone.png")

cone.name = "cone"


cone.x = 900
cone.y = 1500
--cone:scale(0.4,0.4)
cone.isAlive = false
physics.addBody( cone, "dynamic" , coneElement )
cone.gravityScale=0


local trashCan = display.newImage("images/Barrel.png")

trashCan.name = "trash"


trashCan.x = 900
trashCan.y = 1500
--trashCan:scale(0.3,0.3)
trashCan.isAlive = false
physics.addBody( trashCan, "dynamic" , trashElement )
trashCan.gravityScale=0

 cone.isHard = true
 trashCan.isHard = true

obstecales:insert(cone)
obstecales:insert(trashCan)


local birdSpineAn = require "bird"

--bird = display.newRect(500, 900 , 30,65)
local bird = display.newImage("WaterBot/Hitbox.png")
bird.alpha = ob.defualtAlpha

--bird = display.newImage("images/bird.png")

bird.name = "bird"


bird.x = 900
bird.y = 500
bird.isAlive = false
--bird:scale(0.5,0.5)
physics.addBody( bird, "dynamic" , birdBodyElement )
bird.gravityScale=0
bird.isFixedRotation = true
bird.isHard = true
bird.alpha = ob.defualtAlpha

bird.spine =  birdSpineAn.new()
ob.obstecaleSpines:insert(bird.spine.skeleton.group)
obstecales:insert(bird)


obstecales[ob.KID_INDEX].isArs = true
obstecales[ob.TALL_KID_INDEX].isKid = true
obstecales[ob.DOUBLE_KIDS_INDEX].isTwoBoys = true
obstecales[ob.TALL_INDEX].isHard = true


ob.goalNet = display.newRect(55, 0 , 170,55)
ob.goalDummy = display.newRect(55, 0 , 1,1)


goal = {}

goal.numChildren = 2
goal.isAlive = false
local goalSpineAn = require "goal" 
ob.goalSpine  = goalSpineAn.new() 

goal[1] = ob.goalNet
goal[2] = ob.goalDummy

for i = 1, goal.numChildren, 1 do
  local v = goal[i]
  v.strokeWidth = 1
  v:setFillColor(140, 140, 140)
  v:setStrokeColor(180, 180, 180)
  v.alpha = ob.defualtAlpha
  physics.addBody( v , "kinematic" , gameOverElement )
  v.gravityScale=0  
  v.x = v.x +500


end


ob.goalNet.name = "net"
ob.goalNet.isSensor = true

ob.goalSpine.skeleton.group.name = "goalSpine"
ob.goalDummy.name = "goal"
ob.goalDummy.spine = ob.goalSpine

obstecales:insert(ob.goalDummy)
ob.goalDummy.isAlive = false

ob.obstecaleSpines:insert(ob.goalSpine.skeleton.group)

local handSpineAn = require "hand" 
leftHand =  handSpineAn.new()
rightHand =  handSpineAn.new()
leftHand.skeleton.group.x = 60
leftHand.skeleton.group.x = leftHand.skeleton.group.x  - (displayActualContentWidth - display.contentWidth) /2

rightHand.skeleton.group.x = 420
rightHand.skeleton.group.x = rightHand.skeleton.group.x  + (displayActualContentWidth - display.contentWidth) /2


leftHand.skeleton.group.y = 280
rightHand.skeleton.group.y = 280

leftHand.skeleton.group.xScale = -1

sounds.coinSound = audio.loadSound( "coin.mp3" )
sounds.perfectSpreeSound = audio.loadSound( "Comments/Perfect Spree 1.mp3" )
sounds.perfectSpreeSound2 = audio.loadSound( "Comments/SpreeFireSFX.mp3" )
sounds.perfectSpreeSound3 = audio.loadSound( "sounds/combo1.mp3" )

sounds.badKickSound = audio.loadSound( "Ball_Kick_Bad.mp3" )
--goodKickeSound = audio.loadSound( "Ball_Kick_Good.wav" )
sounds.fireKickSound = audio.loadSound( "fireballKick.mp3" )  
sounds.perfectKickSound = audio.loadSound( "Ball_Kick_Perfect.mp3" )
sounds.trophieGoalSound  = audio.loadSound( "TrophieGoal.mp3" )
sounds.coinsGoalSound  = audio.loadSound( "CoinsGoal.mp3" )
sounds.goalPostSound = audio.loadSound( "GoalPostHit.mp3" )
sounds.challengeUnlockedSound = audio.loadSound( "sounds/challenge.mp3" )


if commonData.selectedBall == "Brainz" then
  sounds.badKickBrainzSound  = audio.loadSound( "BrainBounceBad.mp3" )
  sounds.goodKickBrainzSound  = audio.loadSound( "BrainBounceGood.mp3" )
end

if commonData.selectedBall == "Basketball" then
  sounds.basketballSound  = audio.loadSound( "sounds/BasketBallDribble.mp3" )
end

if commonData.selectedBall == "Watermelon" then
  sounds.watermelonSound  = audio.loadSound( "sounds/Watermelon.mp3" )
end

if commonData.selectedSkin == "Steph" then
  sounds.stephPerfectSpreeSound  = audio.loadSound( "sounds/HesOnFire.mp3" )
end

if commonData.selectedSkin == "DribbleBot" then
  sounds.botKickSound  = audio.loadSound( "sounds/laserMod2.mp3" )
end





  

sounds.jumpSound = audio.loadSound( "Kid_Jump.mp3" )
sounds.saltaSound = audio.loadSound( "sounds/FlipWhoosh.mp3" )
sounds.lookoutSound = audio.loadSound( "sounds/players/CoachLookout01.mp3" )
--sounds.transitionSound = audio.loadSound( "sounds/LvlTransition01.mp3" )


sounds.ballFallSound = audio.loadSound( "sounds/BallHitGround.mp3" )
sounds.glassBreakSound =  audio.loadSound( "glass_break.mp3" )
sounds.kickTimeoutSound = audio.loadSound( "SlideOnGround.mp3" )

sounds.crashConeSound = audio.loadSound( "trafficConeHit.mp3" )
sounds.crashTrashSound = audio.loadSound( "Bucket Hit.mp3" )
sounds.birdHitSound = audio.loadSound( "Crow.mp3" )

-- sounds.twoBoysSound = audio.loadSound( "2BoysLaugh.mp3" )
-- sounds.arsSound = audio.loadSound( "tallArsLaugh.mp3" )
-- sounds.kidSound = audio.loadSound( "smallKidLaugh.mp3" )
-- sounds.catchSound = audio.loadSound( "BadGuyPunch3.mp3" )


local backgroundMusic = audio.loadStream( "sounds/generic1.mp3" )
ob.backgroundMusicHdl = commonData.playSound( backgroundMusic, { loops=-1 ,  fadein = 5000 } )

if ob.backgroundMusicHdl then
  audio.pause( ob.backgroundMusicHdl )
end

local backgroundMusic2 = audio.loadStream( "sounds/generic2.mp3" )
ob.backgroundMusicHdl2 = commonData.playSound( backgroundMusic2, { loops=-1 ,  fadein = 5000} )

if ob.backgroundMusicHdl2 then
  audio.pause( ob.backgroundMusicHdl2 )
end

local backgroundMusic3 = audio.loadStream( "sounds/generic3.mp3" )
ob.backgroundMusicHdl3 = commonData.playSound( backgroundMusic3, { loops=-1 ,  fadein = 5000} )

if ob.backgroundMusicHdl3 then
  audio.pause( ob.backgroundMusicHdl3 )
end

ob.activeMusicHdl = backgroundMusicHdl

local function resumeGame()
        timer.resume(gameStatus.mainTimer)
        physics.start()
        --physics.setTimeStep(0)

        hero:resume()
        ob.chaser:resume()
        ob.coach:resume()

        if ob.activeMusicHdl and not commonData.isMute then
          audio.resume(ob.activeMusicHdl)
        end

        if (exitUltraModeHandle) then
            timer.resume( exitUltraModeHandle )                  
         end

         if (advanceUltraModeHandle) then
            timer.resume( advanceUltraModeHandle )                  
         end
         pauseButton.alpha = 1
        gameStatus.isGamePaused = false

end

commonData.pauseGame = function ()

      if (gameStatus.isGameActive) then
  
              if (gameStatus.isGamePaused) then
                local length = comments:resume()

                timer.performWithDelay(length * 1000, resumeGame, 1)
                ob.pausedGroup.alpha = 0 
                pauseButton.alpha = 0
                ob.muteButton.alpha = 0              
                ob.unMuteButton.alpha = 0
              elseif gameStatus.speed > 0 then

                if commonData.isMute then
                  ob.muteButton.alpha = 0              
                  ob.unMuteButton.alpha = 1
                else
                  ob.muteButton.alpha = 1              
                  ob.unMuteButton.alpha = 0
                end

                pauseButton.alpha = 1
                ob.pausedGroup.alpha = 1
                if (gameStatus.mainTimer) then
                  timer.pause(gameStatus.mainTimer)
                end 

                physics.pause()
                hero:pause()
                ob.chaser:pause()
                ob.coach:pause()
                
                if (ob.activeMusicHdl) then
                  audio.pause(ob.activeMusicHdl)
                end


                touchIDs = {}
                if (monster.kickTimer ==1) then
                  monster.kickTimer = 0    
                  gameStatus.kickEnded = true
                end

                if (exitUltraModeHandle) then
                    timer.pause( exitUltraModeHandle )                  
                 end 

                  if (advanceUltraModeHandle) then
                    timer.pause( advanceUltraModeHandle )                  
                 end 

                 if ob.ultraMusicHdl then
                   audio.pause( ob.ultraMusicHdl )
                   ob.ultraMusicHdl  = nil
                 end 

                  gameStatus.isGamePaused = true

              end
      end
  end
 

 local function pauseListener( event )
         if ( "ended" == event.phase ) then
          
            if (event.yStart < 40 ) then
                 commonData.buttonSound()
                commonData.pauseGame(event)
            else
              monster.kickTimer = 0
              gameStatus.kickEnded = true
              touchIDs = {}             
            end
         end 
           return false
  end


local  goBackHandle = nil


local function goBack(event)

     if (goBackHandle) then
         timer.cancel( goBackHandle )
         goBackHandle = nil
       end 

      local options = {params = {gameData = commonData.gameData}}
       composer.gotoScene( "menu" , options )
      
      
      

      return true

end

local function goToPacks(event)

     if (goBackHandle) then
         timer.cancel( goBackHandle )
         goBackHandle = nil
       end 

      local options = {params = {gameData = commonData.gameData}}

      if commonData.gameData.gamesCount == 0 then
        composer.gotoScene( "packs" , options )
      else
        composer.gotoScene( "menu" , options )
      end 
      
      
      

      return true

end

 
 pauseButton = widget.newButton
      {
          x = 457,
          y = 23,
          id = "pauseButton",
          defaultFile = "images/PauseBtn.png",
          overFile = "images/PauseBtnDown.png",
          onEvent = pauseListener
      }
      pauseButton.xScale =  (display.actualContentWidth*0.07) / pauseButton.width
      pauseButton.yScale = pauseButton.xScale  

pauseButton.x = pauseButton.x + (displayActualContentWidth - display.contentWidth) /2

      local function muteListener( event )
         if ( "ended" == event.phase ) then

              commonData.isMute = true
              ob.muteButton.alpha = 0              
              ob.unMuteButton.alpha = 1
          
          end
           return true
     end

     local function unMuteListener( event )
         if ( "ended" == event.phase ) then

              commonData.isMute = false
              ob.muteButton.alpha = 1              
              ob.unMuteButton.alpha = 0
              
          end
           return true
     end
 
     
    ob.muteButton = widget.newButton
      {
          x = 420,
          y = 23,
          id = "muteButton",
          defaultFile = "ExtrasMenu/Mute.png",
          overFile = "ExtrasMenu/UnMuteDown.png",
          onEvent = muteListener
      }

       ob.muteButton.xScale =  (display.actualContentWidth*0.07) / ob.muteButton.width
      ob.muteButton.yScale = ob.muteButton.xScale 

    ob.unMuteButton = widget.newButton
      {
          x = 420,
          y = 23,
          id = "unMuteButton",
          defaultFile = "ExtrasMenu/UnMute.png",
          overFile = "ExtrasMenu/MuteDown.png",
          onEvent = unMuteListener
      }

       ob.unMuteButton.xScale =  (display.actualContentWidth*0.07) / ob.unMuteButton.width
      ob.unMuteButton.yScale = ob.unMuteButton.xScale 
      ob.unMuteButton.alpha = 0

      ob.muteButton.x = ob.muteButton.x + (displayActualContentWidth - display.contentWidth) /2
      ob.unMuteButton.x = ob.unMuteButton.x + (displayActualContentWidth - display.contentWidth) /2



 local paused2 = widget.newButton
{
    x = 315,
    y = 200,
    id = "paused2",
    defaultFile = "images/PauseScreen/PauseResumeUp.png",
    overFile = "images/PauseScreen/PauseResumeDown.png",
    onEvent = commonData.pauseGame
    
}

local paused3 = widget.newButton
{
    x = 165,
    y = 200,
    id = "paused3",
    defaultFile = "images/PauseScreen/PauseExitUP.png",
    overFile = "images/PauseScreen/PauseExitDown.png",
    onEvent = goBack
    
}

paused2:scale(0.4,0.4)
paused3:scale(0.4,0.4)
--create a new group to hold all of our blocks

ob.pausedOverlay = display.newImage("images/Paused.png")
ob.pausedOverlay.x = 240
ob.pausedOverlay.y = 160
ob.pausedOverlay:scale(0.4,0.4)



ob.pausedGroup:insert(ob.pausedOverlay)
ob.pausedGroup:insert(paused3)
ob.pausedGroup:insert(paused2)





local function onSystemEvent( event )
    
    if (event.type == "applicationSuspend" and not gameStatus.isGamePaused and not gameStatus.isTutorial ) then
      commonData.pauseGame()
    end
end



Runtime:addEventListener( "system", onSystemEvent )



  local challengeTextOptions = 
                  {
                      --parent = textGroup,
                      text = "",     
                      x = 420,
                      y = 20,
                      width = 300,     --required for multi-line and alignment
                      font = "Helvetica",   
                      fontSize = 15,
                      align = "center"  --new alignment parameter
                  }

  newChallegeText = display.newText(challengeTextOptions)
  local newChallegeHeaderText = display.newText(challengeTextOptions)
  local newChallegeBack = display.newImage("images/ChallengeMsg.png")

  newChallegeBack:scale(0.5,0.5)
  newChallegeBack.x = 240
  newChallegeBack.y = 300
  


  -- newChallegeHeaderText:setFillColor(1,206/255,0)
  -- newChallegeHeaderText.text = "CHALLENGE COMPLETE"

  -- newChallegeText:setFillColor(194/256,236/256,254/256)

  
  newChallegeText.x = 240
  newChallegeText.y = 310

  newChallegeHeaderText.x = 240
  newChallegeHeaderText.y = 280

  newChallengeGroup:insert(newChallegeBack)
  --newChallengeGroup:insert(newChallegeHeaderText)
  newChallengeGroup:insert(newChallegeText)

  newChallengeGroup.alpha = 0 
  
             
--used to put everything on the screen into the screen group
--this will let us change the order in which sprites appear on
--the screen if we want. The earlier it is put into the group the
--further back it will go
sceneGroup:insert(backgrounds)
sceneGroup:insert(ob.stageGroup)
sceneGroup:insert(blocks)

sceneGroup:insert(ob.foregrounds)
sceneGroup:insert(dirt)
sceneGroup:insert(ob.scoreTextMove)

sceneGroup:insert(ob.redRect)


sceneGroup:insert(ob.coach.skeleton.group)
sceneGroup:insert(ob.bubble.skeleton.group)



sceneGroup:insert(ob.instructionBlocker)



ob.scoreboardDetails = display.newGroup()

ob.scoreboardDetails:insert(ob.scoreBg )
ob.scoreboardDetails:insert(ob.scoreboard )
ob.scoreboardDetails:insert(ob.scoreFull )


ob.scoreboardDetails:insert(scoreText)
ob.multiGroup:insert(multiText)
ob.scoreboardDetails:insert(ob.multiGroup)



sceneGroup:insert(pauseButton)

sceneGroup:insert(ob.muteButton)
sceneGroup:insert(ob.unMuteButton)

sceneGroup:insert(coins)

sceneGroup:insert(ob.obstacleArrow)

sceneGroup:insert(monster)
sceneGroup:insert(chaserRect)



sceneGroup:insert(obstecales)
sceneGroup:insert(ob.obstecaleSpines)

sceneGroup:insert(ultraWave)
sceneGroup:insert(ob.ultraGlow)
sceneGroup:insert(ob.scoreboardDetails)
sceneGroup:insert(coinsSpine)

for i = 1, goal.numChildren, 1 do
    if (goal[i].name ~= "goal") then
      sceneGroup:insert(goal[i])
    end
end

sceneGroup:insert(ob.rewards[1].skeleton.group)
sceneGroup:insert(ob.rewards[2].skeleton.group)
sceneGroup:insert(ob.rewards[3].skeleton.group)



sceneGroup:insert(ob.chaser.skeleton.group)



sceneGroup:insert(ob.leftTimer)
sceneGroup:insert(ob.rightTimer)

sceneGroup:insert(ob.leftCtrl)
sceneGroup:insert(ob.rightCtrl)

sceneGroup:insert(rightHand.skeleton.group)
sceneGroup:insert(leftHand.skeleton.group)

sceneGroup:insert(comments.skeleton.group)
sceneGroup:insert(hero.skeleton.group)
sceneGroup:insert(collisionRect)
sceneGroup:insert(ob.jumpLeg)
sceneGroup:insert(ob.shadow)


sceneGroup:insert(gameOverRect)
sceneGroup:insert(gameOverRect2)


sceneGroup:insert(fire)



sceneGroup:insert(ballon)
sceneGroup:insert(ballSkinGroup)
-- sceneGroup:insert(ultraBall)

sceneGroup:insert(kickToStart)


sceneGroup:insert(coinsShadowText)
sceneGroup:insert(coinsCountText)
sceneGroup:insert(trophieShadowText)
sceneGroup:insert(trophieCountText)

sceneGroup:insert(coinImg)
sceneGroup:insert(trophieImg)
sceneGroup:insert(newChallengeGroup)



sceneGroup:insert(playButton)
sceneGroup:insert(ob.pausedGroup)


sceneGroup:insert(ob.holdDeviceBlocker)
sceneGroup:insert(ob.holdDevice)
sceneGroup:insert(ob.holdDevice)

sceneGroup:insert(ob.notification)


sceneGroup:insert(screenBorder)




     
     --this is a little bit different way to detect touch, but it works
     --well for buttons. Simply add the eventListener to the display object
     --that is the button send the event "touch", which will call the function
     --buttonListener everytime the displayObject is touched.

     playButton:addEventListener("touch", buttonListener )
     
     



local function box_muller()
    return math.sqrt(-2 * math.log(mRandom())) * math.cos(2 * math.pi * mRandom()) / 2
end

local function randNormal(num)
  local bm = box_muller()
  
  return math.floor((num * bm  + num ) / 2)
end

ob.nextObsecalePos = 0
ob.getNextObstecalePos =  function(min , range)  
    local a = randNormal(range ) + min
     ob.nextObsecalePos = math.floor( score + a)      
    --nextObsecalePos = score +2
end

ob.updateScoreboard =  function(num)

        -- if num > 7 then
        --   ob.scoreFull.alpha = 1
        -- else
        --   ob.scoreFull.alpha = 0
        -- end
          
       if num == 0 then   
         for a = 1, ob.scoreboard.numChildren, 1 do
              -- if(a <= num ) then
               

              --   -- if num /12 >= 1 then
              --   --   ob.scoreboard[a]:setFillColor(0/256,2000/256,0/256)
              --   -- end

                   
              -- else
                ob.scoreboard[a].alpha = 0
             -- end
         end  
       else  
         ob.scoreboard[(num -1) % 8 +1 ].alpha = 1
         ob.scoreboard[(num -1) % 8 +1 ]:setFillColor(1,1,(10- 3*math.floor( (num-1)/8 ))/10)
       end  

       if num + 1 > gameStats.combo then
        gameStats.combo = num + 1
       end 
end  



ob.nextCoinPos = 0
ob.getNextCoinPos = function(min , range)  
    local gap = randNormal(range ) + min
    if (gameStatus.isUltraMode) then
       gap = 1 -- math.floor(gap / 3)
    end
     ob.nextCoinPos = math.floor( score +  gap )
     --nextCoinPos = math.floor( score + 2)
end

gameStatus.firstStage = 0
gameStatus.secondStage = 0

ob.exitUltraMode = function()
      fire.alpha = 0
      --ultraBall.alpha = 0 
      gameStatus.isUltraMode = false
      ultraWave.alpha = 0
      --ultraFloor.alpha = 0
      ob.scoreFull.alpha = 0
      ob.ultraCoinsCollected = 0
      ob.ultraGlow.alpha = 0
      gameStatus.sreeCount = 0
      ob.updateScoreboard(0)

      if (ballSkin) then             
            ballSkin.alpha = 1
      else 
            ballon.alpha = 1
      
      end  


      if ob.activeMusicHdl and not commonData.isMute then
          audio.resume(ob.activeMusicHdl)
      end

      ob.ultraMusicHdl = nil

      --ultraWave:pause()
      --ultraFloor:pause()
      
       for j = 1, fire.numChildren do
            if fire[j].isEmitter then 
             fire[j]:stop()          
            end    
        end

       if (exitUltraModeHandle) then
         timer.cancel( exitUltraModeHandle )
         exitUltraModeHandle = nil
       end 


       if (advanceUltraModeHandle) then
         timer.cancel( advanceUltraModeHandle )
         advanceUltraModeHandle = nil
       end 

       
       for a = 1, coins.numChildren, 1 do
            if(coins[a].isAlive == true and coins[a].ultra) then
          
              coins[a].x = -100
              coins[a].ultra = false              
               
            end
       end


       for a = 1, obstecales.numChildren, 1 do
            if(obstecales[a].isAlive and obstecales[a].name ~= "goal") then
            
              obstecales[a].isSensor  = false 
            end
       end
       
       if (gameStatus.inEvent == 14) then
        gameStatus.inEvent = 0
       end
       ob.getNextCoinPos(10,10)

       
    end
    
    local function advanceUltraMode()
       -- ultraWave:setSequence("advance")
       -- ultraWave:play()

       -- ultraFloor:setSequence("advance")
       -- ultraFloor:play()
    end

    local function moveToNextLevel()

        gameStatus.level  = gameStatus.level % LEVELS_COUNT + 1 
         for a = 1, backgrounds.numChildren, 1 do

            if (backgrounds[a].level)    then           
               if (backgrounds[a].level == gameStatus.level ) then
                 backgrounds[a].alpha = 1
                  
                  if (not backgrounds[a].isGroup) then
                      backgrounds[a].x =  backgrounds[a].constWidth * (backgrounds[a].internalIdx + 0.5)
                      -- adjust actual content width
                      backgrounds[a].x = backgrounds[a].x  - (displayActualContentWidth - display.contentWidth) /2
                  end
               else   
                backgrounds[a].alpha = 0
              end
          end  
         end


         for a = 1, ob.foregrounds.numChildren, 1 do

            if (ob.foregrounds[a].level)  then            
               if (ob.foregrounds[a].level == gameStatus.level ) then
                 ob.foregrounds[a].alpha = 1
                  
                  if (not ob.foregrounds[a].isGroup) then
                      ob.foregrounds[a].x =  ob.foregrounds[a].constWidth * (ob.foregrounds[a].internalIdx + 0.5)
                      -- adjust actual content width
                      ob.foregrounds[a].x = ob.foregrounds[a].x  - (displayActualContentWidth - display.contentWidth) /2
                  end
               else   
                ob.foregrounds[a].alpha = 0
              end
          end  
         end
    end  

    ob.enterUltraMode = function ()
        
        --commonData.playSound( sounds.perfectSpreeSound )  
        if ob.activeMusicHdl and not commonData.isMute then
          audio.pause( ob.activeMusicHdl )
        end

        for j = 1, fire.numChildren do
             if (fire[j].isEmitter and not fire[j].isOnKickEmitter) then
              fire[j]:start()
             end 
        end

        
        comments:showReward(true)     
        commonData.playSound(sounds.perfectSpreeSound2) 
        ob.ultraMusicHdl = commonData.playSound(sounds.perfectSpreeSound3) 
        ob.nextCoinPos = score +1
        ob.ultraCoinsCollected = 0
        gameStatus.isUltraMode = true
        --ultraBall.alpha = 1
        fire.alpha = 1        
        fire.y = ballon.y
        fire.x = ballon.x

        -- ultraBall.y = ballon.y
        -- ultraBall.x = ballon.x

        if (ballSkin) then             
            ballSkin.alpha = 0
        else 
             ballon.alpha = 0    
         end  

        exitUltraModeHandle = timer.performWithDelay(ULTRA_MODE_DURATION, ob.exitUltraMode, 1)
        advanceUltraModeHandle = timer.performWithDelay(1000 , advanceUltraMode, 1)

        timer.performWithDelay(50 , moveToNextLevel, 1)

        timer.performWithDelay(30 , function() 
          ob.ultraGlow.alpha =  ob.ultraGlow.alpha + 0.05
        end, 16)

        
         ultraWave.alpha = 1
        
        timer.performWithDelay(100 , function() 
         ultraWave.alpha = ultraWave.alpha - 0.015
        end, 20)

     --   ultraRect.alpha = 0.86
       
        --ultraFloor.alpha = 1
        ob.scoreFull.alpha = 1
      
        -- ultraWave:setSequence("start")
        -- ultraWave:play()

        for a = 1, obstecales.numChildren, 1 do
            if(obstecales[a].isAlive) then
          
              obstecales[a].isSensor  = true 
            end
       end
       
        -- ultraFloor:setSequence("start")
        -- ultraFloor:play()

    end

    
end

local isGoalExists = false
local  isGoalScored = false

local function getSelectedFieldIndex()
  if commonData.selectedField == "Glacier" then
    return 2
  elseif  commonData.selectedField == "Castle" then  
    return 3
  elseif  commonData.selectedField == "Desert" then
    return 4
  elseif  commonData.selectedField == "EagleField" then
    return 5
  else
    return 1
  end  
  

end 

function restartGame()

       gameStatus.forceSwap = false
      if commonData.gameData.abVersion == 1 then
        if commonData.gameData.gamesCount == 0 then
          gameStatus.forceSwap = true
        end  
      else  
        if commonData.gameData.gamesCount < 3 then
          gameStatus.forceSwap = true
        end  
      end
      
      -- commonData.gameData.abVersion = 2
      -- gameStatus.forceSwap = true
      -- TODO: save in file
      -- gameStatus.jumpOverShowed  = false
      -- gameStatus.kickOverShowed = false
       ob.obstacleArrow.alpha = 0
       collisionRect.isSensor = false
       ballon.isSleepingAllowed = false
       ob.muteButton.alpha = 0              
       ob.unMuteButton.alpha = 0   

      ob.notification.alpha = 0
      ob.redRect.alpha = 0
      ob.scoreTextMove.alpha = 0
      ob.scoreFull.alpha = 0
      ob.rightTimer.alpha = 0
      ob.leftTimer.alpha = 0

      if (ballSkin) then
              ballSkin:removeSelf()
              ballSkin = nil
      end
          
      if (commonData.selectedBall == "NormalBall") then
        ballon.alpha = 1
      else  

        ballon.alpha = 0
        ballSkin = display.newImage("balls/" .. commonData.selectedBall .. ".png")
        ballSkin.name = "ballSkin"
        ballSkin:scale(0.23,0.23)
        ballSkinGroup:insert(ballSkin)
          
      end
    --physics.setTimeStep(0)

     ob.pausedGroup.alpha = 0
    ob.scoreboardDetails.alpha = 1
--    dontForget.alpha=0
    collisionRect.isSensor = false
 
      physics.start()       
      touchIDs = {} 
      gameStatus.isGameActive = true
      gameStatus.isAnyLeg = true
      gameStatus.isGamePaused = false
      gameStatus.isConfirmationRequired = false
          
      isGoalExists = false
      gameStatus.ignoreHeader = false
       --reset the score
     score = 0
     gameStatus.newScore = 0
     gameStatus.level = getSelectedFieldIndex()

     --reset the game speed
     gameStatus.speed = 6
     
     gameStatus.inEvent=0
     ob.wasOnGround = true
     -- reset the pause button
     
     --reset the monster
     ballon.y = 10
     ballon.x = BALL_X
     ballon.angularVelocity = 0
     ballon:setLinearVelocity(0,0  ) 
     ballon.gravityScale=1
     ballon.isBullet = true

     fire.x = ballon.x
     fire.y = ballon.y
     fire.alpha = 0
     

     -- ultraBall.x = ballon.x
     -- ultraBall.y = ballon.y
     -- ultraBall.alpha = 0

     
     ob.onGround = true
     monster.isAlive = true
     monster.x = 120
     monster.y = 285
     monster.accel = 0 
     monster:setSequence("running")
     monster:play()
     
     monster.rotation = 0
     monster.kickTimer =0
     chaserRect.x = 20
     chaserRect.y = 235
     chaserRect.speed = 0
     ob.chaser.skeleton.group.x = 0
     ob.coach.skeleton.group.x = 20
     ob.bubble.skeleton.group.x = 40
     ob.bubble.skeleton.group.y = 170
     
     gameStatus.chaserLocation = -50
     gameStatus.preventJump = true
     collisionRect.width = 0
     collisionRect.x= -400
     --collisionRect.isBullet = true
     ob.jumpLeg.width=0
     ob.jumpLeg.x = 0
     
     
      
     for a = 1, blocks.numChildren, 1 do
          --blocks[a].x = (a * blocks[a].contentWidth) - blocks[a].contentWidth
          blocks[a].x = (a-2) * 82
          blocks[a].y = ob.groundLevel
          
     end

     blocks.alpha=0
     for a = 1, coins.numChildren, 1 do
          coins[a].y = 600
          coins[a].isAlive = false
          coins[a].spine:pause()
          coinsSpine[a].y = 700
          
     end
    
      for a = 1, obstecales.numChildren, 1 do
        obstecales[a].isAlive = false            
                
           obstecales[a].x =900          
       
           if (obstecales[a].name == "goal") then

               for i = 1, goal.numChildren, 1 do                  
                  goal[i].x = 900
                end
           else
      
              obstecales[a].rotation = 0
              obstecales[a]:applyTorque(0)
              obstecales[a]:setLinearVelocity( 0, 0 )
          end

          if (obstecales[a].spine) then
              obstecales[a].spine.skeleton.group.x = obstecales[a].x                                        
              obstecales[a].spine:pause()
          end
      
        
     end
     -- --reset the backgrounds
     -- clouds1.x = 240
     -- clouds1.y = 80
     -- clouds2.x = 940
     -- clouds2.y = 80

     for a = 1, backgrounds.numChildren, 1 do

          if ( backgrounds[a].backgroundStage ) then
            if (backgrounds[a].backgroundStage == "GAME") then
                  backgrounds[a].alpha= backgrounds[a].originalAlpha 
              else
                backgrounds[a].alpha=0
              end
            
          else  
            backgrounds[a].alpha= backgrounds[a].originalAlpha 
          end


          if (not backgrounds[a].isGroup) then
            backgrounds[a].x =  backgrounds[a].constWidth * (backgrounds[a].internalIdx + 0.5)

            -- adjust actual content width
            backgrounds[a].x = backgrounds[a].x  - (displayActualContentWidth - display.contentWidth) /2
          end

          if (backgrounds[a].startPos and backgrounds[a].startPos > 0 ) then
              backgrounds[a].alpha = 0
          end

           if (backgrounds[a].level) then
            if  (backgrounds[a].level ~= gameStatus.level ) then
              backgrounds[a].alpha = 0
            else  
              backgrounds[a].alpha = 1
            end  
          end
    end

     for a = 1,  ob.stageGroup.numChildren, 1 do

          if (  ob.stageGroup[a].backgroundStage ) then
            if (gameStatus.isTutorial) then
                if ( ob.stageGroup[a].backgroundStage == "TUTORIAL") then
                   ob.stageGroup[a].alpha=  ob.stageGroup[a].originalAlpha 
                else
                   ob.stageGroup[a].alpha=0
                end
            else
              if ( ob.stageGroup[a].backgroundStage == "GAME") then
                   ob.stageGroup[a].alpha=  ob.stageGroup[a].originalAlpha 
              else
                 ob.stageGroup[a].alpha=0
              end
            end
          end

          if (not  ob.stageGroup[a].isGroup) then
             ob.stageGroup[a].x =   ob.stageGroup[a].constWidth * ( ob.stageGroup[a].internalIdx + 0.5)

            -- adjust actual content width
             ob.stageGroup[a].x =  ob.stageGroup[a].x  - (displayActualContentWidth - display.contentWidth) /2
          end

          if ( ob.stageGroup[a].startPos and  ob.stageGroup[a].startPos > 0 ) then
               ob.stageGroup[a].alpha = 0
          end
    end

    for a = 1, ob.foregrounds.numChildren, 1 do

      if ( ob.foregrounds[a].backgroundStage ) then
        if (gameStatus.isTutorial) then
            if (ob.foregrounds[a].backgroundStage == "TUTORIAL") then
              ob.foregrounds[a].alpha=ob.foregrounds[a].originalAlpha
              
            else
              ob.foregrounds[a].alpha=0
            end
        else
          if (ob.foregrounds[a].backgroundStage == "GAME") then
              ob.foregrounds[a].alpha=ob.foregrounds[a].originalAlpha
          else
            ob.foregrounds[a].alpha=0
          end
        end
      end
      if (not ob.foregrounds[a].isGroup) then
        ob.foregrounds[a].x =  ob.foregrounds[a].constWidth * (ob.foregrounds[a].internalIdx + 0.5)

        -- adjust actual content width
        ob.foregrounds[a].x = ob.foregrounds[a].x  - (displayActualContentWidth - display.contentWidth) /2
      end

       if (ob.foregrounds[a].startPos and ob.foregrounds[a].startPos > 0 ) then
              ob.foregrounds[a].alpha = 0
       end

        
         if (ob.foregrounds[a].level) then
            if  (ob.foregrounds[a].level ~= gameStatus.level ) then
              ob.foregrounds[a].alpha = 0
            else  
              ob.foregrounds[a].alpha = 1
            end  
          end
    end


      if commonData.gameData.abVersion == 1 and gameStatus.forceSwap then 
      -- TODO: cahnge
        ob.getNextObstecalePos(40,3)
      else
        ob.getNextObstecalePos(10,15)
      end
      --ob.getNextObstecalePos(2,2)
      
      
      ob.getNextCoinPos(5,25)

      gameStats = {}
      gameStats.coins = 0
      gameStats.gameScore =0 
      gameStats.meters =0 
      gameStats.bounces = 0
      gameStats.swapBounces = 0 
      gameStats.bouncesPerfect = 0
      gameStats.bouncesGood = 0
      gameStats.bouncesEarly = 0
      gameStats.bouncesLate = 0
      gameStats.jumps = 0
      gameStats.combo = 0
      gameStats.finishReason = nil
      gameStats.isGoalScoredInTheGame = false
      scoreText.text = gameStatus.newScore 
      
      startGameTracking()
      leftHand.skeleton.group.alpha = 0
      rightHand.skeleton.group.alpha = 0
      ob.leftCtrl.fill.effect = nil
      ob.rightCtrl.fill.effect = nil
      ob.leftCtrl.alpha = 1           
      ob.rightCtrl.alpha = 1           

      ob.leftCtrl:setFillColor(1,1,1)
      ob.rightCtrl:setFillColor(1,1,1)
      --ob.leftCtrl:setFillColor(0,0,0)
      ob.stageGroup.maskX = 240
        ob.stageGroup.maskY = 160

      
      if(gameStatus.isTutorial) then
                

      else
        ob.updateScoreboard(0)
        multiText.text = "x1"
        ob.multiGroup.alpha = 1
        
        
        pauseButton.alpha = 0
        coinsCountText.alpha = 1 
        coinsShadowText.alpha = 1
        trophieCountText.alpha = 1 
        trophieShadowText.alpha = 1
        
        
        coinImg.alpha = 1
        trophieImg.alpha = 1

        kickToStart.alpha = 1

        ob.chaser.skeleton.group.alpha = 1
        ob.coach.skeleton.group.alpha = 1
        

           -- Start standing
          ballon.isSleepingAllowed = false
          gameStatus.speed = 0
          
          collisionRect.isSensor = false
          
          ballon.alpha = 1
          if (ballSkin) then
             ballon.alpha = 0
            ballSkin.alpha = 1
          end  

          ballon:setLinearVelocity(0,0)  
          ballon.gravityScale=0
          ballon.y = 240
       

      end

      
      local musicRnd = math.random(3)

      if (musicRnd == 1 ) then
        if ob.backgroundMusicHdl and not commonData.isMute then
          --audio.resume(ob.backgroundMusicHdl)
          audio.rewind(ob.backgroundMusicHdl)
          audio.resume(ob.backgroundMusicHdl)
          ob.activeMusicHdl = ob.backgroundMusicHdl
        end
      elseif (musicRnd == 1 ) then
        if ob.backgroundMusicHdl2 and not commonData.isMute then
          --audio.resume(ob.backgroundMusicHdl)
          audio.rewind(ob.backgroundMusicHdl2)
          audio.resume(ob.backgroundMusicHdl2)
          ob.activeMusicHdl = ob.backgroundMusicHdl2
        end
      else
        if ob.backgroundMusicHdl3 and not commonData.isMute then
          --audio.resume(ob.backgroundMusicHdl)
          audio.rewind(ob.backgroundMusicHdl3)
          audio.resume(ob.backgroundMusicHdl3)
          ob.activeMusicHdl = ob.backgroundMusicHdl3
        end
      end   
      
       
      
      gameStatus.firstStage = mRandom(80 ) + 80
      gameStatus.secondStage = gameStatus.firstStage + mRandom(80 ) + 70

      gameStatus.isStaticBall = true

 --     gameStatus.sombreroCount = 0
      consecutivePerfects = 0
      gameStatus.kicksMulti  = 0
      gameStatus.sreeCount = 0
      hero:reload()
      hero:init()
      hero:cancelKick()
      hero:stand(true)
      
      ob.chaser:init()
      ob.chaser:stand()

      ob.coach:init()
      ob.coach:stand()

       ob.bubble:init()


      ob.exitUltraMode()
      
     
      
     for a = 1, dirt.numChildren, 1 do
        dirt[a].isAlive = false
        dirt[a].x = -300
             
     end 

      timer.resume(gameStatus.mainTimer)
    
    end


-- "scene:show()"
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
      
       if commonData.selectedSkin == "Shakes" then
          sounds.jumpSound  = audio.loadSound( "sounds/players/ShakesJump01.mp3" )
          sounds.heroFallSound  = audio.loadSound( "sounds/players/ShakesFall01.mp3" )
          
        elseif commonData.selectedSkin == "CoolJoe" then
          
          sounds.jumpSound  = audio.loadSound( "sounds/players/CoolJoeJump01.mp3" )
          sounds.heroFallSound  = audio.loadSound( "sounds/players/CoolJoeFall01.mp3" )
        elseif commonData.selectedSkin == "ElMatador" then
          sounds.jumpSound  = audio.loadSound( "sounds/players/ElMatadorJump01.mp3" )
          sounds.heroFallSound  = audio.loadSound( "sounds/players/ElMatadorFall01.mp3" )
        elseif commonData.selectedSkin == "Klaus" then
          sounds.jumpSound  = audio.loadSound( "sounds/players/KlausJump01.mp3" )
          sounds.heroFallSound  = audio.loadSound( "sounds/players/KlausFall01.mp3" )
        elseif commonData.selectedSkin == "NorthShaw" then
          sounds.jumpSound  = audio.loadSound( "sounds/players/NorthShawJump01.mp3" )
          sounds.heroFallSound  = audio.loadSound( "sounds/players/NorthShawFall01.mp3" )
        elseif commonData.selectedSkin == "TwistingTiger" then
          sounds.jumpSound  = audio.loadSound( "sounds/players/TigetJump01.mp3" )
          sounds.heroFallSound  = audio.loadSound( "sounds/players/TigetFall01.mp3" )
        elseif commonData.selectedSkin == "Blok" then
          
        elseif commonData.selectedSkin == "BigBo" then

        elseif commonData.selectedSkin == "Rasta" then
          sounds.jumpSound  = audio.loadSound( "sounds/players/RastaJump01.mp3" )     
          sounds.heroFallSound  = audio.loadSound( "sounds/players/RastaFall01.mp3" )     
        elseif commonData.selectedSkin == "ElMatador" then  
          
          sounds.jumpSound  = audio.loadSound( "sounds/players/ElMatadorJump01.mp3" ) 
          sounds.heroFallSound  = audio.loadSound( "sounds/players/ElMatadorFall01.mp3" )         
        end

          local boostersConfig = require( "boostersConfig" )

         if not boostersConfig[commonData.selectedBooster]then
          commonData.selectedBooster = "ultraBall"
         end

         if not fire.boosterName  or fire.boosterName ~= commonData.selectedBooster then
              for j = 1, fire.numChildren do
                 if (fire[1]) then
                  fire[1]:removeSelf()
                 end 
              end

              --local selectedBooster = "ultraBall"
              
              for i=1,#boostersConfig[commonData.selectedBooster] do
                print("create emittr")
                local boostConf = boostersConfig[commonData.selectedBooster][i]
                if boostConf.duration and boostConf.duration == -1 then
                  boostConf.duration = ULTRA_MODE_DURATION / 1000
                end  
                
                local emitter = display.newEmitter( boostConf )
                --emitter:scale(0.005,0.005)
                emitter:stop()
                emitter.isOnKickEmitter = boostersConfig[commonData.selectedBooster][i].onKick
                emitter.isEmitter = true
                fire:insert( emitter )
                print("finish emittr")
              end

              local ultraBallImg  = "images/UltraBall.png"
              if boostersConfig.ultraBallsImgs[commonData.selectedBooster] then
                ultraBallImg = boostersConfig.ultraBallsImgs[commonData.selectedBooster] 
              end  

              ultraBall = display.newImage(ultraBallImg)
              ultraBall.name = "fire"
              ultraBall.isEmitter = false

              ultraBall:scale(0.5,0.5)
              
              ultraBall.isFixedRotation = true

              fire:insert( ultraBall )

         end 
         fire.boosterName = commonData.selectedBooster

    
   elseif ( phase == "did" ) then


        local function startGravity()
          
              ballon.x = BALL_X
              fire.x = BALL_X
              ballon.gravityScale=1
              ballon:setLinearVelocity(0,20)  
              fire.gravityScale=1
              fire:setLinearVelocity(0,20)  

              -- ultraBall.gravityScale=1
              -- ultraBall:setLinearVelocity(0,20)  
              -- ultraBall.x = BALL_X
         end 

        ob.wasOnGround = true
        
        local additionalCount = nil
        local function setCoinsCount(e)

          coinsShadowText.text = ob.coinsCount
          coinsCountText.text =  ob.coinsCount

          if (additionalCount) then

            coinsShadowText.text = ob.coinsCount .. "   +" .. additionalCount
            coinsCountText.text =  ob.coinsCount .. "   +" .. additionalCount

          end

          -- local playerLevel = string.format("%.00f", commonData.getLevel()) 
          -- trophieShadowText.text = playerLevel
          -- trophieCountText.text =  playerLevel

          trophieShadowText.text = commonData.gameData.packs
          trophieCountText.text =  commonData.gameData.packs


        end 


          if(event.params ) then
           
          end
        

        if(event.params and event.params.gameData) then
             ob.coinsCount = commonData.gameData.coins  
             setCoinsCount()

             gameStatus.isTutorial = event.params.isTutorial
             ob.tutorialStage = START_TUTORIAL_STAGE
        end

    local function getObstecaleIndexes()
      local newIndexes = {}
      local goalRnd = mRandom(100)

      if (goalRnd < P_GOAL and not isGoalExists) then
          newIndexes[1] = ob.GOAL_INDEX
          isGoalExists = true  
      elseif (score > EASY_MODE_LENGTH) then
        -- 5 normal obs + 3 logical index for compund - bird + kid
        local rnd = mRandom(8)
        --if (rnd <= 6) then 
          newIndexes[1] = rnd
        -- else  
        --   newIndexes[1] =  mRandom(2)
        --   newIndexes[2] = ob.BIRD_INDEX -- bird idx
        --  end  
      else

        local totalProbability =  P_BANANA + P_CAN + P_BIRD + P_DOG + P_KID  + P_TALL_KID + P_BIRD_DOG + P_BIRD_KID  
        local easyRnd = mRandom(totalProbability)


        if (easyRnd <= P_BANANA) then
          newIndexes[1]  = ob.CONE_INDEX
        elseif  (easyRnd <= P_BANANA + P_CAN) then
          newIndexes[1]  = ob.CAN_INDEX
        elseif  (easyRnd <= P_BANANA + P_CAN + P_BIRD) then
          newIndexes[1]  = ob.BIRD_INDEX
        elseif  (easyRnd <= P_BANANA + P_CAN + P_BIRD + P_DOG) then
          newIndexes[1]  = ob.DOG_INDEX
        elseif  (easyRnd <= P_BANANA + P_CAN + P_BIRD + P_DOG + P_KID) then
          newIndexes[1]  = ob.KID_INDEX
        elseif  (easyRnd <= P_BANANA + P_CAN + P_BIRD + P_DOG + P_KID + P_TALL_KID) then
          newIndexes[1]  = ob.TALL_KID_INDEX
        elseif  (easyRnd <= P_BANANA + P_CAN + P_BIRD + P_DOG + P_KID + P_TALL_KID + P_DOUBLE_KID) then
          newIndexes[1]  = ob.DOUBLE_KIDS_INDEX
        elseif  (easyRnd <= P_BANANA + P_CAN + P_BIRD + P_DOG + P_KID + P_TALL_KID + P_DOUBLE_KID + P_BIRD_DOG) then
          newIndexes[1] = ob.DOG_INDEX
      --    newIndexes[2] = ob.BIRD_INDEX -- bird idx      
        elseif  (easyRnd <= P_BANANA + P_CAN + P_BIRD + P_DOG + P_KID + P_TALL_KID + P_DOUBLE_KID + P_BIRD_DOG +  P_BIRD_KID) then  
          newIndexes[1] = ob.KID_INDEX
        --  newIndexes[2] = ob.BIRD_INDEX -- bird idx      
        
        end  

        

      end

--newIndexes[1] = 6
      return newIndexes
      
    end  

    

    local function achivmentAlert(achName)
      
      if (not gameStatus.isTutorial) then
        if (unlockAchivment(achName)) then
          --kickPos.text = achName
          -- popup
        end
      end
    end

    local function activateObstecale( obsIndex , pIsCombo , newX)
      
         obstecales[obsIndex].isAlive = true 

         if (obstecales[obsIndex].name=="goal") then
            
            ob.goalNet.x = newX + 55
            ob.goalDummy.x = newX + 55

            local newY = mRandom(100)
            
            ob.goalNet.y = newY + 30
            ob.goalDummy.y = newY



         else
             obstecales[obsIndex].isSensor  = gameStatus.isUltraMode
              obstecales[obsIndex].x = newX
              obstecales[obsIndex].isCombo = pIsCombo

             if (obstecales[obsIndex].name=="cone" or obstecales[obsIndex].name=="trash"  ) then
              --obstecales[obsIndex].y=275
              obstecales[obsIndex].y = ob.groundLevel -  obstecales[obsIndex].contentHeight / 2

             -- elseif (obstecales[obsIndex].name=="bird") then
             --    if (obsIndex == 1 ) then
             --          obstecales[obsIndex].y= 20 + mRandom(100)
             --    else
             --        obstecales[obsIndex].y=mRandom(50)
             --    end  
              
             else -- defenders 

               obstecales[obsIndex].y = 273 - obstecales[obsIndex].height / 2
               --obstecales[obsIndex]:setSequence("running");
               --obstecales[obsIndex]:play()
             end 

        end

       if (obstecales[obsIndex].spine) then
        

          obstecales[obsIndex].spine.skeleton.group.x = obstecales[obsIndex].x --+ obstecales[obsIndex].spine.width

          if (obstecales[obsIndex].name=="bird") then
            obstecales[obsIndex].spine.skeleton.group.y = obstecales[obsIndex].y + 30 
            obstecales[obsIndex].spine.skeleton.group.x = obstecales[obsIndex].x - 15 
          elseif (obstecales[obsIndex].name=="goal") then
                obstecales[obsIndex].spine.skeleton.group.x = ob.goalNet.x                                          
                obstecales[obsIndex].spine.skeleton.group.y = ob.goalNet.y - 30 

                isGoalScored = false
          else
            obstecales[obsIndex].spine.skeleton.group.y = obstecales[obsIndex].y + obstecales[obsIndex].height  /2
          end
          obstecales[obsIndex].spine:init()
      end

    end


    local function checkEvent()
         --first check to see if we are already in an event, we only want 1 event going on at a time
         if(gameStatus.eventRun > 0) then
              --if we are in an event decrease eventRun. eventRun is a variable that tells us how
              --much longer the event is going to take place. Everytime we check we need to decrement
              --it. Then if at this point eventRun is 0 then the event has ended so we set inEvent back
              --to 0.
              gameStatus.eventRun = gameStatus.eventRun - 1
              if(gameStatus.eventRun == 0) then
                   gameStatus.inEvent = 0
              end
         end
         --if we are in an event then do nothing
         if(gameStatus.inEvent > 0 and gameStatus.eventRun > 0) then
              --Do nothing
         else
              --if we are not in an event check to see if we are going to start a new event. To do this
              --we generate a random number between 1 and 100. We then check to see if our 'check' is
              --going to start an event. We are using 100 here in the example because it is easy to determine
              --the likelihood that an event will fire(We could just as easilt chosen 10 or 1000).
              --For example, if we decide that an event is going to
              --start everytime check is over 80 then we know that everytime a block  is a 20%
              --chance that an event will start. So one in every five blocks should start a new event. This
              --is where you will have to fit the needs of your game.
              local check = mRandom(100)
     
              --this first event is going to cause the elevation of the ground to change. For this game we
              --only want the elevation to change 1 block at a time so we don't get long runs of changing
              --elevation that is impossible to pass so we set eventRun to 1.
              if(check > 80 and check < 99) then
                   --since we are in an event we need to decide what we want to do. By making inEvent another
                   --random number we can now randomly choose which direction we want the elevation to change.
                   gameStatus.inEvent = mRandom(10)
                   gameStatus.eventRun = 1
              end

              if (score == ob.nextCoinPos) then
                      gameStatus.inEvent = 14
                      gameStatus.eventRun = 1
                      ob.getNextCoinPos(10 ,10)

              end
                        --the more frequently you want events to happen then
              --greater you should make the checks
              if(score == ob.nextObsecalePos) then
                      gameStatus.inEvent = 12
                      gameStatus.eventRun = 1

                   
                      local nextObstecaleRnd =  mRandom(10)
                      if (score < gameStatus.firstStage) then
                        if (nextObstecaleRnd >2 ) then
                          ob.getNextObstecalePos(8 ,4)
                        else
                          ob.getNextObstecalePos(6 , 6 )
                        end  
                      elseif (score < gameStatus.secondStage) then
                        if (nextObstecaleRnd > 5 ) then
                          ob.getNextObstecalePos(8 ,4)
                        else
                          ob.getNextObstecalePos(5 , 5 )
                        end
                      elseif (score < 400) then
                        if (nextObstecaleRnd > 8 ) then
                          ob.getNextObstecalePos(8 ,4)
                        else
                          ob.getNextObstecalePos(4 , 4 )
                        end
                      else 
                        if (nextObstecaleRnd > 8 ) then
                          ob.getNextObstecalePos(6 ,4)
                        else
                          ob.getNextObstecalePos(4, 3 )
                        end 
                      end  
              
              end
         end
        
    end

    local function initAdditionalCoins()      
    
      additionalCount = nil
      setCoinsCount(nil)
    end
    
    local function reportChallenge(challengeId )
      
      -- check if the cahllenge is new
      if not gameStatus.isTutorial and unlockChallenge(challengeId) then

        -- show notification and add coins
        local newChallenge = getChallengeByID(challengeId)
        if newChallenge and newChallenge.coins then

           commonData.playSound(sounds.challengeUnlockedSound)
           local addCoins = newChallenge.coins
            
           ob.coinsCount = ob.coinsCount + addCoins

           additionalCount = addCoins
          
           timer.performWithDelay(4000, initAdditionalCoins, 1)
           gameStats.coins = gameStats.coins + addCoins

           setCoinsCount(nil)

           newChallegeText.text = newChallenge.text

           timer.performWithDelay(4000, 
            function ()
              newChallengeGroup.alpha = 0
            end, 1)
           newChallengeGroup.alpha = 1
        end  

      end  


    end 
   
    local function updateBlocks()

          if ballon.x > BALL_X + 1 then
            ballon.x = ballon.x - 1
          elseif ballon.x < BALL_X -1 then
            ballon.x = ballon.x + 1  
          end 

          if ballon.y > 250 then
            gameStatus.speed   = gameStatus.speed - gameStatus.speed/100

            if (gameStatus.speed < MIN_SPEED - 1) then
              gameStatus.speed = MIN_SPEED -1 
            end

             hero:setWalkSpeed(gameStatus.speed)
            
           

            if ob.redRect.alpha < 0.6 then
              ob.redRect.alpha = ob.redRect.alpha + 0.01
            end
          end   

          



          if  gameStatus.shakeamount > 0 then
              local shake = math.random( gameStatus.shakeamount )
              sceneGroup.x =  math.random( -shake, shake )
              sceneGroup.y =  math.random( -shake, shake )
              gameStatus.shakeamount = gameStatus.shakeamount - 1
          end

          if  gameStatus.shakeamount2 > 0 then
              local shake2 = math.random( math.floor( gameStatus.shakeamount2 /2) +1  )
              
              ob.multiGroup.x =  math.random( -shake2, shake2 )
              ob.multiGroup.y =  math.random( -shake2, shake2 )
              gameStatus.shakeamount2 = gameStatus.shakeamount2 - 1
          
          end

          
          
          local shadowScale = SHADOW_MAX_SCALE *  (1 - ((ob.shadow.y  - ballon.y  ) / ob.shadow.y))

                    --shadow:scale(shadowScale,shadowScale)
          ob.shadow.xScale = shadowScale
          ob.shadow.yScale = shadowScale

          local newX = 0
        
         for a = 1, blocks.numChildren, 1 do
              if(a > 1) then
                   newX = (blocks[a - 1]).x + blocks[a].contentWidth
              else
                   newX = (blocks[blocks.numChildren]).x + blocks[a].contentWidth - gameStatus.speed
              end
              if((blocks[a]).x < -60 - (displayActualContentWidth - display.contentWidth) /2) then
                   
                   (blocks[a]).x, (blocks[a]).y = newX, ob.groundLevel

                   if (not gameStatus.isTutorial) then


                    local dirtIndex = mRandom(30)
                    if (dirtIndex <= dirt.numChildren and dirtIndex >0) then


                      if (not dirt[dirtIndex].isAlive) then

                          dirt[dirtIndex].isAlive = true
                          dirt[dirtIndex].x = newX + 40
                          dirt[dirtIndex].y = ob.groundLevel
                          dirt[dirtIndex].alpha = 1
                      end
                    end  

                  
                    

                    score = score + 1
                    if ob.redRect.alpha < 0.03 then
                      gameStatus.newScore = gameStatus.newScore  + gameStatus.speed * (gameStatus.kicksMulti +1)
                      scoreText.text = string.format("%.00f", gameStatus.newScore) 
                    end
                    
                    
                   end

                   if (score % 20 == 0 and score > 50  ) then
                      chaserRect.speed = chaserRect.speed + REFEREE_ACCELERATION
                      if (chaserRect.speed > REFEREE_MAX_SPEED ) then
                        chaserRect.speed = REFEREE_MAX_SPEED
                      end  
                     
                    end

                    if (score == 10) then
                      reportChallenge("reacehedMeters10")
                    elseif (score == 20) then  
                      reportChallenge("reacehedMeters20")
                    elseif (score == 50) then
                      reportChallenge("reacehedMeters50")
                      achivmentAlert("LittleBolt")
                    elseif (score == 60 and gameStats.jumps == 0) then    
                       reportChallenge("noJump60")
                    elseif (score == 100) then  
                      reportChallenge("reacehedMeters100")
                      achivmentAlert("LittleBigBolt")
                       --commonData.playSound( sounds.transitionSound )   
                    elseif (score == 150) then  
                      reportChallenge("reacehedMeters150")
                    elseif (score == 200) then    
                      achivmentAlert("PiniBalili")
                      reportChallenge("reacehedMeters200")
                      --commonData.playSound( sounds.transitionSound )   
                     elseif (score == 300) then                          
                      reportChallenge("reacehedMeters300")  
                    end
                   
                    
                   --by setting up the cones this way we are guaranteed to
                   --only have 3 cones out at most at a time.

                   --if (not isObstecaleAlive and inEvent == 12) then
                   if (gameStatus.inEvent == 12) then
                    
                           local obsIndexs = getObstecaleIndexes()

                           local skipCompund =false

                           for index, obsIndex in pairs( obsIndexs ) do
                          
                                 for i=1,4 do                                 
                                  -- todo: 70 
                                   if (obstecales[obsIndex].isAlive or (score < 70 and obstecales[obsIndex].isHard)) then
                                      obsIndex = obsIndex - 1
                                      if ( obsIndex == 0) then
                                        obsIndex = 4
                                      end 

                                      skipCompund = true
                                   else
                                    break
                                   end
                                 end

                                  if (obstecales[obsIndex].isAlive) then
                                      -- all obstecales are live
                                      
                                      break
                                  end  
                                 if (index >1 and skipCompund) then
                                  break
                                 end
                                  activateObstecale(obsIndex, (#obsIndexs == 2),newX)
                               
                            end

                    end
                             -- create new coin
                    if(gameStatus.inEvent == 14) then
                           for a=1, coins.numChildren, 1 do
                               if(coins[a].isAlive == true) then
                                   --do nothing
                               else
                                   coins[a].isAlive = true
                                   coins[a].isEnabled = true
                                   coins[a].y = mRandom(200)
                                   coins[a].x = newX
                                   coins[a].ultra  = gameStatus.isUltraMode
                                   
                                   coinsSpine[a].y = coins[a].y
                                   coinsSpine[a].x = coins[a].x
                                   coins[a].spine:init()

                                   local multiCoinsRnd = mRandom(100)
                                  -- local multiCoinsRnd = 100

                                   if (multiCoinsRnd > 94 and a < 3 and not gameStatus.isUltraMode) then
                                     coins[a+1].isAlive = true
                                     coins[a+1].y = mRandom(200)
                                     coins[a+1].x = newX + mRandom(100) 
                                     coins[a+1].isEnabled = true

                                     coinsSpine[a + 1].y = coins[a +1].y
                                     coinsSpine[a + 1].x = coins[a + 1].x
                                     coins[a + 1].spine:init()

                                     if (multiCoinsRnd > 99 and a < 2) then
                                        coins[a+2].isAlive = true
                                       coins[a+2].y = mRandom(200)
                                       coins[a+2].x = coins[a+1].x + mRandom(100) 
                                       coins[a+2].isEnabled = true

                                       coinsSpine[a + 2].y = coins[a + 2].y
                                       coinsSpine[a + 2].x = coins[a + 2].x
                                       coins[a + 2].spine:init()

                                     end 
                                   end

                                   break
                               end
                           end
                   end

                   checkEvent()
              else
                   (blocks[a]):translate(gameStatus.speed * -1, 0)
              end
         end
    end


    local function pauseBall( )
      monster.kickTimer = 0
      gameStatus.preventJump = true
      gameStatus.speed = 0
      chaserRect.speed = 0
      touchIDs = {}
      hero:cancelKick()
      hero:stand(true)

      gameStatus.isStaticBall = true
      
      ob.chaser:init()
      ob.chaser:stand()

       ob.coach:init()
      ob.coach:stand()
       ob.bubble:init()

      collisionRect.isSensor = false

     ballon.angularVelocity = 0
     ballon:setLinearVelocity(0,0  ) 
     ballon.gravityScale=0
     ballon.isBullet = true
     ballon.isSleepingAllowed = false

    end 

    local function handleFisrtObstacle( )
      monster.kickTimer = 0
     gameStatus.isConfirmationRequired = true
      gameStatus.speed = 0
      chaserRect.speed = 0
      touchIDs = {}
      hero:cancelKick()
      hero:stand(true)

      gameStatus.isStaticBall = true
      
      ob.chaser:init()
      ob.chaser:stand()

       ob.coach:init()
      ob.coach:stand()
       ob.bubble:init()




      collisionRect.isSensor = false

     ballon.angularVelocity = 0
     ballon:setLinearVelocity(0,0  ) 
     ballon.gravityScale=0
     ballon.isBullet = true
     ballon.isSleepingAllowed = false

    ob.boosterMsg:init()  

    timer.performWithDelay(100 , function ()                          
       ob.notification.alpha = 1
     end , 1)     
       
     
    
    ob.boosterButton.alpha = 0
    ob.kickOverImg.alpha = 0
    ob.jumpOverImg.alpha = 0
    ob.tipCircle.alpha = 0
    
    gameStatus.isAnyLeg = true
    gameStatus.ignoreClick = true
    end 
    
    --check to see if the cones are alive or not, if they are
    --then update them appropriately
    local function updateObstecales()

        
        for a = 1, obstecales.numChildren, 1 do
            if(obstecales[a].isAlive == true) then

             
              if (obstecales[a].name == "goal") then
                for i = 1, goal.numChildren, 1 do                  
                  (goal[i]):translate(gameStatus.speed * -1, 0)
                end

                if(ob.goalNet.x < -240) then
                  goal.isAlive = false

                end
              else  
                
                (obstecales[a]):translate(gameStatus.speed * -1, 0)
                if(obstecales[a].x < -120) then
                    obstecales[a].x = 900
                    obstecales[a].y = 500
                    obstecales[a].isAlive = false

                    
                     if (obstecales[a].spine) then
                              obstecales[a].spine:pause()
                     end

                end

                if gameStatus.isGameActive then
                      if ( obstecales[a].name == "defender" ) then
                         if((obstecales[a].x <= monster.x) and (obstecales[a].x >= monster.x - gameStatus.speed) and ob.onGround ) then
                             
                             gameStatus.sombreroCount =  gameStatus.sombreroCount + 1

                             if (gameStatus.sombreroCount >= 10) then
                              achivmentAlert("MasterLaSombrero")                        
                             elseif (gameStatus.sombreroCount >= 6) then
                              achivmentAlert("BigMexican") 
                             elseif (gameStatus.sombreroCount >= 2) then
                              achivmentAlert("LittleMexican") 
                             end

                           
                          end 

                        
                        
                        if (not gameStatus.isTutorial and not commonData.gameData.kickOverShowed 
                                and obstecales[a].x > 260 and obstecales[a].x < 300) then                              

                               handleFisrtObstacle()                               
                               commonData.gameData.kickOverShowed = true
                               ballon.y = 240
                               ballon.x = BALL_X                         
                               gameStatus.preventJump = true

                              timer.performWithDelay(1500 , function ()                          
                                ob.kickOverImg.alpha = 1
                              end , 1)
                              timer.performWithDelay(2500 , function ()
                                ob.boosterButton.alpha = 1                          
                              end , 1)
                        end        
                      end 


                      if (not gameStatus.isTutorial and (obstecales[a].name == "trash" or obstecales[a].name == "cone"
                          or obstecales[a].name == "bird"))  then

                          if (not commonData.gameData.jumpOverShowed and obstecales[a].x > 200 and obstecales[a].x < 220) then
                              
                               handleFisrtObstacle()                               
                               commonData.gameData.jumpOverShowed = true
                               ballon.y = 120
                               ballon.x = BALL_X       
                               gameStatus.preventKick = true

                               leftHand:init()
                               rightHand:init()
                               
                              timer.performWithDelay(1500 , function ()                          
                                ob.jumpOverImg.alpha = 1
                                leftHand.skeleton.group.alpha = 1
                               rightHand.skeleton.group.alpha = 1
                               leftHand:tapLeft()
                               rightHand:tapRight()

                              end , 1)
                              timer.performWithDelay(2500 , function ()
                                ob.boosterButton.alpha = 1                          
                              end , 1)
                        end        

                         if (obstecales[a].x < 380) then
                            ob.obstacleArrow.x = obstecales[a].x
                            ob.obstacleArrow.alpha = 1
                         end

                         if (obstecales[a].x <= -50) and (obstecales[a].x >= -50 - gameStatus.speed ) and gameStatus.isGameActive then

                            reportChallenge("jumpObstecale")
                             ob.obstacleArrow.alpha = 0
                        end
                      end
                    end
              end                    

             if (obstecales[a].spine) then
                      obstecales[a].spine.skeleton.group:translate(gameStatus.speed * -1, 0)
                      
             end

          end
        end -- obsteacales loop

        
    end


    local function updateCoins()
        for a = 1, coins.numChildren, 1 do
            if(coins[a].isAlive == true) then
                (coins[a]):translate(gameStatus.speed * -1, 0)
                coinsSpine[a].x =  coins[a].x

                if(coins[a].x < -80) then
                    coins[a].x = 900
                    coins[a].y = 500
                    coins[a].isAlive = false
                    coins[a].spine:pause()
                end
            end
         end
    end

 
    local function updateReferee()
        if (gameStatus.isGameActive and not gameStatus.isTutorial) then
            local prevX =  gameStatus.chaserLocation
            local gap = chaserRect.speed - gameStatus.speed 
             if ( prevX >= 10 and chaserRect.speed > gameStatus.speed  ) then 
                gap  = gap / 2
             end

             gameStatus.chaserLocation = gameStatus.chaserLocation + gap
          
            if (gameStatus.chaserLocation< -200) then
              gameStatus.chaserLocation = -200
            end  
            
            if (gameStatus.chaserLocation < 0  and prevX >= 0 ) then 

              ob.chaser:walk()

              reportChallenge("runFromBully")
            elseif (gameStatus.chaserLocation >= 0  and prevX < 0 ) then 
              ob.chaser:chase()
              commonData.playSound(sounds.lookoutSound)
              
            end  

            if (display.screenOriginX - 200 > gameStatus.chaserLocation) then
              ob.chaser.skeleton.group.x = display.screenOriginX    - 200        
            else
              ob.chaser.skeleton.group.x = gameStatus.chaserLocation
            end
            chaserRect.x = 80 +  ob.chaser.skeleton.group.x
        end     
    end

    local wasActive = false
    local function updateKids()

       
            if (not gameStatus.isGameActive and wasActive) then

              for a = 1, obstecales.numChildren, 1 do
                  if (obstecales[a].name == "defender"  and obstecales[a].isAlive) then
              
                    if (obstecales[a].spine) then
                        obstecales[a].spine.skeleton.group.x = obstecales[a].x                                        
                        obstecales[a].spine:fail()
                    end
                  end
                  
               end

            end     

            wasActive = gameStatus.isGameActive
        end

    local function moveElements(backgrounds)
       for a = backgrounds.numChildren,1 , -1 do

       
            if (not backgrounds[a].isGroup and backgrounds[a].speedFactor and 
              (not backgrounds[a].level  or backgrounds[a].level ==  gameStatus.level) ) then  

             
                   if (backgrounds[a].startPos == score + 1 and (backgrounds[a].isShowOnce or backgrounds[a].showAndRotate ) ) then

                    backgrounds[a].x = displayActualContentWidth +  backgrounds[a].constWidth * (backgrounds[a].internalIdx + 0.5)
                    backgrounds[a].alpha = backgrounds[a].originalAlpha

                    backgrounds[a].finishEntrance = false
                   end 

                   if backgrounds[a].showAndRotate and not backgrounds[a].finishEntrance  then                
                     backgrounds[a].x = backgrounds[a].x - (gameStatus.speed) 

                     if (backgrounds[a].internalIdx == 0) then

                        
                        if backgrounds[a].x - backgrounds[a].constWidth/2  <  -1 * (displayActualContentWidth - display.contentWidth) /2 then
                          
                          backgrounds[a].finishEntrance = true

                          for i=1,backgrounds[a].groupCount -1  do
                            backgrounds[a+i].finishEntrance = true
                          end
                        end  
                     end 
                   else
                    
                    backgrounds[a].x = backgrounds[a].x - (gameStatus.speed / backgrounds[a].speedFactor ) 
                   end


                  if(backgrounds[a].x < backgrounds[a].constWidth * (-0.5)  - (displayActualContentWidth - display.contentWidth) /2 ) then
                      

                      if (backgrounds[a].internalIdx == 0) then
                        backgrounds[a].x = backgrounds[a + backgrounds[a].groupCount - 1].x + backgrounds[a].constWidth -5 - (gameStatus.speed / backgrounds[a].speedFactor ) 
                      else
                        backgrounds[a].x = backgrounds[a-1].x + backgrounds[a].constWidth - 5 - (gameStatus.speed / backgrounds[a].speedFactor ) 
                      end  
                      -- backgrounds[a].x  = backgrounds[a].constWidth * (mFloor(display.contentWidth/backgrounds[a].constWidth) + 1.5) -
                      --                        ( backgrounds[a].constWidth * (-0.5) - backgrounds[a].x  - 2)   - (displayActualContentWidth - display.contentWidth) /2

                       
                        if (backgrounds[a].startPos ) then
                          if backgrounds[a].startPos <= score and score < backgrounds[a].endPos  then
                            backgrounds[a].alpha = backgrounds[a].originalAlpha
                          else    
                            backgrounds[a].alpha = 0
                          end
                        end                               
                    
                  end             
            end
          end

    end

    local function updateBackgrounds()
    --far background movement
              
           for a = 1, dirt.numChildren, 1 do
               if (dirt[a].isAlive and gameStatus.speed >6) then
                    
                    dirt[a].alpha = 0.2
                    dirt[a].x =  dirt[a].x - gameStatus.speed * 3

                    if (dirt[a].x  < -100) then
                        dirt[a].isAlive = false
                    end
                else   
                  dirt[a].alpha = 0
                end  
           end 

          moveElements(backgrounds)         
          moveElements(ob.stageGroup)  
          moveElements(ob.foregrounds)        

    end
  

     
    
gameStatus.isGameActive = true
    
    ob.stopGameElements =  function () 

     setCoinsCount()
     gameStatus.isGameActive = false
                       --this simply pauses the current animation
                        monster:pause()
                        gameStatus.speed = 0
        timer.pause(gameStatus.mainTimer)
        hero:pause()
        ob.chaser:pause()
        ob.coach:pause()
        
        --comments:pause()
        
        ob.obstacleArrow.alpha = 0
        pauseButton.alpha = 0
        physics.pause()
         gameStats.gameScore = tonumber(string.format("%.00f", gameStatus.newScore)  )  
         gameStats.meters = tonumber(string.format("%.00f", score)  )  
         audio.pause( ob.activeMusicHdl )

         if ob.ultraMusicHdl then
           audio.pause( ob.ultraMusicHdl )
           ob.ultraMusicHdl  = nil
         end 

         if (exitUltraModeHandle) then
           timer.cancel( exitUltraModeHandle )
           exitUltraModeHandle = nil
         end 

        for a = 1, obstecales.numChildren, 1 do

                  if (obstecales[a].spine and obstecales[a].isAlive) then
                      obstecales[a].spine.skeleton.group.x = obstecales[a].x                                        
                      obstecales[a].spine:pause()
                  end                      
          end
    end

    local function stopGame()
          
          --commonData.playSound( sounds.heroFallSound )
          -- if 1==1 then   
          --   return
          -- end
         if (gameStatus.prevScore1 >= 50 and gameStatus.prevScore2 >= 50 and score >= 50) then  
           reportChallenge("topScore350")   
           --print("LittlePerformer")
         end   
         if (gameStatus.prevScore1 >= 100 and gameStatus.prevScore2 >= 100 and score >= 100) then  
           reportChallenge("topScore3100")   
           achivmentAlert("LittlePerformer")   
           --print("LittlePerformer")
         end

         ob.obstacleArrow.alpha = 0 
         gameStatus.prevScore2 = gameStatus.prevScore1 
         gameStatus.prevScore1 = score  

         if not gameStats.isGoalScoredInTheGame then
            gameStatus.goalInARow = 0 
         end   

         if commonData.gameData.totalScore + score >= 42195 then

          reportChallenge("marathon")
         end 

         ob.stopGameElements()   

        local currentSceneName = composer.getSceneName( "current" )
        
         if ( currentSceneName== "game" ) then

                ob.scoreboardDetails.alpha = 0
                local gameOverScene = composer.getScene( "gameOver"  )

                if (gameOverScene) then

                  --print("REUSE SCENE")
                 gameOverScene:outerRefreshResults(gameStats)
                else

                  --print("CREATE GAME OVER")
                 local options = { isModal = false,
                                       effect = "fade",
                                       params = {results = gameStats , gameDisplay = sceneGroup}}
                 composer.showOverlay( "gameOver" , options )  
                end 

                
         end
   end
    local isFallConfirmed = false

    local function getUp()
      hero:init()

      --print("walk get up")
      hero:walk()
      gameStatus.prevStage = 0
      gameStatus.isGameActive = true
      monster.kickTimer = 0
      touchIDs = {}
      ballon.x = BALL_X

    end

    
   
    local function checkCollisions()
         ob.wasOnGround = ob.onGround
         --this is where we check to see if the monster is on the ground or in the air, if he is in the air then he can't jump(sorry no double
         --jumping for our little monster, however if you did want him to be able to double jump like Mario then you would just need
         --to make a small adjustment here, by adding a second variable called something like hasJumped. Set it to false normally, and turn it to
         --true once the double jump has been made. That way he is limited to 2 hops per jump.
         --Again we cycle through the blocks group and compare the x and y values of each.
         for a = 1, blocks.numChildren, 1 do
              if(monster.y >= blocks[a].y - 45 and blocks[a].x < monster.x + 60 and blocks[a].x > monster.x - 60) then
                   monster.y = blocks[a].y - 46
                   ob.onGround = true
                   break
              else
                   ob.onGround = false

              end
         end


         if (gameStatus.isGameActive and  (ballon.x < 0 - (displayActualContentWidth - display.contentWidth) /2    or  
                                ballon.x > display.contentWidth + (displayActualContentWidth - display.contentWidth) /2 )) then
            gameStats.finishReason = "ball out of screen"
            
            
            if (gameStatus.isTutorial) then
              --print("boooo" ..  tostring(gameStatus.isGameActive))
              getUp()

            else
              stopGame()

            end
            
         end

        
    end

    
    local function updateMonster()

        if (ballSkin) then
           ballSkin.x = ballon.x 
            ballSkin.y = ballon.y 
            ballSkin.rotation = ballon.rotation
        end

        fire.x = ballon.x         
        fire.y = ballon.y 
        -- ultraBall.x =  ballon.x 
        -- ultraBall.y =  ballon.y 

       
          
        if monster.kickTimer == 0 and not  gameStatus.isStaticBall then 
          local vx, vy = ballon:getLinearVelocity()
          if vy < 0  then
           -- ob.leftCtrl:setFillColor(1,0,0)
          else
             -- update ctrl
            local  ctrl = nil
            local  tm = nil
            
            if gameStatus.isPrevLeft  then
              ctrl = ob.rightCtrl
              tm = ob.rightTimer
              ob.leftTimer.alpha = 0
              --ob.leftCtrl:setFillColor(0,0,0)
            else  
              ctrl = ob.leftCtrl
              tm = ob.leftTimer
              ob.rightTimer.alpha = 0
              --ob.rightCtrl:setFillColor(0,0,0)
            end

            --ctrl.alpha = 0.5
            local distanceFromPerfect = 180 - ballon.y --math.abs(180 - ballon.y)
            local distanceFromPerfectAbs = math.abs(180 - ballon.y)
            tm:setFillColor(2 * (distanceFromPerfectAbs)/ (75) ,  2 * (1 - (distanceFromPerfectAbs)/ (75))  , 0)
            tm.xScale = 0.17 + distanceFromPerfect / 300
            tm.yScale = tm.xScale
            tm.alpha  = 1 - distanceFromPerfect/100


            
            if gameStatus.forceSwap and math.abs(230 - ballon.y) < 10  then
              if (commonData.gameData.abVersion == 1 and gameStats.bounces < 8) or  gameStats.bounces < 4 then
                pauseBall()
                tm:setFillColor(0,1,0)
                tm.xScale = 0.17 + 1 / 300
                tm.yScale = tm.xScale
                tm.alpha  = 1 
              end  

            end
              
            --print(distanceFromPerfect)
            -- if ob.isSimulator and distanceFromPerfect < -1000 then
            --   monster.kickTimer = 1
            --   gameStatus.lastY = 240
            --   gameStatus.startY = 240
            --   gameStatus.isLeftLeg = not gameStatus.isPrevLeft
            --   hero:startKick(gameStatus.isLeftLeg, false)
            -- end  
            
          end
        end  


                 
         --  ballon:setFillColor(2 * (distanceFromPerfect)/ (75) ,  2 * (1 - (distanceFromPerfect)/ (75))  , 0)
         --  if (ballSkin) then
         --    ballSkin:setFillColor(2 * (distanceFromPerfect)/ (75) ,  2 * (1 - (distanceFromPerfect)/ (75))  , 0)
         -- end


             --if our monster is jumping then switch to the jumping animation
         --if not keep playing the running animation
         if(monster.isAlive == true) then
         	  if (not ob.onGround) then
                  
                    if (not gameStatus.isSalta or monster.accel + monster.gravity <= 0  ) then
                      collisionRect.width = 3
                      collisionRect.x=BALL_X
                      collisionRect.y = hero:getHead().y + 255
                         local x, y = hero:getHead():localToContent( 0, 0 )
                         --print("head y: " .. y .. "  -  " .. collisionRect.y)
                      collisionRect.alpha = ob.defualtAlpha

                    else
                       local prevJumpLegY =  ob.jumpLeg.y 
                       ob.jumpLeg.x =  BALL_X -- hero:getLeftShoe().x +120
                       collisionRect.width = 0
                       collisionRect.x= -400
                     
                      
                      if (hero:getLeftShoe().y + 275 < 230) then


                       ob.jumpLeg.y = hero:getLeftShoe().y + 275
                      else
                       ob.jumpLeg.y = 230
                      
                      end 

                        
                       if (gameStatus.isGameActive and  prevJumpLegY - ob.jumpLeg.y  > 13 and 
                                      prevJumpLegY + 20 > ballon.y and ballon.y >  ob.jumpLeg.y  ) then
                          
                          --print("fixxxxxxxxxx22 ".. ob.jumpLeg.y .. " to " .. ballon.y .. " prev - " .. prevJumpLegY)
                          ob.jumpLeg.y = ballon.y

                        end
                      
                    end

                    if (gameStatus.isSalta) then
                      if (monster.accel + monster.gravity <= 0) then
                        ob.jumpLeg.y = -500
                        ob.jumpLeg.x = -500
                        ob.jumpLeg.width = 0
                      end
                        
                    else  
                           ob.jumpLeg.y = hero:getRightShoe().y + 275
                           ob.jumpLeg.x = hero:getRightShoe().x +120
               
                    end  
                    
                    ob.jumpLeg.width = 20

              else -- on ground
    	    	
           

    	           	if (not ob.wasOnGround or gameStatus.kickEnded) then
                    gameStatus.kickEnded = false
                       collisionRect.width = 0
                      collisionRect.x= -400
                        
                        ob.jumpLeg.y = -500
                        ob.jumpLeg.x = -500
                        ob.jumpLeg.width = 0

                        if gameStats.bounces > 0 and gameStatus.speed > 0 then
                          --print("walk update monster")
                          hero:walk()
                          
                          if (not ob.wasOnGround) then
                            gameStatus.isAnyLeg = true
                          end

                        end
                      
    	           end 

                 local timeoutDuration = 1

                 if IS_AUTO_KICK then
                  timeoutDuration = KICK_TIMEUOT_DURATION_AUTO
                 else
                  timeoutDuration = KICK_TIMEUOT_DURATION
                 end 
                 if ( monster.kickTimer == 1 and system.getTimer() - gameStatus.kickStart > timeoutDuration
                  and gameStatus.isGameActive  and table.maxn(touchIDs) > 0 and (not gameStatus.isTutorial or ob.tutorialStage > 5 ) ) then
                        
                                hero:fall() 
                                gameStatus.isGameActive = false
                                commonData.playSound( sounds.kickTimeoutSound )

                                 monster.kickTimer = 0    
                                 gameStatus.kickEnded = true

                                 
                                
                                    gameStats.finishReason = "fallShpagat"
                                    timer.performWithDelay(1000, stopGame, 1)
                                 
                              end
                             
                end
          
                if ( monster.kickTimer == 1 ) then

                  collisionRect.width = 3
    --             collisionRect.height = 20
                  if collisionRect.x ~= BALL_X then
                    collisionRect.x = BALL_X
                    collisionRect.y = 300
                  end
                 -- collisionRect.height = 60
                   
                      if IS_AUTO_KICK then
                       if (ob.onGround and not gameStatus.preventKick) then
                           gameStatus.lastTime =event.time                    
                           collisionRect.alpha=ob.defualtAlpha
                           
                           gameStatus.lastY =  gameStatus.lastY - 30 

                       end 
                     end

                 
                   local deltaYm = gameStatus.lastY - gameStatus.startY
                  
                  
                   local ang = -1 * deltaYm/3 -35


                   --  local distanceFromPerfect = math.abs (PERFECT_POSITION - kickRange)
                   --  if (distanceFromPerfect > 75 ) then
                   --    distanceFromPerfect = 75
                   --  end

                    
                   -- hero:setKickAngle(ang,gameStatus.isLeftLeg, distanceFromPerfect)

                   hero:setKickAngle(ang,gameStatus.isLeftLeg, distanceFromPerfect)

                   local prevLegY =  collisionRect.y
                   if (gameStatus.isLeftLeg ) then
                     collisionRect.y = hero:getLeftShoe().y   + 265-- + 30
                    else
                     collisionRect.y =  hero:getRightShoe().y + 265 --+ 30
                    end

                    if (gameStatus.isGameActive and  prevLegY - collisionRect.y  > 13 and 
                                  prevLegY + 20 > ballon.y and ballon.y >  collisionRect.y  ) then
                      
                      
                      collisionRect.y = ballon.y

                    end

                      if IS_AUTO_KICK then
                        
                       if (ob.onGround and not gameStatus.preventKick and deltaYm< -330) then

                             monster.kickTimer = 0    
                             gameStatus.kickEnded = true
                             hero:cancelKick(gameStatus.isLeftLeg)                          
                             
                       end 
                     end
                end


    --           monster.kickTimer = monster.kickTimer -1

              if(monster.accel > 0) then
                   monster.accel = monster.accel - 1
              end
              monster.y = monster.y - monster.accel
              monster.y = monster.y - monster.gravity
             
         else
              monster:rotate(5)
         end
         --update the collisionRect to stay in front of the monster
         
    end

    local endKickHandle = nil
    
     local function finishTouch()
       monster.kickTimer = 0
       gameStatus.kickEnded = true  
       endKickHandle = nil

    end       

   

    ob.touched = function ( event )
            if commonData.gameData.abVersion == 1 and gameStatus.forceSwap and  not gameStatus.isStaticBall and gameStats.bounces < 8 then
                return
            end
            
            if (gameStatus.isConfirmationRequired) then              
              return
            end  

               if ( event.phase == "ended"  ) then
                    
                       table.remove(touchIDs,table.indexOf(touchIDs, event.id))
               		   if (gameStatus.ignoreClick) then
              				gameStatus.ignoreClick = false
              		   else 

    	                  --local line = display.newLine( event.xStart, event.yStart, event.x, event.y )
    	                  --line.strokeWidth = 5
                        local assitTime = 1

                        if IS_AUTO_KICK then
                          assitTime = KICK_ASSIST_DURATION_AUTO
                        else
                          assitTime = KICK_ASSIST_DURATION
                          endKickHandle = timer.performWithDelay(assitTime,finishTouch, 1)                         
                        end
    	                  
    	               end

                     
                  end
              
                   if(event.phase == "began" and gameStatus.isGameActive and not gameStatus.isGamePaused and not gameStatus.isConfirmationRequired ) then
                         
                        
                         table.insert(touchIDs,event.id)
                         if (endKickHandle) then
                             timer.cancel( endKickHandle )   
                             hero:cancelKick(gameStatus.isLeftLeg)                          
                          end


                           --- jump
                          if (table.maxn(touchIDs) > 1 )then
                            
                                if (ob.onGround and not gameStatus.preventJump) then
                                  gameStatus.isAnyLeg = true
                                  monster.accel = 19

                                     if gameStatus.preventKick then

                                         leftHand:pause()
                                         rightHand:pause()
                                         leftHand.skeleton.group.alpha = 0
                                         rightHand.skeleton.group.alpha = 0                                         
                                         ob.leftCtrl.alpha = 1
                                         ob.leftCtrl:setFillColor(1,1,1)
                                         ob.rightCtrl:setFillColor(1,1,1)
                                         ob.rightCtrl.alpha = 1

              
                                         gameStatus.preventKick = false
                                     end

                                  if ( event.time - gameStatus.kickStart < 100) then
                                    hero:jump()
                                    gameStatus.isSalta = false
                                    commonData.playSound( sounds.jumpSound )   
                                  else
                                    hero:saltaJump()
                                    gameStatus.isSalta = true
                                    commonData.playSound( sounds.saltaSound )   
                                  end
                                  ob.onGround = false
                                  monster.kickTimer = 0
                                  
                                  
                                  collisionRect.width = 3
                                 collisionRect.x=BALL_X
                                 collisionRect.y=hero:getHead().y + 255
                                  collisionRect.alpha= ob.defualtAlpha
                                  

                                  gameStats.jumps =  gameStats.jumps + 1
                                  gameStatus.ignoreHeader = false
                                  touchIDs = {}

                                end
                          else

                      
                              gameStatus.kickStart = event.time; 
                              gameStatus.isLeftLeg = (event.x < 241)
                              

                              gameStatus.ignoreClick = not ob.onGround or (monster.kickTimer == 1)

                              if (ob.onGround and not  gameStatus.preventKick and monster.kickTimer == 0) then  
                                                                     
                                    
                                    local isBadKick = (gameStatus.isLeftLeg == gameStatus.isPrevLeft 
                                                      and not gameStatus.isAnyLeg ) 

        
                                      
                                      if  gameStatus.forceSwap and 
                                        ((commonData.gameData.abVersion == 1 and gameStats.bounces < 8) or  gameStats.bounces < 4) and
                                        ((rightHand.skeleton.group.alpha == 1  and gameStatus.isLeftLeg) or
                                        (leftHand.skeleton.group.alpha == 1 and not gameStatus.isLeftLeg)) then
                                        
                                      else
                                        monster.kickTimer = 1
                                        hero:startKick(gameStatus.isLeftLeg, isBadKick)

                                        if not isBadKick then
                                            leftHand:pause()  
                                           rightHand:pause()  
                                           leftHand.skeleton.group.alpha = 0
                                           rightHand.skeleton.group.alpha = 0                                         
                                           ob.leftCtrl.alpha = 1
                                           ob.leftCtrl:setFillColor(1,1,1)
                                           ob.leftCtrl.fill.effect = nil
                                           ob.rightCtrl.fill.effect = nil
                                           ob.rightCtrl:setFillColor(1,1,1)
                                           ob.rightCtrl.alpha = 1
                                        
                                        else
                                          if gameStatus.isLeftLeg then
                                            ob.leftCtrl.fill.effect = "filter.brightness"
                                            ob.leftCtrl.fill.effect.intensity = 1
                                            ob.leftCtrl:setFillColor(1,0,0)


                                            timer.performWithDelay(50 , function ()                                
                                               ob.leftCtrl.alpha = 1.5 -  ob.leftCtrl.alpha
                                            end , 6)

                                            timer.performWithDelay(300 , function ()                                
                                               ob.leftCtrl:setFillColor(1,1,1)
                                               ob.leftCtrl.fill.effect = nil
                                            end , 1)

                                            rightHand:init()  
                                            
                                            timer.performWithDelay(1 , function ()                          
                                                   rightHand.skeleton.group.alpha = 1
                                                   rightHand:tapRight()                     
                                                   --ob.leftCtrl.alpha = 0           
                                                   
                                            end , 1)
                                                 
                                       
                                          else
                                            ob.rightCtrl.fill.effect = "filter.brightness"
                                            ob.rightCtrl.fill.effect.intensity = 1
                                            ob.rightCtrl:setFillColor(1,0,0)

                                              leftHand:init()
                                              timer.performWithDelay(1 , function ()                          
                                                     leftHand.skeleton.group.alpha = 1
                                                     leftHand:tapLeft()      
                                                     end , 1)

                                             timer.performWithDelay(50 , function ()                                
                                               ob.rightCtrl.alpha = 1.5 -  ob.rightCtrl.alpha
                                            end , 6)

                                            timer.performWithDelay(300 , function ()                                
                                               ob.rightCtrl:setFillColor(1,1,1)
                                               ob.rightCtrl.fill.effect = nil
                                            end , 1)
                                          end
                                        end  
                                        gameStatus.startY = event.yStart
                                        gameStatus.lastY = gameStatus.startY  
                                      end  
                                      

                                
                                   

                              end
                          end  
                         
                   end

                     if(event.phase == "moved") then
                      
                     
                   end
                   
    end


    
   
    --consecutivePerfects  = 0
    local rawShotPower = nil
    
    
    local initKickColorHandle = nil
    
    local function initKickColor()      
      
      
      initKickColorHandle = nil
    end

      
      local function handleGoal( event )
            ob.goalSpine:goal()

            achivmentAlert("GOAL")

            reportChallenge("scoreGoal")

            if (not ob.onGround) then
              if gameStatus.isSalta then
                reportChallenge("saltaGoal")
              else
                reportChallenge("headerGoal")                
              end
            end

            gameStats.isGoalScoredInTheGame = true
            gameStatus.goalInARow = gameStatus.goalInARow  + 1

            if  gameStatus.goalInARow == 3 then
               reportChallenge("hattrick")                
            end  


            if gameStatus.isUltraMode then
              reportChallenge("fireGoal")                
            end


            local rewardIndex = 1

            for i = 1, goal.numChildren, 1 do
              --if (goal[i].name== "bar") then
                goal[i].x = 0
              --end                                  
            end

            local addCoins = 5

             local trophieRnd
              if score < 80 then
                trophieRnd = 25
              else
                 trophieRnd = 15
              end  

              if (mRandom(trophieRnd) == 1 ) then
                rewardIndex = 3
                addCoins = nil
                achivmentAlert("PackWinner")
              else

                addCoins =  3 + mRandom(8) 
                rewardIndex = 2
              end


            if (addCoins) then
                commonData.playSound(sounds.coinsGoalSound)

               -- addCoins = addCoins +  mRandom(6)  - 3
                if (addCoins < 3) then
                      addCoins = 3
                end  

               ob.coinsCount = ob.coinsCount + addCoins

               additionalCount = addCoins
              
               timer.performWithDelay(4000, initAdditionalCoins, 1)
               gameStats.coins = gameStats.coins + addCoins
            else
              commonData.playSound(sounds.trophieGoalSound)
              commonData.gameData.packs = commonData.gameData.packs + 1
               
            end

            commonData.analytics.logEvent( "scoredGoal", {  prizeCategory= tostring( rewardIndex ) } )

            
            setCoinsCount(nil)

            ob.rewards[rewardIndex]:init()
            ob.rewards[rewardIndex].skeleton.group.x = ballon.x
            ob.rewards[rewardIndex].skeleton.group.y = ballon.y

            local vx, vy = ballon:getLinearVelocity()

            --if (vy < - 5) then
            ballon:setLinearVelocity(0,-5)
            fire:setLinearVelocity(0,-5)
            -- ultraBall:setLinearVelocity(0,-5)
            -- --end
            ballon.gravityScale = 0
            fire.gravityScale = 0    
            --ultraBall.gravityScale = 0            
            timer.performWithDelay(200, startGravity, 1)

            ballon.x = BALL_X
            fire.x = BALL_X
            --ultraBall.x = BALL_X
            
              -- if (commonData.selectedSkin == "Rolando") then
              --   commonData.playSound(sounds.CristianoGoalSound)
              -- elseif (commonData.selectedSkin == "Nessi") then
              --    commonData.playSound(sounds.MessiGoalSound)
              -- elseif (commonData.selectedSkin == "Zlatan") then
              --    commonData.playSound(sounds.ZlatanGoalSound)
              -- elseif (commonData.selectedSkin == "Neymar") then  
              --   commonData.playSound(sounds.neymarGoalSound)
              -- elseif (commonData.selectedSkin == "Rooney") then  
              --   commonData.playSound(sounds.rooneyGoalSound)
              -- elseif (commonData.selectedSkin == "Steph") then  
              --   commonData.playSound(sounds.stephGoalSound)
              -- elseif (commonData.selectedSkin == "PewDiePie") then  
              --   commonData.playSound(sounds.PewdsGoalSound)  
              -- elseif (commonData.selectedSkin == "Zombie") then  
              --   commonData.playSound(sounds.goalBrainzSound)                
              -- end  
      end

    
      ob.finishInstrunct = function ()
        ob.chaser.skeleton.group.alpha = 1
        ob.instructionBlocker.alpha = 0 
        gameStatus.isGameActive = true
        kickToStart.alpha = 1
        hero:reload()
        hero:init()
        hero:cancelKick()
        hero:stand(true)
        scoreText.text = "0"
        
        if (ballSkin) then
          ballSkin.alpha = 1
        else
          ballon.alpha = 1  
        end             
      end 

    ob.kickInstruct = function ()
      ob.instructionBlocker.alpha = 0.8 
      kickToStart.alpha = 0
      ballon.alpha = 0
      if (ballSkin) then
        ballSkin.alpha = 0
      end  
      gameStatus.isGameActive = false
      ob.chaser.skeleton.group.alpha = 0


      local kickBallCallback = function (type)

        if (initKickColorHandle) then
         timer.cancel( initKickColorHandle )
        end 

        
        initKickColorHandle = timer.performWithDelay(4, initKickColor, 100)
           

        if (type == "perfect") then
          
          commonData.playSound( sounds.perfectKickSound )  
          scoreText.text = "GOOD"
        elseif (type == "good") then
          
          commonData.playSound( sounds.perfectKickSound )  
          scoreText.text = "FINE"
        else  
          
          commonData.playSound( sounds.badKickSound ) 
          scoreText.text = "BAD"
        end
      end

      hero:dribbleLoop(ob.finishInstrunct, kickBallCallback)
    end  

    local function kickBall()

      -- ignore kick if ball going up

        --handleGoal()
       if (initKickColorHandle) then
         timer.cancel( initKickColorHandle )
       end 

       if (endKickHandle) then
         timer.cancel( endKickHandle )  
      end

      collisionRect.isSensor = true
      ob.redRect.alpha = 0
      
    --  collisionRect.x = 0
       monster.kickTimer = 0
       --shotPower = 0.35
        
        local incSpeed = 1 - gameStatus.speed / MAX_SPEED
        local decSpeed = gameStatus.speed / MAX_SPEED

        if  gameStatus.isStaticBall then
          incSpeed = 0
           decSpeed = 0
           ballon.gravityScale=1

           
              -- firstKick
             
              ballon.isSleepingAllowed = true
              
              gameStatus.preventJump = false
              chaserRect.speed = REFEREE_START_SPEED
              
              if (ob.onGround ) then
                hero:walk()
              end
              ob.chaser:walk()
              ob.coach:walk()
              
              gameStatus.speed = START_SPEED
              kickToStart.alpha = 0
              pauseButton.alpha = 1
              gameStatus.isStaticBall = false
       

        else  
           
           initKickColorHandle = timer.performWithDelay(4, initKickColor, 100)
           
         end
        local isPerfectKcick = false

        if (ob.onGround ) then
            gameStats.bounces =  gameStats.bounces + 1
            
               ballon.angularVelocity = 400 - mRandom(800) 
               --ballon.angularVelocity = 300
              if gameStats.bounces == 5 then
                
                reportChallenge("kick5time")
              end 

              if (gameStatus.isLeftLeg ~= gameStatus.isPrevLeft) then
                gameStats.swapBounces  = gameStats.swapBounces   + 1

                if gameStats.swapBounces == 6 then
                  reportChallenge("swap6")
                end  
              else  
                gameStats.swapBounces = 0
              end
              
         

            if IS_AUTO_KICK then
              shotPower = 0.8
            end
        else
            ballon.angularVelocity = 0

            -- calc header power
             if (monster.accel + monster.gravity > 0 ) then
              shotPower = ballon.y / 150             
            else
              shotPower = ballon.y / 300 
            end 
            
            if (shotPower > 0.8) then
                shotPower = 0.8
            end 
        end

        
        ballon:setLinearVelocity(0,-500 * shotPower )  
        -- fire:setLinearVelocity(0,-500 * shotPower )  
        
        --TODO: remove me
        --fire.angularVelocity = ballon.angularVelocity

        -- ultraBall:setLinearVelocity(0,-500 * shotPower )  
        -- ultraBall.angularVelocity = ballon.angularVelocity


        --ballon:setLinearVelocity(0,-550 )  
        --ballon:applyLinearImpulse(0,shotPower,ballon.x,ballon.y)
        
        gameStatus.kickEnded = true
        local isBadKick = false

        -- TRYING OUT PERFECT POSITION BY Y (not timing)
         

         
            
            local  kickRange = ballon.y - 180
         
                  if not ob.onGround then
                      gameStatus.speed = gameStatus.speed - decSpeed
                      isBadKick = true

                  elseif (gameStatus.isLeftLeg == gameStatus.isPrevLeft and not gameStatus.isAnyLeg and ob.onGround) then
                      gameStatus.speed = gameStatus.speed - decSpeed
                      isBadKick = true

                      if (not gameStatus.isTutorial or ob.tutorialStage >= 5) then
                        gameStatus.shakeamount = 10
                      end  

                     

                      
                               

                      
                  elseif (kickRange >= PERFECT_POSITION - PERFECT_MARGIN and kickRange <= PERFECT_POSITION + PERFECT_MARGIN ) then
                      gameStatus.speed = gameStatus.speed + incSpeed
                     -- kickPos.text = "P"
                      
                      gameStats.bouncesPerfect =  gameStats.bouncesPerfect + 1
                      isPerfectKcick = true

                      if (kickRange >= PERFECT_POSITION - PERFECT_MARGIN/2 and kickRange <= PERFECT_POSITION + PERFECT_MARGIN/2 ) then
                        ob.bubble:good()  
                      end
                     
                  elseif ((kickRange >= PERFECT_POSITION - PERFECT_MARGIN - GOOD_RANGE  and kickRange <= PERFECT_POSITION - PERFECT_MARGIN ) or
                         (kickRange >=  PERFECT_POSITION + PERFECT_MARGIN   and kickRange <=  PERFECT_POSITION + PERFECT_MARGIN + GOOD_RANGE)) then   
                     --kickPos.text = "G"
                      
                      gameStats.bouncesGood =  gameStats.bouncesGood + 1


                  elseif (kickRange >= PERFECT_POSITION + PERFECT_MARGIN + GOOD_RANGE  ) then
                    --kickPos.text = "TL"
                    gameStatus.speed = gameStatus.speed - decSpeed/2          
                    isBadKick = true
                     gameStats.bouncesLate =  gameStats.bouncesLate + 1

                  elseif (kickRange <=  PERFECT_POSITION - PERFECT_MARGIN - GOOD_RANGE   ) then       
                    --kickPos.text = "TE"
                    gameStatus.speed = gameStatus.speed - decSpeed/2
                    isBadKick = true
                    if (ob.onGround) then            


                        if (not commonData.gameData.tipCircleShown  and commonData.gameData.gamesCount > 0) then
                            commonData.gameData.tipCircleShown = true

                           handleFisrtObstacle()                               
                                 
                                 ballon.y = 240
                                 ballon.x = BALL_X                         
                                 gameStatus.preventJump = true

                                timer.performWithDelay(1500 , function ()                                
                                  ob.tipCircle.alpha = 1
                                end , 1)
                                timer.performWithDelay(2500 , function ()
                                  ob.boosterButton.alpha = 1                          
                                end , 1)
                                return
                       else    


                         gameStats.bouncesEarly =  gameStats.bouncesEarly + 1  
                       end

                       
                    end    
                  end     
        -- end                        
                  
        

        if (isBadKick and ob.onGround) then
          
          if commonData.selectedBall == "Brainz" and  sounds.badKickBrainzSound then
            commonData.playSound( sounds.badKickBrainzSound ) 
          else
            commonData.playSound( sounds.badKickSound ) 
          end  

         
        else
          if (gameStatus.isUltraMode) then
            commonData.playSound( sounds.fireKickSound )

             for j = 1, fire.numChildren do
                   if (fire[j].isEmitter and fire[j].isOnKickEmitter) then
                    fire[j]:start()
                   end 
             end
          else
            if commonData.selectedSkin == "DribbleBot" and  sounds.botKickSound then
              commonData.playSound( sounds.botKickSound ) 
            elseif commonData.selectedBall == "Brainz" and  sounds.goodKickBrainzSound then
              commonData.playSound( sounds.goodKickBrainzSound )                            
            elseif commonData.selectedBall == "Basketball" and  sounds.basketballSound then
              commonData.playSound( sounds.basketballSound )                            
            elseif commonData.selectedBall == "Watermelon" and  sounds.watermelonSound then
              commonData.playSound( sounds.watermelonSound )                              
            else  
              commonData.playSound( sounds.perfectKickSound )  
            end  
            
          end
        end  

         if (gameStatus.forceSwap and gameStats.bounces < 8)  then 

           if gameStatus.isLeftLeg then
            rightHand:init()  
            
            timer.performWithDelay(500 , function ()                          
                   rightHand.skeleton.group.alpha = 1
                   rightHand:tapRight()                     
                   --ob.leftCtrl.alpha = 0           
                   
            end , 1)
                 
          else 
            leftHand:init()
            timer.performWithDelay(500 , function ()                          
                   leftHand.skeleton.group.alpha = 1
                   leftHand:tapLeft()           
                   --ob.rightCtrl.alpha = 0    
                   --ob.rightCtrl:setFillColor(1,0,0)       
            end , 1)
          
          end  
        end

        if commonData.gameData.abVersion == 1  and (gameStatus.forceSwap and gameStats.bounces < 8) then
          isPerfectKcick = true
        end  

        if (isPerfectKcick) then
           consecutivePerfects = consecutivePerfects + 1
           gameStatus.kicksMulti = gameStatus.kicksMulti + 1           
            gameStatus.sreeCount = gameStatus.sreeCount  + 1 
             ob.updateScoreboard(gameStatus.sreeCount)
          
           gameStatus.shakeamount2 = 10
           
           if ( consecutivePerfects >= 20 ) then
              achivmentAlert("DribbleMaster")
           elseif ( consecutivePerfects >= 8 ) then
            achivmentAlert("BigDribbler")               
             
           elseif ( consecutivePerfects >= 3 ) then
            achivmentAlert("LittleDribbler")
             
           end

           if ( consecutivePerfects == 4 or consecutivePerfects == 12 ) then
            comments:showReward()     
           end

           if ( consecutivePerfects == 4) then

           
            reportChallenge("perfect4")
            
           end

            if ( consecutivePerfects == 6) then
              reportChallenge("perfect6")
            
            end

           if ( gameStatus.sreeCount  == ULTRA_MODE_PERFECTS ) then
              ob.enterUltraMode()
           end
          
          
        else

          if consecutivePerfects == 0 then
            gameStatus.kicksMulti = 0
             gameStatus.sreeCount = gameStatus.kicksMulti 
             ob.updateScoreboard(gameStatus.sreeCount)
          end  

          consecutivePerfects = 0             

          ob.bubble:bad()
        end
        

        
        if (gameStatus.speed >= LITTLE_RUNNER_SPEED) then
          achivmentAlert("YouLittleRunner")
          reportChallenge("maxSpeed")
          
        end 
        
        --speed = gameStatus.speed + 0.7
        if (gameStatus.speed > MAX_SPEED) then
          gameStatus.speed = MAX_SPEED
        end 

        if (gameStatus.speed< MIN_SPEED) then
          gameStatus.speed = MIN_SPEED
        end

        if (gameStatus.isTutorial and ob.tutorialStage < 5) then
           gameStatus.speed = 0 
        else
          hero:cancelKick()
          hero:setWalkSpeed(gameStatus.speed)          
        end  
        --kickPos.text = kickRange
        --speed =8
        -- color based on speed
        --local scaledSpeed = gameStatus.speed - MIN_SPEED      
        --speedCircle:setFillColor( 2 * (1 - (scaledSpeed)/ (MAX_SPEED - MIN_SPEED)) , 2 * (scaledSpeed)/ (MAX_SPEED - MIN_SPEED)  , 0)

        -- color based on kick pos
        local distanceFromPerfect = math.abs (PERFECT_POSITION - kickRange)
        if (distanceFromPerfect > 75 ) then
          distanceFromPerfect = 75
        end

        if (gameStatus.isPrevLeft == gameStatus.isLeftLeg and not gameStatus.isAnyLeg) then
          --speedCircle:setFillColor(1 ,  0  , 0)
         --  ballon:setFillColor(1 ,  0  , 0)
         --  if (ballSkin) then
         --    ballSkin:setFillColor(1 ,  0  , 0)
         -- end  
        else
          --speedCircle:setFillColor(2 * (distanceFromPerfect)/ (75) ,  2 * (1 - (distanceFromPerfect)/ (75))  , 0)
         --  ballon:setFillColor(2 * (distanceFromPerfect)/ (75) ,  2 * (1 - (distanceFromPerfect)/ (75))  , 0)
         --  if (ballSkin) then
         --    ballSkin:setFillColor(2 * (distanceFromPerfect)/ (75) ,  2 * (1 - (distanceFromPerfect)/ (75))  , 0)
         -- end  
        end
        
       
        gameStatus.isPrevLeft = gameStatus.isLeftLeg
        
        
        gameStatus.isAnyLeg = false
         gameStatus.kickStart = system.getTimer()

        
        --  local power = consecutivePerfects
        --    if (power > 8) then
        --       power = 8
        --    end

        --     ob.coinsCount = math.pow (2,power)
        -- setCoinsCount()


         multiText.text = "x" .. gameStatus.kicksMulti + 1
        
      end

    local function removeCoin( event )
          -- Access "params" table by pointing to "event.source" (the timer handle)
          local params = event.source.params           
          params.coinObj.isAlive = false
          params.coinObj.y = 700
          params.coinObj.spine.skeleton.group.y = 700          
      end


      local function handleCoin( event )
          -- Access "params" table by pointing to "event.source" (the timer handle)
          local params = event.source.params    
          if (params.coinObj.isEnabled and gameStatus.isGameActive) then
            params.coinObj.isEnabled = false
            ob.coinsCount = ob.coinsCount  + 1            
            setCoinsCount()
            params.coinObj.spine:collect()
            local ts = timer.performWithDelay(500, removeCoin, 1)
            ts.params = {coinObj =  params.coinObj}
            commonData.playSound( sounds.coinSound )   

            gameStats.coins = gameStats.coins + 1
            
            reportChallenge("collectCoin")


            if params.coinObj.ultra then
              ob.ultraCoinsCollected = ob.ultraCoinsCollected  + 1
              if (ob.ultraCoinsCollected == 4 ) then
                reportChallenge("collectSpreeCoins")
              end  

              if (ob.ultraCoinsCollected == 6 ) then
                reportChallenge("collectSpreeCoins2")
              end  
            else  


                if params.coinObj.y <= 30 then
                  reportChallenge("goldDigger")
                end
            
            end  

          end
      end

      
    
      local isHoldLegConfirmed = false
      

      ob.onCollision = function( event )

          if (gameStatus.isConfirmationRequired) then
              
              return
          end  


          if (event.object1.name ~= "gameOver") then
            
          end

          if ( event.phase == "began" ) then
                      if ( event.object1.name == "fire" or  event.object2.name == "fire") then 
                     elseif ( event.object1.name == "leg" or  event.object2.name == "leg") then 
                       

                       
                            
                          --local deltaY =   270  -  collisionRect.y  
                          local deltaY = gameStatus.startY - gameStatus.lastY                     
                           local kickDuration = system.getTimer() - gameStatus.kickStart
                           local ignoreKick  = false

                           if ob.tutorialStage == 7 then
                            ignoreKick = true
                           end


                                    
                           if (ob.onGround) then
                              
                           else
                              
                                -- ignore header when the ball going up
                                local vx, vy = ballon:getLinearVelocity()
                                if (not gameStatus.isSalta and 
                                    ( event.object1.isJumpLeg or  event.object2.isJumpLeg)) then
                                      ignoreKick = true
                                end

                                if ( gameStatus.ignoreHeader) then
                                  ignoreKick = true
                                  
                                else  

                                  -- if hero going up the header is stronger
                                  if (monster.accel + monster.gravity > 0 ) then
                                    shotPower = collisionRect.y / 200 
                                    if (gameStatus.isSalta) then
                                        shotPower = ob.jumpLeg.y / 200 
                                    
                                    end 

                                  else
                                    shotPower = collisionRect.y / 300 
                                  end 

                                  
                                  if (shotPower > 0.8) then
                                      shotPower = 0.8
                                  end 

                                  if (shotPower < 0) then
                                      ignoreKick = true
                                  end 

                         
                                  gameStatus.ignoreHeader = true
                                end
                                rawShotPower = shotPower 
                            end

                             
                             if (not ignoreKick) then  

                                timer.performWithDelay(0, kickBall, 1)
                               
                            end
                         
                      elseif ( event.object1.name == "coin" or  event.object2.name == "coin") then              
                              local ts = timer.performWithDelay(0, handleCoin, 1) 
                              ts.params = {coinObj = event.object1}
                      elseif (gameStatus.isGameActive) then                      -- and 1==2
                        if ( event.object1.name == "gameOver" or  event.object2.name == "gameOver") then                           
                                  --stopGame() -- todo: remove me
                                  if ( event.object1.shouldStopGame or  event.object2.shouldStopGame) then      
                                     timer.performWithDelay(1000, stopGame, 1)

                                    hero:gameOver()
                                    if (event.object1.y < 0) then
                                       gameStats.finishReason = "kick too strong"
                                       commonData.playSound( sounds.glassBreakSound )  
                                       ballon.alpha = 0
                                       if (ballSkin) then
                                          ballSkin.alpha = 0
                                       end  
                                       fire.alpha = 0
                                       --ultraBall.alpha = 0 
                                       
                                    else
                                      gameStats.finishReason = "ball fall"
                                      commonData.playSound( sounds.ballFallSound  )       
                                    end
                                    gameStatus.isGameActive = false                     
                                  else  
                                    --collisionRect.isSensor = false
                                    ballon.isSleepingAllowed = false
                                    
                                    
                                     consecutivePerfects = 0
                                     gameStatus.kicksMulti = 0
                                      gameStatus.sreeCount = 0 
                                     ob.updateScoreboard(gameStatus.sreeCount)
                                      multiText.text = "x" .. gameStatus.kicksMulti + 1
                                      
                                     gameStatus.speed  = gameStatus.speed - (gameStatus.speed / MAX_SPEED) / 3
                                     

                                     local vx, vy = ballon:getLinearVelocity()
                                     ob.bubble:floor()
                                     commonData.playSound( sounds.ballFallSound , { fadein = 400 - vy}) 
                                  end
                              
                        elseif ( event.object1.name == "cone" or  event.object2.name == "cone") then
                              if gameStatus.isUltraMode then
                                return
                              end  
                                gameStatus.isGameActive = false
                                ob.obstacleArrow.alpha = 0
                                commonData.playSound( sounds.crashConeSound )
                                commonData.playSound( sounds.heroFallSound )
                                hero:fallObstecale()
                                
                                
                                 gameStats.finishReason = "fallByCone"
                                 timer.performWithDelay(1000, stopGame, 1)  
                               
                         elseif ( event.object1.name == "bird" or  event.object2.name == "bird") then
                              if gameStatus.isUltraMode then
                                return
                              end
                                gameStatus.isGameActive = false
                                ob.obstacleArrow.alpha = 0
                                commonData.playSound( sounds.crashConeSound )
                                commonData.playSound( sounds.heroFallSound )
                                hero:fallObstecale()
                                
                               
                              
                                 gameStats.finishReason = "fallByBot"
                                 timer.performWithDelay(1000, stopGame, 1)  
                               
                               
                        elseif ( event.object1.name == "trash" or  event.object2.name == "trash" ) then
                            if gameStatus.isUltraMode then
                                return
                              end
                                gameStatus.isGameActive = false
                                ob.obstacleArrow.alpha = 0
                                
                                commonData.playSound( sounds.crashTrashSound )
                                commonData.playSound( sounds.heroFallSound )
                                hero:fallObstecale()                

                                
                                
                                    gameStats.finishReason = "fallByCan"
                                    timer.performWithDelay(1000, stopGame, 1)  
                                
                        elseif ( event.object1.name == "defender" or  event.object2.name == "defender") then
                            if gameStatus.isUltraMode then
                                return
                              end

                                if ( event.object1.isDog  or  event.object2.isDog ) then
                                    if ( event.object1.isCombo  or  event.object2.isCombo ) then
                                      gameStats.finishReason = "hitDog (combo)"
                                    else                                      
                                      gameStats.finishReason = "hitDog"
                                    end
                                    
                                    
                                end

                                if ( event.object1.isArs  or  event.object2.isArs ) then
                                    if ( event.object1.isCombo  or  event.object2.isCombo ) then
                                      gameStats.finishReason = "hitBigKid (combo)"
                                    else                                      
                                      gameStats.finishReason = "hitBigKid"
                                    end
                                    --commonData.playSound( sounds.arsSound ) 
                                end  
                                
                                if ( event.object1.isKid  or  event.object2.isKid ) then
                                    if ( event.object1.isCombo  or  event.object2.isCombo ) then
                                      gameStats.finishReason = "hitSmallKid (combo)"
                                    else                                      
                                      gameStats.finishReason = "hitSmallKid"
                                    end
                                    --commonData.playSound( sounds.kidSound ) 
                                end  

                              
                                if ( event.object1.isTwoBoys  or  event.object2.isTwoBoys ) then
                                  gameStats.finishReason = "hitTwoKids"
                                   -- commonData.playSound( sounds.twoBoysSound ) 
                                end  
                                  
                               if (END_GAME_WHEN_DEF_TOUCH) then                         
                                 gameStatus.isGameActive = false

                                 
                                   hero:gameOver()
                                   timer.performWithDelay(1000, stopGame, 1)    
                                 
                               end
                        elseif ( event.object1.name == "chaser" or  event.object2.name == "chaser") then
                                gameStatus.isGameActive = false
                                gameStats.finishReason = "catchedBYShamina"  
                                timer.performWithDelay(2000, stopGame, 1)
                                --commonData.playSound(sounds.catchSound)        
                                ob.chaser:catch()

                                timer.performWithDelay(300 , function() 
                                        hero:caught()
                                      end, 1)

                                
                        elseif ( event.object1.name == "bird" or  event.object2.name == "bird") then
                          if gameStatus.isUltraMode then
                                return
                              end
                               commonData.playSound( sounds.birdHitSound )      
                               
                                if ( event.object1.isCombo  or  event.object2.isCombo ) then
                                  gameStats.finishReason = "hitBird (combo)"
                                else                                      
                                  gameStats.finishReason = "hitBird"
                                end

                                
                               if (END_GAME_WHEN_DEF_TOUCH) then                         
                                   gameStatus.isGameActive = false                             
                                    hero:gameOver()
                                   timer.performWithDelay(1000, stopGame, 1)          
                                end
                        elseif ( event.object1.name == "bar" or  event.object2.name == "bar") then
--                              timer.performWithDelay(0, stopGame, 1)        
                                commonData.playSound( sounds.goalPostSound ) 
                        elseif ( event.object1.name == "net" or  event.object2.name == "net") then
                            if (not isGoalScored) then 

                                
                                timer.performWithDelay(0, handleGoal, 1)  
                                
                                isGoalScored = true                       
                            end
                            
                        end

                      end  
                           
          elseif ( event.phase == "ended" ) then
                          
              
          end
      end



        -- local function localOnCollision( event )    
        --      onCollision(event)
        -- end

        -- local function localTouched( event )
        --      touched(event)
        -- end

        Runtime:addEventListener( "collision", ob.onCollision )
        Runtime:addEventListener("touch", ob.touched, -1)

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
            updateKids()



             local memUsed = (collectgarbage("count"))
             local texUsed = system.getInfo( "textureMemoryUsed" ) / 1048576 -- Reported in Bytes
           
            
            --print( string.format("%.00f", texUsed))
            
         
        end

        
        if not gameStatus.mainTimer then
              gameStatus.mainTimer = timer.performWithDelay(1, update, -1)
              timer.pause(gameStatus.mainTimer)
        end
        
        local playerSound  = nil

        local soundRnd = math.random(2)
        
        if commonData.selectedSkin == "Shakes" then
          playerSound = audio.loadSound( "sounds/players/ShakesStarter0".. soundRnd ..".mp3" )
        elseif commonData.selectedSkin == "CoolJoe" then
          
          playerSound = audio.loadSound( "sounds/players/CoolJoeStarter0".. soundRnd ..".mp3" )
        elseif commonData.selectedSkin == "ElMatador" then
          playerSound = audio.loadSound( "sounds/players/ElMatadorStarter0".. soundRnd ..".mp3" )
        elseif commonData.selectedSkin == "Klaus" then
          playerSound = audio.loadSound( "sounds/players/KlausStarter0".. soundRnd ..".mp3" )
        elseif commonData.selectedSkin == "NorthShaw" then
          playerSound = audio.loadSound( "sounds/players/NorthShawStarter0".. soundRnd ..".mp3" )
        elseif commonData.selectedSkin == "TwistingTiger" then
          playerSound = audio.loadSound( "sounds/players/TigetStarter0".. soundRnd ..".mp3" )
        elseif commonData.selectedSkin == "Blok" then
          
        elseif commonData.selectedSkin == "BigBo" then

        elseif commonData.selectedSkin == "Rasta" then
          playerSound = audio.loadSound( "sounds/players/RastaStarter0".. soundRnd ..".mp3" )          
        elseif commonData.selectedSkin == "ElMatador" then  
          
          playerSound = audio.loadSound( "sounds/players/ElMatadorStarter0".. soundRnd ..".mp3" )          
        end

        if playerSound then          
          commonData.playSound(playerSound)
        end
        restartGame()

   end
end

-- "scene:hide()"
function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase
    --print("hide game")
   if ( phase == "will" ) then

       if  gameStatus.isGameActive then
        ob.stopGameElements()
       end
    
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
        Runtime:removeEventListener( "collision", ob.onCollision )
        Runtime:removeEventListener("touch", ob.touched, -1)
   
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end

-- "scene:destroy()"
function scene:destroy( event )

   local sceneGroup = self.view
   --print("hide game")

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end

function scene:outerCoinsReward(coinsToAdd , x , y)
    --code to resume game
 

  if (coinsToAdd) then
     ob.coinsCount = ob.coinsCount + coinsToAdd 
     coinsShadowText.text = ob.coinsCount  .. "   +" .. coinsToAdd
     coinsCountText.text =  ob.coinsCount  .. "   +" .. coinsToAdd

      ob.rewards[2]:init()
      ob.rewards[2].skeleton.group.x = x
      ob.rewards[2].skeleton.group.y = y

         commonData.playSound(sounds.coinsGoalSound)
             


  end  
end


function scene:outerRestartGame()
    --code to resume game
 restartGame()
end


function scene:outerPauseGame()
    --code to resume game

    if gameStatus.isGameActive and not gameStatus.isGamePaused and gameStats.bounces > 0 then
        commonData.pauseGame()
        return true
    elseif ob.instructionBlocker.alpha > 0 then
        hero:cancelDribbleLoop()
        ob.finishInstrunct()
        return true
    else  
        return false 
    end    

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene 