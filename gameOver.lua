local commonData = require( "commonData" )

local composer = require( "composer" )
local widget = require( "widget" )

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

local rateUsButton = nil
local fbLoginButton = nil
local fbLoginButton2 = nil
local achivmetBarFull = nil
local achivmetBar = nil
local highScoreShadowText = nil
local parent = nil
local scoreText  = nil
local scoreTextS  = nil
local packsIndicator = nil
 local LoginDisclamer = nil
 local highScoreText = nil

local boosterMsgSpine =  nil
local boosterMsg = nil
local avatarsInProgress = 0

local shareButton = nil

local scoreTitleText = nil 
local scoreTitleTextS = nil
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
local friendsBox =nil
local friendsData =nil

local tip = nil
local tip2 = nil
local tip3 = nil
local packReminder = nil
local dailyReward = nil
local activeScreen = 1


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
        {
           iOSAppId = "986567641",          
           androidAppPackageName = "com.ld.dribble",
           supportedAndroidStores = { "google" },
        }
        native.showPopup( "appStore", options )
     end 
       return true
 end



local function logHighScore(gameData , newHighScore)
  local coinsToNotify = {}
  coinsToNotify[1] = 20  
  coinsToNotify[2] = 50
  coinsToNotify[3] = 75  
  coinsToNotify[4] = 100  
  coinsToNotify[5] = 150
  coinsToNotify[6] = 200  
  coinsToNotify[7] = 300  
  coinsToNotify[8] = 400    
  coinsToNotify[9] = 500

  for i=1,9 do
    

    if gameData.highScore < coinsToNotify[i] and
       coinsToNotify[i] < newHighScore then

          commonData.analytics.logEvent( "reached " ..  tostring(coinsToNotify[i]) .. " meters", { gamesCount= tostring( gameData.gamesCount)  } )
    end  
  end

   
end



local function logGamesCount(gameData)
  local gamesToAlert = {}
  gamesToAlert[1] = 5  
  gamesToAlert[2] = 10
  gamesToAlert[3] = 20  
  gamesToAlert[4] = 30 
  gamesToAlert[5] = 50
  gamesToAlert[6] = 70
  gamesToAlert[7] = 100
  gamesToAlert[8] = 150
  gamesToAlert[9] = 200
  gamesToAlert[10] = 300
  gamesToAlert[11] = 500
  gamesToAlert[12] = 1000

  for i=1,12 do
    

    if gameData.gamesCount  == gamesToAlert[i]  then

         if system.getInfo("environment") ~= "simulator" then
          commonData.analytics.logEvent( "Played " ..  tostring(gameData.gamesCount) .. " games", 
            {  highScore = tostring(  gameData.highScore) ,
              totalCoins = tostring(  gameData.coins + gameData.usedcoins) ,
              avgScore =  tostring(gameData.totalScore / math.max(gameData.gamesCount, 1)) } )
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
      if tip then 
        tip.alpha = 1   
          tip:setSequence("start")
          tip:play()  
          okButtonDelay = 2000
      end

      if tip2 then 
        tip2.alpha = 1   
          tip2:setSequence("start")
          tip2:play()  
          okButtonDelay = 2000
      end

      if tip3 then 
        tip3.alpha = 1             
          okButtonDelay = 2000
      end
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


local function buildFriendsPart(gameData)
                     
  
                     if gameData.isConnectedToFB  or isSimulator then
                        fbLoginButton2.alpha = 0 
                        LoginDisclamer.alpha = 0 
                      else
                        fbLoginButton2.alpha = 1 
                        LoginDisclamer.alpha = 1
                      end  

                    if not friendsData then
                      --print("no friendsData")
                      return
                    end  

                    if friendsData.numChildren then
                      for j = 1, friendsData.numChildren do                       
                          
                            friendsData[1]:removeSelf()          
                          
                      end
                    end

                    
                    local  friendPos = 1

                    local freindTextOptions = 
                          {
                              --parent = textGroup,
                              text = "",     
                              x = 420,
                              y = 20,
                              width = 70,     --required for multi-line and alignment
                              font = "UnitedSansRgHv",   
                              fontSize = 15,
                              align = "left"  --new alignment parameter
                          }
                    local freindTextOptions2 = 
                        {
                            --parent = textGroup,
                            text = "",     
                            x = 420,
                            y = 20,
                            width = 70,     --required for multi-line and alignment
                            --height = 10,
                            font = "UnitedSansRgHv",   
                            fontSize = 10,
                            align = "left"  --new alignment parameter
                        }

                    local localPlayerRank  = 1
                    local isPlayerInTop  = 0

                                        
                    for index, friend in pairsByHighScore( commonData.friendsScore ) do
  
                    local isAvatarExists = friend.avatarId and commonData.avatars and commonData.avatars[friend.avatarId] 
                            
                            if index > gameData.highScore
                            then
                              localPlayerRank = localPlayerRank + 1
                            elseif (isPlayerInTop == 0  and (gameData.isConnectedToFB or isSimulator))  then 
                              isPlayerInTop = 1

                              -- draw local player
                              local heroBack = display.newImage("images/FriendBox.png")
                               local heroAvatar = heroSpine.new(0.15, true, false)
                                heroBack:scale(0.4,0.4)
                               
                               if friendPos % 2 == 1 then
                                 heroBack.x = 160 
                               else
                                 heroBack.x = 300 
                                
                               end

                               if friendPos > 2 then
                                 heroBack.y = 210 
                                 heroBack.x = 160 
                                 heroBack.xScale = -0.4
                               else
                                 heroBack.y = 140 
                               end

                               heroBack:setFillColor(0,0.5,0.5)
                               heroAvatar.skeleton.group.x = heroBack.x + 40
                               heroAvatar.skeleton.group.y = heroBack.y + 25

                               heroAvatar.skeleton.group.xScale = -1
                               
                              

                               local heroText = display.newText(freindTextOptions)
                               local heroText1 = display.newText(freindTextOptions)
                               heroText.text = friendPos .. ". YOU " 
                               heroText1.text = gameData.highScore .. "M"
                               heroText.x = heroBack.x - 15
                               heroText.y = heroBack.y - 15

                               heroText1.x = heroBack.x 
                               heroText1.y = heroBack.y + 7

                               heroText1:setFillColor(1,206/255,0)
                               --heroBack:setFillColor(19/256,236/256,254/256)
                               heroBack:setFillColor(0,1,0)
                               
                               avatarsInProgress = avatarsInProgress + 1
                               heroAvatar:init()

                               timer.performWithDelay(1, function () 
                                  
                                 heroAvatar:pause()
                                 avatarsInProgress = avatarsInProgress - 1
                               end , 1)


                               local friendGroup = display.newGroup()
                               friendGroup:insert(heroBack)
                               friendGroup:insert(heroAvatar.skeleton.group)
                               friendGroup:insert(heroText)
                               friendGroup:insert(heroText1)

                               if friendsData and friendsData.isVisible then
                                 friendsData:insert(friendGroup)
                               else
                                 friendGroup.alpha = 0 
                               end
                               
                            end  
                      
                          if friendPos < 3 then
                                 local avatarToLoad = nil
                                  if isAvatarExists then
                                    avatarToLoad = commonData.avatars[friend.avatarId].data
                                  else
                                     avatarToLoad = {pants = "defaultPants",
                                                  shirt = "defaultShirt",
                                                  shoes = "Default",
                                                  ball = "Ball001",
                                                  skin = "littleDribbler"
                                                }  
                                  end  
                                  

                                 local friendBack = display.newImage("images/FriendBox.png")
                                 local friendAvatar = heroSpine.new(0.15, true, false, avatarToLoad)
                                  friendBack:scale(0.4,0.4)
                                 
                                 if (friendPos + isPlayerInTop) % 2 == 1 then
                                   friendBack.x = 160 
                                 else
                                   friendBack.x = 300 
                                  
                                 end

                                 if (friendPos + isPlayerInTop) > 2 then
                                   friendBack.y = 210 
                                   friendBack.xScale = -0.4
                                 else
                                   friendBack.y = 140 
                                 end

                                 friendAvatar.skeleton.group.x = friendBack.x + 40
                                 friendAvatar.skeleton.group.y = friendBack.y + 25

                                 friendAvatar.skeleton.group.xScale = -1
                                 
                                 local friendText = display.newText(freindTextOptions)

                                 local friendText2 = display.newText(freindTextOptions)
                                 local friendText3 = display.newText(freindTextOptions2)
                                 local friendText4 = display.newText(freindTextOptions)

                                 friendText.text = (friendPos + isPlayerInTop) .. ". " 

                                 local isFirst = true
                                 friendText3.text = ""
                                 for i in string.gmatch(friend.name, "%S+") do
                                   
                                   if isFirst then
                                      friendText2.text = i
                                   else
                                    friendText3.text = friendText3.text ..  i .. " "
                                   end 
                                   isFirst = false

                                 end
                                 --friendText2.text = string.gmatch(friend.name, "%S+")[1] -- split(friend.name)[1] 
                                 --friendText3.text = friend.name 
                                 friendText4.text =  index .. "M"

                                 friendText.x = friendBack.x - 15
                                 friendText.y = friendBack.y - 15

                                 friendText2.x = friendBack.x 
                                 friendText2.y = friendBack.y - 15
                                
                                 friendText3.x = friendBack.x 
                                 friendText3.y =  friendText2.y + friendText2.contentHeight / 2 + friendText3.contentHeight / 2  - 5
                                
                                 friendText4.x = friendBack.x 
                                 --friendText4.y = friendBack.y + 15
                                 friendText4.y =  friendText3.y + friendText3.contentHeight / 2 + friendText4.contentHeight / 2 
                               
                                 friendText4:setFillColor(1,206/255,0)
                                
                                 avatarsInProgress = avatarsInProgress + 1 
                                 friendAvatar:init()
                                 timer.performWithDelay(1, function () 
                                  
                                   friendAvatar:pause()
                                   avatarsInProgress = avatarsInProgress - 1
                                 end , 1)

                                 

                                  local friendGroup = display.newGroup()
                                friendGroup:insert(friendBack)
                                 friendGroup:insert(friendAvatar.skeleton.group)
                                 friendGroup:insert(friendText)
                                 friendGroup:insert(friendText2)
                                 friendGroup:insert(friendText3)
                                 friendGroup:insert(friendText4)

                                 if friendsData and friendsData.isVisible then
                                   friendsData:insert(friendGroup)
                                 else
                                   friendGroup.alpha = 0 
                                 end
                         end

                         friendPos = friendPos + 1
                        
                      
                    end -- end loop


                                  if (isPlayerInTop == 0  and (gameData.isConnectedToFB or isSimulator))  then
                                          isPlayerInTop = 1

                                          -- draw local player
                                                      local heroBack = display.newImage("images/FriendBox.png")
                                                       local heroAvatar = heroSpine.new(0.15, true, false)
                                                        heroBack:scale(0.4,0.4)
                                                       
                                                       local friendPos2 = friendPos
                                                        if (friendPos2 > 3) then
                                                          friendPos2 = 3
                                                        end

                                                       if friendPos2 % 2 == 1 then
                                                         heroBack.x = 160 
                                                       else
                                                         heroBack.x = 300 
                                                        
                                                       end

                                                       if friendPos2 > 2 then
                                                         heroBack.y = 210 
                                                         heroBack.xScale = -0.4
                                                       else
                                                         heroBack.y = 140 
                                                       end

                                                       heroAvatar.skeleton.group.x = heroBack.x + 40
                                                       heroAvatar.skeleton.group.y = heroBack.y + 25

                                                       heroAvatar.skeleton.group.xScale = -1
                                                       
                                                       local heroText = display.newText(freindTextOptions)
                                                       local heroText1 = display.newText(freindTextOptions)
                                                       heroText.text = friendPos .. ". YOU " 
                                                       heroText1.text = gameData.highScore .. "M"
                                                       heroText.x = heroBack.x - 15
                                                       heroText.y = heroBack.y - 15

                                                       heroText1.x = heroBack.x 
                                                       heroText1.y = heroBack.y + 7

                                                       heroText1:setFillColor(1,206/255,0)
                                                       --heroBack:setFillColor(19/256,236/256,254/256)
                                                       heroBack:setFillColor(0,1,0)
                                                       avatarsInProgress = avatarsInProgress + 1
                                                       heroAvatar:init()
                                                       timer.performWithDelay(1, function () 
                                                        --print("stop avatar")
                                                         heroAvatar:pause()
                                                         avatarsInProgress = avatarsInProgress - 1
                                                       end , 1)

                                                      local friendGroup = display.newGroup()
                                                      friendGroup:insert(heroBack)
                                                      friendGroup:insert(heroAvatar.skeleton.group)
                                                      friendGroup:insert(heroText)
                                                      friendGroup:insert(heroText1)

                                                     if friendsData and friendsData.isVisible then
                                                       friendsData:insert(friendGroup)
                                                     else
                                                       friendGroup.alpha = 0 
                                                     end
                                end 
                                 if (gameData.isConnectedToFB or isSimulator)  then
                                          friendPos = friendPos + 1
                                                     if friendPos > 3 then
                                                        friendPos = 4
                                                     end 
                                                     
                                                      local heroBack1 = widget.newButton
                                                      {
                                                          x = 410,
                                                          y = 165,
                                                          id = "playButton",
                                                          defaultFile = "images/InviteBTNUp.png",
                                                          overFile = "images/InviteBTNDown.png",
                                                          onEvent = commonData.fbInviteListener
                                                      }
                                                    
                                                     heroBack1:scale(0.4,0.4)
                                                       
                                                       if friendPos % 2 == 1 then
                                                         heroBack1.x = 160 
                                                       else
                                                         heroBack1.x = 300 
                                                        
                                                       end

                                                       if friendPos > 2 then
                                                         heroBack1.y = 210 
                                                        -- heroBack1.xScale = -0.4
                                                       else
                                                         heroBack1.y = 140 
                                                       end
                                                       
                                                    
                                                      local friendGroup1 = display.newGroup()
                                                      friendGroup1:insert(heroBack1)
                                                      
                                                     if friendsData and friendsData.isVisible then
                                                       friendsData:insert(friendGroup1)
                                                     else
                                                       friendGroup1.alpha = 0 
                                                     end
                                end    
            end -- end build friends


local function showActiveScreen()
      if activeScreen == 1 then        
        scoreBox.alpha = 1 
        chalengesBox.alpha = 0
        friendsBox.alpha = 0
      elseif activeScreen == 2 then        
        scoreBox.alpha = 0 
        chalengesBox.alpha = 1
        friendsBox.alpha = 0
      else  
        scoreBox.alpha = 0
        chalengesBox.alpha = 0
        friendsBox.alpha = 1
      end  
    end  


local function showGameOver( gameResult , isFirstLoad)



             local memUsed = (collectgarbage("count"))
             local texUsed = system.getInfo( "textureMemoryUsed" ) / 1048576 -- Reported in Bytes
           
            
            --print( string.format("%.00f", texUsed) .. " / " .. memUsed)
             
    
        boosterMsg.skeleton.group.alpha = 0
        notification.alpha = 0
        packsIndicator.alpha = 0

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
            commonData.gameData.selectedSkin = "littleDribbler"
            commonData.gameData.selectedBall = "Ball001"
            commonData.gameData.selectedShoes = "Default"
            commonData.gameData.selectedPants = "default"
            commonData.gameData.selectedShirt = "defaultShirt"

            
            commonData.gameData.isConnectedToFB  = false

          end  
       end 

 
   
      --Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
      if(gameResult) then

            local endGameScore = gameResult.gameScore
            scoreText.text = commonData.comma_value(endGameScore)
            scoreTextS.text = commonData.comma_value(endGameScore)
            

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
                      width = 300,     --required for multi-line and alignment
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
                      width = 100,     --required for multi-line and alignment
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
                        challegesText:setFillColor(109/256,219/255,255/256)
                        bullet = display.newImage("images/ChallengeBulletComplete.png")
                        

                      else
                        challegesCoinsText:setFillColor(194/256,236/256,254/256)
                        challegesText:setFillColor(194/256,236/256,254/256)
                        bullet = display.newImage("images/ChallengeBullet.png")
                                          
                      end

                      bullet:scale(0.5,0.5)
                      bullet.y = 95 + i* 22
                      bullet.x = 240 - background.contentWidth/2 + bullet.contentWidth/2 + 35
                      challegesText.x = bullet.x + bullet.contentWidth/2  + challegesText.contentWidth/2 + 15
                      challegesText.y = 95 + i* 22
                      challegesText.text = challeges[i].text

                      
                      challegesCoinsText.y = 95 + i* 22
                      challegesCoinsText.text = challeges[i].coins

                      challegesCoin:scale(0.15,0.15)
                      challegesCoin.x = 240 + background.contentWidth/2 -  challegesCoin.contentWidth/2 - 35
                      challegesCoin.y = 95 + i* 22

                      challegesCoinsText.x = challegesCoin.x - challegesCoin.contentWidth/2  - challegesCoinsText.contentWidth/2 - 10
                      
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
            fbLoginButton.alpha =0
            local function postScoreSubmit( event )
               
               --whatever code you need following a score submission...                
               return true
            end 
                    --for GameCenter, default to the leaderboard name from iTunes Connect
            local myCategory = "Little Dribble High Score"

            --if ( system.getInfo( "platformName" ) == "Android" ) then
               --for GPGS, reset "myCategory" to the string provided from the leaderboard setup in Google
               myCategory = "CgkI_YzqptgFEAIQAA"
            --end

            -- TODO: remove
            -- commonData.gameNetwork.request( "setHighScore",
            -- {
            --    localPlayerScore = { category=myCategory, value=tonumber(gameResult.gameScore) },
            --    listener = postScoreSubmit
            -- } )
            commonData.gpgs.leaderboards.submit( {leaderboardId=myCategory, score=tonumber(gameResult.gameScore) } )

            -- submit highest combo
            local highestComboId = "CgkI_YzqptgFEAIQBw"
            commonData.gpgs.leaderboards.submit( {leaderboardId=highestComboId, score=tonumber(gameResult.combo) } )
            

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

              submitHighScoreToFacebook()                 
            else

              scoreTitleText.text = "YOU REACHED:"
              scoreTitleTextS.text = "YOU REACHED:"
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

            if not commonData.gameData.highestCombo or commonData.gameData.highestCombo < gameResult.combo then
              commonData.gameData.highestCombo = gameResult.combo
            end  


            comboText.text = "HIGHEST COMBO: " ..  gameResult.combo
            comboTextS.text = "HIGHEST COMBO: " ..   gameResult.combo
            comboText.alpha = 1
            comboTextS.alpha = 1

            if (isFirstLoad or isHighScore) then
              timer.performWithDelay(1,function ()
                
                buildFriendsPart(commonData.gameData)
              end,1)      
            end  

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
            
            if  commonData.gameData.lastGameTime  and  (commonData.gameData.lastGameTime < todayStart or 
              (commonData.gameData.gamesCount == 10 and commonData.gameData.fisrtGameTime == todayStart)) then


              if yesterdayStart < commonData.gameData.lastGameTime then
              
               -- reward
                commonData.gameData.daysInARow = commonData.gameData.daysInARow + 1
              else
                commonData.gameData.daysInARow = 1              
              end
              
              if commonData.gameData.daysInARow > 1 then
                commonData.analytics.logEvent( "dailyBonus day " .. tostring( commonData.gameData.daysInARow) , { gamesCount= tostring( commonData.gameData.gamesCount),
                appOpened= tostring( commonData.gameData.appOpened)
                 } )
              end
              local coinsDailyReward = 20 + commonData.gameData.daysInARow * 20

              if (coinsDailyReward > 120) then
                coinsDailyReward  = 120
              end  
              --showNotification("DAILY REWARD! \n\n" ..  tostring( coinsDailyReward ) .. " COINS \n\n ")
              --showPrizeNotification("DAILY REWARD!" , "play every day and get better rewards")


              if not dailyReward then
                dailyReward = display.newGroup()

                local coinImg1 = display.newImage( "images/DailyRewardBox.png")
              
                coinImg1.x = 180
              
                coinImg1.y = 140
              
                coinImg1:scale(0.6,0.6)


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
                    font = "UnitedSansRgHv",   
                    fontSize = 25,
                    align = "center"  --new alignment parameter
                }


              --  boosterText.y =   boosterText.y  + (display.actualContentHeight - display.contentHeight)/2  
               -- boosterButton.y =   boosterButton.y  + (display.actualContentHeight - display.contentHeight)/2  

                day1Text = display.newText(boosterHeaderTextOptions)
                day1Text:setFillColor(194/256,236/256,254/256)
                day1Text.x = 115
                day1Text.y = 170
                day1Text.text = coinsDailyReward 

                --oosterHeaderText.y =   boosterHeaderText.y  + (display.actualContentHeight - display.contentHeight)/2  

                day2Text = display.newText(boosterTextOptions)
                day2Text:setFillColor(194/256,236/256,254/256)
                day2Text.x = 193
                day2Text.y = 165
                day2Text.text = math.min(coinsDailyReward + 20 , 120) 

                day3Text = display.newText(boosterTextOptions)
                day3Text:setFillColor(194/256,236/256,254/256)
                day3Text.x = 248
                day3Text.y = 165
                day3Text.text = math.min(coinsDailyReward + 40 , 120) 

                day4Text = display.newText(boosterTextOptions)
                day4Text:setFillColor(194/256,236/256,254/256)
                day4Text.x = 303
                day4Text.y = 165
                day4Text.text = math.min(coinsDailyReward + 60 , 120)

                dayText = display.newText(boosterHeaderTextOptions)
                dayText:setFillColor(194/256,236/256,254/256)
                dayText.x = 100
                dayText.y = 205
                dayText.text = getTransaltedText("DailyRewardDay") .." " .. commonData.gameData.daysInARow  
                
                dailyReward:insert(coinImg1)
                dailyReward:insert(day1Text)
                dailyReward:insert(day2Text)
                dailyReward:insert(day3Text)
                dailyReward:insert(day4Text)
                dailyReward:insert(dayText)
                notificationData:insert(dailyReward)
              
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
             
             local function validateDailyReward(event)
                      
                  -- no internet - no glory
                  if ( event.isError ) then
            
                      
            
                  else
            
                      
                      local server_time = json.decode(event.response)
                         
                      if server_time then
              
                        player_time = os.time(os.date( '*t' ))

                        if math.abs(server_time - player_time) > 12 * 60 * 60 then
                            -- cheater
                        else
                           giveDailyReward()
                        end
                      end
            
                  end
                  dailyRewardBlocker.alpha = 0
                  --playButton.alpha = 1
                  return true
            
              end
     
            -- get Server time  
            --print("call time api")
            local URL = "http://www.timeapi.org/utc/now?%5Cs"
            dailyRewardBlocker.alpha = 0.01
            network.request( URL, "GET", validateDailyReward ) 
          
              -- not fisrt game today  
           --  elseif ((commonData.gameData.gamesCount == 5 and commonData.gameData.highScore < 20)   or 
           --        (commonData.gameData.gamesCount == 20 and commonData.gameData.highScore < 40) )  then
                
           --      showPrizeNotification("Dribbler Tip:" , "Hold your leg up until you hit the ball",nil,true)



           --      if not tip then  
           --          local ultraSheetSetup = 
           --          {
           --          width = 456,
           --          height = 355,
           --          numFrames = 5,
           --          sheetContentWidth = 2280,
           --          sheetContentHeight = 355
           --          }

           --          local ultraData = 
           --          {
           --          { name = "start", start = 1, count = 5, time = 3000, loopCount = 0}
           --          }
           --          local spriteSheet = graphics.newImageSheet("images/TipSheet.jpg", ultraSheetSetup);
           --          tip = display.newSprite(spriteSheet, ultraData);


           --          tip.x = 180
           --          tip.y = 140
           --          tip:scale(0.35,0.35)

           --          local currentSceneName = composer.getSceneName( "current" )
                    
           --          if ( currentSceneName== "game" ) then
           --            notificationData:insert(tip)
           --          else
           --            tip:removeSelf()
           --          end
                   

           --      end    
           -- elseif  (gameResult.finishReason=="catchedBYShamina"  and gameResult.gameScore < 45)  then

           --      showPrizeNotification("Dribbler Tip:" , "Kick in perfect timing and swap legs \n to gain speed",nil,true)



           --      if not tip3 then  
                    
           --          tip3 = display.newImage("images/Tip3.jpg")


           --          tip3.x = 180
           --          tip3.y = 140
           --          tip3:scale(0.35,0.35)

           --          local currentSceneName = composer.getSceneName( "current" )
                    
           --          if ( currentSceneName== "game" ) then
           --            notificationData:insert(tip3)
           --          else
           --            tip3:removeSelf()
           --          end           
           --      end    

           -- elseif  ((commonData.gameData.gamesCount == 30 and commonData.gameData.highScore < 50)   or 
           --        (commonData.gameData.gamesCount == 50 and commonData.gameData.highScore < 70)) then

           --      showPrizeNotification("Dribbler Tip:" , "Try to kick the ball low",nil,true)



           --      if not tip2 then  
           --          local ultraSheetSetup = 
           --          {
           --          width = 365,
           --          height = 355,
           --          numFrames = 7,
           --          sheetContentWidth = 2555,
           --          sheetContentHeight = 355
           --          }

           --          local ultraData = 
           --          {
           --          { name = "start", start = 1, count = 5, time = 3000, loopCount = 0}
           --          }
           --          local spriteSheet = graphics.newImageSheet("images/Tip2.jpg", ultraSheetSetup);
           --          tip2 = display.newSprite(spriteSheet, ultraData);


           --          tip2.x = 180
           --          tip2.y = 140
           --          tip2:scale(0.35,0.35)

           --          local currentSceneName = composer.getSceneName( "current" )
                    
           --          if ( currentSceneName== "game" ) then
           --            notificationData:insert(tip2)
           --          else
           --            tip2:removeSelf()
           --          end
                   

           --      end    

               
           elseif (commonData.gameData.gamesCount > 100 and isHighScore and not commonData.gameData.rateUsShown ) then   
           
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
            elseif (not commonData.gameData.isConnectedToFB and commonData.gameData.gamesCount == 50)  then
            --elseif (not gameData.isConnectedToFB ) then
              local rateImg = display.newImage("images/LoginWithFacebook.png")
              rateImg:scale(0.65,0.65)
              rateImg.x =190
              rateImg.y =140

               local currentSceneName = composer.getSceneName( "current" )
                
                if ( currentSceneName== "game" ) then
                  notificationData:insert(rateImg)
                else
                  rateImg:removeSelf()
                end
              
              fbLoginButton.alpha =1
              --showPrizeNotification("NICE SCORE!" , "Rate us if you like our game")
              showPrizeNotification("" , "",nil,false)
            end    


            t = os.date( '*t' )


            if not commonData.gameData.lastGameTime or commonData.gameData.lastGameTime < os.time( t ) then
              commonData.gameData.lastGameTime = os.time( t )
            end
            
            
            commonData.saveTable(commonData.gameData , GAME_DATA_FILE)

            
            logCoins(commonData.gameData ,  gameResult.coins)
           
            logGamesCount(commonData.gameData)
            
           
            commonData.analytics.logEvent( "finishGame", { gamesCount= tostring( commonData.gameData.gamesCount) ,  
                                                gameScore= tostring( gameResult.gameScore) , 
                                                highScore= tostring(  commonData.gameData.highScore) ,
                                                reason= tostring(gameResult.finishReason)  } )

            
            if (commonData.gameData.packs > 0) then
              packsIndicator.alpha = 1
            else  
              packsIndicator.alpha = 0
            end


            highScoreText.text = commonData.comma_value(commonData.gameData.highScore)
            highScoreShadowText.text = commonData.comma_value(commonData.gameData.highScore)
            --parse:logEvent( "Share", { ["score"] = gameResult.gameScore } )

            -- unlock new achivments

            
            local newAchiv = getNewUnlockedAchivments()

            
            for k,v in pairs(newAchiv) do
              
                commonData.gpgs.achievements.unlock({
                                              achievementId=v.code
                                            })
              -- commonData.gameNetwork.request( "unlockAchievement", {
              --                               achievement = {
              --                                 identifier=v.code
              --                               }
              --                             }); 

            end
            

            if isHighScore or isFirstLoad then
              activeScreen = 1
            
            elseif #newChallenges > 0 then
              activeScreen = 2

            
            else
              activeScreen = math.random(3)
            
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
     friendsBox = display.newGroup()
     friendsData= display.newGroup()
     
     buttonsSet = "BlueSet"
     --everything from here down to the return line is what makes
     --up the scene so... go crazy
     background = display.newImage("images/EndGameBG.png")
     -- background = display.newImage("images/EndGameBG Blue.png")

    
     background.xScale =  (display.actualContentWidth*0.7) / background.contentWidth
     background.yScale =  (display.actualContentHeight*0.6) / background.contentHeight
     background.x = 240
     background.y = 160 

      
       local chalengesTable = display.newImage("images/ChallengeScreenTable.png")


      chalengesTable.xScale =  (display.actualContentWidth*0.5) / chalengesTable.contentWidth
      chalengesTable.yScale =  chalengesTable.xScale
     
     chalengesTable.x = 240
     chalengesTable.y = 160

      LoginDisclamer = display.newImage("images/LoginDisclamer.png")


      LoginDisclamer.xScale =  (display.actualContentWidth*0.5) / LoginDisclamer.contentWidth
      LoginDisclamer.yScale =  LoginDisclamer.xScale
     
     LoginDisclamer.x = 240
     LoginDisclamer.y = 200


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
          parent:outerRestartGame()
          

       
          end
          return true
     end

    local function goToMenu()
      if avatarsInProgress == 0 then
       local options = {params = {gameData = commonData.gameData}}
       composer.gotoScene( "menu" , options )
      end 

    end 
    local function menuListener( event )
          
          if ( "ended" == event.phase ) then
            
            commonData.buttonSound()

            if avatarsInProgress > 0 then
              timer.performWithDelay(500, goToMenu , 1)
            else  
              local options = {params = {gameData = commonData.gameData}}
              composer.gotoScene( "menu" , options )

            end  

            
       
          end
          return true
     end



    local function nativeShareListener( event )
            
            if ( "ended" == event.phase ) then
              
              commonData.buttonSound()
              native.setActivityIndicator( true )

              self.view.alpha=0
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


              self.view.alpha=1            
              
              --local serviceName = "twitter"  --supported values are "twitter", "facebook", or "sinaWeibo"
              local serviceName = event.target.id

              if (serviceName=="share" and system.getInfo("platformName") == "iPhone OS" ) then
                local items =
                      {
                        { type = "image", value = { filename="result.png", baseDir=system.TemporaryDirectory } },
                        { type = "string", value ="Little Dribble!"},
                        { type = "url", value = "http://littledribblegame.com/" },
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
                      native.showAlert( "Error", "Can't display the view controller. Are you running iOS 7 or later?", { "OK" } )
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
                          message = "Little Dribble!",
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
       if avatarsInProgress == 0 then
    
         local options = {params = {gameData = commonData.gameData}}
         composer.gotoScene( "packs" , options )
       end  

    end 

    local function packsListener( event )
          
          if ( "ended" == event.phase ) then
            
            commonData.buttonSound()

            if avatarsInProgress > 0 then
              timer.performWithDelay(500, goToPacks , 1)
            else  
              local options = {params = {gameData = commonData.gameData}}
              composer.gotoScene( "packs" , options )

            end  
          end  

           return true
      end      

     

       local function boosterButtonListener( event )
         if ( "ended" == event.phase ) then
          notification.alpha = 0 

          if tip then
            tip:removeSelf()
            tip = nil
          end  

          if tip2 then
            tip2:removeSelf()
            tip2 = nil
          end  

          if tip3 then
            tip3:removeSelf()
            tip3 = nil
          end  


          if dailyReward then
            dailyReward:removeSelf()
            dailyReward = nil
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

      local menuButton = widget.newButton
      {
          x = 240,
          y = 280,
          id = "menuButton",
          defaultFile = buttonsSet .. "/End/MainMenuUp.png",
          overFile = buttonsSet .. "/End/MainMenuDown.png",
          onEvent = menuListener
      }
      menuButton.xScale =  (display.actualContentWidth* 0.28) / menuButton.width
      menuButton.yScale =   menuButton.xScale  -- (display.actualContentHeight* 0.1) / menuButton.height
   
    
      rateUsButton = widget.newButton
      {
          x = 240,
          y = 265,
          id = "rateUsButton",
          defaultFile = buttonsSet .. "/End/RateUp.png",
          overFile = buttonsSet .. "/End/RateDown.png",
          onEvent = rateUsListener
      }
      rateUsButton.xScale =  (display.contentWidth*0.25) / rateUsButton.width
      rateUsButton.yScale = rateUsButton.xScale  
      rateUsButton.x =  rateUsButton.x - (display.actualContentWidth - display.contentWidth) /2

      fbLoginButton = widget.newButton
      {
          x = 240,
          y = 265,
          id = "fbLoginButton",
          defaultFile = "ExtrasMenu/FBLogin.png",
          overFile = "ExtrasMenu/FBLoginDown.png",
          onEvent = commonData.fbLoginListener
      }
      fbLoginButton.xScale =  (display.contentWidth*0.25) / fbLoginButton.width
      fbLoginButton.yScale = fbLoginButton.xScale  
      fbLoginButton.x =  fbLoginButton.x - (display.actualContentWidth - display.contentWidth) /2
      
      fbLoginButton2 = widget.newButton
      {
          x = 280,
          y = 155,
          id = "fbLoginButton2",
          defaultFile = "ExtrasMenu/FBLogin.png",
          overFile = "ExtrasMenu/FBLoginDown.png",
          onEvent = commonData.fbLoginListener
      }
      fbLoginButton2.xScale =  (display.contentWidth*0.25) / fbLoginButton2.width
      fbLoginButton2.yScale = fbLoginButton2.xScale  
      fbLoginButton2.x =  fbLoginButton2.x - (display.actualContentWidth - display.contentWidth) /2
      

      rateUsButton.alpha = 0
      fbLoginButton.alpha = 0
      

      shareButton = widget.newButton
      {
          x = 120,
          y = 278,
          id = "share",
          defaultFile = buttonsSet .. "/End/ShareScoreUp.png",
          overFile = buttonsSet .. "/End/ShareScoreDown.png",
          onEvent = nativeShareListener
      }

      shareButton.xScale =  (display.actualContentWidth*0.25) / shareButton.width
      shareButton.yScale =  shareButton.xScale-- (display.actualContentHeight*0.22) / shareButton.height


      local openPkgButton = widget.newButton
      {
          x = 360,
          y = 278,
          id = "openPkgButton",
          defaultFile = buttonsSet .. "/End/OpenPacksUp.png",
          overFile = buttonsSet .. "/End/OpenPacksDown.png",
          onEvent = packsListener
      }
     openPkgButton.xScale =  (display.actualContentWidth*0.25) / openPkgButton.width
      openPkgButton.yScale = openPkgButton.xScale  -- (display.actualContentHeight*0.22) / openPkgButton.height



      packsIndicator = display.newImage("images/PacksIndicator.png")
     
      packsIndicator:scale(0.3,0.3)

     -- packsIndicator:setFillColor(1,0,0)

      packsIndicator.x =  openPkgButton.x  - openPkgButton.contentWidth/2 + 17
      packsIndicator.y =  openPkgButton.y


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
    

    scoreText = display.newText("", 0, 0 , "UnitedSansRgHv" , 90)
    scoreText.x = 230
    scoreText.y = 180
    scoreText:setFillColor(255/255,241/255,208/255)

    scoreTextS = display.newText("", 0, 0 , "UnitedSansRgHv" , 90)
    scoreTextS.x = 230
    scoreTextS.y = 184
    scoreTextS:setFillColor(0,0,0)
    

    scoreTitleText = display.newText("", 0, 0 , "UnitedSansRgHv" , 24)
    scoreTitleText.x = 240
    scoreTitleText.y = 120
    scoreTitleText.text = "YOU REACHED:"
    scoreTitleText:setFillColor(255/255,241/255,208/255)
    
    scoreTitleTextS = display.newText("", 0, 0 , "UnitedSansRgHv" , 24)
    scoreTitleTextS.x = 240
    

    scoreTitleTextS.text = "YOU REACHED:"
    scoreTitleTextS:setFillColor(39/255,39/255,53/255)
    scoreTitleTextS.y = scoreTitleText.y + 2

    scoreTitleText.alpha = 0
    scoreTitleTextS.alpha = 0

    comboText = display.newText("", 0, 0 , "UnitedSansRgHv" , 24)
    comboText.x = 240
    comboText.y = 235
    comboText.text = ""
    comboText:setFillColor(255/255,241/255,208/255)
    
    comboTextS = display.newText("", 0, 0 , "UnitedSansRgHv" , 24)
    comboTextS.x = 240
    

    comboTextS.text = ""
    comboTextS:setFillColor(39/255,39/255,53/255)
    comboTextS.y = comboText.y + 2

    comboText.alpha = 0
    comboTextS.alpha = 0


    local coinTextOptions = 
    {
        --parent = textGroup,
        text = "",     
        x = 420,
        y = 20,
        width = 130,     --required for multi-line and alignment
        font = "UnitedSansRgHv",   
        fontSize = 20,
        align = "center"  --new alignment parameter
    }

    local highScoreTitle = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
    local  highScoreTitleShadow = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
    
    highScoreTitle:setFillColor(1,206/255,0)
    highScoreTitleShadow:setFillColor(128/255,97/255,40/255)
    highScoreTitleShadow.y = highScoreTitle.y + 2

    highScoreTitle.text = "HIGH SCORE:"
    highScoreTitleShadow.text = "HIGH SCORE:"
    
    highScoreText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
    highScoreShadowText = display.newText(coinTextOptions) -- "",0,0, "troika" , 24)
    highScoreText.y = 40
    highScoreShadowText.y = highScoreText.y + 2
    highScoreShadowText:setFillColor(69/255,69/255,69/255)

    highScoreTitle.x =   highScoreTitle.x  + (display.actualContentWidth - display.contentWidth)/2  
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
        font = "UnitedSansRgHv",   
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
      if event.target.id == "rightArrow" then
        activeScreen = activeScreen + 1
      else
        activeScreen = activeScreen + 2 -- equal to -1
      end 

      activeScreen = activeScreen % 3

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

    leftArrowButton.xScale =  (display.actualContentWidth*0.06) / leftArrowButton.width
    leftArrowButton.yScale = leftArrowButton.xScale

    leftArrowButton:rotate(180)

    local rightArrowButton = widget.newButton
    {
        x = 335,
        y = 80,
        id = "rightArrow",
        defaultFile = "images/ArrowBtnUp.png",
        overFile = "images/ArrowBtnDown.png",
        onEvent = changeScreenListener
    }

    rightArrowButton.xScale =  (display.actualContentWidth*0.06) / rightArrowButton.width
    rightArrowButton.yScale = rightArrowButton.xScale  
  --  rightArrowButton:rotate(-180)
    

    local challengesText = display.newText(boosterHeaderTextOptions)
    challengesText:setFillColor(255/255,241/255,208/255)
    challengesText.x = 240
    
    challengesText.y = 160 - background.contentHeight/2 + challengesText.contentHeight/2 + 3
    challengesText.text = "CHALLENGES" 

    chalengesTable.isConstant = true
    challengesText.isConstant = true

    local scoreScreenText = display.newText(boosterHeaderTextOptions)
    scoreScreenText:setFillColor(255/255,241/255,208/255)
    scoreScreenText.x = 240
    scoreScreenText.y = 160 - background.contentHeight/2 + scoreScreenText.contentHeight/2 + 3
    scoreScreenText.text = "SCORE" 

    local friendsScreenText = display.newText(boosterHeaderTextOptions)
    friendsScreenText:setFillColor(255/255,241/255,208/255)
    friendsScreenText.x = 240
    friendsScreenText.y = 160 - background.contentHeight/2 + friendsScreenText.contentHeight/2 + 3
    friendsScreenText.text = "TOP FRIENDS" 

    fbLoginButton2.alpha = 0
    LoginDisclamer.alpha = 0

    friendsScreenText.isConstant = true
    fbLoginButton2.isConstant = true
    LoginDisclamer.isConstant = true

    
    rightArrowButton.y = friendsScreenText.y 
    leftArrowButton.y = rightArrowButton.y 


    chalengesBox:insert(chalengesTable)
    chalengesBox:insert(challengesText)
    chalengesBox:insert(chalengesData)
    
    
    friendsBox:insert(friendsScreenText)
    friendsBox:insert(fbLoginButton2)
    friendsBox:insert(LoginDisclamer)
    friendsBox:insert(friendsData)
    
    
          

       
     sceneGroup:insert(blackRect)

     sceneGroup:insert(background)    

     scoreBox:insert(scoreScreenText)     
     scoreBox:insert(scoreTitleTextS)     
     scoreBox:insert(scoreTitleText)     
     scoreBox:insert(scoreTextS) 
     scoreBox:insert(scoreText)    
     scoreBox:insert(comboTextS) 
     scoreBox:insert(comboText)    
      
     
     
     sceneGroup:insert(highScoreTitleShadow)     
     sceneGroup:insert(highScoreTitle)     
     
     sceneGroup:insert(highScoreShadowText)     
     sceneGroup:insert(highScoreText)   

     

     sceneGroup:insert(friendsBox)     
     sceneGroup:insert(scoreBox)     
     sceneGroup:insert(chalengesBox)     
     sceneGroup:insert(confetti)   

     sceneGroup:insert(rightArrowButton)   
     sceneGroup:insert(leftArrowButton)   


       
     scoreBox.alpha = 1
     chalengesBox.alpha = 0
     friendsBox.alpha = 0
     
     sceneGroup:insert(playButton)
     
     sceneGroup:insert(shareButton)
     sceneGroup:insert(openPkgButton)
     sceneGroup:insert(menuButton)     

     sceneGroup:insert(packsIndicator)
     
       
      sceneGroup:insert(dailyRewardBlocker)

     notification:insert(boosterRect)
     
     notification:insert(boosterMsg.skeleton.group)

     notificationData:insert(boosterText)
     notificationData:insert(boosterHeaderText)     
     notificationData:insert(boosterCoinsText)     
     notificationData:insert(boosterCoinImg)   
     notificationData:insert(boosterHandImg) 
     notificationData:insert(rateUsButton) 
     notificationData:insert(fbLoginButton) 
         
     
     notificationData.x = 15
     
     notificationData:insert(boosterButton)
     notificationData:insert(boosterClose)
     
     notification:insert(notificationData)

     notification.x =   notification.x  + (display.actualContentWidth - display.contentWidth)/2  
   
     
     sceneGroup:insert(notification)
     sceneGroup:insert(loadingBlocker) 

     
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
      parent = event.parent
       local isSimulator = (system.getInfo("environment") == "simulator");
 
        
        boosterMsg.skeleton.group.alpha = 0
        notification.alpha = 0
        packsIndicator.alpha = 0

     


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


function scene:outerDrawFriends(gameData)
    --code to resume game
 buildFriendsPart(gameData)
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
 
end


---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene

