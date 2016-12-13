local commonData = require( "commonData" )

local composer = require( "composer" )
local widget = require( "widget" )

require "catalog"

--store.purchase({ id }) to:


local scene = composer.newScene()
local levelSelectGroup

local coinsReward = nil
local buyButton = nil
local useButton = nil
local rewardBox = nil
local coinsCountText = nil
local coinsShadowText = nil
local packsCountText = nil
local packsShadowText = nil
local buyTrophieDisabled = nil
local priceSText = nil
local priceText = nil
local ballPackSpine =  nil
local ballPack = nil
local itemReward = nil
local buyWithCashText = nil
local buyWithCoinsText = nil
local ballGlowImg  = nil
local itemRewardImg = nil
local itemRewardImg2 = nil
local youWonText = nil
local youWonSText = nil
local itemRewardCategory = nil
local rewardBoxBackgroundGreen = nil
local coinsCount = 0

local  reward = nil

local packOpeningSound = audio.loadSound( "PackOpening.mp3" )
local packRewardSound = audio.loadSound( "PackReward.mp3" )
local packNewRewardSound = audio.loadSound( "Celebration.mp3" )



local function logPacks(gameData)
  local packsToAlert = {}
  packsToAlert[1] = 1  
  packsToAlert[2] = 2
  packsToAlert[3] = 5  
  packsToAlert[4] = 10 
  packsToAlert[5] = 15
  packsToAlert[6] = 20
  packsToAlert[7] = 30
  packsToAlert[8] = 50
  packsToAlert[9] = 100
  
  for i=1,9 do
    

    if gameData.packsBought  == packsToAlert[i]  then

         if system.getInfo("environment") ~= "simulator" then
          --analytics.logEvent( "buyPack", {  totalPack = tostring( gameData.packs  + gameData.usedpacks  ) } ) 

          commonData.analytics.logEvent( "Bought " ..  tostring(gameData.packsBought) .. " packs", 
            {gamesCount = tostring(  gameData.gamesCount) , 
            usedPacks = tostring(  gameData.usedpacks) , 
             highScore = tostring(  gameData.highScore) ,
              totalCoins = tostring(  gameData.coins + gameData.usedcoins) ,
              avgScore =  tostring(gameData.totalScore / math.max(gameData.gamesCount, 1)) } )
        end
        print("Bought "  ..  tostring(gameData.packsBought) .. " packs: " .. tostring(  gameData.highScore)  .. "," .. 
             tostring(  gameData.coins + gameData.usedcoins)  .. "," .. tostring(gameData.totalScore / math.max(gameData.gamesCount, 1))) 

        break
    end  
  end  
end


 local function setCoinsCount(e)

    coinsShadowText.text =  commonData.gameData.coins
    coinsCountText.text =  commonData.gameData.coins

    packsShadowText.text = commonData.gameData.packs
    packsCountText.text =  commonData.gameData.packs    

    if (commonData.gameData.coins >=  100) then
      buyTrophieDisabled.alpha = 0 
     else
      buyTrophieDisabled.alpha = 1 
     end
      
  end  

local isPackReady = false

local function packReady()
      isPackReady = true 
end
         

 local function dropNewBall()
     isPackReady = false 
     if (commonData.gameData.packs > 0) then
      ballPack.skeleton.group.alpha = 1
       ballPack:drop()
       timer.performWithDelay(400, packReady, 1)
     else

      --ballPack.skeleton.group.alpha = 0
     end
            
     
  end  

 
-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view



local widget = require( "widget" )

local coinImg  = display.newImage("Coin/Coin.png")
coinImg.x = 450
coinImg.y = 23
coinImg:scale(0.25,0.25)

local packsImg  = display.newImage("TrophieReward/Trophie.png")
packsImg.x = 450
packsImg.y = 58
packsImg:scale(0.07,0.07)


ballGlowImg  = display.newImage("PacksScreen/BallGlowSpinning2.png")
ballGlowImg.x = 240
ballGlowImg.y = 160
ballGlowImg:scale(2.7,2.7)


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


local backMenuSound = nil

backMenuSound = audio.loadSound( "BtnPress.mp3" )


packsCountText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
packsShadowText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)

packsCountText:setFillColor(1,206/255,0)
packsShadowText:setFillColor(128/255,97/255,40/255)
packsCountText.y  =  packsCountText.y  + 35 
packsShadowText.y = packsCountText.y + 2

packsImg.x = packsImg.x + (display.actualContentWidth - display.contentWidth) /2
packsCountText.x = packsCountText.x + (display.actualContentWidth - display.contentWidth) /2
packsShadowText.x = packsShadowText.x + (display.actualContentWidth - display.contentWidth) /2

coinsCountText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
coinsShadowText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)

coinsCountText:setFillColor(1,206/255,0)
coinsShadowText:setFillColor(128/255,97/255,40/255)
coinsShadowText.y = coinsCountText.y + 2

coinImg.x = coinImg.x + (display.actualContentWidth - display.contentWidth) /2
coinsCountText.x = coinsCountText.x + (display.actualContentWidth - display.contentWidth) /2
coinsShadowText.x = coinsShadowText.x + (display.actualContentWidth - display.contentWidth) /2

-- --local scrollView
-- local icons = {}
  

  local background = display.newImage("PacksScreen/BackGround.jpg")
     background.x = 240
     background.y = 160
     
     background.xScale = display.actualContentWidth / background.contentWidth 
     background.yScale = display.actualContentHeight  / background.contentHeight

    

      ballPackSpine =  require ("ballPack")
      ballPack = ballPackSpine.new(0.6, true)
      
      ballPack.skeleton.group.x = 240
       ballPack.skeleton.group.y = 300

      -- local rewardsSpineAn = require "reward"

      -- reward = rewardsSpineAn.new(2)
      --  reward.skeleton.group.x = 240
      --  reward.skeleton.group.y = 100

    
        local function backButtonListener( event )

           if ( "ended" == event.phase ) then
               local options = {params = {gameData = commonData.gameData}}
               commonData.playSound( backMenuSound ) 
              composer.gotoScene( "menu" , options )
            
          end
          return true
         end

         local function useButtonListener( event )

           if ( "ended" == event.phase ) then
                
                commonData.playSound( backMenuSound ) 
           
                if (itemRewardCategory == "shirts") then
                    commonData.selectedShirt = itemReward.id                    
                end  

                 if (itemRewardCategory == "skins") then
                   commonData.selectedSkin = itemReward.id
                end  

                 if (itemRewardCategory == "balls") then
                   commonData.selectedBall = itemReward.id
                end  

                if (itemRewardCategory == "shoes") then
                   commonData.selectedShoes = itemReward.id
                end  


                if (itemRewardCategory == "pants") then
                   commonData.selectedPants = itemReward.id
                end  


                 
              commonData.gameData.selectedBall = commonData.selectedBall                  
              commonData.gameData.selectedShirt = commonData.selectedShirt 
              commonData.gameData.selectedSkin = commonData.selectedSkin 
              commonData.gameData.selectedShoes = commonData.selectedShoes 

              commonData.saveTable(commonData.gameData , GAME_DATA_FILE, true)
              
              useButton.alpha = 0 
              rewardBoxBackgroundGreen.alpha = 1
          end
          return true
         end

         local function continueListener( event )

           if ( "ended" == event.phase ) then
              
              commonData.playSound( backMenuSound ) 
              rewardBox.alpha = 0
              ballGlowImg.alpha = 0 
              if itemRewardImg then
                itemRewardImg:removeSelf()
                itemRewardImg = nil
              end

              if itemRewardImg2 then
                itemRewardImg2:removeSelf()
                itemRewardImg2 = nil
              end  

             itemRewardCategory = nil
             itemReward = nil

             if (commonData.gameData.packs == 0 and commonData.gameData.gamesCount == 0 ) then
              local options = {params = {gameData = commonData.gameData}}               
              composer.gotoScene( "menu" , options )

             else
               
              dropNewBall()              
             end
              
              
            
            end
          return true
         end
         


        local function getTrophieListener( event )

           if ( "ended" == event.phase ) then
              commonData.gameData.coins = commonData.gameData.coins  - 100
              commonData.gameData.usedcoins =  commonData.gameData.usedcoins + 100
              commonData.gameData.packs = commonData.gameData.packs + 1
              commonData.gameData.packsBought = commonData.gameData.packsBought + 1
              setCoinsCount(nil)
              
              commonData.saveTable(commonData.gameData , GAME_DATA_FILE)
              logPacks(commonData.gameData)
              


             if (commonData.gameData.packs == 1) then
                  rewardBox.alpha = 0
                  ballGlowImg.alpha = 0 
                  if itemRewardImg then
                    itemRewardImg:removeSelf()
                    itemRewardImg = nil
                  end

                  if itemRewardImg2 then
                    itemRewardImg2:removeSelf()
                    itemRewardImg2 = nil
                  end  

                 itemRewardCategory = nil
                 itemReward = nil
                 
                 dropNewBall()
             end
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

      
    
       local buyTrophie = widget.newButton
      {
          x = 400,
          y = 270,
          id = "buyTrophie",
          defaultFile = "PacksScreen/GetTrophieUp.png",
          overFile = "PacksScreen/GetTrophieDown.png",
          onEvent = getTrophieListener
      }
      buyTrophie:scale(0.8,0.8)

      buyTrophieDisabled  = display.newImage("PacksScreen/GetTrophieDisabled.png")
      

      buyTrophie.x = buyTrophie.x  + (display.actualContentWidth - display.contentWidth) /2
      buyTrophieDisabled.width = buyTrophie.contentWidth
      buyTrophieDisabled.height = buyTrophie.contentHeight
      buyTrophieDisabled.x = buyTrophie.x 
      buyTrophieDisabled.y = buyTrophie.y 

      local function nullListener( event )
          
         return true
       end

     buyTrophieDisabled:addEventListener("touch", nullListener )

      useButton = widget.newButton
      {
          x = 240,
          y = 240,
          id = "useButton",
          defaultFile = "PacksScreen/UseNow.png",
          overFile = "PacksScreen/UseNowDown.png",
          onEvent = useButtonListener
      }
      useButton:scale(0.4,0.4)

     local continueButton = widget.newButton
      {
          x = 240,
          y = 200,
          id = "continueButton",
          defaultFile = "PacksScreen/Continue.png",
          overFile = "PacksScreen/ContinueDown.png",
          onEvent = continueListener
      }
      continueButton:scale(0.4,0.4)

      rewardBox = display.newGroup()

      local rewardBoxBackground  = display.newImage("PacksScreen/RewardBox.png")
      rewardBoxBackgroundGreen  = display.newImage("PacksScreen/RewardBox.png")
     coinsReward  = display.newImage("PacksScreen/Coins.png")

      youWonText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
      youWonSText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
      --coinsCount = 0
      youWonText:setFillColor(1,206/255,0)
      youWonSText:setFillColor(128/255,97/255,40/255)

      youWonText.y = 45
      youWonText.x = 240
      youWonSText.y = youWonText.y + 2
      youWonSText.x =  youWonText.x 

      youWonText.text = "YOU WON!"      
      youWonSText.text = "YOU WON!"

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

      rewardBoxBackground.x = 240
      rewardBoxBackground.y = 100
      rewardBoxBackground:scale(0.4,0.4)

      rewardBoxBackgroundGreen.x = 240
      rewardBoxBackgroundGreen.y = 100
      rewardBoxBackgroundGreen:scale(0.42,0.42)
      rewardBoxBackgroundGreen:setFillColor(0,1,0)

      


      coinsReward.x = 240
      coinsReward.y = 100
      coinsReward:scale(0.4,0.4)


      rewardBox:insert(rewardBoxBackgroundGreen)
      rewardBox:insert(rewardBoxBackground)
      rewardBox:insert(youWonSText)
      rewardBox:insert(youWonText)
      rewardBox:insert(priceSText)
      rewardBox:insert(priceText)
      
      rewardBox:insert(coinsReward)
      
      rewardBox:insert(useButton)
      rewardBox:insert(continueButton)      

      sceneGroup:insert(background)
      sceneGroup:insert(ballGlowImg)
      

      sceneGroup:insert(coinImg)
      sceneGroup:insert(packsImg)

      sceneGroup:insert(packsShadowText)
      sceneGroup:insert(packsCountText)

      
      sceneGroup:insert(coinsShadowText)
      sceneGroup:insert(coinsCountText)

      
     sceneGroup:insert(ballPack.skeleton.group)
     --sceneGroup:insert(reward.skeleton.group)

    
     sceneGroup:insert(backButton)
     sceneGroup:insert(buyTrophie)
     sceneGroup:insert(buyTrophieDisabled)
       

     sceneGroup:insert(rewardBox)

    
end

-- "scene:show()"

local function showCoins()
    -- reward:init()
    -- reward.skeleton.group.alpha = 1

    
end

local function handleCoinsPrize(coinsPrice)
    coinsReward.alpha = 1
    useButton.alpha = 0

    priceText.text = coinsPrice .. " COINS"
    priceSText.text = coinsPrice .. " COINS"

    coinsCount = coinsCount + coinsPrice
    commonData.gameData.coins = coinsCount
    setCoinsCount(nil)
    commonData.saveTable(commonData.gameData , GAME_DATA_FILE)

end


local function handleItemPrize()
    

       local  accuSum = 0        
      -- for key,cat in pairs(items) do
      --   for i=1,#cat do
      --      if not cat[i].packCategory then

                
      --      end 
      --   end
      --  end 
      local  categoryIdx = 4
      rewardBoxBackgroundGreen.alpha = 0
      local shopItemsCount = 0
      local  itemIdx = nil
      local itemToBuy = nil
      
       for k,v in pairs(commonData.shopItems) do
           shopItemsCount = shopItemsCount + 1
      end
                  
             
       for i=1,math.random(10) + 10  do
          
           local categoryRnd  = math.random(5000)
           if categoryRnd == 1 then
              categoryIdx = 1
           elseif categoryRnd < 27 then
              categoryIdx = 2
           elseif categoryRnd  < 1028 then
              categoryIdx = 3
           else  
              categoryIdx = 4
           end  
           
           
         itemIdx = math.random(#packCategories[categoryIdx])  

        itemToBuy = packCategories[categoryIdx][itemIdx]
        
         
       end

       commonData.analytics.logEvent( "openPack", {  categoryIdx= tostring( categoryIdx ) } ) 
           
          while (shopItemsCount <= 10 and  commonData.shopItems[itemToBuy.id]) do
            categoryIdx = 4
            itemIdx = math.random(#packCategories[categoryIdx])  
            itemToBuy = packCategories[categoryIdx][itemIdx]    
          end  
   --       if (cat[i].packChance) then
    --        if (prizeItemRnd <= accuSum + cat[i].packChance ) then
         
         if (commonData.shopItems[itemToBuy.id]) then
            -- item allready owned
             
             commonData.gameData.coins = commonData.gameData.coins  + 20
             setCoinsCount(nil)
             youWonText.text = "TRY AGAIN! (+20)"      
             youWonSText.text = "TRY AGAIN! (+20)"

         else 
             youWonText.text = "YOU WON!"      
             youWonSText.text = "YOU WON!"

             commonData.playSound(packNewRewardSound)

         end
            
         coinsReward.alpha = 0
         useButton.alpha = 1

         commonData.shopItems[itemToBuy.id] = true
         priceText.text = itemToBuy.name
         priceSText.text = itemToBuy.name

         itemRewardCategory = itemToBuy.itemCategory
         itemReward = itemToBuy


         if (itemToBuy.image2) then
            itemRewardImg2 = display.newImage(itemToBuy.image2) -- "",0,0, "troika" , 24)
             if (itemRewardImg2) then
                 itemRewardImg2.y = 85
                 itemRewardImg2.x = 238
                 if (itemToBuy.imgScale) then
                  itemRewardImg2:scale(itemToBuy.imgScale * 0.6, itemToBuy.imgScale * 0.6)
                 end
                 rewardBox:insert(itemRewardImg2)
            end
        end

        if (itemToBuy.image) then
            itemRewardImg = display.newImage(itemToBuy.image) -- "",0,0, "troika" , 24)
             if (itemRewardImg) then
                 itemRewardImg.y = 100 
                 itemRewardImg.x = 240
                 if (itemToBuy.imgScale) then
                  itemRewardImg:scale(itemToBuy.imgScale * 0.6, itemToBuy.imgScale * 0.6)
                 end

                 if (itemToBuy.color) then
                  itemRewardImg:setFillColor(itemToBuy.color.r , 
                                   itemToBuy.color.g ,
                                   itemToBuy.color.b)
                 end
                 rewardBox:insert(itemRewardImg)
            end
        end

       commonData.saveTable(commonData.shopItems , SHOP_FILE)
       commonData.saveTable(commonData.gameData , GAME_DATA_FILE)


--          end

    return



end

local function buildCoinsPrice()
    
    rewardBox.alpha = 1
    
    handleCoinsPrize(15 + math.random(15)) 
end

local function buildPrice()
    
    rewardBox.alpha = 1
    commonData.playSound( packRewardSound )    
    
    handleItemPrize()    
end

local function rotateSpinner()
    
    ballGlowImg.rotation = ballGlowImg.rotation + 2

    if  ballGlowImg.alpha > 0 then
      if  ballGlowImg.alpha < 1 then
        ballGlowImg.alpha = ballGlowImg.alpha +  0.04
      end
        
        timer.performWithDelay(50, rotateSpinner, 1)
    end
end

local function showSpinner()
    
    ballGlowImg.alpha = 0.1
    timer.performWithDelay(200, rotateSpinner, 1)
end

function packsTouched(event )

   if ( event.phase == "ended"  and isPackReady) then
      
      isPackReady = false
      if (commonData.gameData.packs > 0) then
        
        commonData.gameData.packs = commonData.gameData.packs - 1
        commonData.gameData.usedpacks = commonData.gameData.usedpacks + 1
        commonData.saveTable(commonData.gameData , GAME_DATA_FILE)
              
        
        setCoinsCount(nil)
        commonData.playSound( packOpeningSound )      
        ballPack:openSpecial()
       -- local rnd = math.random(100)
        
        -- if (rnd > 85) then
        
        --   timer.performWithDelay(700, showCoins, 1)
        --   timer.performWithDelay(1700, buildCoinsPrice, 1)          
        -- else
       
          timer.performWithDelay(500, showSpinner, 1)
          timer.performWithDelay(1500, buildPrice, 1)
       -- end  
                      
      end
       
   end                 
end


function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).

      if itemRewardImg then
        itemRewardImg:removeSelf()
        itemRewardImg = nil
      end

      if itemRewardImg2 then
        itemRewardImg2:removeSelf()
        itemRewardImg2 = nil
      end  
      
     itemRewardCategory = nil
     itemReward = nil

   elseif ( phase == "did" ) then
    
    --commonData.gameData.packs = 5
    ballPack:init()
    rewardBox.alpha = 0
     ballGlowImg.alpha = 0
    if(event.params and event.params.gameData) then
           coinsCount = commonData.gameData.coins  
           setCoinsCount()

           if (commonData.gameData.packs > 0) then
              dropNewBall()
           else
            
              -- ballPack.skeleton.group.alpha = 0
             
           end 
      end
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
       Runtime:addEventListener("touch", packsTouched, -1)
       
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
      ballPack:pause()
   
   

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

