local commonData = require( "commonData" )

local composer = require( "composer" )
local widget = require( "widget" )
local particleDesigner = require( "particleDesigner" )

--local fuse = require( "plugin.fuse" )
require( "menu" )
require( "achivmentsManager" )
require "translation"



local json = require("json")
local heroSpine =  require ("hero")
local isSimulator = "simulator" == system.getInfo( "environment" )
      
local scene = composer.newScene()
local playButton = nil
local background = nil
local newLevelBackground = nil
local skipAdmob = false
local admobTime = nil
local rateUsButton = nil
local showAdButton =  nil
local isGameOverActive = true


local achivmetBarFull = nil
local achivmetBar = nil
local highScoreShadowText = nil
local parent = nil
local scoreText  = nil
local scoreTextS  = nil
local openPkgButton = nil
local openPkgButton2 = nil
 
 local highScoreText = nil

local boosterMsgSpine =  nil
local boosterMsg = nil

local shareButton = nil

local scoreTitleText = nil 
local scoreTitleTextS = nil
local levelText = nil 
local nextLevelText = nil 
local comboText = nil 
local comboTextS = nil

local dailyRewardBlocker = nil
local loadingBlocker = nil
local boosterRect = nil
local boosterText  = nil
local boosterHeaderText  = nil
local boosterButton = nil
local boosterClose = nil

local boosterCoinsText= nil
local boosterCoinImg = nil
local boosterHandImg = nil
local confetti  = nil
local notification = nil
local notificationData = nil
local scoreBox = nil
local chalengesData = nil
local chalengesBox = nil
local gameOverGroup = nil
local newLevelGroup = nil
local promotionGroup = nil
local newItemsGroup = nil

local packReminder = nil
local dailyReward = nil
local dailyRewardGroup = nil
local activeScreen = 1

local xp = {
  xpBarMiddle = nil,
  xpBarEnd = nil,
  xpBarBG = nil,
  xpBarStart = nil,
  xpEmiter = nil
}

local newLevelText = {
  levelUp = nil,
  newLevel = nil,
  newItems = nil
}

local promotionElements = {}


---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------


local function logCoins(gameData , newCoins)
  local coinsToNotify = {}
  coinsToNotify[1] = 20  
  coinsToNotify[2] = 50
  coinsToNotify[3] = 100  
  coinsToNotify[4] = 200  
  coinsToNotify[5] = 500
  coinsToNotify[6] = 1000


  for i=1,6 do
    

    if gameData.coins + gameData.usedcoins > coinsToNotify[i] and
          gameData.coins + gameData.usedcoins < coinsToNotify[i] + newCoins then

          commonData.analytics.logEvent( "reached " ..  tostring(coinsToNotify[i]) .. " coins", { gamesCount= tostring( gameData.gamesCount)  } )
    end  
  end  
end

local function rateUsListener( event )
     if ( "ended" == event.phase ) then

      
      commonData.buttonSound()
      local options =
        {  -- TODO: update app id
           iOSAppId = "1251367023",          
           androidAppPackageName = "com.sprbl.supaStrikas",
           supportedAndroidStores = { "google" },
        }
        native.showPopup( "appStore", options )
     end 
       return true
 end



local function logHighScore(gameData , newHighScore)
  local coinsToNotify = {}
  coinsToNotify[1] = 100  
  coinsToNotify[2] = 300
  coinsToNotify[3] = 500  
  coinsToNotify[4] = 1000  
  coinsToNotify[5] = 2000
  coinsToNotify[6] = 3000  
  coinsToNotify[7] = 6000  
  coinsToNotify[8] = 10000    
  coinsToNotify[9] = 20000
  coinsToNotify[10] = 30000
  coinsToNotify[11] = 40000

  for i=1,11 do
    

    if gameData.highScore < coinsToNotify[i] and
       coinsToNotify[i] < newHighScore then

           if system.getInfo("environment") ~= "simulator" then
            if not commonData.gameData.abVersion then
               commonData.analytics.logEvent( "reached " ..  tostring(coinsToNotify[i]) .. " points", { gamesCount= tostring( gameData.gamesCount)  } )
            else      
              commonData.analytics.logEvent( "reached " ..  tostring(coinsToNotify[i]) .. " points in version " .. tostring( commonData.gameData.abVersion), 
                { gamesCount= tostring( gameData.gamesCount)  } )
            end
        end
          
    end  
  end

   
end


local function logGamesCount(gameData)
  local gamesToAlert = {}
  gamesToAlert[1] = 1  
  gamesToAlert[2] = 2
  gamesToAlert[3] = 3  
  gamesToAlert[4] = 4 
  gamesToAlert[5] = 5
  gamesToAlert[6] = 7
  gamesToAlert[7] = 10
  gamesToAlert[8] = 15
  gamesToAlert[9] = 20
  gamesToAlert[10] = 30
  gamesToAlert[11] = 50
  gamesToAlert[12] = 75
  gamesToAlert[13] = 100
  gamesToAlert[14] = 150
  gamesToAlert[15] = 200
  gamesToAlert[16] = 500
  gamesToAlert[17] = 1000

  for i=1,17 do
    

    if gameData.gamesCount  == gamesToAlert[i]  then

         if system.getInfo("environment") ~= "simulator" then
            if not commonData.gameData.abVersion then
                commonData.analytics.logEvent( "Played " ..  tostring(gameData.gamesCount) .. " games", 
                  {  highScore = tostring(  gameData.highScore) ,
                    totalCoins = tostring(  gameData.coins + gameData.usedcoins) ,
                    avgScore =  tostring(gameData.totalScore / math.max(gameData.gamesCount, 1)) } )
            else      
              commonData.analytics.logEvent( "Played " ..  tostring(gameData.gamesCount) .. " games in version " .. tostring( commonData.gameData.abVersion), 
                  {  highScore = tostring(  gameData.highScore) ,
                    totalCoins = tostring(  gameData.coins + gameData.usedcoins) ,
                    avgScore =  tostring(gameData.totalScore / math.max(gameData.gamesCount, 1)) } )
            end
        end
        
        break
    end  
  end  
end



local shouldDisplayOkButton = true

local function showText( )
  local okButtonDelay = 1
  boosterText.alpha = 1
  boosterHeaderText.alpha = 1
   notificationData.alpha = 1 

   if boosterCoinsText.text and boosterCoinsText.text ~= "" then

      --boosterCoinsText.alpha = 1
      --boosterCoinImg.alpha = 1
   else
      -- if tip then 
      --   tip.alpha = 1   
      --     tip:setSequence("start")
      --     tip:play()  
      --     okButtonDelay = 2000
      -- end

      -- if tip2 then 
      --   tip2.alpha = 1   
      --     tip2:setSequence("start")
      --     tip2:play()  
      --     okButtonDelay = 2000
      -- end

      -- if tip3 then 
      --   tip3.alpha = 1             
      --     okButtonDelay = 2000
      -- end
   end
   
   if shouldDisplayOkButton then
     timer.performWithDelay(okButtonDelay, function ()
       boosterButton.alpha = 1     
     end, 1)
     
   else 
     boosterClose.alpha = 1  
   end
end

local function showNotification( text )
    boosterText.alpha = 0
    boosterButton.alpha = 0
    boosterClose.alpha = 0
    boosterHeaderText.alpha = 0
    boosterCoinsText.alpha = 0
    boosterCoinImg.alpha = 0
    boosterHandImg.alpha = 0   
    notificationData.alpha = 0 
    shouldDisplayOkButton = true
    boosterMsg.skeleton.group.alpha = 1
    boosterMsg:init()
    boosterText.text = text
    boosterHeaderText.text = ""
    boosterCoinsText.text = ""
    notification.alpha = 1

    timer.performWithDelay(1500 , showText , 1)
end

local function showPrizeNotification( header , text , coins, displyOk )
    boosterText.alpha = 0
    boosterButton.alpha = 0
    boosterClose.alpha = 0
    boosterHeaderText.alpha = 0
    boosterCoinsText.alpha = 0
    boosterCoinImg.alpha = 0
    boosterHandImg.alpha = 0 
    notificationData.alpha = 0 
    
    shouldDisplayOkButton = displyOk
    if coins then
      boosterCoinsText.text = " x " .. tostring(coins)    
    else
      boosterCoinsText.text = nil    
    end  
 
    boosterMsg.skeleton.group.alpha = 1
    boosterMsg:init()
    boosterText.text = text
    boosterHeaderText.text = header
    notification.alpha = 1

    timer.performWithDelay(1500 , showText , 1)
end


local function adBonus( event )
        showAdButton.alpha = 0
        
        playButton.alpha = 1
        commonData.gameData.coins = commonData.gameData.coins + 20     
        commonData.gameData.adsPressed = commonData.gameData.adsPressed + 1   

        commonData.saveTable(commonData.gameData , GAME_DATA_FILE)


        logCoins(commonData.gameData , 20)
        commonData.analytics.logEvent( "endWatchAd", {  prizeCategory= tostring( rewardIndex ) } ) 

        parent:outerCoinsReward(20 ,  70 - (display.actualContentWidth - display.contentWidth) /2 , 165 )

        if commonData.gameData.adsPressed == 100 then
          
          initAchivments(commonData.gameData.unlockedAchivments)

          unlockAchivment("MoneyMachine", true) 
        end

end


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

local admob = require( "plugin.admob" )
 
-- AdMob listener function
local function adListener( event )
 
    if ( event.phase == "init" ) then  -- Successful initialization
        admob.load( "interstitial", { adUnitId="ca-app-pub-3507083359749399/1731272629", childSafe=true } )
        admob.load( "rewardedVideo", { adUnitId="ca-app-pub-3507083359749399/6868049235", childSafe=true } )

    elseif ( event.phase == "displayed" ) then  -- Successful initialization    
         admob.load( "interstitial", { adUnitId="ca-app-pub-3507083359749399/1731272629", childSafe=true } )
        admob.load( "rewardedVideo", { adUnitId="ca-app-pub-3507083359749399/6868049235", childSafe=true } )
        playButton.alpha = 1
        
        if not isGameOverActive  then
          commonData.analytics.logEvent( "admob banner during game", {  latency= tostring( system.getTimer() - admobTime ) } )           
          skipAdmob = true
        end
  
    elseif ( event.phase == "reward" ) then  -- Successful initialization
        adBonus(event)      
        
    end
end
 
-- Initialize the AdMob plugin
admob.init( adListener, { appId="ca-app-pub-3507083359749399~5078602640", testMode=true } )



local superawesome = require( "plugin.superawesome" )
 
-- Pre-declare a placement ID
local myPlacementID = "34643"
 
local function adListener( event )
 
    if ( event.phase == "init" ) then  -- Successful initialization
        -- Load a banner ad
        superawesome.load( "video", { placementId=myPlacementID } )
    elseif ( event.phase == "playbackEnded" ) then  -- Successful initialization
        adBonus(event)
    end
end
 
-- Initialize the SuperAwesome plugin
superawesome.init( adListener, { testMode=false } )
 
-- Sometime later, check if the ad is loaded

local function pairsByHighScore (t)
      local a = {}
      for n in pairs(t) do table.insert(a, n) end
      table.sort(a, function (a,b)
        return a >b
      end)
      local i = 0      -- iterator variable
      local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else           
          return a[i], t[a[i]]
        end
      end
      return iter
    end

local function showActiveScreen()
      if activeScreen == 1 then        
        scoreBox.alpha = 1 
        chalengesBox.alpha = 0              
        
      else  
        scoreBox.alpha = 0 
        chalengesBox.alpha = 1
        
      end  
    end  

local function showPromotion( gameResult , isFirstLoad , currentPromo)

     
         local promotionBackground =  display.newImage("images/BGDotted.jpg")
     promotionBackground.xScale =  (display.actualContentWidth*1) / promotionBackground.contentWidth
     promotionBackground.yScale =  (display.actualContentHeight*1) / promotionBackground.contentHeight
     promotionBackground.x = 240
     promotionBackground.y = 160

     promotionElements.promotionBackground2 =  display.newImage("images/BGStripes.png")
     promotionElements.promotionBackground2.xScale =  (display.actualContentWidth*1) / promotionElements.promotionBackground2.contentWidth
     promotionElements.promotionBackground2.yScale =  (display.actualContentHeight*1) / promotionElements.promotionBackground2.contentHeight
     promotionElements.promotionBackground2.x = 240
     promotionElements.promotionBackground2.y = 160

    promotionElements.promotionBackground3 =  display.newImage("images/Coach.png")
     
     promotionElements.promotionBackground3.yScale =  (display.actualContentHeight* 0.9 ) / promotionElements.promotionBackground3.contentHeight
     promotionElements.promotionBackground3.xScale  = promotionElements.promotionBackground3.yScale
     promotionElements.promotionBackground3.x = 110 - (display.actualContentWidth - display.contentWidth)/2  
     promotionElements.promotionBackground3.y = 160

     promotionElements.promotionBackground3.y = 320 - promotionElements.promotionBackground3.contentHeight/2  + (display.actualContentHeight - display.contentHeight)/2  

      local function goToShopListener( event )
          
          if ( "ended" == event.phase ) then
            commonData.playSound( selectMenuSound ) 
            
            commonData.analytics.logEvent( "Claim promotion"  , { gamesCount= tostring( commonData.gameData.gamesCount) ,                                                  
                                                highScore= tostring(  commonData.gameData.highScore) ,
                                                 } )

            promotionElements.wings:pause()
            promotionElements.wings2:pause()

            local options = {params = {gameData = commonData.gameData}}
            composer.gotoScene( "shop" , options )
            
          end
          return true
     end
     local function cancelPromoBtnListener( event )
          
          if ( "ended" == event.phase ) then
            
            commonData.buttonSound()

            commonData.analytics.logEvent( "Cancel promotion"  , { gamesCount= tostring( commonData.gameData.gamesCount) ,                                                  
                                                highScore= tostring(  commonData.gameData.highScore) ,
                                                 } )


            promotionElements.wings:pause()
            promotionElements.wings2:pause()


            promotionGroup.alpha = 0
            
          end
          return true
     end


     local gradient = {
          type="gradient",
          color2={ 255/255,241/255,208/255,1}, color1={ 1, 180/255, 0,1 }, direction="up"
      }

      local promotoionClaimBtn = widget.newButton
      {
          x = 330,
          y = 290,
          id = "boosterButton",
          defaultFile =  "BlueSet/End/EGMainMenuUp.png",
          overFile = "BlueSet/End/EGMainMenuDown.png",
          onEvent = goToShopListener,
          label = getTransaltedText("OK"),
          labelAlign = "center",
          font = "UnitedSansRgHv",  
          fontSize = 40 ,           
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } }
      }
     promotoionClaimBtn.xScale =  (display.actualContentWidth*0.3) / promotoionClaimBtn.width
     promotoionClaimBtn.yScale = promotoionClaimBtn.xScale  

      local promotoionCancelBtn = widget.newButton
      {
          x = 170,
          y = 290,
          id = "boosterButton",
          defaultFile =  "BlueSet/End/EGMainMenuUp.png",
          overFile = "BlueSet/End/EGMainMenuDown.png",
          onEvent = cancelPromoBtnListener,
          label = getTransaltedText("Cancel"),
          labelAlign = "center",
          font = "UnitedSansRgHv",  
          fontSize = 40 ,           
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } }
      }
     promotoionCancelBtn.xScale =  (display.actualContentWidth*0.3) / promotoionCancelBtn.width
     promotoionCancelBtn.yScale = promotoionCancelBtn.xScale  

    

   local gradient = {
          type="gradient",
          color3={ 255/255,1,1,1}, color2={ 255/255,241/255,208/255,1}, color1={ 1, 180/255, 0,1 }, direction="up"
      }


    promotionElements.promoText1 = display.newText({text="ONE TIME" , x = 250, y = 80, font = "UnitedSansRgHv", fontSize = 50,align = "center"})
    promotionElements.promoShadow1 = display.newText({ text="ONE TIME" ,  x = 250, y = 80, font = "UnitedSansRgHv", fontSize = 52,align = "center"}) 
    
    promotionElements.promoText1:setFillColor(gradient)
    promotionElements.promoShadow1:setFillColor(0,0,0)
    
    promotionElements.promoText2 = display.newText({ text="SPECIAL" ,  x = 250, y = 140, font = "UnitedSansRgHv", fontSize = 80,align = "center"})
    promotionElements.promoShadow2 = display.newText({ text="SPECIAL" ,  x = 250, y = 140, font = "UnitedSansRgHv", fontSize = 82,align = "center"}) 
    
    promotionElements.promoText2:setFillColor(gradient)
    promotionElements.promoShadow2:setFillColor(0,0,0)    
    
    promotionElements.promoText3 = display.newText({ text="OFFER" ,  x = 250, y = 200, font = "UnitedSansRgHv", fontSize = 80,align = "center"})
    promotionElements.promoShadow3 = display.newText({ text="OFFER" ,  x = 250, y = 200, font = "UnitedSansRgHv", fontSize = 82,align = "center"}) 
    
    promotionElements.promoText3:setFillColor(gradient)
    promotionElements.promoShadow3:setFillColor(0,0,0)
    
    promotionElements.promoText1.x =   promotionElements.promoText1.x  + (display.actualContentWidth - display.contentWidth)/2  
    promotionElements.promoShadow1.x = promotionElements.promoText1.x 
    
    promotionElements.promoText2.x =   promotionElements.promoText2.x  + (display.actualContentWidth - display.contentWidth)/2  
    promotionElements.promoShadow2.x = promotionElements.promoText2.x 
    
    
    promotionElements.promoText3.x =   promotionElements.promoText3.x  + (display.actualContentWidth - display.contentWidth)/2  
    promotionElements.promoShadow3.x = promotionElements.promoText3.x 

    local promoIdx= 1
    if currentPromo == "starterPack"  then
      promoIdx= 1
    elseif   currentPromo == "shakesPack"  then
      promoIdx= 2
    elseif   currentPromo == "megaPack"  then
      promoIdx= 3
    end  
    commonData.catalog.items["gems"][promoIdx].hidden = false

    promotionElements.promoImage = display.newImage(commonData.catalog.items["gems"][promoIdx].image)
    promotionElements.promoImage.x = 240
    promotionElements.promoImage.y = 120
            
    promotionElements.promoText4 = display.newText({text=commonData.catalog.items["gems"][promoIdx].name , x = 240, y = 40, font = "UnitedSansRgHv", fontSize = 40,align = "center"})
    promotionElements.promoShadow4 = display.newText({ text=commonData.catalog.items["gems"][promoIdx].name ,  x = 240, y = 40, font = "UnitedSansRgHv", fontSize = 41,align = "center"}) 
    
    promotionElements.promoText4:setFillColor(gradient)
    promotionElements.promoShadow4:setFillColor(0,0,0)

    promotionElements.promoText5 = display.newText({text="90% OFF" , x = 240, y = 200, font = "UnitedSansRgHv", fontSize = 40,align = "center"})
    promotionElements.promoShadow5 = display.newText({ text="90% OFF" ,  x = 240, y = 200, font = "UnitedSansRgHv", fontSize = 41,align = "center"}) 
    
    promotionElements.promoText5:setFillColor(gradient)
    promotionElements.promoShadow5:setFillColor(0,0,0)
    
    
    promotionElements.promoText6 = display.newText({text="ONLY TODAY" , x = 240, y = 250, font = "UnitedSansRgHv", fontSize = 40,align = "center"})
    promotionElements.promoShadow6 = display.newText({ text="ONLY TODAY" ,  x = 240, y = 250, font = "UnitedSansRgHv", fontSize = 41,align = "center"}) 
    
    promotionElements.promoText6:setFillColor(gradient)
    promotionElements.promoShadow6:setFillColor(0,0,0)

    promotionElements.promoText4.alpha = 0
    promotionElements.promoText5.alpha = 0
    promotionElements.promoText6.alpha = 0
    promotionElements.promoShadow4.alpha = 0
    promotionElements.promoShadow5.alpha = 0
    promotionElements.promoShadow6.alpha = 0
    promotionElements.promoImage.alpha = 0
        
    
    local promotionSpineAn = require "promotion"


   

    promotionElements.wings = promotionSpineAn.new()
    promotionElements.wings.skeleton.group.alpha = 0
    promotionElements.wings.skeleton.group.x = - 100
    promotionElements.wings.skeleton.group.y = 300

    promotionElements.wings2 = promotionSpineAn.new()
    promotionElements.wings2.skeleton.group.alpha = 0
    promotionElements.wings2.skeleton.group.x = 580
    promotionElements.wings2.skeleton.group.y = 300

    promotionElements.wings2.skeleton.group.xScale = -1

    
 
     promotionGroup:insert(promotionBackground)
     promotionGroup:insert(promotionElements.promotionBackground2)
     promotionGroup:insert(promotionElements.promotionBackground3)
     promotionGroup:insert(promotionElements.promoShadow1)
     promotionGroup:insert(promotionElements.promoText1)
     promotionGroup:insert(promotionElements.promoShadow2)
     promotionGroup:insert(promotionElements.promoText2)
     promotionGroup:insert(promotionElements.promoShadow3)
     promotionGroup:insert(promotionElements.promoText3)
     promotionGroup:insert(promotionElements.promoShadow4)
     promotionGroup:insert(promotionElements.promoText4)
     promotionGroup:insert(promotionElements.promoShadow5)
     promotionGroup:insert(promotionElements.promoText5)
     promotionGroup:insert(promotionElements.promoShadow6)
     promotionGroup:insert(promotionElements.promoText6)
     promotionGroup:insert(promotionElements.wings.skeleton.group)
     promotionGroup:insert(promotionElements.wings2.skeleton.group)
     promotionGroup:insert(promotionElements.promoImage)
           

     promotionGroup:insert(promotoionCancelBtn)
     promotionGroup:insert(promotoionClaimBtn)


    promotionGroup.alpha =1 

    
    transition.moveTo(promotionElements.promotionBackground2 , { x= promotionElements.promotionBackground2.x - 100,alpha = 0, time=2000 } )
    transition.moveTo(promotionElements.promoText1 , { x= promotionElements.promoText1.x - 30 ,alpha = 0, time=2000 } )
    transition.moveTo(promotionElements.promoShadow1 , { x= promotionElements.promoShadow1.x - 30,alpha = 0, time=2000 } )
    transition.moveTo(promotionElements.promoText2 , { alpha = 0, time=2000 } )
    transition.moveTo(promotionElements.promoShadow2 , { alpha = 0, time=2000 } )
    transition.moveTo(promotionElements.promoText3 , { x= promotionElements.promoText3.x + 30,alpha = 0, time=2000 } )
    transition.moveTo(promotionElements.promoShadow3 , { x= promotionElements.promoShadow3.x + 30,alpha = 0, time=2000 } )

    timer.performWithDelay(1800 , function ()
      promotionElements.wings.skeleton.group.alpha = 1
      promotionElements.wings:init()
      promotionElements.wings2.skeleton.group.alpha = 1
      promotionElements.wings2:init()

      promotionElements.promoText4.alpha = 1
      promotionElements.promoText5.alpha = 1
      promotionElements.promoText6.alpha = 1
      promotionElements.promoShadow4.alpha = 1
      promotionElements.promoShadow5.alpha = 1
      promotionElements.promoShadow6.alpha = 1
      promotionElements.promoImage.alpha = 1

      promotionElements.promotionBackground2.alpha = 0
      promotionElements.promotionBackground3.alpha = 0
      promotionElements.promoText1.alpha = 0
      promotionElements.promoText2.alpha = 0
      promotionElements.promoText3.alpha = 0
      promotionElements.promoShadow1.alpha = 0
      promotionElements.promoShadow2.alpha = 0
      promotionElements.promoShadow3.alpha = 0
    end,1)
    
end  

local function showGameOver( gameResult , isFirstLoad)

        isGameOverActive = true
        gameOverGroup.alpha =0 
        newLevelGroup.alpha =0 
        promotionGroup.alpha =0 
        dailyRewardGroup.alpha =0 

        -- if math.random(2) == 1 then
             showAdButton.alpha = 1
        -- else
        --     showAdButton.alpha = 0
        -- end      


             local memUsed = (collectgarbage("count"))
             local texUsed = system.getInfo( "textureMemoryUsed" ) / 1048576 -- Reported in Bytes
           
        
            --print( string.format("%.00f", texUsed) .. " / " .. memUsed)
             
    
        boosterMsg.skeleton.group.alpha = 0
        notification.alpha = 0
        

       if ( not commonData.gameData) then 
          commonData.gameData = loadTable(GAME_DATA_FILE)

          if ( not commonData.gameData) then 
            commonData.gameData = {}
            commonData.gameData.highScore = 0
            commonData.gameData.coins = 0
            commonData.gameData.usedcoins = 0
            commonData.gameData.usedpacks = 0 
            commonData.gameData.packs = 0            
            commonData.gameData.gamesCount = 0
            commonData.gameData.totalScore = 0
            commonData.gameData.totalMeters = 0

            commonData.gameData.bounces = 0
            commonData.gameData.bouncesPerfect = 0
            commonData.gameData.bouncesGood = 0
            commonData.gameData.bouncesEarly = 0
            commonData.gameData.bouncesLate = 0
            commonData.gameData.jumps = 0
            commonData.gameData.lastGameTime = nil
            commonData.gameData.adsPressed = 0
            commonData.gameData.madePurchase = false
            commonData.gameData.unlockedAchivments = {}
          
          end  
       end 
      

        local gmCnt = commonData.gameData.gamesCount
       if (gmCnt == 0) then
        gmCnt = 1
       end 
       local showAdRnd =  gmCnt % 5 
               
         if not  admob.isLoaded( "interstitial" ) then
            admob.load( "interstitial", { adUnitId="ca-app-pub-3507083359749399/1731272629", childSafe=true } )
        
         end

         if not  admob.isLoaded( "rewardedVideo" ) then
            admob.load( "rewardedVideo", { adUnitId="ca-app-pub-3507083359749399/6868049235", childSafe=true } )
         end

         if not  superawesome.isLoaded( "video" ) then
            superawesome.load( "video", { placementId=myPlacementID } )
         end

         if (commonData.gameData.gamesCount > 50  and not  commonData.gameData.madePurchase) then
          commonData.kidoz.show( "panelView")      
        end

       if (gmCnt == 12) then
          showPromotion( gameResult , isFirstLoad , "starterPack")     
       elseif (gmCnt> 1 and  gmCnt % 121 == 1)  then   
          showPromotion( gameResult , isFirstLoad , "shakesPack")     
       elseif (gmCnt> 80 and  gmCnt % 121 == 70)   then  
          showPromotion( gameResult , isFirstLoad , "megaPack")       
       end 
       
       
       if (commonData.gameData.gamesCount > 30  and --not  commonData.gameData.madePurchase and 
            (commonData.gameData.adsPressed / gmCnt) < 0.2  and showAdRnd == 1 and not isFirstLoad and not skipAdmob ) then
                                       -- show the advert.
           
                admob.show("interstitial") 
                playButton.alpha = 0
                admobTime = system.getTimer() 
                timer.performWithDelay(3000,function ()
                  playButton.alpha = 1
                end,1)
           
      else
        playButton.alpha = 1

      end 


      --Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
      if(gameResult) then

            local endGameScore = gameResult.gameScore
            scoreText.text = commonData.comma_value(endGameScore)
            scoreTextS.text = commonData.comma_value(endGameScore)
            
            --commonData.kidoz.show( "rewardedVideo" )
            local function buildChallengesPart()

                  if not chalengesData or not chalengesData.numChildren then
                    return
                  end  

                    for j = 1, chalengesData.numChildren do                       
                        
                          chalengesData[1]:removeSelf()          
                        
                    end
                  
                   local challengeTextOptions = 
                  {
                      --parent = textGroup,
                      text = "",     
                      x = 420,
                      y = 20,
                    --  width = 300,     --required for multi-line and alignment
                      font = "UnitedSansRgHv",   
                      fontSize = 15,
                      align = "left"  --new alignment parameter
                  }

                  local challengeCoinsTextOptions = 
                  {
                      --parent = textGroup,
                      text = "",     
                      x = 420,
                      y = 20,
                      --width = 100,     --required for multi-line and alignment
                      font = "UnitedSansRgHv",   
                      fontSize = 15,
                      align = "right"  --new alignment parameter
                  }  

                  local challeges = getChalenges()
                   
                  for i=1,6 do

                    if challeges[i] then
                      local challegesText = display.newText(challengeTextOptions)
                      local challegesCoinsText = display.newText(challengeCoinsTextOptions)
                      local challegesCoin = display.newImage("Coin/Coin.png")
                      local bullet = nil

                      

                      if challeges[i].isUnlocked then
                      --      challegesText:setFillColor(19/256,236/256,254/256)
                        challegesCoinsText:setFillColor(1,206/255,0)
                        challegesText:setFillColor(1,206/255,0)
                        bullet = display.newImage("images/ChallengeBulletComplete.png")
                        

                      else
                        challegesCoinsText:setFillColor(1,1,1)
                        challegesText:setFillColor(1,1,1)
                        bullet = display.newImage("images/ChallengeBullet.png")
                                          
                      end

                      bullet:scale(0.5,0.5)
                      bullet.y = 95 + i* 22
                      bullet.x = 240 - background.contentWidth/2 + bullet.contentWidth/2 + 35
                      challegesText.text = getTransaltedText(challeges[i].name)  -- challeges[i].text
                      challegesText.x = bullet.x + bullet.contentWidth/2  + challegesText.contentWidth/2 + 15
                      challegesText.y = 95 + i* 22

                     
                      
                      challegesCoinsText.y = 95 + i* 22
                      challegesCoinsText.text = challeges[i].coins

                      challegesCoin:scale(0.15,0.15)
                      challegesCoin.x = 240 + background.contentWidth/2 -  challegesCoin.contentWidth/2 - 35
                      challegesCoin.y = 95 + i* 22

                      challegesCoinsText.x = challegesCoin.x - challegesCoin.contentWidth/2  - challegesCoinsText.contentWidth/2 - 10
                      
                      if  challegesText.x +  challegesText.contentWidth / 2 >  challegesCoinsText.x - challegesCoin.contentWidth/2 then
                        challegesText.xScale  =  (background.contentWidth*0.5) / challegesText.contentWidth
                        challegesText.yScale  = challegesText.xScale 
                        challegesText.x = bullet.x + bullet.contentWidth/2  + challegesText.contentWidth/2 + 15
                      end


                      

                      chalengesData:insert(bullet)
                      chalengesData:insert(challegesCoin)
                      chalengesData:insert(challegesCoinsText)
                      chalengesData:insert(challegesText)
                    end
                  end  
             end
             
             
             local newChallenges = getNewUnlockedChalenges()
             if (isFirstLoad  or #newChallenges > 0) then
              
               timer.performWithDelay(1,buildChallengesPart,1)     

               if #newChallenges > 0 then
                 for i=1,#newChallenges do
                
                  commonData.analytics.logEvent( "newChallenge", { name= tostring( newChallenges[i].text),
                    gamesCount= tostring( commonData.gameData.gamesCount) ,  
                    highScore= tostring(  commonData.gameData.highScore)
                      } )
                                                

                 end
               end

             end

            
            rateUsButton.alpha =0
            
            local function postScoreSubmit( event )
               
               --whatever code you need following a score submission...                
               return true
            end 
                    --for GameCenter, default to the leaderboard name from iTunes Connect
            local myCategory = ""

            if ( system.getInfo( "platformName" ) == "Android" ) then
               --for GPGS, reset "myCategory" to the string provided from the leaderboard setup in Google
               myCategory = "CgkI_YzqptgFEAIQAA"
               commonData.gpgs.leaderboards.submit( {leaderboardId=myCategory, score=tonumber(gameResult.gameScore) } )

              -- submit highest combo
              local highestComboId = "CgkI_YzqptgFEAIQBw"
              commonData.gpgs.leaderboards.submit( {leaderboardId=highestComboId, score=tonumber(gameResult.combo) } )
              
            else
                commonData.gameNetwork.request( "setHighScore",
              {
                 localPlayerScore = { category=myCategory, value=tonumber(gameResult.gameScore) },
                 listener = postScoreSubmit
              } )


                 local highestComboId = "CgkI_YzqptgFEAIQBw"
                 commonData.gameNetwork.request( "setHighScore",
              {
                 localPlayerScore = { category=highestComboId, value=tonumber(gameResult.combo) },
                 listener = postScoreSubmit
              } ) 
                  
            end

            -- TODO: remove
            -- commonData.gameNetwork.request( "setHighScore",
            -- {
            --    localPlayerScore = { category=myCategory, value=tonumber(gameResult.gameScore) },
            --    listener = postScoreSubmit
            -- } )
            

            local isHighScore = gameResult.gameScore > commonData.gameData.highScore

            if confetti then
              for j = 1, confetti.numChildren do
                 if (confetti[1]) then
                  confetti[1]:removeSelf()
                 end 
              end
            end
             

            if ( isHighScore ) then
            
                   local particleDesigner = require( "particleDesigner" )


                  
                  local emitter1 = particleDesigner.newEmitter( "confetti.json" )
                  emitter1:scale(0.05,0.05)

                   local emitter2 = particleDesigner.newEmitter( "confetti.json" )
                  emitter2:scale(0.05,0.05)
                  
                  confetti:insert(emitter1)
                  confetti:insert(emitter2)

                  emitter1.x = 20
                  emitter1.y = 320

                   emitter2.x = 460
                  emitter2.y = 320

               logHighScore(commonData.gameData , gameResult.gameScore)
                  
               commonData.gameData.highScore = gameResult.gameScore
               commonData.globalHighScore = gameResult.gameScore
              
              scoreTitleText.text = "NEW HIGH SCORE:"
              scoreTitleTextS.text = "NEW HIGH SCORE:"

              
            else

              scoreTitleText.text = getTransaltedText("youReached")  .. ":"
              scoreTitleTextS.text = getTransaltedText("youReached")  .. ":"
            end 
            scoreTitleText.alpha = 1
            scoreTitleTextS.alpha = 1
        
            commonData.gameData.coins = commonData.gameData.coins + gameResult.coins
            commonData.gameData.gamesCount = commonData.gameData.gamesCount + 1
            commonData.gameData.totalScore = commonData.gameData.totalScore + gameResult.gameScore
            
            commonData.gameData.bounces = commonData.gameData.bounces + gameResult.bounces
            commonData.gameData.bouncesPerfect = commonData.gameData.bouncesPerfect + gameResult.bouncesPerfect
            commonData.gameData.bouncesGood = commonData.gameData.bouncesGood + gameResult.bouncesGood
            commonData.gameData.bouncesEarly = commonData.gameData.bouncesEarly + gameResult.bouncesEarly
            commonData.gameData.bouncesLate = commonData.gameData.bouncesLate + gameResult.bouncesLate
            commonData.gameData.jumps  = commonData.gameData.jumps + gameResult.jumps
            commonData.gameData.unlockedAchivments = getUnlockedAchivments()
            commonData.gameData.unlockedChallenges = getUnlockedChallenges()

            -- local newLevelScene = composer.getScene( "newLevel"  )

            -- if (newLevelScene) then

            --   --print("REUSE SCENE")
            --  newLevelScene:outerRefreshResults(gameStats)
            --  print("reuse new levelStart")
            -- else

            --   --print("CREATE GAME OVER")
            --  local options = { isModal = false,
            --                        effect = "fade",
            --                        params = {results = gameStats , gameDisplay = sceneGroup}}
            --  composer.showOverlay( "newLevel" , options )  

            --  print("new overlay")
            -- end 

            
            
            local currentLevel = commonData.getLevel() 
            local levelStart = 50 * currentLevel * (currentLevel +1)
            local completeRatio = (commonData.gameData.totalMeters - levelStart) / ((currentLevel+1)  * 100)
            
            local temp = xp.xpBarMiddle.xScale
            xp.xpBarMiddle:scale(completeRatio * (xp.xpBarBG.contentWidth - 10) / xp.xpBarMiddle.contentWidth, 1)
            xp.xpBarMiddle.x = xp.xpBarStart.x + xp.xpBarMiddle.contentWidth / 2 + xp.xpBarStart.contentWidth/2 
            xp.xpBarEnd.x = xp.xpBarMiddle.x + xp.xpBarMiddle.contentWidth / 2 + xp.xpBarEnd.contentWidth/2 - 1
            xp.xpEmiter.x = xp.xpBarEnd.x
            
            levelText.text = "LVL " .. currentLevel
            nextLevelText.text = currentLevel+1
            if not commonData.gameData.highestCombo or commonData.gameData.highestCombo < gameResult.combo then
              commonData.gameData.highestCombo = gameResult.combo
            end  


            commonData.gameData.totalMeters = commonData.gameData.totalMeters + gameResult.meters
            completeRatio = (commonData.gameData.totalMeters - levelStart) / ((currentLevel+1)  * 100)


            local newLevel = commonData.getLevel() 

            if newLevel > currentLevel  then
               for j = 1, newItemsGroup.numChildren do
                 if (newItemsGroup[1]) then
                    newItemsGroup[1]:removeSelf()
                 end 
              end
              newLevelText.newLevel.text = newLevel
      
              newLevelGroup.alpha = 1

             
              if commonData.catalog.itemsByLevel[newLevel] then
                newLevelText.newItems.alpha =1
                for newItemsIdx = 1, #commonData.catalog.itemsByLevel[newLevel] do
                  local  img = display.newImage(commonData.catalog.itemsByLevel[newLevel][newItemsIdx].image) 
                   if (img) then
                       img.y = 225 
                       img.x = 70 * newItemsIdx
                       img.xScale = 60 / img.contentWidth   
                       img.yScale = img.xScale
                       newItemsGroup:insert(img)   
                   end    
                end


              else
                newLevelText.newItems.alpha =0  
              end

              
              local x, y = newItemsGroup:contentToLocal( 240, 0 )
              
              newItemsGroup.x= 200 - newItemsGroup.contentWidth/2  

            else
              gameOverGroup.alpha = 1
            end  
            --local newScale = completeRatio * (xp.xpBarBG.contentWidth - 10) / xp.xpBarMiddle.contentWidth
            if completeRatio > 1 then
              completeRatio = 1
            end  

            local newScale = completeRatio * (xp.xpBarBG.contentWidth - 10) / xp.xpBarMiddle.width
            --local newScale = 20
            

            --transition.scaleTo( xp.xpBarMiddle, { xScale=newScale, time=500 } )
            transition.to(xp.xpBarMiddle, {x = xp.xpBarStart.x + xp.xpBarMiddle.width* newScale  / 2 + xp.xpBarStart.contentWidth/2, xScale = newScale,  time = 500})
            -- transition.moveTo( xp.xpBarMiddle, { x=xp.xpBarStart.x + xp.xpBarMiddle.width* newScale  / 2 + xp.xpBarStart.contentWidth/2 , time=500 } )
            transition.moveTo( xp.xpBarEnd, { x=xp.xpBarStart.x + xp.xpBarMiddle.width* newScale + xp.xpBarStart.contentWidth/2 + xp.xpBarEnd.contentWidth/2 - 1, time=500 } )
            transition.moveTo( xp.xpEmiter, { x=xp.xpBarStart.x + xp.xpBarMiddle.width* newScale + xp.xpBarStart.contentWidth/2 + xp.xpBarEnd.contentWidth/2 - 1, time=500 } )
            
          
            comboText.text = getTransaltedText("HighestCombo")  ..  ": " ..  gameResult.combo
            comboTextS.text = getTransaltedText("HighestCombo")  ..  ": " ..   gameResult.combo
            comboText.alpha = 1
            comboTextS.alpha = 1


            local  t = os.date( '*t' )
            
            t.hour = 0
            t.min = 0
            t.sec = 0
            
            local todayStart =  os.time( t ) 

            t.day = t.day -1

            local yesterdayStart =  os.time( t ) 
            
            --  todayStart = os.time( os.date( '*t' ) ) 


            if not commonData.gameData.lastGameTime then
              commonData.gameData.fisrtGameTime = todayStart
            end
            
            if  commonData.gameData.lastGameTime  and  (commonData.gameData.lastGameTime < todayStart or --1==1 or
              (commonData.gameData.gamesCount == 10 and commonData.gameData.fisrtGameTime == todayStart)) then


              if yesterdayStart < commonData.gameData.lastGameTime then
              
               -- reward
                commonData.gameData.daysInARow = commonData.gameData.daysInARow + 1
              else
                commonData.gameData.daysInARow = 1              
              end
              
              if commonData.gameData.daysInARow > 1 then
                local version = ""
                if  commonData.gameData.abVersion then
                 version = " in version " .. tostring( commonData.gameData.abVersion)
                end

                commonData.analytics.logEvent( "dailyBonus day " .. tostring( commonData.gameData.daysInARow) ..  version, { gamesCount= tostring( commonData.gameData.gamesCount),
                appOpened= tostring( commonData.gameData.appOpened)
                 } )
              end
              local coinsDailyReward = 20 + commonData.gameData.daysInARow * 20

              -- if (coinsDailyReward > 120) then
              --   coinsDailyReward  = 120
              -- end  
              --showNotification("DAILY REWARD! \n\n" ..  tostring( coinsDailyReward ) .. " COINS \n\n ")
              --showPrizeNotification("DAILY REWARD!" , "play every day and get better rewards")


              if not dailyReward then
                dailyReward = display.newGroup()
              

                local boosterTextOptions = 
                {
                    --parent = textGroup,
                    text = "",     
                    x = 420,
                    y = 12,
                    width = 300,     --required for multi-line and alignment
                    font = "UnitedItalicRgHv",   
                    fontSize = 10,
                    align = "center"  --new alignment parameter
                }

                local boosterHeaderTextOptions = 
                {
                    --parent = textGroup,
                    text = "",     
                    x = 420,
                    y = 20,
                    --width = 230,     --required for multi-line and alignment
                    font = "UnitedSansRgStencil",   
                    fontSize = 25,
                    align = "center"  --new alignment parameter
                }


               

                local dailySubTitleText = display.newText(boosterTextOptions)
                --dailySubTitleText:setFillColor(194/256,236/256,254/256)
                dailySubTitleText.x = 240
                dailySubTitleText.y = 80 
                dailySubTitleText.text = getTransaltedText("DailyRewardText")

              --  boosterText.y =   boosterText.y  + (display.actualContentHeight - display.contentHeight)/2  
               -- boosterButton.y =   boosterButton.y  + (display.actualContentHeight - display.contentHeight)/2  

                local  dailyTitleText = display.newText(boosterHeaderTextOptions)
               -- dailyTitleText:setFillColor(194/256,236/256,254/256)
                dailyTitleText.x = 240
                dailyTitleText.y = 60
                dailyTitleText.text = getTransaltedText("DailyRewardTitle") 
                           

                 local function dailyOkBtnListener( event )
          
                      if ( "ended" == event.phase ) then
                        
                        commonData.buttonSound()


                       
                        --newLevelGroup.alpha = 0

                        
                          if (commonData.gameData.daysInARow < 7) then
                            if not coinsDailyReward then
                               coinsDailyReward = 20 + commonData.gameData.daysInARow * 20
                            end  
                            commonData.gameData.coins = commonData.gameData.coins + coinsDailyReward        
                        
                            logCoins(commonData.gameData , coinsDailyReward) 
                          else
                            commonData.gameData.gems = commonData.gameData.gems + 1     
                            commonData.gameData.daysInARow = 0
                            coinsDailyReward = nil
                          end  
                        
                          commonData.saveTable(commonData.gameData , GAME_DATA_FILE)

                          timer.performWithDelay(300, 
                            function()
                             parent:outerCoinsReward(coinsDailyReward ,  70 - (display.actualContentWidth - display.contentWidth) /2 , 165 )
                              dailyRewardGroup.alpha = 0
                              gameOverGroup.alpha = 1
                            end
                          , 1)

                      end
                      return true
                 end

                  local dailyOkBtn = widget.newButton
                  {
                      x = 240,
                      y = 280,
                      id = "boosterButton",
                      defaultFile = "images/OKUp.png",
                      overFile = "images/OKDown.png",
                      onEvent = dailyOkBtnListener
                  }
                 dailyOkBtn.xScale =  (display.actualContentWidth*0.3) / dailyOkBtn.width
                  dailyOkBtn.yScale = dailyOkBtn.xScale  
                 

                  local dailyBackground = display.newRect(240, 160, 700,400)
                  dailyBackground.fill.effect = "generator.radialGradient"
             
                  dailyBackground.fill.effect.color2 = { 0.8, 0, 0.2, 1 }
                  dailyBackground.fill.effect.color1 = { 0.2, 0.2, 0.2, 0.85 }
                  dailyBackground.fill.effect.center_and_radiuses  =  { 0.5, 0.5, 0.25, 0.75 }
                  dailyBackground.fill.effect.aspectRatio  = 1
                 
                
                 local dailyBackground2 = display.newImage("images/TeamImage.png")
                 --background:setFillColor(59/255,  131/255 , 163/255)
                 dailyBackground2.x = 240
                 dailyBackground2.y = 160
                 dailyBackground2.xScale = display.actualContentWidth / dailyBackground2.contentWidth 
                 dailyBackground2.yScale = display.actualContentHeight  / dailyBackground2.contentHeight

                 

                 dailyReward:insert(dailyBackground)
                 dailyReward:insert(dailyBackground2)

                 --commonData.gameData.daysInARow =3 
                 for i=1,7 do
                      local card = nil
                      if  i == commonData.gameData.daysInARow then
                        card =  display.newImage("images/shop/ShopItemExlusive.png")             
                      else
                        card =  display.newImage("images/shop/ItemsNoCash.png")            
                      end  
                      
                      card.xScale = display.actualContentWidth * 0.14 / card.contentWidth 
                      card.yScale =  card.xScale 

                      card.x = 240 - display.actualContentWidth / 2 + card.contentWidth /2 + (i-1) * (card.contentWidth + 3)
                      card.y = 160
                      dailyReward:insert(card)

                     local dayText = display.newText(boosterTextOptions)
                      dayText:setFillColor(255/255,241/255,208/255)
                      dayText.x = card.x
                      dayText.y = card.y - card.contentHeight/2 + 15
                      dayText.text = getTransaltedText("DailyRewardDay") .." " .. i 

                     dailyReward:insert(dayText) 
                     local priceImg = nil
                     if i == 7 then
                      priceImg = display.newImage("images/SupaGem.png")
                     else
                      priceImg = display.newImage("images/IcoCoins.png")
                     end 

                     --background:setFillColor(59/255,  131/255 , 163/255)
                     priceImg.x = card.x
                     priceImg.y = card.y 
                     priceImg.xScale = card.contentWidth * 0.5 / priceImg.contentWidth 
                     priceImg.yScale = priceImg.xScale
                     
                     dailyReward:insert(priceImg)  



                      local day1Text = display.newText(boosterTextOptions)
                      day1Text:setFillColor(255/255,241/255,208/255)
                      day1Text.x = card.x
                      day1Text.y = card.y + card.contentHeight/2  - 20

                       if i == 7 then
                        day1Text.text = "1"  .. getTransaltedText("SupaGems") 
                       else
                        day1Text.text = 20 + i * 20  .. " Coins" 
                       end 
                      

                      dailyReward:insert(day1Text)  
                 end

                
                
               
                dailyReward:insert(dailyOkBtn)
                dailyReward:insert(dailyTitleText)
                dailyReward:insert(dailySubTitleText)
                
                dailyRewardGroup:insert(dailyReward)
              
              end  

              local function giveDailyReward()

                showPrizeNotification( getTransaltedText("DailyRewardTitle") ,
                           getTransaltedText("DailyRewardText"), coinsDailyReward, true)
                timer.performWithDelay(2000, 
                  function()
                   parent:outerCoinsReward(coinsDailyReward ,  70 - (display.actualContentWidth - display.contentWidth) /2 , 165 )
                  end
                , 1)

                commonData.gameData.coins = commonData.gameData.coins + coinsDailyReward        
            
                logCoins(commonData.gameData , coinsDailyReward)                
              end
             
            dailyRewardGroup.alpha = 1 
            gameOverGroup.alpha = 0
            --  local function validateDailyReward(event)
                      
            --       -- no internet - no glory
            --       if ( event.isError ) then
            
                      
            
            --       else
            
                      
            --           local server_time = json.decode(event.response)
                         
            --           if server_time then
              
            --             player_time = os.time(os.date( '*t' ))

            --             if math.abs(server_time - player_time) > 12 * 60 * 60 then
            --                 -- cheater
            --             else
            --                giveDailyReward()
            --             end
            --           end
            
            --       end
            --       dailyRewardBlocker.alpha = 0
            --       --playButton.alpha = 1
            --       return true
            
            --   end
     
            -- -- get Server time  
            -- --print("call time api")
            -- local URL = "http://www.timeapi.org/utc/now?%5Cs"
            -- dailyRewardBlocker.alpha = 0.01
            -- network.request( URL, "GET", validateDailyReward ) 

         --   giveDailyReward()
          
          

               
           elseif (commonData.gameData.gamesCount > 100 and isHighScore and not commonData.gameData.rateUsShown  ) then   
           
              local rateImg = display.newImage("images/Rate.png")
              rateImg:scale(0.7,0.7)
              rateImg.x =190
              rateImg.y =140


              rateImg:addEventListener("touch", rateUsListener )
              
              
              local currentSceneName = composer.getSceneName( "current" )
                
              if ( currentSceneName== "game" ) then
                notificationData:insert(rateImg)
              else
                rateImg:removeSelf()
              end

              rateUsButton.alpha =1

              --showPrizeNotification("NICE SCORE!" , "Rate us if you like our game")
              showPrizeNotification("" , "",nil,false)
              commonData.gameData.rateUsShown = true
            
            end    


            t = os.date( '*t' )


            if not commonData.gameData.lastGameTime or commonData.gameData.lastGameTime < os.time( t ) then
              commonData.gameData.lastGameTime = os.time( t )
            end
            
            
            commonData.saveTable(commonData.gameData , GAME_DATA_FILE)

            
            logCoins(commonData.gameData ,  gameResult.coins)
           
            logGamesCount(commonData.gameData)
            
            local version = ""
             if  commonData.gameData.abVersion then
                 version = " in version " .. tostring( commonData.gameData.abVersion)
             end

            local sameLegBounces = gameResult.bounces - gameResult.bouncesPerfect - gameResult.bouncesGood - gameResult.bouncesEarly - gameResult.bouncesLate
            print(tostring(gameResult.bouncesPerfect) .. "/" .. tostring(gameResult.bouncesGood)  .. "/" .. tostring(gameResult.bouncesEarly) .. "/" .. tostring(sameLegBounces))         
                  
            commonData.analytics.logEvent( "finishGame" .. version , { gamesCount= tostring( commonData.gameData.gamesCount) ,  
                                                gameScore= tostring( gameResult.gameScore) , 
                                                highScore= tostring(  commonData.gameData.highScore) ,
                                                pgbsj = tostring(gameResult.bouncesPerfect) .. "/" .. tostring(gameResult.bouncesGood) 
                                                 .. "/" .. tostring(gameResult.bouncesEarly) .. "/" .. tostring(sameLegBounces) ..  "/" .. tostring(gameResult.jumps) ,
                                                reason= tostring(gameResult.finishReason)  } )

            
            if (commonData.gameData.packs > 0) then
              openPkgButton.alpha = 0
              openPkgButton2.alpha = 1
            else  
              openPkgButton2.alpha = 0
              openPkgButton.alpha = 1
            end


            highScoreText.text = commonData.comma_value(commonData.gameData.highScore)
            highScoreShadowText.text = commonData.comma_value(commonData.gameData.highScore)
            --parse:logEvent( "Share", { ["score"] = gameResult.gameScore } )

            -- unlock new achivments

            
            local newAchiv = getNewUnlockedAchivments()

            
            for k,v in pairs(newAchiv) do
                
                if ( system.getInfo( "platformName" ) == "Android" ) then
                  commonData.gpgs.achievements.unlock({
                                                achievementId=v.code
                                              })
                 else 

                  commonData.gameNetwork.request( "unlockAchievement", {
                                                achievement = {
                                                  identifier=v.code
                                                }
                                              });   
                end

            end
            

            if isHighScore or isFirstLoad then
              activeScreen = 1
            
            elseif #newChallenges > 0 then
              activeScreen = 2

            
            else
              activeScreen = math.random(2)
            
            end    

            showActiveScreen()


      end    
end
-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view

      local  buttonsSet = nil
     
     confetti  = display.newGroup()
     notification = display.newGroup()
     notificationData = display.newGroup()
     scoreBox = display.newGroup()
     chalengesBox = display.newGroup()
     chalengesData = display.newGroup()

     gameOverGroup = display.newGroup()
     newLevelGroup = display.newGroup()
     promotionGroup = display.newGroup()
     newItemsGroup = display.newGroup()
     dailyRewardGroup = display.newGroup()

     
     buttonsSet = "BlueSet"
     --everything from here down to the return line is what makes
     --up the scene so... go crazy
     background = display.newImage("images/EndGameBG.png")
     -- background = display.newImage("images/EndGameBG Blue.png")

    
     background.xScale =  (display.actualContentWidth*0.7) / background.contentWidth
     background.yScale =  (display.actualContentHeight*0.6) / background.contentHeight
     background.x = 240
     background.y = 160 

      

      local newLevelBackground = display.newRect(240, 160, 700,400)
      newLevelBackground.fill.effect = "generator.radialGradient"
 
      newLevelBackground.fill.effect.color2 = { 0.8, 0, 0.2, 0.7 }
      newLevelBackground.fill.effect.color1 = { 0.2, 0.2, 0.2, 0.7 }
      newLevelBackground.fill.effect.center_and_radiuses  =  { 0.5, 0.5, 0.25, 0.75 }
      newLevelBackground.fill.effect.aspectRatio  = 1

      local newLevelBackground2 =  display.newImage("images/EndGameBG.png")
       newLevelBackground2.xScale =  (display.actualContentWidth*0.7) / newLevelBackground2.contentWidth
     newLevelBackground2.yScale =  (display.actualContentHeight*0.7) / newLevelBackground2.contentHeight
     newLevelBackground2.x = 240
     newLevelBackground2.y = 160 
     
    
      

      newLevelText.levelUp = display.newText({text = "LEVEL UP!", font = "UnitedSansRgHv", fontSize = 25 }  )
      
      newLevelText.newLevel = display.newText({text = "5",font = "UnitedSansRgHv", fontSize = 45}  )
      newLevelText.newLevel.text = "5"
      newLevelText.newLevel:setFillColor(1,206/255,0)

      newLevelText.newItems = display.newText({text = "You can use now the following items:", font = "UnitedItalicRgHv", fontSize = 15}  )
      
      newLevelText.levelUp.x = 240
      newLevelText.levelUp.y = newLevelBackground2.y - newLevelBackground2.contentHeight/2  +  newLevelText.levelUp.contentHeight /2  + 3

      newLevelText.newLevel.x = 240
      newLevelText.newLevel.y = 130

      newLevelText.newItems.x = 240
      newLevelText.newItems.y = 170
      

      local function newLevelOkBtnListener( event )
          
          if ( "ended" == event.phase ) then
            
            commonData.buttonSound()

            gameOverGroup.alpha = 1
            newLevelGroup.alpha = 0
            promotionGroup.alpha = 0
            
          end
          return true
     end

     local gradient = {
          type="gradient",
          color2={ 255/255,241/255,208/255,1}, color1={ 1, 180/255, 0,1 }, direction="up"
      }

      local newLevelOkBtn = widget.newButton
      {
          x = 240,
          y = 290,
          id = "boosterButton",
          defaultFile = buttonsSet .. "/End/EGMainMenuUp.png",
          overFile = buttonsSet .. "/End/EGMainMenuDown.png",
          onEvent = newLevelOkBtnListener,
          label = getTransaltedText("OK"),
          labelAlign = "center",
          font = "UnitedSansRgHv",  
          fontSize = 40 ,           
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } }
      }
     newLevelOkBtn.xScale =  (display.actualContentWidth*0.3) / newLevelOkBtn.width
      newLevelOkBtn.yScale = newLevelOkBtn.xScale  

      
     newLevelGroup:insert(newLevelBackground)
     newLevelGroup:insert(newLevelBackground2)
     newLevelGroup:insert(newLevelText.levelUp)
     newLevelGroup:insert(newLevelText.newLevel)
     newLevelGroup:insert(newLevelText.newItems)
     newLevelGroup:insert(newItemsGroup)
     
     newLevelGroup:insert(newLevelOkBtn)




     
      
       local chalengesTable = display.newImage("images/ChallengeScreenTable.png")


      chalengesTable.xScale =  (display.actualContentWidth*0.5) / chalengesTable.contentWidth
      chalengesTable.yScale =  chalengesTable.xScale
     
     chalengesTable.x = 240
     chalengesTable.y = 160


      boosterMsgSpine =  require ("boosterMsg")
      boosterMsg = boosterMsgSpine.new(0.8, true)
      
      boosterMsg.skeleton.group.x = 190
      boosterMsg.skeleton.group.y = 320

      --boosterMsg.skeleton.group.x =   boosterMsg.skeleton.group.x  + (display.actualContentWidth - display.contentWidth)/2  
      --boosterMsg.skeleton.group.y =   boosterMsg.skeleton.group.y  + (display.actualContentHeight - display.contentHeight)/2  
        

     
    
    
      
  
   
    
    
   -- fuse.init( fuseListener )      
    local widget = require( "widget" )

      local function buttonListener( event )
          
          if ( "ended" == event.phase ) then

            commonData.buttonSound()
            
            
            scoreTitleText.alpha = 0
            scoreTitleTextS.alpha = 0

            comboText.alpha = 0
            comboTextS.alpha = 0

         
          --composer.gotoScene( "game" , options )
          --composer.hideOverlay(true, "fade", 400 )
          sceneGroup.alpha = 0
          isGameOverActive = false
          parent:outerRestartGame()
          commonData.kidoz.hide( "panelView")
          

       
          end
          return true
     end

    local function goToMenu()
      
       local options = {params = {gameData = commonData.gameData}}
       composer.gotoScene( "menu" , options )      
    end 

    local function menuListener( event )
          
          if ( "ended" == event.phase ) then
            
            commonData.buttonSound()

            
            local options = {params = {gameData = commonData.gameData}}
            composer.gotoScene( "menu" , options )

       
          end
          return true
     end



    local function nativeShareListener( event )
            
            if ( "ended" == event.phase ) then
              
              commonData.buttonSound()
              native.setActivityIndicator( true )

              --self.view.alpha=0
              local group = display.getCurrentStage()
              -- local gameScene   = composer.getScene( "game" )
              -- group = gameScene.view

              -- local maxTextureSize = system.getInfo("maxTextureSize")
              -- local scaleFactor = math.min(maxTextureSize / group.width, maxTextureSize / group.height) 

              -- if (scaleFactor < 1) then
              --   group.xScale = scaleFactor 
              --   group.yScale = scaleFactor 
              -- end

              
               local widthFactor = display.actualContentWidth / display.contentWidth 
              local heightFactor = display.actualContentHeight / display.contentHeight 
              local savedH = parent.view.height
              local savedW = parent.view.width
              local savedX = parent.view.x
              local savedY = parent.view.y
              parent.view:scale(1/widthFactor, 1/heightFactor)
              parent.view.width = savedW
              parent.view.height = savedH
                        
              parent.view.x = parent.view.x + 0.5 * (display.actualContentWidth - display.contentWidth) / widthFactor
              parent.view.y = parent.view.y + 0.5 * (display.actualContentHeight - display.contentHeight) / heightFactor

              display.save( group, { filename="result.png", baseDir=system.TemporaryDirectory, isFullResolution=false, backgroundColor={0, 0, 0, 0} } )

              parent.view:scale(widthFactor, heightFactor)
              parent.view.width = savedW
              parent.view.height = savedH
              parent.view.x = savedX
              parent.view.y = savedY


             --  self.view.alpha=1            
              
              --local serviceName = "twitter"  --supported values are "twitter", "facebook", or "sinaWeibo"
              local serviceName = event.target.id

              if (serviceName=="share" and system.getInfo("platformName") == "iPhone OS" ) then
                local items =
                      {
                        { type = "image", value = { filename="result.png", baseDir=system.TemporaryDirectory } },
                        { type = "string", value ="Supa Strikas Dash!"},
                        { type = "url", value = "http://www.supastrikas.com/" },
                      }

                  local popupName = "activity"
                  local isAvailable = native.canShowPopup( popupName )
                  
                 
                  -- If it is possible to show the popup
                  if isAvailable then
                    local listener = {}
                    function listener:popup( event )
                      
                      
                      native.setActivityIndicator( false )
                      unlockAchivment("LittleBragger",true)
                    end
                 
                    -- Show the popup
                    native.showPopup( popupName,
                    {
                      items = items,
                      -- excludedActivities = { "UIActivityTypeCopyToPasteboard", },
                      listener = listener,
                      origin = shareButton.contentBounds, 
                      permittedArrowDirections={ "up", "down" }
                    })
                  else
                    native.setActivityIndicator( false )
                    if isSimulator then
                      native.showAlert( "Build for device", "This plugin is not supported on the Corona Simulator, please build for an iOS/Android device or the Xcode simulator", { "OK" } )
                    else
                      -- Popup isn't available.. Show error message
                      --native.showAlert( "Error", "Can't display the view controller. Are you running iOS 7 or later?", { "OK" } )
                    end
                  end



              else -- Android share with social plugin
                  local isAvailable = native.canShowPopup( "social", serviceName )

                  if ( isAvailable ) then

                      local listener = {}

                      function listener:popup( event )
                          native.setActivityIndicator( false )
                          unlockAchivment("LittleBragger",true)
                      end

                      native.showPopup( "social",
                      {
                          service = serviceName,
                          message = "Supa Strikas!",
                          listener = listener,
                          image = 
                          {
                              
                              { filename="result.png", baseDir=system.TemporaryDirectory }
                          }
                    
                      })

                  else
                    native.setActivityIndicator( false )
                      native.showAlert(
                          "Cannot send message.",
                          "Please setup your account or check your network connection.",
                          { "OK" } )
                  end
              end
            end
            return true
       end -- native share listener
  

    local function goToPacks()
       
       local options = {params = {gameData = commonData.gameData}}
       composer.gotoScene( "packs" , options )
     
    end 

    local function packsListener( event )
          
          if ( "ended" == event.phase ) then
            
            commonData.buttonSound()

            local options = {params = {gameData = commonData.gameData}}
            composer.gotoScene( "packs" , options )
          end  

           return true
      end      

     

       local function boosterButtonListener( event )
         if ( "ended" == event.phase ) then
          notification.alpha = 0 

        
          if dailyReward then
            dailyReward:removeSelf()
            dailyReward = nil
          end  

         end 
           return true
       end

        local function showAdListener( event )
            if ( "ended" == event.phase ) then
                  local isSimulator = (system.getInfo("environment") == "simulator");
                  commonData.analytics.logEvent( "startWatchAd", {  prizeCategory= tostring( rewardIndex ) } ) 
                if (not isSimulator)  then
                  local isSpwLoaded =  superawesome.isLoaded( myPlacementID )
                  local isAdmobLoaded =  admob.isLoaded( "interstitial" )

                    if isAdLoaded and not isAdmobLoaded then
                        superawesome.show( myPlacementID )
                    elseif not isAdLoaded and isAdmobLoaded then
                        admob.show("rewardedVideo")
                    elseif isAdLoaded and isAdmobLoaded then
                        if math.random(10) < 8 then
                          admob.show("rewardedVideo") 
                        else
                          superawesome.show( myPlacementID )
                        end     
                    end

     
                    showAdButton.alpha = 0
                     
              
                else
                    showAdButton.alpha = 0
                    adBonus(event)
                  
                end
           end 
         return true
       end

      


        
      -- Create the widget
      playButton = widget.newButton
      {
          x = 410,
          y = 180,
          id = "playButton",
          defaultFile = buttonsSet .. "/End/TryAgainUp.png",
          overFile = buttonsSet .. "/End/TryAgainDown.png",
          onEvent = buttonListener
      }
      local scaleFactorP = (display.contentWidth*0.15) / playButton.width
     playButton:scale(scaleFactorP , scaleFactorP)
     --playButton.yScale =  playButton.yScale
     playButton.x =  playButton.x +  (display.actualContentWidth - display.contentWidth) /2
     --playButton.alpha = 0

     playButton.x =  background.x + background.contentWidth /2  + playButton.contentWidth /2 - 10
      
    

      local gradient = {
          type="gradient",
          color2={ 255/255,241/255,208/255,1}, color1={ 1, 180/255, 0,1 }, direction="up"
      }

      local menuButton = widget.newButton
      {
          x = 240,
          y = 280,
          id = "menuButton",          
          defaultFile = buttonsSet .. "/End/EGMainMenuUp.png",
          overFile = buttonsSet .. "/End/EGMainMenuDown.png",
          onEvent = menuListener,
          label = getTransaltedText("MainMenu"),
          labelAlign = "center",
          font = "UnitedSansRgHv",  
          fontSize = 40 ,           
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } }
      }
      menuButton.xScale =  (display.actualContentWidth* 0.28) / menuButton.width
      menuButton.yScale =   menuButton.xScale  -- (display.actualContentHeight* 0.1) / menuButton.height
      
       showAdButton = widget.newButton
      {
          x = 70,
          y = 180,
          id = "showAdButton",
          defaultFile = buttonsSet .. "/End/WatchAdUp.png",
          overFile = buttonsSet .. "/End/WatchAdDown.png",
          onEvent = showAdListener
      }
      showAdButton.xScale =  (display.contentWidth*0.15) / showAdButton.width
      showAdButton.yScale = showAdButton.xScale  
      --showAdButton.x =  showAdButton.x - (display.actualContentWidth - display.contentWidth) /2

      showAdButton.x =  background.x - background.contentWidth /2 - showAdButton.contentWidth /2 + 10
      
    
      rateUsButton = widget.newButton
      {
          x = 240,
          y = 265,
          id = "rateUsButton",
          defaultFile = buttonsSet .. "/End/EGMainMenuUp.png",
          overFile = buttonsSet .. "/End/EGMainMenuDown.png",
          onEvent = rateUsListener
      }
      rateUsButton.xScale =  (display.contentWidth*0.25) / rateUsButton.width
      rateUsButton.yScale = rateUsButton.xScale  
      rateUsButton.x =  rateUsButton.x - (display.actualContentWidth - display.contentWidth) /2

      

      rateUsButton.alpha = 0
      

      shareButton = widget.newButton
      {
          x = 120,
          y = 278,
          id = "share",
           defaultFile = buttonsSet .. "/End/EGShareUp.png",
          overFile = buttonsSet .. "/End/EGShareDown.png",
          onEvent = packsListener,
          label = getTransaltedText("ShareScore"),
          labelAlign = "center",
          font = "UnitedSansRgHv",  
          fontSize = 40 ,           
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } },
          onEvent = nativeShareListener
      }

      shareButton.xScale = (display.actualContentWidth*0.25) / shareButton.width
      shareButton.yScale =  shareButton.xScale-- (display.actualContentHeight*0.22) / shareButton.height
      


      openPkgButton = widget.newButton
      {
          x = 360,
          y = 278,
          id = "openPkgButton",
          defaultFile = buttonsSet .. "/End/EGPacksUp.png",
          overFile = buttonsSet .. "/End/EGPacksDown.png",
          onEvent = packsListener,
          label = getTransaltedText("Packs"),
          labelAlign = "center",
          font = "UnitedSansRgHv",  
          fontSize = 40 ,           
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } }
      }
     openPkgButton.xScale =  (display.actualContentWidth*0.25) / openPkgButton.width
      openPkgButton.yScale = openPkgButton.xScale  -- (display.actualContentHeight*0.22) / openPkgButton.height


       openPkgButton2 = widget.newButton
      {
          x = 360,
          y = 278,
          id = "openPkgButton2",
          defaultFile = buttonsSet .. "/End/EGPacksActive.png",
          overFile = buttonsSet .. "/End/EGPacksDown.png",
          onEvent = packsListener,
          label = getTransaltedText("Packs"),
          labelAlign = "center",
          font = "UnitedSansRgHv",  
          fontSize = 40 ,           
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } }
      }
     openPkgButton2.xScale =  (display.actualContentWidth*0.25) / openPkgButton2.width
      openPkgButton2.yScale = openPkgButton2.xScale  -- 


     


     boosterButton = widget.newButton
      {
          x = 190,
          y = 280,
          id = "boosterButton",
          defaultFile = "images/OKUp.png",
          overFile = "images/OKDown.png",
          onEvent = boosterButtonListener
      }
     boosterButton.xScale =  (display.actualContentWidth*0.2) / boosterButton.width
      boosterButton.yScale = boosterButton.xScale  

  
    boosterClose = widget.newButton
      {
          x = 40,
          y = 43,
          id = "boosterClose",
          defaultFile = "images/X.png",
          overFile = "images/XDown.png",
          onEvent = boosterButtonListener
      }

      boosterClose.xScale =  (display.contentWidth*0.07) / boosterClose.width
      boosterClose.yScale = boosterClose.xScale  
    

    scoreText = display.newText("", 0, 0 , "UnitedSansRgHv" , 70)
    scoreText.x = 230
    scoreText.y = 160
    scoreText:setFillColor(255/255,241/255,208/255)

    scoreTextS = display.newText("", 0, 0 , "UnitedSansRgHv" , 70)
    scoreTextS.x = 230
    scoreTextS.y = 164
    scoreTextS:setFillColor(0,0,0)
    

    scoreTitleText = display.newText("", 0, 0 , "UnitedSansRgHv" , 20)
    scoreTitleText.x = 240
    scoreTitleText.y = 120
    scoreTitleText.text = "YOU REACHED:"
    scoreTitleText:setFillColor(255/255,241/255,208/255)
    
    scoreTitleTextS = display.newText("", 0, 0 , "UnitedSansRgHv" , 20)
    scoreTitleTextS.x = 240
    

    scoreTitleTextS.text = "YOU REACHED:"
    scoreTitleTextS:setFillColor(39/255,39/255,53/255)
    scoreTitleTextS.y = scoreTitleText.y + 2

    scoreTitleText.alpha = 0
    scoreTitleTextS.alpha = 0

    comboText = display.newText("", 0, 0 , "UnitedSansRgHv" , 20)
    comboText.x = 240
    comboText.y = 215
    comboText.text = ""
    comboText:setFillColor(255/255,241/255,208/255)
    
    comboTextS = display.newText("", 0, 0 , "UnitedSansRgHv" , 20)
    comboTextS.x = 240
    

    comboTextS.text = ""
    comboTextS:setFillColor(39/255,39/255,53/255)
    comboTextS.y = comboText.y + 2

    comboText.alpha = 0
    comboTextS.alpha = 0

    levelText = display.newText("", 0, 0 , "UnitedSansRgHv" , 10)
    levelText.x = 240
    levelText.y = 240 
    levelText.text = ""
    levelText:setFillColor(255/255,241/255,208/255)

    nextLevelText = display.newText("", 0, 0 , "UnitedSansRgHv" , 10)
    nextLevelText.x = 240
    nextLevelText.y = 240 
    nextLevelText.text = ""
    nextLevelText:setFillColor(255/255,241/255,208/255)


    local coinTextOptions = 
    {
        --parent = textGroup,
        text = "",     
        x = 420,
        y = 20,
        --width = 130,     --required for multi-line and alignment
        font = "UnitedSansRgHv",   
        fontSize = 20,
        align = "center"  --new alignment parameter
    }

    local highScoreTitle = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
    local  highScoreTitleShadow = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
    
    highScoreTitle:setFillColor(1,206/255,0)
    highScoreTitleShadow:setFillColor(128/255,97/255,40/255)
    highScoreTitleShadow.y = highScoreTitle.y + 2

    highScoreTitle.text = getTransaltedText("Highscore") 
    highScoreTitleShadow.text = getTransaltedText("Highscore") 

    
    highScoreText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
    highScoreShadowText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
    highScoreText.y = 40
    highScoreShadowText.y = highScoreText.y + 2
    highScoreShadowText:setFillColor(69/255,69/255,69/255)

    local titleWidth = math.max(highScoreTitle.contentWidth , 100)
    highScoreTitle.x =  470 - titleWidth/2  + (display.actualContentWidth - display.contentWidth)/2  
    highScoreTitleShadow.x = highScoreTitle.x 
    highScoreText.x = highScoreTitle.x
    highScoreShadowText.x = highScoreTitle.x


    local blackRect = display.newRect(240, 160, 600,400)
    blackRect:setFillColor(0, 0, 0)
    blackRect.alpha = 0.4



     local function boosterRectListener( event )   
        
          return true
     end

    boosterRect = display.newRect(240, 160, 700,400)
    boosterRect:setFillColor(0, 0, 0)
    boosterRect.alpha = 0.7
    boosterRect:addEventListener("touch", boosterRectListener )

    
    dailyRewardBlocker = display.newRect(240, 160, 700,400)
    dailyRewardBlocker:setFillColor(0, 0, 0)
    dailyRewardBlocker.alpha = 0
    dailyRewardBlocker:addEventListener("touch", boosterRectListener )

    loadingBlocker = display.newRect(240, 160, 700,400)
    loadingBlocker:setFillColor(0, 0, 0)
    loadingBlocker.alpha = 0
    loadingBlocker:addEventListener("touch", boosterRectListener )



    local boosterTextOptions = 
    {
        --parent = textGroup,
        text = "",     
        x = 420,
        y = 20,
        width = 300,     --required for multi-line and alignment
        font = "UnitedSansRgHv",   
        fontSize = 15,
        align = "center"  --new alignment parameter
    }

    local boosterHeaderTextOptions = 
    {
        --parent = textGroup,
        text = "",     
        x = 420,
        y = 20,
        --width = 230,     --required for multi-line and alignment
        font = "UnitedSansRgStencil",   
        fontSize = 25,
        align = "center"  --new alignment parameter
    }

   

    boosterText = display.newText(boosterTextOptions)
    boosterText:setFillColor(194/256,236/256,254/256)
    boosterText.x = 190
    boosterText.y = 225 

  --  boosterText.y =   boosterText.y  + (display.actualContentHeight - display.contentHeight)/2  
   -- boosterButton.y =   boosterButton.y  + (display.actualContentHeight - display.contentHeight)/2  

    boosterHeaderText = display.newText(boosterHeaderTextOptions)
    boosterHeaderText:setFillColor(194/256,236/256,254/256)
    boosterHeaderText.x = 190
    boosterHeaderText.y = 60

    --oosterHeaderText.y =   boosterHeaderText.y  + (display.actualContentHeight - display.contentHeight)/2  

    boosterCoinsText = display.newText(boosterHeaderTextOptions)
    boosterCoinsText:setFillColor(194/256,236/256,254/256)
    boosterCoinsText.x = 210
    boosterCoinsText.y = 120

    --boosterHeaderText.y =   boosterHeaderText.y  + (display.actualContentHeight - display.contentHeight)/2  


    boosterCoinImg  = display.newImage("Coin/Coin.png")
    boosterCoinImg.x = 150
    boosterCoinImg.y = 120
    boosterCoinImg:scale(0.5,0.5)

    boosterHandImg  = display.newImage("Tutorialhand/TutorialHand.png")
    boosterHandImg.x = 180
    boosterHandImg.y = 120
    boosterHandImg:scale(0.4,0.4)

  
    
    local function changeScreenListener( event )
     if ( "ended" == event.phase ) then
      commonData.buttonSound()
      
      activeScreen = activeScreen + 1
      
      activeScreen = activeScreen % 2

      showActiveScreen()
      
     end 
       return true
     end


     local leftArrowButton = widget.newButton
    {
        x = 145,
        y = 80,
        id = "leftArrow",
        defaultFile = "images/ArrowBtnUp.png",
        overFile = "images/ArrowBtnDown.png",
        onEvent = changeScreenListener
    }

    leftArrowButton.xScale = -1* (display.actualContentWidth*0.05) / leftArrowButton.width
    leftArrowButton.yScale = -1* leftArrowButton.xScale

    --leftArrowButton:rotate(180)

    local rightArrowButton = widget.newButton
    {
        x = 335,
        y = 80,
        id = "rightArrow",
        defaultFile = "images/ArrowBtnUp.png",
        overFile = "images/ArrowBtnDown.png",
        onEvent = changeScreenListener
    }

    rightArrowButton.xScale =  (display.actualContentWidth*0.05) / rightArrowButton.width
    rightArrowButton.yScale = rightArrowButton.xScale  
  --  rightArrowButton:rotate(-180)
    

    local challengesText = display.newText(boosterHeaderTextOptions)
    challengesText:setFillColor(255/255,241/255,208/255)
    challengesText.x = 240
    
    challengesText.y = 160 - background.contentHeight/2 + challengesText.contentHeight/2 + 3
    challengesText.text = getTransaltedText("Challenges") 

    if  challengesText.contentWidth > 150 then
        challengesText.xScale  =  150  / challengesText.contentWidth
        challengesText.yScale  = challengesText.xScale 
        --challegesText.x = bullet.x + bullet.contentWidth/2  + challegesText.contentWidth/2 + 15
    end


    chalengesTable.isConstant = true
    challengesText.isConstant = true

    local scoreScreenText = display.newText(boosterHeaderTextOptions)
    scoreScreenText:setFillColor(255/255,241/255,208/255)
    scoreScreenText.x = 240
    scoreScreenText.y = 160 - background.contentHeight/2 + scoreScreenText.contentHeight/2 + 3
    scoreScreenText.text = getTransaltedText("Score") 

    xp.xpBarBG  = display.newImage("BlueSet/End/XPBarBG.png")
    xp.xpBarBG:scale(0.5,0.5)
    xp.xpBarBG.x = 240
    xp.xpBarBG.y = 240

    xp.xpBarStart  = display.newImage("BlueSet/End/XPBarStart.png")
    xp.xpBarStart:scale(0.5,0.5)
    xp.xpBarStart.x = xp.xpBarBG.x - xp.xpBarBG.contentWidth / 2 + xp.xpBarStart.contentWidth/2 + 2
    xp.xpBarStart.y = 240

    xp.xpBarMiddle  = display.newImage("BlueSet/End/XPBarMiddle.png")
    xp.xpBarMiddle:scale(0.5,0.5)
    xp.xpBarMiddle.x = xp.xpBarStart.x + xp.xpBarMiddle.contentWidth / 2 + xp.xpBarStart.contentWidth/2 
    xp.xpBarMiddle.y = 240

    xp.xpBarEnd  = display.newImage("BlueSet/End/XPBarFinish.png")
    xp.xpBarEnd:scale(0.5,0.5)
    xp.xpBarEnd.x = xp.xpBarMiddle.x + xp.xpBarMiddle.contentWidth / 2 + xp.xpBarEnd.contentWidth/2 - 1
    xp.xpBarEnd.y = 240

    xp.xpEmiter = particleDesigner.newEmitter( "fire1.json" )
    xp.xpEmiter:scale(0.05,0.005)
    xp.xpEmiter.x = xp.xpBarEnd.x 
    xp.xpEmiter.y = 240

    --boosterHandImg:scale(0.4,0.4)

    nextLevelText.x = xp.xpBarBG.x + xp.xpBarBG.contentWidth / 2 + 15
    levelText.x =  xp.xpBarBG.x - xp.xpBarBG.contentWidth / 2  - 15
    
    rightArrowButton.y = scoreScreenText.y 
    leftArrowButton.y = rightArrowButton.y 


    chalengesBox:insert(chalengesTable)
    chalengesBox:insert(challengesText)
    chalengesBox:insert(chalengesData)
       
     gameOverGroup:insert(blackRect)

     gameOverGroup:insert(background)    

     scoreBox:insert(scoreScreenText)     
     scoreBox:insert(scoreTitleTextS)     
     scoreBox:insert(scoreTitleText)     
     scoreBox:insert(scoreTextS) 
     scoreBox:insert(scoreText)    
     scoreBox:insert(comboTextS) 
     scoreBox:insert(comboText)    
     scoreBox:insert(xp.xpBarBG)    
     scoreBox:insert(xp.xpBarStart)    
     scoreBox:insert(xp.xpBarMiddle)  
     scoreBox:insert(xp.xpBarEnd) 
     scoreBox:insert(xp.xpEmiter) 
     
     scoreBox:insert(levelText)  
     scoreBox:insert(nextLevelText) 
          
     
     
     gameOverGroup:insert(highScoreTitleShadow)     
     gameOverGroup:insert(highScoreTitle)     
     
     gameOverGroup:insert(highScoreShadowText)     
     gameOverGroup:insert(highScoreText)   

     

     
     gameOverGroup:insert(scoreBox)     
     gameOverGroup:insert(chalengesBox)     
     gameOverGroup:insert(confetti)   

     gameOverGroup:insert(rightArrowButton)   
     gameOverGroup:insert(leftArrowButton)   


       
     scoreBox.alpha = 1
     chalengesBox.alpha = 0
     
     
     gameOverGroup:insert(playButton)
     gameOverGroup:insert(showAdButton)
     
     gameOverGroup:insert(shareButton)
     gameOverGroup:insert(openPkgButton)
     gameOverGroup:insert(openPkgButton2)
     gameOverGroup:insert(menuButton)     

     
     
       
      gameOverGroup:insert(dailyRewardBlocker)

     notification:insert(boosterRect)
     
     notification:insert(boosterMsg.skeleton.group)

     notificationData:insert(boosterText)
     notificationData:insert(boosterHeaderText)     
     notificationData:insert(boosterCoinsText)     
     notificationData:insert(boosterCoinImg)   
     notificationData:insert(boosterHandImg) 
     notificationData:insert(rateUsButton) 
     
         
     
     notificationData.x = 15
     
     notificationData:insert(boosterButton)
     notificationData:insert(boosterClose)
     
     notification:insert(notificationData)

     notification.x =   notification.x  + (display.actualContentWidth - display.contentWidth)/2  
   
     
     gameOverGroup:insert(notification)
     gameOverGroup:insert(loadingBlocker) 


     sceneGroup:insert(gameOverGroup) 
     sceneGroup:insert(newLevelGroup) 
     sceneGroup:insert(dailyRewardGroup) 
     sceneGroup:insert(promotionGroup) 


     
     
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
      -- loadingBlocker.alpha = 0.01
      -- playButton.alpha = 0
        gameOverGroup.alpha =0 
        newLevelGroup.alpha =0 
        promotionGroup.alpha =0 

      parent = event.parent
       local isSimulator = (system.getInfo("environment") == "simulator");
 
        
        boosterMsg.skeleton.group.alpha = 0
        notification.alpha = 0
        

     


   elseif ( phase == "did" ) then

       
      if(event.params and event.params.results) then
        showGameOver(event.params.results , true)
      end  

       
   end
end

-- "scene:hide()"
function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase
   

   if ( phase == "will" ) then
      boosterMsg:pause()
      commonData.kidoz.hide( "panelView")
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
--        parent:outerRestartGame()
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



function scene:outerRefreshResults(gameResult)
    --code to resume game
 showGameOver(gameResult, false)
 local sceneGroup = self.view

 sceneGroup.alpha = 0.05
 local screenAlpha  = 0.05
 timer.performWithDelay(5,function()

  if sceneGroup and sceneGroup.alpha and sceneGroup.alpha > 0 then
   screenAlpha = screenAlpha + 0.05
   sceneGroup.alpha = screenAlpha

  end 
 end, 19)
 if (commonData.gameData.gamesCount > 50  and not  commonData.gameData.madePurchase) then
          commonData.kidoz.show( "panelView")
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

