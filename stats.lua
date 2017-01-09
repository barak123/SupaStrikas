local commonData = require( "commonData" )

local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

local highScoreText = nil
local gamesCountText = nil
local scoreText = nil
local averageScoreText = nil
local gamesCountText = nil
local perfectRatioText = nil
local distanceText = nil
local comboText = nil

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view


    --everything from here down to the return line is what makes
     --up the scene so... go crazy
     local background = display.newImage("images/StatsScreenBG.jpg")
     --background:setFillColor(59/255,  131/255 , 163/255)
     background.x = 240
     background.y = 160
     background.xScale = display.actualContentWidth / background.contentWidth 
     background.yScale = display.actualContentHeight  / background.contentHeight
     

    local highScoreOptions = 
    {
        --parent = textGroup,
        text = "",     
        x = 420,
        y = 20,
        width = 270,     --required for multi-line and alignment
        font = "UnitedSansRgHv",   
        fontSize = 25,
        align = "center"  --new alignment parameter
    }

   -- local highScoreTitle = display.newText(coinTextOptions) 

     highScoreText = display.newText(highScoreOptions) 
     highScoreText.x = 115
     highScoreText.y = 110

     local highScoreOptions1 = 
    {
        --parent = textGroup,
        text = "",     
        x = 420,
        y = 20,
        width = 250,     --required for multi-line and alignment
        font = "UnitedSansRgHv",   
        fontSize = 60,
        align = "center"  --new alignment parameter
    }
      scoreText = display.newText(highScoreOptions1) 
      scoreText.x = 115
      scoreText.y = 200

   
      local coinTextOptions = 
    {
        --parent = textGroup,
        text = "",     
        x = 420,
        y = 20,
        width = 300,     --required for multi-line and alignment
        font = "troika",   
        fontSize = 20,
        align = "left"  --new alignment parameter
    }


     gamesCountText = display.newText(coinTextOptions)  
     gamesCountText.x = 420
     gamesCountText.y = 103

     averageScoreText = display.newText(coinTextOptions)    
     averageScoreText.x = 420
     averageScoreText.y = 143

     perfectRatioText = display.newText(coinTextOptions)  
     perfectRatioText.x = 420
     perfectRatioText.y = 183
    
     distanceText = display.newText(coinTextOptions)  
     distanceText.x = 420
     distanceText.y = 223

     comboText = display.newText(coinTextOptions)  
     comboText.x = 420
     comboText.y = 263

    local function backButtonListener( event )

       if ( "ended" == event.phase ) then
         commonData.buttonSound()
        composer.gotoScene( "menu" )
        
      end
      return true
     end

       local backButton = widget.newButton
      {
          x = 60,
          y = 20,
          id = "backButton",
          defaultFile = "images/shop/BACK.png",
          overFile = "images/shop/BACK Down.png",
          onEvent = backButtonListener
      }
      backButton:scale(0.5,0.5)

      
      backButton.x = display.screenOriginX  + backButton.contentWidth /2


     sceneGroup:insert(background)
     sceneGroup:insert(highScoreText)
     sceneGroup:insert(scoreText)
     
     sceneGroup:insert(gamesCountText)
     sceneGroup:insert(averageScoreText)
     sceneGroup:insert(perfectRatioText)
     sceneGroup:insert(distanceText)
     sceneGroup:insert(comboText)

     
     sceneGroup:insert(backButton)
     --this is what gets called when playButton gets touched
     --the only thing that is does is call the transition
     --from this scene to the game scene, "downFlip" is the
     --name of the transition that the director uses
     
    
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
end

-- "scene:show()"
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then

    IS_AUTO_KICK = not IS_AUTO_KICK
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
      if(event.params and event.params.gameData) then

           
             highScoreText.text  = "HIGH SCORE" 
             scoreText.text =  commonData.comma_value(event.params.gameData.highScore)
             gamesCountText.text = "GAMES PLAYED: ".. commonData.comma_value(event.params.gameData.gamesCount)
             distanceText.text = "TOTAL METERS: ".. commonData.comma_value(event.params.gameData.totalScore)
             comboText.text = "HIGHEST COMBO: ".. event.params.gameData.highestCombo
             averageScoreText.text = "AVARAGE SCORE: ".. 
                                string.format("%.00f" , event.params.gameData.totalScore / math.max(event.params.gameData.gamesCount, 1))    
             perfectRatioText.text = "PERFECT RATIO: "..  
                                string.format("%.00f" , 100 * event.params.gameData.bouncesPerfect / math.max(event.params.gameData.bounces, 1)) .. "%"       

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

