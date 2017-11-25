local commonData = require( "commonData" )

local composer = require( "composer" )
local widget = require( "widget" )

require ("achivmentsManager")
local store = nil
if ( system.getInfo("platformName") == "Android" ) then
  store = require("plugin.google.iap.v3")
else
  store = require("store")   
end

local moshe= "moshe"


local BUTTON_1_Y = 130
local BUTTON_2_Y = 160
local BUTTON_3_Y = 190

local scene = composer.newScene()
local levelSelectGroup

local isVelocity = false
local scrollTo = false
local outerScrollTo = false
local coinsCount = 1
local gemsCount = 1
      

local seletedCategory = nil
local buyButton = nil
local useButton = nil
local cancelBuyButton = nil
local backButton = nil

-- local useDisabled = nil
-- local buyDisabled = nil
local areYouSureBackground = nil
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

local buyWithCoinsButton = nil
local buyWithCoinsButtonDisabled = nil
local buyWithCoinsButtonIcon = nil

local  buyWithGemsText = nil
local buyWithGemsButton = nil
local buyWithGemsButtonIcon = nil

local  buyWithCashText = nil
local buyWithCashButton = nil
local buyWithCashButtonIcon = nil

local resolutionFactor = 0
local  buyNotificationText = nil
local  buyNotificationRect = nil

local categories = nil

local productList =
{
  -- These Product IDs must already be set up in your store
  -- We'll use this list to retrieve prices etc. for each item
  -- Note, this simple test only has room for about 4 items, please adjust accordingly
  -- The iTunes store will not validate bad Product IDs 
  "com.ld.3supagems",
  "com.ld.10supagems",
  --"android.test.purchased" ,
  "com.ld.20supagems",
  "com.ld.40supagems",
  "com.ld.80supagems",
  "com.ld.starterPack",
  "com.ld.shakesPack",
  "com.ld.promoPack",  
}
            

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------
 local function setCoinsCount(e)

    coinsShadowText.text = coinsCount
    coinsCountText.text =  coinsCount

    gemsShadowText.text = gemsCount
    gemsCountText.text =  gemsCount

  end  

  local function setSlidesLocked(pLock)
        
      
          levelSelectGroup:setIsLocked(pLock)
          levelSelectGroup.isLocked =  pLock
          levelSelectGroup.verticalScrollDisabled =  true
          
  end 


 
 --local scrollView
local icons = {}

local function  selectedItemChanged( itemIdx )

  local catItems = commonData.catalog.getActiveItems(seletedCategory) 

  if (itemIdx and catItems[itemIdx]) then
    

    selectedItemIdx = itemIdx
    itemDesc.text = catItems[itemIdx].name
    if (catItems[itemIdx] and commonData.shopItems[catItems[itemIdx].id]) then
      useButton.alpha = 1
      buyButton.alpha = 0
    else
      useButton.alpha = 0
      buyButton.alpha = 1
    end

    -- if (commonData.catalog.items[seletedCategory][itemIdx].level and 
    --     commonData.catalog.items[seletedCategory][itemIdx].level > commonData.getLevel()) then      

    --   buyDisabled.alpha = buyButton.alpha
    --   useDisabled.alpha = useButton.alpha 

    --   useButton.alpha = 0
    --   buyButton.alpha = 0
    -- else
    --    buyDisabled.alpha = 0
    --   useDisabled.alpha = 0
    -- end
     
     if (seletedCategory == "skins") then
       commonData.shopSkin = catItems[itemIdx].id

    end  

     if (seletedCategory == "balls") then
       commonData.shopBall = catItems[itemIdx].id
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
             if  icons[i] then
               for j = 1, icons[i].numChildren do
                 if (icons[i][1]) then
                  icons[i][1]:removeSelf()
                 end 

                end

                if icons[1] then
                  icons[1]:removeSelf()
                end
             end   
          end
        end 
        local catItems = commonData.catalog.getActiveItems(seletedCategory) 
        for i = 1, #catItems do

          if not catItems[i].hidden then 
            local card = nil

            if catItems[i].specialOffer then
              card =  display.newImage("images/shop/ShopItemsOffer.png")             
            elseif catItems[i].cashCost then
              card =  display.newImage("images/shop/ShopItemExlusive.png")             
            else
              card =  display.newImage("images/shop/ItemsNoCash.png")            
            end  
            
          

            icons[i] = display.newGroup()
            icons[i].width = 70

            card.y = 100

            icons[i]:insert(card)

            if (catItems[i].image) then
                 local  img = display.newImage(catItems[i].image) -- "",0,0, "UnitedSansRgHv" , 24)
                 if (img) then
                     img.y = 45 
                     img.x = 2
                     if (catItems[i].imgScale) then
                      img:scale(catItems[i].imgScale, catItems[i].imgScale)
                     end

                      --  if (catItems[i].level and 
                      --      catItems[i].level > commonData:getLevel()) then
                      --     img.fill.effect = "filter.desaturate"           
                      --     img.fill.effect.intensity = 1
                      -- end

                     
                     --     leftBottomObj.fill.effect = "filter.brightness"
      --    leftBottomObj.fill.effect.intensity = 0.8

      --    leftTopObj.fill.effect = "filter.brightness"
      --    leftTopObj.fill.effect.intensity = 0.8

                     if (catItems[i].color) then
                      img:setFillColor(catItems[i].color.r , 
                                       catItems[i].color.g ,
                                       catItems[i].color.b)
                     end
                     icons[i]:insert(img)
                end
            end

            if (catItems[i].level) then
               local levelFlag =  display.newImage("images/shop/LevelFlag.png")
                 
                levelFlag.x = -75
                levelFlag.y = -18 
               
                levelFlag:scale(0.5,0.5)
               
               icons[i]:insert(levelFlag)

               local levelTextOptions = 
                  {
                      parent = icons[i],
                      text = "",     
                      x = 0,
                      y = 155,
                      font = "UnitedSansRgHv",   
                      fontSize = 20,
                      align = "left"  --new alignment parameter
                  }

                local  levelCostText = display.newText(levelTextOptions) -- "",0,0, "UnitedSansRgHv" , 24)
                levelCostText.text = "LVL \n" .. catItems[i].level .. "+"

                levelCostText.x = -72
                levelCostText.y = -30
                levelCostText:setFillColor(1,206/255,0)
              --coinsShadowText:setFillColor(128/255,97/255,40/255)
                 icons[i]:insert(levelCostText)
          
            end

              local itemEquipped =  display.newImage("images/shop/ItemsEquipped.png")

            icons[i]:insert(itemEquipped)
            itemEquipped.y = 100
            icons[i].equipped = itemEquipped


             if catItems[i].id == commonData.selectedSkin or                          
              catItems[i].id == commonData.selectedBall or                          
              catItems[i].id == commonData.selectedBooster or                              
              catItems[i].id == commonData.selectedField 
              
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
            if commonData.shopItems[catItems[i].id] then
              ownedIcon.alpha = 1
            else  
              ownedIcon.alpha = 0

            end  
        
            if (catItems[i].coinsCost) then
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
                coinsCostText.text = catItems[i].coinsCost


                 local  coinsImg =  display.newImage("Coin/Coin.png")
 
                 
                 
                 coinsImg.x = 50
                 coinsImg:scale(0.3,0.3)


                
                 coinsCostText.y = 175
                 coinsImg.y = 177
                     
                 icons[i]:insert(coinsImg)
                 icons[i]:insert(coinsCostText)
               -- icons[i]:insert(itemDescText)
            end

             if (catItems[i].gemsCost) then
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
                coinsCostText.text = catItems[i].gemsCost


                 local  coinsImg =  display.newImage("images/SupaGem.png")
 
                 
                 
                 coinsImg.x = 50
                 coinsImg:scale(0.25,0.25)


                
                 coinsCostText.y = 210
                 coinsImg.y = 212
                 coinsCostText:setFillColor(0,1,0)    
                
                 icons[i]:insert(coinsImg)
                 icons[i]:insert(coinsCostText)
               -- icons[i]:insert(itemDescText)
            end
           
             if (catItems[i].cashCost) then
                local coinTextOptions = 
                  {
                      parent = icons[i],
                      text = "",     
                      x = 0,
                      y = 205,
                     -- width = 120,     --required for multi-line and alignment
                      font = "UnitedSansRgHv",   
                      fontSize = 30,
                      align = "left"  --new alignment parameter
                  }


                local  cashCostText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
                cashCostText.text = catItems[i].cashCost


                 local  cashImg = display.newImage("images/shop/CashIcon.png")
                 
                 cashImg.y = 205
                 cashImg.x = 50
                 cashImg:scale(0.2,0.2)
                 cashImg.alpha = 0


                 if (catItems[i].coinsCost) then
                    cashCostText.y = 205
                    cashImg.y = 205
                 else
                    cashCostText.y = 185
                    cashImg.y = 187
                     
                 end 

                 icons[i]:insert(cashImg)
                 icons[i]:insert(cashCostText)
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
                local lastIdx = #catItems
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


          

         for i = #catItems , 1 , -1 do
            if (icons[i]) then
                    levelSelectGroup:insert(icons[i])   
                    icons[i].alpha = 0.6
                    icons[i].xScale, icons[i].yScale = minScale, minScale
                    icons[i].y = 86
            
             end       
         end

           if objShop and objShop[1] then
                objShop[1].xScale, objShop[1].yScale = maxScale, maxScale
                
                objShop[1]:toFront()
                objShop[1].alpha = 1
                objShop[1].y = 50
           end
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


local gemImg  = display.newImage("images/SupaGem.png")
gemImg.x = 350
gemImg.y = 23
gemImg:scale(0.25,0.25)

local gemTextOptions = 
{
    --parent = textGroup,
    text = "",     
    x = 315,
    y = 23,
   -- width = 120,     --required for multi-line and alignment
    font = "UnitedSansRgHv",   
    fontSize = 20,
    align = "left"  --new alignment parameter
}

gemsCountText = display.newText(gemTextOptions) -- "",0,0, "UnitedSansRgHv" , 24)
gemsShadowText = display.newText(gemTextOptions) -- "",0,0, "UnitedSansRgHv" , 24)
--gemsCount = 0
gemsCountText:setFillColor(1,206/255,0)
gemsShadowText:setFillColor(128/255,97/255,40/255)
gemsShadowText.y = gemsCountText.y + 2

gemImg.x = gemImg.x + (display.actualContentWidth - display.contentWidth) /2
gemsCountText.x = gemsCountText.x + (display.actualContentWidth - display.contentWidth) /2
gemsShadowText.x = gemsShadowText.x + (display.actualContentWidth - display.contentWidth) /2



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
       for index, category in pairs( commonData.catalog.items ) do

          -- Create the widget
          local button1 = widget.newButton
          {
              x = 35,
              y = 40 + 40 * category.index,           
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

          local defaultCat = 1
          if not store.isActive then
                defaultCat = 2           
          end

          if (category.index == defaultCat) then
              button1.xScale = display.actualContentWidth * 0.45  / display.contentWidth 
              button1.yScale = button1.xScale 

          end

        
          counter = counter + 1
          
       end

       
        local function setSelectedItems()


             if (seletedCategory == "skins") then
               commonData.selectedSkin = commonData.catalog.items[seletedCategory][selectedItemIdx].id
                unlockChallenge("changeCharacter")
            end  

             if (seletedCategory == "balls") then
               commonData.selectedBall = commonData.catalog.items[seletedCategory][selectedItemIdx].id
                unlockChallenge("changeBall")
            end  

            if (seletedCategory == "fields") then
               commonData.selectedField = commonData.catalog.items[seletedCategory][selectedItemIdx].id
                unlockChallenge("changeField")
            end  

            if (seletedCategory == "boosts") then
               commonData.selectedBooster = commonData.catalog.items[seletedCategory][selectedItemIdx].id                
            end
            



          commonData.gameData.selectedBall = commonData.selectedBall                  
          commonData.gameData.selectedSkin = commonData.selectedSkin 
          commonData.gameData.selectedField = commonData.selectedField
          commonData.gameData.selectedBooster = commonData.selectedBooster
          
          
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

            local catItems = commonData.catalog.getActiveItems(seletedCategory) 
            
            if (catItems[selectedItemIdx].coinsCost and
              (not catItems[selectedItemIdx].level or
               catItems[selectedItemIdx].level <= commonData.getLevel()  )) then

              --buyWithCoinsText.text = "USE " .. catItems[selectedItemIdx].coinsCost
              buyWithCoinsButtonDisabled.alpha =0
            

              buyWithCoinsText.text = catItems[selectedItemIdx].coinsCost
              buyWithCoinsText.x = buyWithCoinsButtonIcon.x - buyWithCoinsButtonIcon.contentWidth/2 - buyWithCoinsText.contentWidth /2 -3
              buyWithCoinsButton.alpha = 1
              buyWithCoinsButtonIcon.alpha = 1
              buyWithCoinsText.alpha = 1

              if (catItems[selectedItemIdx].gemsCost) then
                buyWithCoinsText.y = BUTTON_1_Y
                buyWithCoinsButton.y = BUTTON_1_Y
                buyWithCoinsButtonIcon.y = BUTTON_1_Y
                buyWithCoinsButtonDisabled.y = BUTTON_1_Y
              else
                buyWithCoinsText.y = BUTTON_2_Y
                buyWithCoinsButton.y = BUTTON_2_Y
                buyWithCoinsButtonIcon.y = BUTTON_2_Y
                buyWithCoinsButtonDisabled.y = BUTTON_2_Y
              end  

              --print("have coins")
            else
              --print("no coins")
              --buyWithCoinsButton.alpha = 0
              
              

              if catItems[selectedItemIdx].level then
                buyWithCoinsText.text = "LVL " .. catItems[selectedItemIdx].level
                buyWithCoinsText.x = buyWithCoinsButtonIcon.x - buyWithCoinsButtonIcon.contentWidth/2 - buyWithCoinsText.contentWidth /2 -3                
                buyWithCoinsButtonDisabled.alpha = 1
                buyWithCoinsButtonDisabled:setEnabled(false)       
                buyWithCoinsButtonIcon.alpha = 1
                buyWithCoinsText.alpha = 1     
              else  
                buyWithCoinsButton.alpha = 0
                buyWithCoinsButtonDisabled.alpha = 0
                buyWithCoinsButtonIcon.alpha = 0
                buyWithCoinsText.alpha = 0
              end
            end


            if (catItems[selectedItemIdx].gemsCost) then
              --buyWithGemsText.text = "USE " .. catItems[selectedItemIdx].gemsCost
              buyWithGemsText.text = catItems[selectedItemIdx].gemsCost
              buyWithGemsText.x = buyWithGemsButtonIcon.x - buyWithGemsButtonIcon.contentWidth/2 - buyWithGemsText.contentWidth /2 -3
              buyWithGemsButton.alpha = 1
              buyWithGemsButtonIcon.alpha = 1
              buyWithGemsText.alpha = 1

              
              buyWithGemsText.y = BUTTON_2_Y
              buyWithGemsButton.y = BUTTON_2_Y
              buyWithGemsButtonIcon.y = BUTTON_2_Y
              --print("have gems")
            else
              --print("no gems")
              buyWithGemsButton.alpha = 0
              buyWithGemsButtonIcon.alpha = 0
              buyWithGemsText.alpha = 0
            end
        
            if (catItems[selectedItemIdx].cashCost) then
              buyWithCashText.text = catItems[selectedItemIdx].cashCost
              buyWithCashText.x = buyWithCashButtonIcon.x - buyWithCashButtonIcon.contentWidth/2 - buyWithCashText.contentWidth /2 -3
              buyWithCashButton.alpha = 1
              buyWithCashButtonIcon.alpha = 1
              buyWithCashText.alpha = 1

              
              buyWithCashText.y = BUTTON_2_Y
              buyWithCashButton.y = BUTTON_2_Y
              buyWithCashButtonIcon.y = BUTTON_2_Y
              --print("have cash")
            else
              --print("no cash")
              buyWithCashButton.alpha = 0
              buyWithCashButtonIcon.alpha = 0
              buyWithCashText.alpha = 0
            end
        

            if itemToBuyImg then
                itemToBuyImg:removeSelf()
            end  

            
              if catItems[selectedItemIdx].image then
                itemToBuyImg = display.newImage(catItems[selectedItemIdx].image)
              end

              if itemToBuyImg then
                
                itemToBuyImg.xScale =  areYouSureBackground.contentWidth  * 0.3 / itemToBuyImg.contentWidth
                itemToBuyImg.yScale = itemToBuyImg.xScale 
                
                itemToBuyImg.x = areYouSureBackground.x - areYouSureBackground.contentWidth  * 0.21 
                itemToBuyImg.y = areYouSureBackground.y + areYouSureBackground.contentHeight  * 0.04 
                areYouSurePopup:insert(itemToBuyImg)
              end

             commonData.analytics.logEvent( "buyPressed", {  item = tostring(  catItems[selectedItemIdx].id ) } ) 
          
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

       local gradient = {
          type="gradient",
          color2={ 255/255,241/255,208/255,1}, color1={ 255/255,255/255,255/255,1 }, direction="up"
      }

       buyButton = widget.newButton
      {
          x = 137,
          y = 250,
          id = "buyButton",          
          defaultFile = "images/UseUp.png",          
          overFile = "images/UseDown.png",          
          label = getTransaltedText("Buy"),
          labelAlign = "center",
          font = "UnitedItalicRgHv",  
          fontSize = 25 ,           
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } },
          onEvent = buyButtonListener
      }
      buyButton:scale(0.5,0.5)


       useButton = widget.newButton
      {
          x = 137,
          y = 250,
          id = "useButton",
          defaultFile = "images/UseUp.png",          
          overFile = "images/UseDown.png",          
          label = getTransaltedText("Use"),
          labelAlign = "center",
          font = "UnitedItalicRgHv",  
          fontSize = 25 ,           
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } },
          onEvent = useButtonListener
      }
       useButton:scale(0.5,0.5)


      buyButton.x = buyButton.x  - (display.actualContentWidth - display.contentWidth) /2
      useButton.x = useButton.x  - (display.actualContentWidth - display.contentWidth) /2


     --  buyDisabled  = display.newImage("images/shop/BuyDisabled.png")      
     --  buyDisabled.width = buyButton.contentWidth
     --  buyDisabled.height = buyButton.contentHeight
     --  buyDisabled.x = buyButton.x 
     --  buyDisabled.y = buyButton.y 


     --  useDisabled  = display.newImage("images/shop/UseDisabled.png")      
     --  useDisabled.width = useButton.contentWidth
     --  useDisabled.height = useButton.contentHeight
     --  useDisabled.x = useButton.x 
     --  useDisabled.y = useButton.y 

     --  local function nullListener( event )
          
     --     return true
     --   end

     -- buyDisabled:addEventListener("touch", nullListener )
     -- useDisabled:addEventListener("touch", nullListener )

     -- buyDisabled.alpha = 0
     -- useDisabled.alpha = 0

        

       local function buyWithCoinsListener( event )


           if ( "began" == event.phase ) then
               if (commonData.catalog.items[seletedCategory][selectedItemIdx] and                  
                  not commonData.shopItems[commonData.catalog.items[seletedCategory][selectedItemIdx].id] and
                  commonData.catalog.items[seletedCategory][selectedItemIdx].coinsCost and
                  coinsCount < commonData.catalog.items[seletedCategory][selectedItemIdx].coinsCost ) then

                  local alphaNum = 1.1
                  buyNotificationText.alpha = 1.5
                  buyNotificationRect.alpha = 1.5

                   timer.performWithDelay(1, function( )
                     alphaNum = alphaNum - 0.01
                     buyNotificationText.alpha = alphaNum
                     buyNotificationRect.alpha = alphaNum

                   end, 110)
              
                    commonData.analytics.logEvent( "notEnoughCoins", {  item = tostring(  commonData.catalog.items[seletedCategory][selectedItemIdx].id ) } ) 
                end
           elseif ( "ended" == event.phase ) then
                 commonData.buttonSound()

            
             if (commonData.catalog.items[seletedCategory][selectedItemIdx] and                  
                  not commonData.shopItems[commonData.catalog.items[seletedCategory][selectedItemIdx].id] and
                  commonData.catalog.items[seletedCategory][selectedItemIdx].coinsCost and
                  coinsCount >= commonData.catalog.items[seletedCategory][selectedItemIdx].coinsCost ) then

                  commonData.analytics.logEvent( "buyWithCoins", {  item = tostring(  commonData.catalog.items[seletedCategory][selectedItemIdx].id ) } ) 

            
                  coinsCount = coinsCount - commonData.catalog.items[seletedCategory][selectedItemIdx].coinsCost
                  commonData.shopItems[commonData.catalog.items[seletedCategory][selectedItemIdx].id] = true
                  commonData.gameData.coins  = coinsCount
                  commonData.gameData.usedcoins =  commonData.gameData.usedcoins + commonData.catalog.items[seletedCategory][selectedItemIdx].coinsCost
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

       
        local function buyWithGemsListener( event )


           if ( "began" == event.phase ) then
               -- if (commonData.catalog.items[seletedCategory][selectedItemIdx] and                  
               --    not commonData.shopItems[commonData.catalog.items[seletedCategory][selectedItemIdx].id] and
               --    commonData.catalog.items[seletedCategory][selectedItemIdx].gemsCost and
               --    gemsCount < commonData.catalog.items[seletedCategory][selectedItemIdx].gemsCost ) then

               --    local alphaNum = 1.1
               --    buyNotificationText.alpha = 1.5
               --    buyNotificationRect.alpha = 1.5

               --     timer.performWithDelay(1, function( )
               --       alphaNum = alphaNum - 0.01
               --       buyNotificationText.alpha = alphaNum
               --       buyNotificationRect.alpha = alphaNum

               --     end, 110)
              
               --      commonData.analytics.logEvent( "notEnoughGems", {  item = tostring(  commonData.catalog.items[seletedCategory][selectedItemIdx].id ) } ) 
               --  end
           elseif ( "ended" == event.phase ) then
                 commonData.buttonSound()

            
             if (commonData.catalog.items[seletedCategory][selectedItemIdx] and                  
                  not commonData.shopItems[commonData.catalog.items[seletedCategory][selectedItemIdx].id] and
                  commonData.catalog.items[seletedCategory][selectedItemIdx].gemsCost and
                  gemsCount >= commonData.catalog.items[seletedCategory][selectedItemIdx].gemsCost ) then

                  commonData.analytics.logEvent( "buyWithGems", {  item = tostring(  commonData.catalog.items[seletedCategory][selectedItemIdx].id ) } ) 

            
                  gemsCount = gemsCount - commonData.catalog.items[seletedCategory][selectedItemIdx].gemsCost
                  commonData.shopItems[commonData.catalog.items[seletedCategory][selectedItemIdx].id] = true
                  commonData.gameData.gems  = gemsCount
                  commonData.gameData.usedgems =  commonData.gameData.usedgems + commonData.catalog.items[seletedCategory][selectedItemIdx].gemsCost
                  setCoinsCount()
                  icons[selectedItemIdx].owned.alpha = 1

                  setSelectedItems()
                  areYouSurePopup.alpha = 0
                  useButton.alpha = 1
                  buyButton.alpha = 0
                  setSlidesLocked(false)
             else
               areYouSurePopup.alpha = 0
               setSlidesLocked(false)

               seletedCategory = "gems"
               openCategory()

     
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

       local function makeStorePurchase(productId)

            if ( system.getInfo("platformName") == "Android" ) then
              store.purchase( productId)
            else
              store.purchase( {productId})
            end  
        end 

       local function buyWithCashListener( event )
          
          if ( "ended" == event.phase ) then
             commonData.buttonSound()

             local catItems = commonData.catalog.getActiveItems(seletedCategory)    
           
             if (catItems[selectedItemIdx] and                  
                  catItems[selectedItemIdx].storeId) then

                   commonData.analytics.logEvent( "buyWithCashPressed", {  item = tostring(  catItems[selectedItemIdx].id ) } ) 


                  if store.isActive == false then
                    -- native.showAlert("Store is not available, please try again later", {"OK"})
                    -- print("Store is not available, please try again later")
                  elseif store.canMakePurchases == false then
                    -- native.showAlert("Store purchases are not available, please try again later", {"OK"})
                    --  print("Store purchases are not available, please try again later")
                  else
            --        print("Ka-ching! Purchasing " .. tostring(productId))

                    -- if (seletedCategory=="balls") then
                    --   makeStorePurchase( "android.test.purchased")
                    -- else  
                    --   makeStorePurchase( "com.ld.dribble.test.ball" )
                    -- end

                    makeStorePurchase( catItems[selectedItemIdx].storeId )
                  end                  
             end

          end
          return true
        
       end


      
      buyWithCoinsButtonIcon =  display.newImage("Coin/Coin.png")
      buyWithCoinsButtonIcon:scale(0.15,0.15)
      


      buyWithCoinsButton = widget.newButton
      {
          x = 295,
          y = BUTTON_1_Y,
          id = "buyWithCoins",
          defaultFile = "images/shop/BuyWithCoins.png",          
          overFile = "images/shop/BuyWithCoinsDown.png",
          onEvent = buyWithCoinsListener
      }

      buyWithCoinsButtonDisabled = widget.newButton
      {
          x = 295,
          y = BUTTON_1_Y,
          id = "buyWithCoins",
          defaultFile = "images/shop/UseCoinsDisabled.png",          
          overFile = "images/shop/UseCoinsDisabled.png",
          onEvent = nullListener
      }
      

      buyWithGemsButtonIcon =  display.newImage("images/SupaGem.png")
      buyWithGemsButtonIcon:scale(0.15,0.15)
      


      buyWithGemsButton = widget.newButton
      {
          x = 295,
          y = BUTTON_1_Y,
          id = "buyWithGems",
          defaultFile = "images/shop/BuyWithCoins.png",          
          overFile = "images/shop/BuyWithCoinsDown.png",
          onEvent = buyWithGemsListener
      }

      buyWithCashButtonIcon =  display.newImage("images/shop/CashIcon.png")
      buyWithCashButtonIcon:scale(0.2,0.2)
      
      buyWithCashButton = widget.newButton
      {
          x = 295,
          y = BUTTON_1_Y,
          id = "buyWithCash",
          defaultFile = "images/shop/BuyWithCoins.png",          
          overFile = "images/shop/BuyWithCoinsDown.png",
          onEvent = buyWithCashListener
      }
      cancelBuyButton = widget.newButton
      {
          x = 295,
          y = BUTTON_3_Y,
          id = "cancelBuyButton",
          defaultFile = "images/shop/BuyWithCoins.png",          
          overFile = "images/shop/BuyWithCoinsDown.png",
          label = getTransaltedText("Cancel"),
          labelAlign = "center",
          font = "UnitedItalicRgHv",  
          fontSize = 48 , 
         -- labelXOffset = 20,
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } },
          onEvent = cancelButtonListener
      }

        local function backButtonListener( event )

           if ( "ended" == event.phase ) then
            commonData.buttonSound()
            composer.gotoScene( "menu" )
            
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
          --labelAlign = "left",
          font = "UnitedItalicRgHv",  
          fontSize = 64 , 
          --labelXOffset = 200,
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


      local coinTextOptions = 
      {
         
          text = "",     
          x = 0,
          y = 155,
         -- width = 120,     --required for multi-line and alignment
          font = "UnitedSansRgHv",   
          fontSize = 13,
          align = "right"  --new alignment parameter
      }


                
      
      buyWithCoinsText = display.newText(coinTextOptions)       
      buyWithCoinsText.x = 315
      buyWithCoinsText.y = BUTTON_1_Y
      buyWithCoinsText:setFillColor(255/255,241/255,208/255)

      buyWithGemsText = display.newText(coinTextOptions)       
      buyWithGemsText.x = 315
      buyWithGemsText.y = BUTTON_2_Y
      buyWithGemsText:setFillColor(255/255,241/255,208/255)


      buyWithCashText = display.newText(coinTextOptions)       
      buyWithCashText.x = 315
      buyWithCashText.y = BUTTON_2_Y
      buyWithCashText:setFillColor(255/255,241/255,208/255)

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
          width = 200,     --required for multi-line and alignment
          font = "UnitedSansRgHv",   
          fontSize = 15,    
          align = "left"  --new alignment parameter
      }


      itemDesc = display.newText(itemDescOptions) 
      itemDesc.x = 200
      itemDesc.y = 220
      itemDesc:setFillColor(255/255,241/255,208/255)
      itemDesc.x = itemDesc.x  - (display.actualContentWidth - display.contentWidth) /2

      areYouSurePopup = display.newGroup()

      areYouSureBackground  = display.newImage("images/shop/BuyDialogBlue.png")

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

             -------------------------------------------------------------------------------
         

      
      

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


       
      
        if store.isActive then
           seletedCategory = "gems"
        else     
           seletedCategory = "skins"
        end

        openCategory()      
       
      
      areYouSureBackground.xScale = 0.65 *display.actualContentWidth / areYouSureBackground.contentWidth 
      areYouSureBackground.yScale = areYouSureBackground.xScale
      buyWithCoinsButton.xScale = 0.2 *display.actualContentWidth / buyWithCoinsButton.contentWidth 
      buyWithCoinsButton.yScale = buyWithCoinsButton.xScale
      buyWithCoinsButtonDisabled.xScale = 0.2 *display.actualContentWidth / buyWithCoinsButtonDisabled.contentWidth 
      buyWithCoinsButtonDisabled.yScale = buyWithCoinsButtonDisabled.xScale

      buyWithGemsButton.xScale = 0.2 *display.actualContentWidth / buyWithGemsButton.contentWidth 
      buyWithGemsButton.yScale = buyWithGemsButton.xScale
      
      buyWithCashButton.xScale = 0.2 *display.actualContentWidth / buyWithCashButton.contentWidth 
      buyWithCashButton.yScale = buyWithCashButton.xScale
      
      
      
      cancelBuyButton.xScale = 0.2 *display.actualContentWidth / cancelBuyButton.contentWidth 
      cancelBuyButton.yScale = cancelBuyButton.xScale

      buyWithCoinsButtonIcon.x = buyWithCoinsButton.x + 30
      buyWithCoinsButtonIcon.y = buyWithCoinsButton.y

      buyWithGemsButtonIcon.x = buyWithGemsButton.x + 30
      buyWithGemsButtonIcon.y = buyWithGemsButton.y

      buyWithCashButtonIcon.x = buyWithCashButton.x + 30
      buyWithCashButtonIcon.y = buyWithCashButton.y
      
      buyWithCoinsText.x = buyWithCoinsButtonIcon.x - buyWithCoinsButtonIcon.contentWidth/2 - buyWithCoinsText.contentWidth /2 -3
      buyWithGemsText.x = buyWithGemsButtonIcon.x - buyWithGemsButtonIcon.contentWidth/2 - buyWithGemsText.contentWidth /2 -3
      buyWithCashText.x = buyWithCashButtonIcon.x - buyWithCashButtonIcon.contentWidth/2 - buyWithCashText.contentWidth /2 -3
      
      areYouSurePopup:insert(blackRect)
      areYouSurePopup:insert(areYouSureBackground)
      areYouSurePopup:insert(buyWithCoinsButton)
      areYouSurePopup:insert(buyWithCoinsButtonDisabled)
      
      
      areYouSurePopup:insert(buyWithCoinsButtonIcon)
      
      areYouSurePopup:insert(buyWithCoinsText)
      
      areYouSurePopup:insert(buyWithGemsButton)      
      areYouSurePopup:insert(buyWithGemsButtonIcon)      
      areYouSurePopup:insert(buyWithGemsText)

      areYouSurePopup:insert(buyWithCashButton)      
      areYouSurePopup:insert(buyWithCashButtonIcon)      
      areYouSurePopup:insert(buyWithCashText)


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

    sceneGroup:insert(gemsShadowText)
    sceneGroup:insert(gemsCountText)
    sceneGroup:insert(gemImg)


    sceneGroup:insert(useButton)
    sceneGroup:insert(buyButton)
    -- sceneGroup:insert(useDisabled)
    -- sceneGroup:insert(buyDisabled)
    
     sceneGroup:insert(categories)   
     
     
     sceneGroup:insert(itemDesc)  
     sceneGroup:insert(backButton)
     sceneGroup:insert(backIcon)
     


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

      buyButton:setLabel(getTransaltedText("Buy"))
      useButton:setLabel(getTransaltedText("Use"))
      cancelBuyButton:setLabel(getTransaltedText("Cancel"))
      backButton:setLabel(getTransaltedText("Back"))


      local prevScene = composer.getSceneName( "previous" )
      if prevScene == "game" then
        seletedCategory = "gems"
      end  
      openCategory()


  
   elseif ( phase == "did" ) then
      
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
      if(event.params and event.params.gameData) then
           coinsCount = commonData.gameData.coins  
           gemsCount = commonData.gameData.gems             
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

function scene:initStore( )
    
     
     local function trim1(s)
        return (s:gsub("^%s*(.-)%s*$", "%1"))
      end

     local function productCallback( event )
            --print( "Showing valid products:", #event.products )
            for i = 1,#event.products do
                -- print( event.products[i].title )
                -- print( event.products[i].description )
                -- print( event.products[i].price )
                -- print( event.products[i].localizedPrice )
                -- print( event.products[i].productIdentifier )


                for key,cat in pairs(commonData.catalog.items) do
                  for idx=1,#cat do
                  
                    if (cat[idx].storeId and cat[idx].storeId  == event.products[i].productIdentifier) then
--                      print ("items matched")
                      cat[idx].cashCost = trim1(event.products[i].localizedPrice)
                    end  
                  end
                end    
            end

  --          print( "Showing invalid products:", #event.invalidProducts )
            for i = 1,#event.invalidProducts do
                --printTable( event.invalidProducts[i] )
            end        
        end
     

     local isProductLoaded = false
        local productsReloadCount  = 5
        
        local function loadProducts()
          if not isProductLoaded then
            
            if (store.isActive and store.canLoadProducts ) then
              --print("try to load products")
              store.loadProducts( productList, productCallback )
              isProductLoaded = true 
            else
              --print("cannot load products")
              if (productsReloadCount > 0 ) then
                productsReloadCount = productsReloadCount -1
                timer.performWithDelay(2000 , loadProducts , 1)              
              end
            end
          end

          return store.isActive and store.canLoadProducts
        end
        

      local function transactionCallback( event )
        local infoString

        
        -- print("transactionCallback: Received event " .. tostring(event.name))
        -- print("state: " .. tostring(event.transaction.state))
        -- print("errorType: " .. tostring(event.transaction.errorType))
        -- print("errorString: " .. tostring(event.transaction.errorString))

        if ( event.name == "init" ) then
        --  print("call load products")          
          loadProducts()
        elseif event.transaction.state == "purchased" then
          infoString = "Transaction successful!"
          -- print(infoString)
          
          -- print("receipt: " .. tostring(event.transaction.receipt))
          -- print("signature: " .. tostring(event.transaction.signature))
      

          local catItems = commonData.catalog.getActiveItems(seletedCategory) 

          if  catItems[selectedItemIdx].specialOffer then
            if catItems[selectedItemIdx].id == "starterPack" then
              commonData.shopItems["NorthShaw"] = true
              commonData.shopItems["RedBall"] = true
              commonData.shopItems["Glacier"] = true
              commonData.shopItems["ice"] = true

            elseif  catItems[selectedItemIdx].id == "shakesPack" then
              commonData.shopItems["Shakes"] = true
              commonData.gameData.gems = commonData.gameData.gems + 2
            elseif  catItems[selectedItemIdx].id == "megaPack" then
              commonData.shopItems["ElMatador"] = true
              commonData.shopItems["Rasta"] = true
              commonData.gameData.gems = commonData.gameData.gems + 5
            end  

          else  
            commonData.gameData.gems = commonData.gameData.gems + catItems[selectedItemIdx].gemsCount
          end

          commonData.gameData.madePurchase = true
          gemsCount = commonData.gameData.gems             
          commonData.saveTable(commonData.shopItems , SHOP_FILE)

          commonData.saveTable(commonData.gameData , GAME_DATA_FILE, true)

          setCoinsCount()
          
          areYouSurePopup.alpha = 0          
          setSlidesLocked(false)  


          if ( system.getInfo("platformName") == "Android" ) then
            store.consumePurchase( catItems[selectedItemIdx].storeId )
          end
          
          commonData.analytics.logEvent( "itemPurchased", {  item = tostring( catItems[selectedItemIdx].id ) } ) 


        elseif  event.transaction.state == "restored" then
          -- Reminder: your app must store this information somewhereƒ
          -- Here we just display some of it
          -- infoString = "Restoring transaction:" ..
          --           "\n   Original ID: " .. tostring(event.transaction.originalTransactionIdentifier) ..
          --           "\n   Original date: " .. tostring(event.transaction.originalDate)
          -- print(infoString)
          -- print("productIdentifier: " .. tostring(event.transaction.productIdentifier))
          -- print("receipt: " .. tostring(event.transaction.receipt))
          -- print("transactionIdentifier: " .. tostring(event.transaction.transactionIdentifier))
          -- print("date: " .. tostring(event.transaction.date))
          -- print("originalReceipt: " .. tostring(event.transaction.originalReceipt))

        elseif  event.transaction.state == "refunded" then
          -- Refunds notifications is only supported by the Google Android Marketplace.
          -- Apple's app store does not support this.
          -- This is your opportunity to remove the refunded feature/product if you want.
          -- infoString = "A previously purchased product was refunded by the store."
          -- print(infoString .. "\nFor product ID = " .. tostring(event.transaction.productIdentifier))
         
        elseif event.transaction.state == "cancelled" then
          -- infoString = "Transaction cancelled by user."
          -- print(infoString)
         
        elseif event.transaction.state == "failed" then        
          -- infoString = "Transaction failed, type: " .. 
          --   tostring(event.transaction.errorType) .. " " .. tostring(event.transaction.errorString)
          -- print(infoString)
          
        else
          infoString = "Unknown event"
          -- print(infoString)
         end

        -- Tell the store we are done with the transaction.
        -- If you are providing downloadable content, do not call this until
        -- the download has completed.
        store.finishTransaction( event.transaction )
      end

      print("call init")
        store.init(transactionCallback)

        timer.performWithDelay ( 1000, loadProducts )
        moshe= "david"
        
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene

