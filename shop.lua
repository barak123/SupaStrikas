local commonData = require( "commonData" )

local composer = require( "composer" )
local widget = require( "widget" )

require ("achivmentsManager")


local BUTTON_1_Y = 130
local BUTTON_2_Y = 160
local BUTTON_3_Y = 190

local scene = composer.newScene()
local levelSelectGroup

local isVelocity = false
local scrollTo = false
local outerScrollTo = false
local coinsCount = 1

local seletedCategory = nil
local buyButton = nil
local useButton = nil
local areYouSurePopup = nil
local coinsCountText = nil
local coinsShadowText = nil
local selectedItemIdx = 1
local prevItem = nil
local heroSpine =  nil
local hero = nil
local currentProductList = nil

local  buyWithCoinsText = nil
local  itemToBuyImg = nil
local  itemToBuyImg2 = nil
local  itemDesc = nil

local byWithCoinsButton = nil

local byWithCoinsButtonIcon = nil

local resolutionFactor = 0
local  buyNotificationText = nil
local  buyNotificationRect = nil

local categories = nil
            

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------
 local function setCoinsCount(e)

    coinsShadowText.text = coinsCount
    coinsCountText.text =  coinsCount

  end  

 
 --local scrollView
local icons = {}

local function  selectedItemChanged( itemIdx )

  if (itemIdx and items[seletedCategory][itemIdx]) then
    
    selectedItemIdx = itemIdx
    itemDesc.text = items[seletedCategory][itemIdx].name
    if (items[seletedCategory][itemIdx] and commonData.shopItems[items[seletedCategory][itemIdx].id]) then
      useButton.alpha = 1
      buyButton.alpha = 0
    else
      useButton.alpha = 0
      buyButton.alpha = 1
    end

    if (items[seletedCategory][itemIdx].level > commonData.getLevel()) then
      useButton.alpha = 0
      buyButton.alpha = 0
    end
     
     if (seletedCategory == "skins") then
       commonData.shopSkin = items[seletedCategory][itemIdx].id

    end  

     if (seletedCategory == "balls") then
       commonData.shopBall = items[seletedCategory][itemIdx].id
     end  



     hero:pause()
      hero:reload()
      hero:init()
  end
end

local boutiqueFrame = nil
local function openCategory()
       Runtime:removeEventListener("enterFrame", boutiqueFrame)
        if (icons) then
          for i = 1, #icons do
             for j = 1, icons[i].numChildren do
               if (icons[i][1]) then
                icons[i][1]:removeSelf()
               end 

              end
              icons[1]:removeSelf()
          end
        end 

        for i = 1, #items[seletedCategory] do
            local card = nil

            if items[seletedCategory][i].coinsCost and items[seletedCategory][i].cashCost then
              card =  display.newImage("images/shop/Items.png")
            elseif items[seletedCategory][i].coinsCost then
              card =  display.newImage("images/shop/ItemsNoCash.png")
            else
              card =  display.newImage("images/shop/ItemsCashOnly.png")
            end  
            
            if (items[seletedCategory][i].level > commonData:getLevel()) then
                card:setFillColor(0.5,0.5,1)              
            end

            icons[i] = display.newGroup()
            icons[i].width = 70

            card.y = 100

            icons[i]:insert(card)


              local itemEquipped =  display.newImage("images/shop/ItemsEquipped.png")

            icons[i]:insert(itemEquipped)
            itemEquipped.y = 100
            icons[i].equipped = itemEquipped


             if items[seletedCategory][i].id == commonData.selectedSkin or                          
              items[seletedCategory][i].id == commonData.selectedBall or                          
              items[seletedCategory][i].id == commonData.selectedField 
              
              then
              itemEquipped.alpha = 1 
             else
               itemEquipped.alpha = 0
             end  


            local ownedIcon =  display.newImage("images/shop/ownedIcon.png")
            icons[i]:insert(ownedIcon)
            ownedIcon.x = 95
            ownedIcon.y = -55
            icons[i].owned = ownedIcon
            if commonData.shopItems[items[seletedCategory][i].id] then
              ownedIcon.alpha = 1
            else  
              ownedIcon.alpha = 0

            end  

           


            if (items[seletedCategory][i].image2) then
                 local  img = display.newImage(items[seletedCategory][i].image2) -- "",0,0, "UnitedSansRgHv" , 24)
                 if (img) then
                     img.y = 30 
                     img.x = 0
                     if (items[seletedCategory][i].imgScale) then
                      img:scale(items[seletedCategory][i].imgScale, items[seletedCategory][i].imgScale)
                     end
                     icons[i]:insert(img)
                end
            end

            if (items[seletedCategory][i].image) then
                 local  img = display.newImage(items[seletedCategory][i].image) -- "",0,0, "UnitedSansRgHv" , 24)
                 if (img) then
                     img.y = 45 
                     img.x = 2
                     if (items[seletedCategory][i].imgScale) then
                      img:scale(items[seletedCategory][i].imgScale, items[seletedCategory][i].imgScale)
                     end

                     if (items[seletedCategory][i].color) then
                      img:setFillColor(items[seletedCategory][i].color.r , 
                                       items[seletedCategory][i].color.g ,
                                       items[seletedCategory][i].color.b)
                     end
                     icons[i]:insert(img)
                end
            end
            if (items[seletedCategory][i].coinsCost) then
                local coinTextOptions = 
                  {
                      parent = icons[i],
                      text = "",     
                      x = 0,
                      y = 155,
                     -- width = 120,     --required for multi-line and alignment
                      font = "UnitedSansRgHv",   
                      fontSize = 30,
                      align = "left"  --new alignment parameter
                  }


                local  coinsCostText = display.newText(coinTextOptions) -- "",0,0, "UnitedSansRgHv" , 24)
                coinsCostText.text = items[seletedCategory][i].coinsCost


                 local  coinsImg =  display.newImage("Coin/Coin.png")
 
                 
                 
                 coinsImg.x = 50
                 coinsImg:scale(0.3,0.3)


                 if (items[seletedCategory][i].cashCost) then
                    coinsCostText.y = 155
                    coinsImg.y = 157
                 else
                    coinsCostText.y = 185
                    coinsImg.y = 187
                     
                 end 
                 icons[i]:insert(coinsImg)
                 icons[i]:insert(coinsCostText)
               -- icons[i]:insert(itemDescText)
            end

           
            
           
           -- scrollView:insert( icons[i] )
          icons[i].width = 70
         --  icons[i].height = card.height
           icons[i].x = 35 + (i-1) * 70
           icons[i].y = 70
           
            icons[i].id = i
            icons[i].category  = seletedCategory


        end

          local objShop = icons 

         
          local scaleWithinDist = display.actualContentWidth * .5
          local minScale, maxScale = 0.3 ,0.45
          local scaleDiff = maxScale - minScale
      
          local prevVelocity = 1
          boutiqueFrame  = function()
              

              local velocity = math.abs(levelSelectGroup._view._velocity)
            
              if (levelSelectGroup.isLocked ) then
--                if (levelSelectGroup.isLocked or (prevVelocity == 0 and velocity == 0)) then
  
                return
              end

              prevVelocity = velocity

              for j = 1,#objShop do
                --  print(velocity)
                  local item = objShop[j]
                  
               if item then
                   
                   --"scaling object"
                     local x, y = item:localToContent( 0, 0 )
                    if (j==#objShop) then
                   --print(item.x .. " - " .. x  .. " - " .. x + 20 * j )
                  --  print(#objShop .. " - " .. #items[seletedCategory]  .. " - " .. x + 20 * j )
                    end  
                    local dist = math.abs(x - 70) 
                    local scale = nil
                                
                    if (dist > 30 ) then
                      scale = minScale
                    else
                     -- local factor = 1 - (dist / 50)
                       scale = maxScale
                     -- item.xScale, item.yScale = scale, scale
                     -- print(item.x .. " - " .. x  .. " - " .. x + 20 * j )
                    
                                   
                     end
                       
                      if (scale >= 0.4 ) then
           
                         item.xScale, item.yScale = maxScale, maxScale
           
                          
                          item:toFront()
                          item.alpha = 1
                          item.y = 50

                           local itemIdx = j-1
                          local between =70
                                    

                          
                           if math.abs(levelSelectGroup._view._velocity) <= 0.3 and not isVelocity and not scrollTo then 
                              
                               scrollTo = true
                              isVelocity = true
                              if (j ~= prevItem) then
                                      selectedItemChanged(j)
                                       prevItem  = j
                              end

                               levelSelectGroup:scrollToPosition
                               {x =35 + (-1* itemIdx* 70  + resolutionFactor) , time = 190, 
                                onComplete = function() 
                                    scrollTo = false                                 
                                end}
                              
                           end      
                         
                      elseif (not outerScrollTo) then
                        item.alpha = 0.6
                        item.xScale, item.yScale = minScale, minScale
                        item.y = 86
           
                        
                      end
                  end
                end

              --  print ("dooo")
                local lastIdx = #items[seletedCategory]
                if objShop and objShop[lastIdx] then
                    local x, y = objShop[lastIdx]:localToContent( 0, 0 )
                --    print (x)
                
                    if x <= 0 and not outerScrollTo then

                       outerScrollTo = true
                       prevVelocity = 1
                                  isVelocity = true
                                  objShop[lastIdx].xScale, objShop[lastIdx].yScale = maxScale, maxScale
                                  
                                  objShop[lastIdx]:toFront()
                                  objShop[lastIdx].alpha = 1
                                  objShop[lastIdx].y = 50

                                  if (lastIdx ~= prevItem) then
                                    selectedItemChanged(lastIdx)
                                     prevItem  = lastIdx
                                  end 

                                   levelSelectGroup:scrollToPosition
                                   {x =105 + (-1* lastIdx * 70  + resolutionFactor) , time = 190, 
                                    onComplete = function() 
                                        scrollTo = false 
                                        outerScrollTo= false 
                                        prevVelocity = 1
                                        

                                    end}
                                  
                    end  
                end
              
          end -- boutiqueFrame


          

         for i = #items[seletedCategory] , 1 , -1 do
            if (icons[i]) then
                    levelSelectGroup:insert(icons[i])   
                    icons[i].alpha = 0.6
                    icons[i].xScale, icons[i].yScale = minScale, minScale
                    icons[i].y = 86
            
             end       
         end

          objShop[1].xScale, objShop[1].yScale = maxScale, maxScale
          
          objShop[1]:toFront()
          objShop[1].alpha = 1
          objShop[1].y = 50

           prevVelocity = 1
           outerScrollTo=true
        levelSelectGroup:scrollToPosition
                             {x = 35  + resolutionFactor , time = 190, 
                              onComplete = function() 
                                   scrollTo = false
                                    outerScrollTo= false 
                                    prevVelocity = 1
                              end}

         selectedItemChanged(1)

        --   local dummy = display.newRect(#items[seletedCategory] * 70 , 50, 50, 10 )
          -- dummy.alpha=1
        -- levelSelectGroup:insert(dummy)

        Runtime:addEventListener("enterFrame", boutiqueFrame )

end


-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view


      require "catalog"
      initAchivments(commonData.gameData.unlockedAchivments ) 

    --everything from here down to the return line is what makes
     --up the scene so... go crazy
     local background = display.newImage("images/shop/ShopBG.jpg")
     background.x = 240
     background.y = 160

     

      local function nullListener( event )
          
      
          return true
     end

     
     
     background.xScale = display.actualContentWidth / background.contentWidth 
     background.yScale = display.actualContentHeight  / background.contentHeight
     
     
     heroSpine =  require ("hero")
      hero = heroSpine.new(0.6, true, true,nil,true)
      
      hero.skeleton.group.x = 440
      hero.skeleton.group.xScale = -1

      hero.skeleton.group.x = hero.skeleton.group.x + (display.actualContentWidth - display.contentWidth)/2
      

     categories = display.newGroup()



local widget = require( "widget" )

local coinImg  = display.newImage("Coin/Coin.png")
coinImg.x = 450
coinImg.y = 23
coinImg:scale(0.25,0.25)

local coinTextOptions = 
{
    --parent = textGroup,
    text = "",     
    x = 415,
    y = 23,
   -- width = 120,     --required for multi-line and alignment
    font = "UnitedSansRgHv",   
    fontSize = 20,
    align = "left"  --new alignment parameter
}

coinsCountText = display.newText(coinTextOptions) -- "",0,0, "UnitedSansRgHv" , 24)
coinsShadowText = display.newText(coinTextOptions) -- "",0,0, "UnitedSansRgHv" , 24)
--coinsCount = 0
coinsCountText:setFillColor(1,206/255,0)
coinsShadowText:setFillColor(128/255,97/255,40/255)
coinsShadowText.y = coinsCountText.y + 2

coinImg.x = coinImg.x + (display.actualContentWidth - display.contentWidth) /2
coinsCountText.x = coinsCountText.x + (display.actualContentWidth - display.contentWidth) /2
coinsShadowText.x = coinsShadowText.x + (display.actualContentWidth - display.contentWidth) /2




          local function scrollListener( event )
              
               if (levelSelectGroup.isLocked) then
                return true
               end

              local phase = event.phase

               if ( phase == "began" ) then isVelocity = true
                  elseif ( phase == "moved" ) then
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
                                width = display.actualContentWidth * 0.64 ,
                                height = 220,
                                isLocked = false,
                                friction = 0.975, 
                                isBounceEnabled = false,
                                hideBackground = true,
                                hideScrollBar = false,
                                verticalScrollDisabled = true,                                
                                listener = scrollListener })

        
          levelSelectGroup.x = 205
        --  levelSelectGroup.x = levelSelectGroup.x  + (display.actualContentWidth - display.contentWidth) /2

          levelSelectGroup.y = display.contentCenterY 
          resolutionFactor = 23 -  (levelSelectGroup.x - levelSelectGroup.width / 2)

        
      local function setSlidesLocked(pLock)
        
      
          levelSelectGroup:setIsLocked(pLock)
          levelSelectGroup.isLocked =  pLock
          levelSelectGroup.verticalScrollDisabled =  true
          
      end 

      -- Function to handle button events
      local function handleButtonEvent( event )

        if ( "ended" == event.phase ) then
           commonData.buttonSound()
          
          commonData.shopSkin = commonData.selectedSkin 
          commonData.shopBall = commonData.selectedBall 
          
          
          

          seletedCategory = event.target.id
          openCategory()

          -- if ( "ended" == event.phase ) then

            for i=1,categories.numChildren, 1 do
               categories[i].xScale = display.actualContentWidth * 0.3  / display.contentWidth 
               categories[i].yScale =  categories[i].xScale 

               if (categories[i].id == seletedCategory) then
                    categories[i].xScale = display.actualContentWidth * 0.45  / display.contentWidth 
                    categories[i].yScale = categories[i].xScale


               end
            end
       end
       return true
   
     end

        local counter = 1
       for index, category in pairs( items ) do

          -- Create the widget
          local button1 = widget.newButton
          {
              x = 35,
              y = 100 + 40 * category.index,           
              id = category.category,
           --   label = category.category,
             defaultFile = "images/shop/" .. category.category.. ".png",
             -- overFile = "over.png",
              onEvent = handleButtonEvent          
          }


          button1.xScale = display.actualContentWidth * 0.3  / display.contentWidth 
          button1.yScale = button1.xScale 

          button1.x = button1.x  - (display.actualContentWidth - display.contentWidth) /2

          categories:insert(button1)

          if (category.index == 1) then
              button1.xScale = display.actualContentWidth * 0.45  / display.contentWidth 
              button1.yScale = button1.xScale 

          end

        
          counter = counter + 1
          
       end

       
        local function setSelectedItems()


             if (seletedCategory == "skins") then
               commonData.selectedSkin = items[seletedCategory][selectedItemIdx].id
                unlockChallenge("changeCharacter")
            end  

             if (seletedCategory == "balls") then
               commonData.selectedBall = items[seletedCategory][selectedItemIdx].id
                unlockChallenge("changeBall")
            end  

            if (seletedCategory == "fields") then
               commonData.selectedField = items[seletedCategory][selectedItemIdx].id
                unlockChallenge("changeField")
            end  



          commonData.gameData.selectedBall = commonData.selectedBall                  
          commonData.gameData.selectedSkin = commonData.selectedSkin 
          commonData.gameData.selectedField = commonData.selectedField
          
          for i=1,#icons do
             icons[i].equipped.alpha = 0
          end
          
          icons[selectedItemIdx].equipped.alpha = 1


          commonData.saveTable(commonData.gameData , GAME_DATA_FILE, true)
          commonData.saveTable(commonData.shopItems , SHOP_FILE)

          

     end   

        local function buyButtonListener( event )
          
          if ( "ended" == event.phase ) then
             commonData.buttonSound()
              buyNotificationText.alpha = 0 
              buyNotificationRect.alpha = 0 
              
            areYouSurePopup.alpha = 1
            setSlidesLocked(true)

            if (items[seletedCategory][selectedItemIdx].coinsCost) then
              buyWithCoinsText.text = "USE " .. items[seletedCategory][selectedItemIdx].coinsCost
              byWithCoinsButton.alpha = 1
              byWithCoinsButtonIcon.alpha = 1
              buyWithCoinsText.alpha = 1

              if (items[seletedCategory][selectedItemIdx].cashCost) then
                buyWithCoinsText.y = BUTTON_1_Y
                byWithCoinsButton.y = BUTTON_1_Y
                byWithCoinsButtonIcon.y = BUTTON_1_Y
              else
                buyWithCoinsText.y = BUTTON_2_Y
                byWithCoinsButton.y = BUTTON_2_Y
                byWithCoinsButtonIcon.y = BUTTON_2_Y
              end  

            else
              byWithCoinsButton.alpha = 0
              byWithCoinsButtonIcon.alpha = 0
              buyWithCoinsText.alpha = 0
            end

        

            if itemToBuyImg2 then
                itemToBuyImg2:removeSelf()
            end  

            if items[seletedCategory][selectedItemIdx].image2 then
                itemToBuyImg2 = display.newImage(items[seletedCategory][selectedItemIdx].image2)

                if (items[seletedCategory][selectedItemIdx].imgScale) then
                    itemToBuyImg2:scale(items[seletedCategory][selectedItemIdx].imgScale * 0.6,
                     items[seletedCategory][selectedItemIdx].imgScale * 0.6)
                end
                itemToBuyImg2.x = 160
                itemToBuyImg2.y = 150
                areYouSurePopup:insert(itemToBuyImg2)
            end

            if itemToBuyImg then
                itemToBuyImg:removeSelf()
            end  

            

              itemToBuyImg = display.newImage(items[seletedCategory][selectedItemIdx].image)

              if itemToBuyImg then
                if (items[seletedCategory][selectedItemIdx].imgScale) then
                    itemToBuyImg:scale(items[seletedCategory][selectedItemIdx].imgScale * 0.5,
                     items[seletedCategory][selectedItemIdx].imgScale * 0.5)
                end
                itemToBuyImg.x = 185
                itemToBuyImg.y = 145
                areYouSurePopup:insert(itemToBuyImg)
              end

             commonData.analytics.logEvent( "buyPressed", {  item = tostring(  items[seletedCategory][selectedItemIdx].id ) } ) 
          
          end

          return true
       end

       local function useButtonListener( event )
          
          if ( "ended" == event.phase ) then
             commonData.buttonSound()
            setSelectedItems()
          end

          return true
       end

       buyButton = widget.newButton
      {
          x = 137,
          y = 250,
          id = "buyButton",
          defaultFile = "images/shop/BUY.png",
          overFile = "images/shop/BUY Down.png",
          onEvent = buyButtonListener
      }
      buyButton:scale(0.5,0.5)


       useButton = widget.newButton
      {
          x = 137,
          y = 250,
          id = "useButton",
          defaultFile = "images/shop/USE.png",          
          overFile = "images/shop/USE Down.png",
          onEvent = useButtonListener
      }
       useButton:scale(0.5,0.5)


      

        

       local function buyWithCoinsListener( event )


           if ( "began" == event.phase ) then
               if (items[seletedCategory][selectedItemIdx] and                  
                  not commonData.shopItems[items[seletedCategory][selectedItemIdx].id] and
                  items[seletedCategory][selectedItemIdx].coinsCost and
                  coinsCount < items[seletedCategory][selectedItemIdx].coinsCost ) then

                  local alphaNum = 1.1
                  buyNotificationText.alpha = 1.5
                  buyNotificationRect.alpha = 1.5

                   timer.performWithDelay(1, function( )
                     alphaNum = alphaNum - 0.01
                     buyNotificationText.alpha = alphaNum
                     buyNotificationRect.alpha = alphaNum

                   end, 110)
              
                    commonData.analytics.logEvent( "notEnoughCoins", {  item = tostring(  items[seletedCategory][selectedItemIdx].id ) } ) 
                end
           elseif ( "ended" == event.phase ) then
                 commonData.buttonSound()

            
             if (items[seletedCategory][selectedItemIdx] and                  
                  not commonData.shopItems[items[seletedCategory][selectedItemIdx].id] and
                  items[seletedCategory][selectedItemIdx].coinsCost and
                  coinsCount >= items[seletedCategory][selectedItemIdx].coinsCost ) then

                  commonData.analytics.logEvent( "buyWithCoins", {  item = tostring(  items[seletedCategory][selectedItemIdx].id ) } ) 

            
                  coinsCount = coinsCount - items[seletedCategory][selectedItemIdx].coinsCost
                  commonData.shopItems[items[seletedCategory][selectedItemIdx].id] = true
                  commonData.gameData.coins  = coinsCount
                  commonData.gameData.usedcoins =  commonData.gameData.usedcoins + items[seletedCategory][selectedItemIdx].coinsCost
                  setCoinsCount()
                  icons[selectedItemIdx].owned.alpha = 1

                  setSelectedItems()
                  areYouSurePopup.alpha = 0
                  useButton.alpha = 1
                  buyButton.alpha = 0
                  setSlidesLocked(false)


             end

                 
          end
          return true
        
       end

      local function cancelButtonListener( event )
          
          if ( "ended" == event.phase ) then
             commonData.buttonSound()
            areYouSurePopup.alpha = 0
            setSlidesLocked(false)

          end
          return true
        
       end

      
      byWithCoinsButtonIcon =  display.newImage("Coin/Coin.png")
      byWithCoinsButtonIcon:scale(0.15,0.15)
      


      byWithCoinsButton = widget.newButton
      {
          x = 295,
          y = BUTTON_1_Y,
          id = "byWithCoins",
          defaultFile = "images/shop/BuyWithCoins.png",          
          overFile = "images/shop/BuyWithCoinsDown.png",
          onEvent = buyWithCoinsListener
      }

     local cancelBuyButton = widget.newButton
      {
          x = 295,
          y = BUTTON_3_Y,
          id = "cancelBuyButton",
          defaultFile = "images/shop/Cancel.png",
          overFile = "images/shop/CancelDown.png",
          onEvent = cancelButtonListener
      }

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

      buyButton.x = buyButton.x  - (display.actualContentWidth - display.contentWidth) /2
      useButton.x = useButton.x  - (display.actualContentWidth - display.contentWidth) /2

      local coinTextOptions = 
      {
         
          text = "",     
          x = 0,
          y = 155,
         -- width = 120,     --required for multi-line and alignment
          font = "UnitedSansRgHv",   
          fontSize = 15,
          align = "left"  --new alignment parameter
      }


                
      
      buyWithCoinsText = display.newText(coinTextOptions) 
      buyWithCoinsText.text = "Buy with coins"
      buyWithCoinsText.x = 295
      buyWithCoinsText.y = BUTTON_1_Y
      buyWithCoinsText:setFillColor(255/255,241/255,208/255)


      buyNotificationText= display.newText(coinTextOptions) 
      buyNotificationText.text = "Not enough coins"
      buyNotificationText.x = 260
      buyNotificationText.y = 225
      buyNotificationText:setFillColor(1,63/256,63/256)

      buyNotificationRect = display.newRect(0, 0, 30,15)
      buyNotificationRect.x = 260
      buyNotificationRect.y = 225
      buyNotificationRect:setFillColor(164/256,0,0)

      

      buyNotificationText.alpha = 0
      buyNotificationRect.alpha = 0 
              


      local itemDescOptions = 
      {          
          text = "",     
          width = 120,     --required for multi-line and alignment
          font = "UnitedSansRgHv",   
          fontSize = 15,
          align = "left"  --new alignment parameter
      }


      itemDesc = display.newText(itemDescOptions) 
      itemDesc.x = 157
      itemDesc.y = 220
      itemDesc:setFillColor(255/255,241/255,208/255)
      itemDesc.x = itemDesc.x  - (display.actualContentWidth - display.contentWidth) /2

      areYouSurePopup = display.newGroup()

      local areYouSureBackground  = display.newImage("images/shop/BuyDialog.png")

      areYouSureBackground.x = 240
      areYouSureBackground.y = 160

      local blackRect = display.newRect(240, 160, 600,400)
      blackRect:setFillColor(0, 0, 0)
      blackRect.alpha = 0.4


     local function blackRectListener( event )        
          return true
     end

      blackRect:addEventListener("touch", blackRectListener )
            -------------------------------------------------------------------------------

        seletedCategory = "skins"

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

       
       openCategory()
         

      areYouSureBackground.xScale = 0.5 *display.actualContentWidth / areYouSureBackground.contentWidth 
      areYouSureBackground.yScale = areYouSureBackground.xScale
      byWithCoinsButton.xScale = 0.2 *display.actualContentWidth / byWithCoinsButton.contentWidth 
      byWithCoinsButton.yScale = byWithCoinsButton.xScale
      
      cancelBuyButton.xScale = 0.2 *display.actualContentWidth / cancelBuyButton.contentWidth 
      cancelBuyButton.yScale = cancelBuyButton.xScale

      byWithCoinsButtonIcon.x = byWithCoinsButton.x + 30
      byWithCoinsButtonIcon.y = byWithCoinsButton.y

      
      areYouSurePopup:insert(blackRect)
      areYouSurePopup:insert(areYouSureBackground)
      areYouSurePopup:insert(byWithCoinsButton)
      
      areYouSurePopup:insert(byWithCoinsButtonIcon)
      
      areYouSurePopup:insert(buyWithCoinsText)
      
      areYouSurePopup:insert(buyNotificationRect)
      
      areYouSurePopup:insert(buyNotificationText)
      areYouSurePopup:insert(cancelBuyButton)

      areYouSurePopup.alpha = 0
      buyNotificationRect.width = areYouSureBackground.contentWidth -20
      buyNotificationRect.x = areYouSureBackground.x

    sceneGroup:insert(background)


    sceneGroup:insert(levelSelectGroup)
    sceneGroup:insert(hero.skeleton.group)

    sceneGroup:insert(coinsShadowText)
    sceneGroup:insert(coinsCountText)
    sceneGroup:insert(coinImg)

    sceneGroup:insert(useButton)
    sceneGroup:insert(buyButton)
     sceneGroup:insert(categories)   
     
     
     sceneGroup:insert(itemDesc)  
     sceneGroup:insert(backButton)


    sceneGroup:insert(areYouSurePopup)
   
     
end

-- "scene:show()"
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase


 
   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).

      
      commonData.shopSkin = commonData.selectedSkin 
      commonData.shopBall = commonData.selectedBall 
       

      hero:reload()
      hero:init()
      hero:menuIdle()
      openCategory()
  
   elseif ( phase == "did" ) then

      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
      if(event.params and event.params.gameData) then
           coinsCount = commonData.gameData.coins  
           setCoinsCount()
      end

       commonData.analytics.logEvent( "openShop", {  coins = tostring( commonData.gameData.coins  ) } ) 

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
        hero:pause()
        Runtime:removeEventListener("enterFrame", boutiqueFrame)

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

