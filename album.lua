local commonData = require( "commonData" )

local composer = require( "composer" )
local widget = require( "widget" )

--store.purchase({ id }) to:


local scene = composer.newScene()


local buyButton = nil
local useButton = nil
local backButton = nil
local useText = nil
local continueText= nil

local priceSText = nil
local priceText = nil
local levelSelectGroup = nil
local indexGroup = nil
local openCardsGroup = nil
local pickPackGroup = nil


local itemReward = nil
local buyWithCashText = nil
local buyWithCoinsText = nil

local itemRewardImg = nil
local itemRewardImg2 = nil
local youWonText = nil
local youWonSText = nil
local itemRewardCategory = nil

local coinsCount = 0

local  reward = nil

local packOpeningSound = audio.loadSound( "PackOpening.mp3" )
local packRewardSound = audio.loadSound( "PackReward.mp3" )
local packNewRewardSound = audio.loadSound( "Celebration.mp3" )
local  indexArrow = display.newImage("images/album/IndexArrow.png")
local  tradeBar = nil

local commonCountText = display.newText({text="0" , x = 120, y = 270, font = "UnitedSansRgHv", fontSize = 15,align = "center"})
local rareCountText = display.newText({text="0" , x = 220, y = 270, font = "UnitedSansRgHv", fontSize = 15,align = "center"})
local epicCountText = display.newText({text="0" , x = 320, y = 270, font = "UnitedSansRgHv", fontSize = 15,align = "center"})
local packsCountText = display.newText({text="0" , x = 320, y = 270, font = "UnitedSansRgHv", fontSize = 15,align = "center"})
local doublesCountText = display.newText({text="0" , x = 320, y = 270, font = "UnitedSansRgHv", fontSize = 10,align = "center"})
local doubleBar = display.newRect(5,5,5,5)
doubleBar:setFillColor(0,1,0)
local dummy = nil
local claimButtons = {}
local tradeButtonDisabled = nil
local tradeButton = nil


local rewards = {
  {id = "blok", row = 1 , fromIdx = 1, toIdx = 2 , isItem = true , category="skins" , catIdx= 3},
  {id = "group", row = 2.5 , fromIdx = 3, toIdx = 9 , isItem = false , coins = 50},
  {id = "shakes", row = 4.5 , fromIdx = 10, toIdx = 18, isItem = false , gems=1},
  {id = "shakes", row = 6.5 , fromIdx = 19, toIdx = 27, isItem = false , coins = 50},
  {id = "shakes", row = 8.5 , fromIdx = 28, toIdx = 36, isItem = false , gems=1},
  {id = "shakes", row = 10.5 , fromIdx = 37, toIdx = 45, isItem = false , coins = 100},
  {id = "shakes", row = 12.5 , fromIdx = 46, toIdx = 54, isItem = false , gems=1},
  {id = "shakes", row = 14.5 , fromIdx = 55, toIdx = 63, isItem = true , category="boosts" , catIdx= 3},
  {id = "shakes", row = 16.5 , fromIdx = 64, toIdx = 72, isItem = false , coins = 150},
    {id = "shakes", row = 18.5 , fromIdx = 73, toIdx = 81, isItem = false , gems=2},
      {id = "shakes", row = 20.5 , fromIdx = 82, toIdx = 90, isItem = true , category="balls" , catIdx= 5,scaleAn = 1.6},
        {id = "shakes", row = 22.5 , fromIdx = 91, toIdx = 99, isItem = false , coins = 200},
          {id = "shakes", row = 24.5 , fromIdx = 100, toIdx = 108, isItem = false , coins = 200},
            {id = "shakes", row = 26.5 , fromIdx = 109, toIdx = 117, isItem = true , category="boosts" , catIdx= 6},
              {id = "shakes", row = 28.5 , fromIdx = 118, toIdx = 126, isItem = false , coins = 300},
                {id = "shakes", row = 30.5 , fromIdx = 127, toIdx = 135, isItem = false , gems=3},
                  {id = "shakes", row = 32.5 , fromIdx = 136, toIdx = 144, isItem = true , category="balls" , catIdx= 6,scaleAn = 1.6},
                    {id = "shakes", row = 34.5 , fromIdx = 145, toIdx = 153, isItem = false , coins = 400},
                      {id = "shakes", row = 36.5 , fromIdx = 154, toIdx = 162, isItem = false ,  gems=5},
                        {id = "shakes", row = 38.5 , fromIdx = 163, toIdx = 171, isItem = true , category="skins" , catIdx= 6},
                          {id = "shakes", row = 40.5 , fromIdx = 172, toIdx = 180, isItem = true , category="skins" , catIdx= 7},
                            
} 



local function updateDoubles( )
  
  doublesCountText.text = commonData.gameData.doubleCards .. "/5"

  local min = math.min(commonData.gameData.doubleCards, 5 )
  doubleBar.xScale = 1
  doubleBar.xScale =  (min  / 5 )* tradeBar.contentWidth / doubleBar.contentWidth
  doubleBar.yScale = 1
  doubleBar.yScale =  0.7 * tradeBar.contentHeight / doubleBar.contentHeight
  doubleBar.x = tradeBar.x - tradeBar.contentWidth/2 + doubleBar.contentWidth/2
  doubleBar.y = tradeBar.y

  if commonData.gameData.doubleCards >= 5 then
    tradeButtonDisabled.alpha = 0
    tradeButton.alpha = 1
  else
    tradeButtonDisabled.alpha = 1
    tradeButton.alpha = 0
  end

  
end 

local function updateRewards()
      for i=1,#rewards do
          local isRewardAvailable = true
          for j=rewards[i].fromIdx,rewards[i].toIdx do
            if not commonData.gameData.cards[commonData.collection[j].id] then
              isRewardAvailable = false
              break
            end  
          end  

          if isRewardAvailable and not commonData.gameData.claimedRewards[i] then
            claimButtons[i].alpha  =1
          else
            claimButtons[i].alpha  =0
          end
      end
end 

local gradient = {
          type="gradient",
          color2={ 255/255,241/255,208/255,1}, color1={ 255/255,255/255,255/255,1 }, direction="up"
      }
      local rowsNum = 1
       for i=1,#commonData.collection do
          if (commonData.collection[i].row > rowsNum) then
            rowsNum = commonData.collection[i].row
          end  
       end



local function insertCards(fromIdx, toIdx, skipDevider )
   for i=fromIdx,toIdx do
          local card  = nil

          if commonData.gameData.cards[commonData.collection[i].id] then
          --if commonData.collection[i].type == 3 then
            --card = display.newImage(collection[i].img)  
            --card = display.newImage("images/album/DemoCard.png")  

            
                local cardStr = i

                if i < 100 then
                  cardStr = "0" .. cardStr
                end

                if i < 10 then
                  cardStr = "0" .. cardStr
                end
                  
                 card  = display.newImage("images/album/Cards Frames" .. cardStr .. ".png")  
                
            
          else              

            card = display.newImage("images/album/Cards Frames000.png")  
          end  

       
          card.xScale = levelSelectGroup.contentWidth * 0.15  / card.contentWidth 
          card.yScale = card.xScale 

          card.x =  (card.contentWidth + 5)* (commonData.collection[i].col - 0.5)  --+ levelSelectGroup.x - levelSelectGroup.contentWidth /2  + 10
          card.y =  (card.contentHeight +10 )* (commonData.collection[i].row - 0.5)  --+ levelSelectGroup.y - levelSelectGroup.contentHeight /2 + 10

          if (commonData.collection[i].row % 2 == 0) then
            card.y = card.y + 8
            if (commonData.collection[i].col == 1 and not skipDevider) then

              local divider =display.newImage("images/album/Devider.png")  
              divider.xScale = levelSelectGroup.contentWidth / divider.contentWidth
              divider.yScale = divider.xScale
              divider.y = card.y - card.contentHeight /2 - 8
              divider.x = divider.contentWidth/2
              --divider:setFillColor(0.5,0.5,0.5)

              levelSelectGroup:insert(divider)
            end
          end  

          levelSelectGroup:insert(card)



          local cardSmall = display.newRect(3,3,3,3)
          

          cardSmall.yScale = (display.actualContentHeight/  (rowsNum))  / (cardSmall.contentHeight + 3)
          cardSmall.xScale = cardSmall.yScale          

          cardSmall.x =  ( cardSmall.contentWidth + 3 )* commonData.collection[i].col + backButton.x + backButton.contentWidth/2 - ( cardSmall.contentWidth + 3 )* 6
          cardSmall.y =  (cardSmall.contentHeight + 3 ) * (commonData.collection[i].row - 0.5) + display.actualContentHeight* 0.15

          if (commonData.collection[i].row % 2 == 0) then
            cardSmall.y = cardSmall.y + 1
          end  

          if not commonData.gameData.cards then
            commonData.gameData.cards = {}
          end

          if commonData.gameData.cards[commonData.collection[i].id] then
            cardSmall:setFillColor(0, 1, 0)
          else  
            --cardSmall.fill.effect = "filter.grayscale"
            -- cardSmall:setFillColor(23/32, 23/32, 23/32)
            if commonData.collection[i].type == "epic" then
              cardSmall:setFillColor(0, 0, 140/256)      
            elseif commonData.collection[i].type == "rare" then
                cardSmall:setFillColor(0, 0, 190/256)    
            else
              cardSmall:setFillColor(0, 0, 1)
              
            end    
          end  

          indexGroup:insert(cardSmall)
         
      end  
end 

 

 
-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view



local widget = require( "widget" )



local backMenuSound = nil

backMenuSound = audio.loadSound( "BtnPress.mp3" )


-- --local scrollView
-- local icons = {}
  

  local background = display.newImage("images/album/ScreenBG.jpg")
     background.x = 240
     background.y = 160
     
     background.xScale = display.actualContentWidth / background.contentWidth 
     background.yScale = display.actualContentHeight  / background.contentHeight

    

      
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


        local function claimRewardListener( event )

           if ( "ended" == event.phase ) then
              local rewardIndex  = event.target.id
               if not commonData.gameData.claimedRewards[rewardIndex] then
                commonData.gameData.claimedRewards[rewardIndex] = true

                if rewards[rewardIndex].gems then
                  commonData.gameData.gems = commonData.gameData.gems + rewards[rewardIndex].gems
                end  

                if rewards[rewardIndex].coins then
                  commonData.gameData.coins = commonData.gameData.coins + rewards[rewardIndex].coins
                end  


                if rewards[rewardIndex].isItem then
                  commonData.shopItems[commonData.catalog.items[rewards[rewardIndex].category][rewards[rewardIndex].catIdx].id] = true 
                  commonData.saveTable(commonData.shopItems , SHOP_FILE)
                end  
                
                commonData.saveTable(commonData.gameData , GAME_DATA_FILE, true)

                event.target.alpha = 0
               end 
            
          end
          return true
         end
         

       

         
      

        local function openPackButtonListener( event )

           if ( "ended" == event.phase ) then
              -- commonData.gameData.coins = commonData.gameData.coins  - 100
              -- commonData.gameData.usedcoins =  commonData.gameData.usedcoins + 100
              if event.target.packType == "common" and commonData.gameData.commonPacks > 0 then
                commonData.gameData.commonPacks = commonData.gameData.commonPacks - 1
              elseif event.target.packType == "rare" and commonData.gameData.rarePacks > 0 then  
                commonData.gameData.rarePacks = commonData.gameData.rarePacks - 1
              elseif event.target.packType == "epic" and commonData.gameData.epicPacks > 0 then    
                commonData.gameData.epicPacks = commonData.gameData.epicPacks - 1
              else
                return
              end  

              pickPackGroup.alpha=0

              packsCountText.text = commonData.gameData.commonPacks + commonData.gameData.rarePacks + commonData.gameData.epicPacks 
        
              
              
              commonData.saveTable(commonData.gameData , GAME_DATA_FILE)

               local options = { isModal = false,
                                       effect = "fade", 
                                       time = 1,
                                       params = {packType=event.target.packType}}
                 
              composer.showOverlay( "openPack" , options)  
  
             

          end
          return true
         end -- open pack

         local function pickPackButtonListener( event )

           if ( "ended" == event.phase ) then
              if commonData.gameData.commonPacks + commonData.gameData.rarePacks + commonData.gameData.epicPacks >0 then
                pickPackGroup.alpha = 1
                epicCountText.text = commonData.gameData.epicPacks
                rareCountText.text = commonData.gameData.rarePacks
                commonCountText.text = commonData.gameData.commonPacks
              end
              
              
          end
          return true
         end
            

            

       

       backButton = widget.newButton
      {
          x = 60,
          y = 20,
          id = "backButton",
          defaultFile = "MainMenu/EmptyBtnUp.png",          
          overFile = "MainMenu/EmptyBtnDown.png",          
          label = getTransaltedText("Back"),
          labelAlign = "left",
          font = "UnitedItalicRgHv",  
          fontSize = 64 ,           
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } },
          onEvent = backButtonListener
      }

       backButton.xScale =  (display.actualContentWidth*0.25) / backButton.width
       backButton.yScale = backButton.xScale  

      
      backButton.x = display.screenOriginX  + backButton.contentWidth /2
      local  backIcon = display.newImage("images/IcoBack.png")
      
      backIcon.yScale = (backButton.contentHeight * 0.4) / backIcon.contentHeight 
      backIcon.xScale = backIcon.yScale
      backIcon.y = backButton.y
      backIcon.x = backButton.x - backButton.contentWidth/2 + backIcon.contentWidth/2  + 3

       local  openPackButton = display.newImage("images/album/PackCommon.png")
        openPackButton:scale(0.3,0.3)
        openPackButton.y = 160
        openPackButton.x =240 - display.actualContentWidth/2 + openPackButton.contentWidth/2 - 15
        openPackButton.rotation = 75

        openPackButton:addEventListener("touch", pickPackButtonListener )

        local  cardCountBadge = display.newImage("images/album/CardCountBadge.png")
        cardCountBadge:scale(0.3,0.3)
        cardCountBadge.y = 180
        cardCountBadge.x =240 - display.actualContentWidth/2 + openPackButton.contentWidth/2
        packsCountText.x = cardCountBadge.x
        packsCountText.y = cardCountBadge.y

        packsCountText.text = commonData.gameData.commonPacks + commonData.gameData.rarePacks + commonData.gameData.epicPacks 
        


        local function tradeButtonListener( event )

           if ( "ended" == event.phase ) then
               local options = {params = {gameData = commonData.gameData}}
               commonData.playSound( backMenuSound ) 
              commonData.gameData.commonPacks = commonData.gameData.commonPacks + 1
              packsCountText.text = commonData.gameData.commonPacks + commonData.gameData.rarePacks + commonData.gameData.epicPacks 
              commonData.gameData.doubleCards = commonData.gameData.doubleCards  - 5
              updateDoubles()
              commonData.saveTable(commonData.gameData , GAME_DATA_FILE)
            
          end
          return true
         end

       tradeButton = widget.newButton
      {
          x = 60,
          y = 20,
          id = "tradeButton",
          defaultFile = "MainMenu/EmptyBtnUp.png",          
          overFile = "MainMenu/EmptyBtnDown.png",          
          label = "Trade Up",
          labelAlign = "center",
          font = "UnitedItalicRgHv",  
          fontSize = 64 ,           
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } },
          onEvent = tradeButtonListener
      }


       tradeButtonDisabled = widget.newButton
      {
          x = 60,
          y = 20,
          id = "tradeButton",
          defaultFile = "BlueSet/End/EGMainMenuDisabled.png",          
          
          label = "Trade Up",
          labelAlign = "center",
          font = "UnitedItalicRgHv",  
          fontSize = 32 ,  
          disabled = true,         
          labelColor = { default={ gradient } },
          
      }
      


       tradeButton.xScale =  (display.actualContentWidth*0.15) / tradeButton.width
       tradeButton.yScale = tradeButton.xScale  

      tradeButton.y= openPackButton.y + openPackButton.contentHeight + tradeButton.contentHeight
      tradeButton.x = display.screenOriginX  + tradeButton.contentWidth /2

      tradeButtonDisabled.yScale = tradeButton.contentHeight / tradeButtonDisabled.contentHeight 
      tradeButtonDisabled.xScale = tradeButtonDisabled.yScale
      tradeButtonDisabled.y = tradeButton.y
      tradeButtonDisabled.x = tradeButton.x + tradeButton.contentWidth/2 - tradeButtonDisabled.contentWidth/2



      local  tradeIcon = display.newImage("images/album/TradeUpIcon.png")
      
      tradeIcon.yScale = (tradeButton.contentHeight) / tradeIcon.contentHeight 
      tradeIcon.xScale = tradeIcon.yScale
      tradeIcon.y = tradeButton.y - 5
      tradeIcon.x = tradeButton.x - tradeButton.contentWidth/2 + tradeIcon.contentWidth/2  + 3

      tradeBar = display.newImage("images/album/TradeUpBarBG.png")
      
      tradeBar.xScale = (tradeButton.contentWidth) / tradeBar.contentWidth 
      tradeBar.yScale = tradeBar.xScale
      tradeBar.y = tradeButton.y - tradeButton.contentHeight/2 - tradeBar.contentHeight/2 
      tradeBar.x = tradeButton.x 

      doublesCountText.y = tradeBar.y
      doublesCountText.x = tradeBar.x + 30
      doublesCountText.text = "3/5"



    
       local coinTextOptions = 
      {
         
          text = "",     
          x = 0,
          y = 155,
          width = 120,     --required for multi-line and alignment
          font = "UnitedSansRgHv",   
          fontSize = 13,
          align = "center"  --new alignment parameter
      }


      local function printTable( t, label, level )
  if label then print( label ) end
  level = level or 1

  if t then
    for k,v in pairs( t ) do
      local prefix = ""
      for i=1,level do
        prefix = prefix .. "\t"
      end

      print( prefix .. "[" .. tostring(k) .. "] = " .. tostring(v) )
      if type( v ) == "table" then
        print( prefix .. "{" )
        printTable( v, nil, level + 1 )
        print( prefix .. "}" )
      end
    end
  end
end

  
      local function scrollListener( event )
              
               if (levelSelectGroup.isLocked) then
                return true
               end

              local phase = event.phase

               if ( phase == "began" ) then isVelocity = true
                  elseif ( phase == "moved" or phase == "stopped"   ) then
                    local x, y = levelSelectGroup:getContentPosition() 

                    print(y/ (dummy.contentHeight +10))
                    indexArrow.y = -6.5 * y/ (dummy.contentHeight +10)  + display.actualContentHeight* 0.15

                      elseif ( phase == "ended" or phase == "cancelled" ) then isVelocity = false
              end

              if ( event.limitReached ) then
                  if ( event.direction == "left" ) then levelSelectGroup._view._velocity = 0
                      elseif ( event.direction == "right" ) then levelSelectGroup._view._velocity = 0 
                  end
              end

              return true
              
          end


        levelSelectGroup = widget.newScrollView({
                                width = display.actualContentWidth  * 0.75,
                                height = display.actualContentHeight,
                                isLocked = false,
                                friction = 0, 
                                isBounceEnabled = false,
                                hideBackground = true,
                                hideScrollBar = false,
                        
                                listener = scrollListener })

        
          levelSelectGroup.x =  backButton.x + backButton.contentWidth/2 + levelSelectGroup.contentWidth/2
        --  levelSelectGroup.x = levelSelectGroup.x  + (display.actualContentWidth - display.contentWidth) /2

          levelSelectGroup.y = display.contentCenterY 
          resolutionFactor = 23 -  (levelSelectGroup.x - levelSelectGroup.width / 2)

      
         local function indexClickListener( event )   
              if ( "ended" == event.phase ) then
                 

          
            local cardHeight = 3 * (display.actualContentHeight/  (rowsNum))  / (6)
            print(event.y)

            local goToRow = (event.y - display.actualContentHeight* 0.15) / (6.5)
            print(goToRow)

          -- display.actualContentHeight + (-1) * levelSelectGroup:getView().contentHeight  * 
          --             ((event.y - backButton.contentHeight)  / (display.actualContentHeight - backButton.contentHeight) )
 
                 levelSelectGroup:scrollToPosition
                  {                      
                      y = (-1) * goToRow * (dummy.contentHeight +10),
                      time = 800,                      
                  }
                  indexArrow.y = event.y

              end
              return true
           end
        local cardSmall = display.newRect(5,5,5,5)
          

          cardSmall.yScale = (display.actualContentHeight* 0.8 /  40)  / (cardSmall.contentHeight + 3)
          cardSmall.xScale = cardSmall.yScale          
          cardSmall.alpha = 0
         
        local indexRect2 = display.newRect(backButton.x + backButton.contentWidth/2  - (cardSmall.contentWidth+3) * 3 ,backButton.contentHeight + backButton.y / 2 + (display.actualContentHeight -backButton.contentHeight) / 2   
            , (cardSmall.contentWidth + 3) * 6 , display.actualContentHeight -backButton.contentHeight)
        --local blackRect2 = display.newRect(240, 170, 800,600)
        indexRect2:setFillColor(0, 0, 0)
        indexRect2.alpha = 0.01
        indexRect2:addEventListener("touch", indexClickListener )

        indexArrow.x = indexRect2.x - indexRect2.contentWidth/2
        indexArrow.y = indexRect2.y + indexArrow.contentHeight/2 - indexRect2.contentHeight/2
              


       
      indexGroup = display.newGroup()    
      indexGroup:insert(indexRect2)
      openCardsGroup= display.newGroup()    
      pickPackGroup= display.newGroup()    


      
      local blackRect2 = display.newRect(240, 170, 800,600)
              blackRect2:setFillColor(0, 0, 0)
              blackRect2.alpha = 0.9              

              local function boosterRectListener( event )   
        
                    return true
               end

              blackRect2:addEventListener("touch", boosterRectListener )

              pickPackGroup:insert(blackRect2)




      local  openPack1 = display.newImage("images/album/PackCommon.png")
      openPack1:scale(0.4,0.4)
      openPack1.y = 200
      openPack1.x =140 
      openPack1.rotation = 20
      openPack1.packType = "common"
      openPack1:addEventListener("touch", openPackButtonListener )
        local  openPack2 = display.newImage("images/album/PackRare.png")
      openPack2:scale(0.4,0.4)
      openPack2.y = 200
      openPack2.x =240 
      openPack2.rotation = 20
      openPack2.packType = "rare"
      openPack2:addEventListener("touch", openPackButtonListener )
      local  openPack3 = display.newImage("images/album/PackEpic.png")
      openPack3:scale(0.4,0.4)
      openPack3.y = 200
      openPack3.x =340 
      openPack3.packType = "epic"
      openPack3.rotation = 20
      openPack3:addEventListener("touch", openPackButtonListener )

      local  cardCountBadge1 = display.newImage("images/album/CardCountBadge.png")
      cardCountBadge1:scale(0.3,0.3)
      cardCountBadge1.y = 270
      cardCountBadge1.x =160
      local  cardCountBadge2 = display.newImage("images/album/CardCountBadge.png")
      cardCountBadge2:scale(0.3,0.3)
      cardCountBadge2.y = 270
      cardCountBadge2.x =260
      local  cardCountBadge3 = display.newImage("images/album/CardCountBadge.png")
      cardCountBadge3:scale(0.3,0.3)
      cardCountBadge3.y = 270
      cardCountBadge3.x =360
         local gradient = {
          type="gradient",
          color3={ 255/255,1,1,1}, color2={ 255/255,241/255,208/255,1}, color1={ 1, 180/255, 0,1 }, direction="up"
      }
      commonCountText.x = cardCountBadge1.x
      commonCountText.y = cardCountBadge1.y
      rareCountText.x = cardCountBadge2.x
      rareCountText.y = cardCountBadge2.y
      epicCountText.x = cardCountBadge3.x
      epicCountText.y = cardCountBadge3.y



      local pickText = display.newText({text="PICK A PACK" , x = 240, y = 80, font = "UnitedSansRgHv", fontSize = 45,align = "center"})
      local commonText = display.newText({text="Common" , x = 120, y = 270, font = "UnitedSansRgHv", fontSize = 15,align = "center"})
      local rareText = display.newText({text="Rare" , x = 220, y = 270, font = "UnitedSansRgHv", fontSize = 15,align = "center"})
      local epicText = display.newText({text="Epic" , x = 320, y = 270, font = "UnitedSansRgHv", fontSize = 15,align = "center"})

      pickText:setFillColor(gradient)
      epicText:setFillColor(gradient)
      rareText:setFillColor(0,0,1)

        
      pickPackGroup:insert(openPack1)
      pickPackGroup:insert(openPack2)
      pickPackGroup:insert(openPack3)
      pickPackGroup:insert(cardCountBadge1)
      pickPackGroup:insert(cardCountBadge2)
      pickPackGroup:insert(cardCountBadge3)
      pickPackGroup:insert(commonText)
      pickPackGroup:insert(rareText)
      pickPackGroup:insert(epicText)
      pickPackGroup:insert(pickText)
      pickPackGroup:insert(rareCountText)
      pickPackGroup:insert(epicCountText)
      pickPackGroup:insert(commonCountText)
      

      pickPackGroup.alpha =0

      dummy = display.newImage("images/album/Cards Frames000.png")  

          dummy.xScale = levelSelectGroup.contentWidth * 0.15  / dummy.contentWidth 
          dummy.yScale = dummy.xScale 
          dummy.alpha = 0

          sceneGroup:insert(dummy)
      sceneGroup:insert(background)
      
     sceneGroup:insert(levelSelectGroup)
     sceneGroup:insert(indexGroup)
     sceneGroup:insert(indexArrow)

     sceneGroup:insert(backButton)
     sceneGroup:insert(backIcon)
     sceneGroup:insert(openPackButton)
     sceneGroup:insert(cardCountBadge)
     sceneGroup:insert(packsCountText)


     
     sceneGroup:insert(tradeBar)
     sceneGroup:insert(doubleBar)
     
     sceneGroup:insert(doublesCountText)
     
     sceneGroup:insert(tradeButton)
     sceneGroup:insert(tradeButtonDisabled)
     

     sceneGroup:insert(tradeIcon)
     
     
     
     
     sceneGroup:insert(openCardsGroup)
     
     





      
       local gradient = {
                      type="gradient",
                      color2={ 255/255,241/255,208/255,1}, color1={ 1, 180/255, 0,1 }, direction="up"
                  }


for i=1,#rewards do
          local card  = nil
          
          if rewards[i].isItem then            
            local item = commonData.catalog.items[rewards[i].category][rewards[i].catIdx]
          
            card  = display.newImage(item.image)            
            if rewards[i].scaleAn then
              card.yScale = rewards[i].scaleAn
              card.xScale = rewards[i].scaleAn
            end  
          elseif rewards[i].gems then
            card  = display.newImage("images/shop/gems/3.png")
          else --coins
            card  = display.newImage("images/IcoCoins.png")            
            card.yScale = 1.4
            card.xScale = card.yScale 
          end  

          

          --card.xScale = levelSelectGroup.contentWidth * 0.15  / card.contentWidth 
          card.yScale = math.min(dummy.contentHeight  / card.contentHeight, dummy.contentWidth  / card.contentWidth) 
          card.xScale = card.yScale 

          card.x =  levelSelectGroup.contentWidth  -  card.contentWidth/2 
          card.y =  (dummy.contentHeight + 10 )* (rewards[i].row - 0.5) 

          local claimButton = widget.newButton
          {
              x = card.x,
              y = card.y + 35,
              id = i,
              defaultFile = "BlueSet/End/EGShareUp.png",          
              overFile = "BlueSet/End/EGShareDown.png",          
              label = "Claim",
              labelAlign = "center",
              font = "UnitedItalicRgHv",  
              fontSize = 50 ,           
              labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } },
              onEvent = claimRewardListener
          }

          claimButton.xScale =  (display.actualContentWidth*0.1) / claimButton.width
          claimButton.yScale = claimButton.xScale 

          claimButtons[i] =  claimButton

          local background =  display.newImage("images/album/RewardBG.png")

          background.yScale =   dummy.contentHeight  / background.contentHeight      
          background.xScale =  background.yScale

          background.x = card.x
          background.y = card.y
          levelSelectGroup:insert(background)
          levelSelectGroup:insert(card)
          levelSelectGroup:insert(claimButton)

          if rewards[i].gems or rewards[i].coins then
            local rewardText = display.newText({text="0" , x = 120, y = 270, font = "UnitedSansRgHv", fontSize = 15,align = "center"})
            if rewards[i].gems then
              rewardText.text = rewards[i].gems
              rewardText:setFillColor(0,1,0)
            else
              rewardText.text = rewards[i].coins
              rewardText:setFillColor(1,206/255,0)
            end  

            rewardText.x = background.x
            rewardText.y = background.y + background.contentHeight/2 - rewardText.contentHeight/2 - 3
            levelSelectGroup:insert(rewardText)
          end  

         
        
end 

                    
     -- for i=1,#commonData.collection do
     --      local card  = nil

         
     --      local cardSmall = display.newRect(5,5,5,5)
          

     --      cardSmall.yScale = (display.actualContentHeight* 0.8 /  (rowsNum))  / (cardSmall.contentHeight + 3)
     --      cardSmall.xScale = cardSmall.yScale          

     --      cardSmall.x =  ( cardSmall.contentWidth + 3 )* commonData.collection[i].col + backButton.x + backButton.contentWidth/2 - ( cardSmall.contentWidth + 3 )* 6
     --      cardSmall.y =  (cardSmall.contentHeight + 3 ) * (commonData.collection[i].row - 0.5) - display.actualContentHeight* 0.4 + 165

     --      if (commonData.collection[i].row % 2 == 0) then
     --        cardSmall.y = cardSmall.y + 1
     --      end  


     --      if not commonData.gameData.cards then
     --        commonData.gameData.cards = {}
     --      end

     --      if commonData.gameData.cards[commonData.collection[i].id] then
     --        cardSmall:setFillColor(gradient)
     --      else  
     --        --cardSmall.fill.effect = "filter.grayscale"
     --        cardSmall:setFillColor(23/32, 23/32, 23/32)
     --      end  

     --      indexGroup:insert(cardSmall)
     --  end  
    --commonData.gameData.packs = 5
    
    insertCards(1,180) 

     
     --sceneGroup:insert(reward.skeleton.group)

    
       

     

    
end

-- "scene:show()"

local function showCoins()
    -- reward:init()
    -- reward.skeleton.group.alpha = 1

    
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

      
      
      
      backButton:setLabel(getTransaltedText("Back"))


   elseif ( phase == "did" ) then
      
      for j = 1, openCardsGroup.numChildren do
         if (openCardsGroup[1]) and openCardsGroup[1].removeSelf then
          openCardsGroup[1]:removeSelf()
         end 
      end

      updateDoubles()
      packsCountText.text = commonData.gameData.commonPacks + commonData.gameData.rarePacks + commonData.gameData.epicPacks 

      if commonData.newCards and #commonData.newCards > 0 then
        for i=1,#commonData.newCards do
          insertCards(commonData.newCards[i],commonData.newCards[i], skipDevider)    
        end

        commonData.newCards = {}
      end

      updateRewards()
      
    -- local loadCardIdx = 20
    -- timer.performWithDelay(300, function ( )
    --   insertCards(loadCardIdx + 1 ,loadCardIdx + 20)
    --   loadCardIdx  = loadCardIdx + 20
    -- end,8)

    
    if(event.params and event.params.gameData) then
           coinsCount = commonData.gameData.coins  
           

      end
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
       
       
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

