local commonData = require( "commonData" )

local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

local highScoreText = nil
local gamesCountText = nil
local scoreText = nil
local openCardsGroup = nil
local gamesCountText = nil
local perfectRatioText = nil
local distanceText = nil
local comboText = nil
local backButton = nil

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

-- "scene:create()"

  local function revealCardListener( event )   
                    if ( "ended" == event.phase ) then
                       local cardBackImg = event.target 
                       transition.to(cardBackImg, {xScale = 0.01 , alpha = 0,  time = 300})
                       local newScale  = cardBackImg.cardHandle.img.yScale
                       timer.performWithDelay(300 , function ( )
                          transition.to(cardBackImg.cardHandle.img, {xScale = newScale , alpha = 1,  time = 300})       
                       end,1)     
                       commonData.gameData.cards[cardBackImg.cardHandle.id] = true 
                       commonData.saveTable(commonData.gameData , GAME_DATA_FILE)

                       print(cardBackImg.cardHandle.id)

                    end
                    return true
         end

         local function hideCardsListener( event )   
                    if ( "ended" == event.phase ) then
                       for j = 1, openCardsGroup.numChildren do
                         if (openCardsGroup[1]) and openCardsGroup[1].removeSelf then
                          openCardsGroup[1]:removeSelf()
                         end 
                      end

                    end
                    return true
                 end


        local function openPackButtonListener(packType , cardIdx )

          
              -- commonData.gameData.coins = commonData.gameData.coins  - 100
              -- commonData.gameData.usedcoins =  commonData.gameData.usedcoins + 100
              
              -- commonData.gameData.commonPacks = commonData.gameData.commonPacks - 1
              -- packsCountText.text = commonData.gameData.commonPacks + commonData.gameData.rarePacks + commonData.gameData.epicPacks 
        
              
              -- commonData.saveTable(commonData.gameData , GAME_DATA_FILE)
              
              local numberOfCardsInPack = 2
              if packType == "tutorial" then 
                  numberOfCardsInPack = 1
              elseif  packType == "common" then     
                  numberOfCardsInPack = 2
              elseif  packType == "rare" then         
                  numberOfCardsInPack = 3
              elseif  packType == "epic" then           
                numberOfCardsInPack = 5
              end  

              for j = 1, openCardsGroup.numChildren do
                 if (openCardsGroup[1]) and openCardsGroup[1].removeSelf then
                  openCardsGroup[1]:removeSelf()
                 end 
              end

              local blackRect2 = display.newRect(240, 170, 800,600)
              blackRect2:setFillColor(0, 0, 0)
              blackRect2.alpha = 0.7
              blackRect2:addEventListener("touch", hideCardsListener )
              openCardsGroup:insert(blackRect2)

             
              for i=1,numberOfCardsInPack do

                local rnd = math.random(180)

                if cardIdx then
                  rnd = cardIdx
                end  

                local cardBack  = display.newImage("images/album/DemoCardBack.png")  
                local card  = display.newImage("images/album/" .. rnd .. ".jpg")  
                 local defaultScale = 480 / numberOfCardsInPack / cardBack.contentWidth 
                cardBack.xScale = defaultScale
                cardBack.yScale = cardBack.xScale

                cardBack.x =  (cardBack.contentWidth + 5)* (i - 0.5)  --+ levelSelectGroup.x - levelSelectGroup.contentWidth /2  + 10
                cardBack.y = 160  
                
                card.xScale  = 0.01
                card.yScale  = cardBack.contentHeight  / card.contentHeight 

                card.x  =cardBack.x
                card.y  =cardBack.y
                card.alpha = 0

                cardBack:addEventListener("touch", revealCardListener )
                cardBack.cardHandle = {img=card , id = commonData.collection[rnd].id }
                -- cardBack.path.x1 = -110 --{ x2=110, y2=-110, x4=-110, y4=110}
                -- cardBack.path.y1 = 110 
                -- cardBack.path.x3 = 110 
                -- cardBack.path.y3 = -110 
                cardBack.rotation = 90
                cardBack.xScale = 0.001

                --transition.to(cardBack.fill.effect, { time=1200, delay=400, r=0.2, g=0, b=0.7, a=0.2, transition=easing.inOutSine })
                --transition.to(cardBack.path, { time=1200, delay=400, x1=0, y1=0, x3=0, y1=0, transition=easing.inOutSine })
                transition.to(cardBack, { time=500, delay=2800 + 50*(numberOfCardsInPack - i + 1), rotation = 0,xScale=defaultScale,transition=easing.inOutSine })
                

                openCardsGroup:insert(card)
                openCardsGroup:insert(cardBack)

              end

               ballPackSpine =  require ("cardPack")
              ballPack = ballPackSpine.new(0.6, true)
              
              ballPack.skeleton.group.x = 240
               ballPack.skeleton.group.y = 160
               
               openCardsGroup:insert(ballPack.skeleton.group)
               ballPack:init()
               ballPack:open()

               timer.performWithDelay(4000, function ( )
                   ballPack:pause()      
               end,1)


         
         end -- open pack
function scene:create( event )

   local sceneGroup = self.view


     
       

     
     openCardsGroup= display.newGroup()    
      sceneGroup:insert(openCardsGroup)
    
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

function scene:firstPack()

   local sceneGroup = self.view
    openPackButtonListener("tutorial" , 1)
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end

function scene:secondPack()

   local sceneGroup = self.view
    openPackButtonListener("tutorial" , 2)
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end

function scene:albumPack(packType)

   local sceneGroup = self.view
    openPackButtonListener(packType)
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

