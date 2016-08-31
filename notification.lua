local composer = require( "composer" )
local widget = require( "widget" )



--store.purchase({ id }) to:


local scene = composer.newScene()
local levelSelectGroup

local coinsReward = nil
local buyButton = nil
local useButton = nil
local rewardBox = nil
local coinsCountText = nil
local coinsShadowText = nil
local priceSText = nil
local priceText = nil
local boosterMsgSpine =  nil
local boosterMsg = nil
local itemReward = nil
local  buyWithCashText = nil
local  buyWithCoinsText = nil
local ballGlowImg  = nil
local  itemRewardImg = nil
local  itemRewardImg2 = nil

local  itemRewardCategory = nil

local  reward = nil

-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view

      boosterMsgSpine =  require ("boosterMsg")
      boosterMsg = boosterMsgSpine.new(0.7, true)
      
      boosterMsg.skeleton.group.x = 300
       boosterMsg.skeleton.group.y = 240

     
        local function backButtonListener( event )

           if ( "ended" == event.phase ) then
               local options = {params = {gameData = gameData}}
               buttonSound()
              composer.gotoScene( "menu" , options )
            
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

      backButton.x = backButton.x  - (display.actualContentWidth - display.contentWidth) /2


      local coinTextOptions = 
      {
          --parent = textGroup,
          text = "",     
          x = 415,
          y = 23,
         -- width = 120,     --required for multi-line and alignment
          font = "troika",   
          fontSize = 20,
          align = "left"  --new alignment parameter
      }

    
      priceText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
      priceSText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
      --coinsCount = 0
      priceText:setFillColor(1,206/255,0)
      priceSText:setFillColor(128/255,97/255,40/255)

      priceText.y = 160
      priceText.x = 240
      priceSText.y = priceText.y + 2
      priceSText.x =  priceText.x 

      priceText.text = ""      
      priceSText.text = ""

    
     sceneGroup:insert(boosterMsg.skeleton.group)
      sceneGroup:insert(priceSText)
      sceneGroup:insert(priceText)
     
     sceneGroup:insert(backButton)
    
    
end

-- "scene:show()"



function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).


   elseif ( phase == "did" ) then
    boosterMsg:init()
    if(event.params and event.params.gameData) then
      end
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
     --  Runtime:addEventListener("touch", packsTouched, -1)
       
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

    --  saveTable(gameData , "gameData14.dat")
          
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   --    hero:pause()
     Runtime:removeEventListener("touch", packsTouched, -1)
      boosterMsg:pause()
   
   

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

