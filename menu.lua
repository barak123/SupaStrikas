
local commonData = require( "commonData" )
local composer = require( "composer" )
local widget = require( "widget" )
--parse = require( "mod_parse" )
require( "game_config" )

--local zip = require( "plugin.zip" )
local json = require("json")
local mime=require("mime")
local openssl = require "plugin.openssl"
local isFlurryReady = false
local shouldLogOpens = false

commonData.gpgs = require( "plugin.gpgs" )
 
local function gpgsLoginListener( event )
    print( "Login event:", json.prettify(event) )

    if commonData.loadAfterLogin then
      commonData.loadAfterLogin()
    end 
end
 
local function gpgsInitListener( event )
    if not event.isError then
        -- Try to automatically log in the user without displaying the login screen
        commonData.gpgs.login( { listener = gpgsLoginListener , userInitiated=true} )
    end
end
 
commonData.gpgs.init( gpgsInitListener )

local function logAppOpens()
  local opensToAlert = {}
  opensToAlert[1] = 1  
  opensToAlert[2] = 2
  opensToAlert[3] = 3  
  opensToAlert[4] = 5  
  opensToAlert[5] = 10
  opensToAlert[6] = 15
  opensToAlert[7] = 20
  opensToAlert[8] = 25
  opensToAlert[9] = 30
  opensToAlert[10] = 40
  opensToAlert[11] = 100

  for i=1,11 do
    

    if commonData.gameData and commonData.gameData.appOpened  == opensToAlert[i]  then  
      -- print("appOpened")
      -- print(commonData.gameData.appOpened  )

         if system.getInfo("environment") ~= "simulator" then
          commonData.analytics.logEvent( "App opened " ..  tostring(commonData.gameData.appOpened) .. " times", 
            { gamesCount = tostring( commonData.gameData.gamesCount)  ,
              highScore = tostring(  commonData.gameData.highScore) ,
              totalCoins = tostring(  commonData.gameData.coins + commonData.gameData.usedcoins) ,
              avgScore =  tostring(commonData.gameData.totalScore / math.max(commonData.gameData.gamesCount, 1)) } )
        end
        -- print("app opened "  ..  tostring(commonData.gameData.appOpened) .. " times: "  .. tostring( commonData.gameData.gamesCount)  .. "," ..  tostring(  commonData.gameData.highScore)  .. "," .. 
        --      tostring(  commonData.gameData.coins + commonData.gameData.usedcoins)  .. "," .. tostring(commonData.gameData.totalScore / math.max(commonData.gameData.gamesCount, 1))) 

        break
    end  
  end  
end

local function flurryListener( event )

    if ( event.phase == "init" ) then  -- Successful initialization
        --print( event.provider )
        isFlurryReady = true
        commonData.analytics.logEvent( "appOpened" )
        if shouldLogOpens then
          logAppOpens()
          shouldLogOpens = false
        end  
    end
end

-- Initialize the Flurry plugin
commonData.analytics = require( "plugin.flurry.analytics" )
--local twitter = require "plugin.twitter"

local flurryKey =  nil 
if ( system.getInfo("platformName") == "Android" ) then
    flurryKey =  "VM9MZ6KBTM6NGD94GVJV"
 else
    flurryKey =  "J86WNYRJSSS5MMY98V2Q"
 end
commonData.analytics.init( flurryListener, { apiKey=flurryKey , crashReportingEnabled=true })




-- local mt = getmetatable(_G)
-- if mt == nil then
--   mt = {}
--   setmetatable(_G, mt)
-- end

-- __STRICT = true
-- mt.__declared = {}

-- mt.__newindex = function (t, n, v)
--   if __STRICT and not mt.__declared[n] then
--     local w = debug.getinfo(2, "S").what
--     if w ~= "main" and w ~= "C" then
--       error("assign to undeclared variable '"..n.."'", 2)
--     end
--     mt.__declared[n] = true
--   end
--   rawset(t, n, v)
-- end
  
-- mt.__index = function (t, n)
--   if not mt.__declared[n] and debug.getinfo(2, "S").what ~= "C" then
--     error("variable '"..n.."' is not declared", 2)
--   end
--   return rawget(t, n)
-- end

-- function global(...)
--    for _, v in ipairs{...} do mt.__declared[v] = true end
-- end

-- combre = require( "plugin.combre" )

-- -- Initialize Commercial Break
-- combre.init( "77fc86766d02bd370c623dd5ad4801066805e50e" )

local scene = composer.newScene()


local isFirstGame = false

local heroSpine =  nil
local hero = nil
local packsIndicator = nil
local splash = nil
local splash2 = nil
local blackRect = nil 
local isSimulator = false

commonData.isMute = false

if system.getInfo("environment") == "simulator" then
--  commonData.isMute = true
  isSimulator = true
end  

local muteButton = nil
local unMuteButton = nil
local isAppOpened = false


math.randomseed( os.time() )
commonData.isABTesting = false
commonData.globalHighScore = 0

local cipher = openssl.get_cipher ( "aes-256-cbc" )
local dataFileEncKey = "t0m y@m kun8"

--local clouds = nil
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

function encodeB64(data)
  local len = data:len()
  local t = {}
  for i=1,len,384 do
    local n = math.min(384, len+1-i)
    if n > 0 then
      local s = data:sub(i, i+n-1)
      local enc, _ = mime.b64(s)
      t[#t+1] = enc
    end
  end

  return table.concat(t)
end

function decodeB64(data)
  local len = data:len()
  local t = {}
  for i=1,len,384 do
    local n = math.min(384, len+1-i)
    if n > 0 then
      local s = data:sub(i, i+n-1)
      local dec, _ = mime.unb64(s)
      t[#t+1] = dec
    end
  end
  return table.concat(t)
end

local function loadGameScene()
  
      if (commonData.gameData) then  
        local options = {params = {gameData = commonData.gameData, isTutorial=false}}
              
        local results = composer.loadScene( "game", false, options )
      end
     
      
end


function fileExists(fileName, base)
  assert(fileName, "fileName is missing")
  local base = base or system.ResourceDirectory
  local filePath = system.pathForFile( fileName, base )
  local exists = false
 
  if (filePath) then -- file may exist. won't know until you open it
    local fileHandle = io.open( filePath, "r" )
    if (fileHandle) then -- nil if no file found
      exists = true
      io.close(fileHandle)
    end
  end
 
  return(exists)
end



-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view


commonData.selectedSkin = "Shakes"
commonData.selectedBall = "NormalBall"
commonData.selectedShoes = "Default"
commonData.selectedPants = "defaultPants"
commonData.selectedShirt = "defaultShirt"


commonData.shopSkin = commonData.selectedSkin 
commonData.shopBall = commonData.selectedBall 
commonData.shopShoes = commonData.selectedShoes
commonData.shopShirt = commonData.selectedShirt
commonData.shopPants = commonData.selectedPants

local selectMenuSound =  audio.loadSound( "BtnPress.mp3" )



--commonData.gameNetwork = require( "gameNetwork" )
local playerName
local googlePlayerId = nil

    local function onGetObject( event )

      --printTable(event)

    if  event.error == "object not found for get" then

        
    end
  end

      

local function loadLocalPlayerCallback( event )
   -- print("loadLocalPlayerCallback")
   commonData.playerName = event.data.alias
   commonData.googlePlayerId = event.data.playerID
  -- native.showAlert("debug", "logged in as " .. playerName)

   --saveSettings()  --save player data locally using your own "saveSettings()" function
   
end

-- local function gameNetworkLoginCallback( event )
--   --native.showAlert("debug","gameNetworkLoginCallback" )
--    -- print("gameNetworkLoginCallback")
--    commonData.gameNetwork.request( "loadLocalPlayer", { listener=loadLocalPlayerCallback } )
--    return true
-- end

-- local function gpgsInitCallback( event )
--    commonData.gameNetwork.request( "login", { userInitiated=true, listener=gameNetworkLoginCallback } )
--    -- native.showAlert("debug", "gpgsInitCallback")

-- end

-- local function gameNetworkSetup()
   
--    if ( system.getInfo("platformName") == "Android" ) then
--       commonData.gameNetwork.init( "google", gpgsInitCallback )
--    else
--       -- print("call gamecenter init")
--       commonData.gameNetwork.init( "gamecenter", gameNetworkLoginCallback )
--    end
-- end

------HANDLE SYSTEM EVENTS------
local function systemEvents( event )
   --print("systemEvent " .. event.type)
   if ( event.type == "applicationSuspend" ) then
     -- print( "suspending..........................." )
   elseif ( event.type == "applicationResume" ) then
      --print( "resuming............................." )
   elseif ( event.type == "applicationExit" ) then
      --print( "exiting.............................." )
   elseif ( event.type == "applicationStart" ) then
      --gameNetworkSetup()  --login to the network here
   end
   return true
end


commonData.comma_value = function (n)

  local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
  return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end


commonData.playSound = function ( soundToPlay , params)


  if not commonData.isMute then
    return audio.play(soundToPlay, params)
  end
end

commonData.buttonSound = function ()

  commonData.playSound(selectMenuSound)
end


commonData.saveTable = function (t, filename, isPostAvatar , ignoreFbStatus)

    local path = system.pathForFile( filename, system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = json.encode(t)
        local encryptedData = cipher:encrypt ( contents , dataFileEncKey )
        file:write( encryptedData )
        io.close( file )

         local function gpgsSnapshotAfterSaveListener( event )
          print( "gpgsSnapshotAfterSaveListener", json.prettify(event) )
        end
           
        local function gpgsSnapshotOpenForSaveListener( event )
            if not event.isError then
              print("about to save")
              print(contents)
              print("end of data")
                event.snapshot.contents.write( encodeB64(encryptedData) )  -- Write new data as a JSON string into the snapshot
                commonData.gpgs.snapshots.save({
                    snapshot = event.snapshot,
                    description = "Save slot " .. filename,
                    listener = gpgsSnapshotAfterSaveListener
                })
            end
        end
         
          commonData.gpgs.snapshots.open({  -- Open the save slot
              filename = filename,
              create = true,  -- Create the snapshot if it's not found
              listener = gpgsSnapshotOpenForSaveListener
          })
---            print(filename)
 --           print(contents)
      
          
        return true
    else
        return false
    end
end

commonData.loadTable =  function(filename)
    local path = system.pathForFile( filename, system.DocumentsDirectory)
    local contents = ""
    local myTable = {}
    local file = io.open( path, "r" )
    if file then
         -- read all contents of file into a string
         local contents = file:read( "*a" )
         local decryptedData = cipher:decrypt (contents , dataFileEncKey )
         myTable = json.decode(decryptedData);
         io.close( file )
         return myTable 
    end
    return nil
end


local function onKeyEvent( event )

   local phase = event.phase
   local keyName = event.keyName
   local currentSceneName = composer.getSceneName( "current" )
   --print( event.phase, event.keyName , currentSceneName)

   if ( "back" == keyName and phase == "up" ) or ("b" == keyName and phase == "down" and system.getInfo("environment") == "simulator") then
      if ( currentSceneName == "menu" ) then
         native.requestExit()
      elseif ( currentSceneName== "game" ) then
          local gameScene = composer.getScene( "game"  )
          local gameWasActive = gameScene:outerPauseGame()

          if not gameWasActive then
            
             local options = {params = {gameData = commonData.gameData}}
              commonData.playSound( selectMenuSound ) 
              composer.gotoScene( "menu" , options )
          end
            
      else  
        local options = {params = {gameData = commonData.gameData}}
          commonData.playSound( selectMenuSound ) 
          composer.gotoScene( "menu" , options )
      end
       return true
   end

   return false  --SEE NOTE BELOW
end

--add the key callback
Runtime:addEventListener( "key", onKeyEvent )
Runtime:addEventListener( "system", systemEvents )

      
    --everything from here down to the return line is what makes
     --up the scene so... go crazy
     local background = display.newImage("MainMenu/MainMenu BG.jpg")
     background.x = 240
     background.y = 160


     background.xScale = display.actualContentWidth / background.contentWidth 
     background.yScale = display.actualContentHeight  / background.contentHeight

     local abstract = display.newImage("MainMenu/Abstract.png")
     
     abstract.yScale = display.actualContentHeight  / abstract.contentHeight
     abstract.xScale = abstract.yScale
     
     abstract.x = 240 + display.actualContentWidth/2 - abstract.contentWidth/2 
     abstract.y = 160
     
     local logo = display.newImage("ExtrasMenu/Logo.png")
     
     logo.yScale = 0.15 * display.actualContentHeight  / logo.contentHeight
     logo.xScale = logo.yScale
     
     logo.x = 240 + display.actualContentWidth/2 - logo.contentWidth/2  -10
     logo.y = 160 + display.actualContentHeight/2 - logo.contentHeight/2 -10
      
     


     splash = display.newImage("images/Splash.jpg")
     splash.x = 240
     splash.y = 160


     splash.xScale = display.actualContentWidth / splash.contentWidth 
     splash.yScale = display.actualContentHeight  / splash.contentHeight



     

     
      local function nullListener( event )
      
          return true
      end

 
     splash:addEventListener("touch", nullListener )
           

     


    local widget = require( "widget" )
  
    --local hero =  require ("hero")

    --hero:init()
      local function buttonListener( event )
          
          if ( "ended" == event.phase ) then
            commonData.playSound( selectMenuSound ) 
            local isTutorial = (event.target.id == "tutorialButton") or isFirstGame

            if isTutorial then
             if isFirstGame then 
              commonData.analytics.logEvent( "startTutorial" )
              commonData.gameData.gamesCountForInstruct = 7
             else
              commonData.gameData.gamesCountForInstruct = commonData.gameData.gamesCount
              commonData.analytics.logEvent( "replayTutorial" )             
             end 
           end

            local options = {params = {gameData = commonData.gameData, isTutorial=false}}
            composer.gotoScene( "game" , options )
            isFirstGame = false

       
          end
          return true
     end

     local function leadersListener( event )
         if ( "ended" == event.phase ) then
          commonData.playSound( selectMenuSound ) 
           commonData.analytics.logEvent( "leaderboardScreen" )
           commonData.gpgs.leaderboards.show()
                    
           -- if ( system.getInfo("platformName") == "Android" ) then
           --    commonData.gameNetwork.show( "leaderboards" )
           -- else
           --    commonData.gameNetwork.show( "leaderboards", { leaderboard = {timeScope="AllTime"} } )
           -- end
          end
           return true
     end

    local function achivListener( event )
         if ( "ended" == event.phase ) then
            commonData.playSound( selectMenuSound ) 
                     
            
            commonData.gpgs.achievements.show()
           --commonData.gameNetwork.show("achievements")
           commonData.analytics.logEvent( "achievementsScreen" )
          end
           return true
     end

     local function statsListener( event )
         if ( "ended" == event.phase ) then
          commonData.playSound( selectMenuSound ) 
           commonData.analytics.logEvent( "statsScreen" )
          local options = {params = {gameData = commonData.gameData}}
          composer.gotoScene( "stats" , options )
         end 
           return true
     end
 
    local function shopListener( event )
         if ( "ended" == event.phase ) then
          commonData.playSound( selectMenuSound ) 
          
          local options = {params = {gameData = commonData.gameData}}
          composer.gotoScene( "shop" , options )
         end 
           return true
     end


     local function packsListener( event )
         if ( "ended" == event.phase ) then
          local options = {params = {gameData = commonData.gameData}}
          commonData.playSound( selectMenuSound ) 
          composer.gotoScene( "packs" , options )
         end 
           return true
     end

    
     
      local function fbLikeListener( event )
         if ( "ended" == event.phase ) then
            --isGetMeRequest = true
         --   gameData.packs = 5
             commonData.analytics.logEvent( "fbLikePressed" )
             system.openURL( "https://m.facebook.com/SupaStrikasFC" )
 
         
          end
           return true
     end

     
    
   
   
     local function muteListener( event )
         if ( "ended" == event.phase ) then

              commonData.isMute = true
              muteButton.alpha = 0              
              unMuteButton.alpha = 1
          
          end
           return true
     end

     local function unMuteListener( event )
         if ( "ended" == event.phase ) then

              commonData.isMute = false
              muteButton.alpha = 1              
              unMuteButton.alpha = 0
          
          end
           return true
     end
 
      
     local  buttonsSet = "BlueSet"
      
      -- Create the widget
      local playButton = widget.newButton
      {
          x = 160, 
          y = 110,
          id = "playButton",
          defaultFile = "MainMenu/PlayBtnUp.png",
          overFile = "MainMenu/PlayBtnDown.png",
          onEvent = buttonListener
      }

       playButton.xScale =  (display.actualContentWidth*0.45) / playButton.width
       playButton.yScale = playButton.xScale  

      -- playButton:scale( playButton.contentWidth / display.actualContentWidth  , 0.5)
      playButton.x = playButton.x - (display.actualContentWidth - display.contentWidth)/2


      local shopButton = widget.newButton
      {
          x = 160,
          y = 195,
          id = "shopButton",
          defaultFile = "MainMenu/CustomizeUp.png",
          overFile = "MainMenu/CustomizeDown.png",
          onEvent = shopListener
      }
        shopButton.xScale =  (display.actualContentWidth*0.45) / shopButton.width
       shopButton.yScale = shopButton.xScale  
       shopButton.x = shopButton.x - (display.actualContentWidth - display.contentWidth)/2

       shopButton.y =  playButton.y + shopButton.contentHeight /2  + playButton.contentHeight /2 + 5


    local packsButton = widget.newButton
      {
          x = 160,
          y = 195,
          id = "packsButton",
          defaultFile = "MainMenu/PacksUp.png",
          overFile = "MainMenu/PacksDown.png",
          onEvent = packsListener
      }
        packsButton.xScale =  (display.actualContentWidth*0.45) / packsButton.width
       packsButton.yScale = packsButton.xScale  
       packsButton.x = packsButton.x - (display.actualContentWidth - display.contentWidth)/2
       packsButton.y =  shopButton.y + packsButton.contentHeight /2  + shopButton.contentHeight /2 + 5

      packsIndicator = display.newImage("images/PacksIndicator.png")
     
      packsIndicator:scale(0.5,0.5)

     -- packsIndicator:setFillColor(1,0,0)

      packsIndicator.x =  packsButton.x + 20
      packsIndicator.y =  packsButton.y



      local leaderButton = widget.newButton
      {
          x = 160,
          y = 280,
          id = "leaderButton",
          defaultFile = "MainMenu/LeaderBoardUp.png",
          overFile = "MainMenu/LeaderBoardDown.png",
          onEvent = leadersListener
      }
       leaderButton.xScale =  (display.actualContentWidth*0.08) / leaderButton.width
      leaderButton.yScale = leaderButton.xScale  

      local achivButton = widget.newButton
      {
          x = 200,
          y  = 280,
          id = "acivButton",
          defaultFile = "MainMenu/ChallengeUp.png",
          overFile = "MainMenu/ChallengeDown.png",
          onEvent = achivListener
      }

      achivButton.xScale =  (display.actualContentWidth*0.08) / achivButton.width
      achivButton.yScale = achivButton.xScale  

      achivButton.x = leaderButton.x + leaderButton.contentWidth/2 + achivButton.contentWidth/2 + 2


      local statsButton = widget.newButton
      {
          x = 100 ,
          y = 280,
          id = "statsButton",
          defaultFile = "MainMenu/StatsUp.png",
          overFile = "MainMenu/StatsDown.png",
          onEvent = statsListener
      }
      
      statsButton.xScale =  (display.actualContentWidth*0.08) / statsButton.width
      statsButton.yScale = statsButton.xScale  

      statsButton.x = leaderButton.x - leaderButton.contentWidth/2 - statsButton.contentWidth/2 - 2
     
     
   
     

      --backButton.x = display.screenOriginX  + backButton.contentWidth /2

      


     local fbLikeButton = widget.newButton
      {
          left = 330,
          top = 180,
          id = "fbLikeButton",
          defaultFile = "ExtrasMenu/FBLike.png",
          overFile = "ExtrasMenu/FBLikeDown.png",
          onEvent = fbLikeListener
      }

      fbLikeButton.xScale =  (display.actualContentWidth*0.07) / fbLikeButton.width
      fbLikeButton.yScale = fbLikeButton.xScale  

     
      muteButton = widget.newButton
      {
          left = 280,
          top = 180,
          id = "muteButton",
          defaultFile = "ExtrasMenu/Mute.png",
          overFile = "ExtrasMenu/UnMuteDown.png",
          onEvent = muteListener
      }

       muteButton.xScale =  (display.actualContentWidth*0.07) / muteButton.width
      muteButton.yScale = muteButton.xScale 

       unMuteButton = widget.newButton
      {
          left = 280,
          top = 180,
          id = "unMuteButton",
          defaultFile = "ExtrasMenu/UnMute.png",
          overFile = "ExtrasMenu/MuteDown.png",
          onEvent = unMuteListener
      }

       unMuteButton.xScale =  (display.actualContentWidth*0.07) / unMuteButton.width
      unMuteButton.yScale = unMuteButton.xScale 
      unMuteButton.alpha = 0



    
      
      statsButton.x =  35 +   statsButton.contentWidth / 2 + 10
      leaderButton.x =  statsButton.x + statsButton.contentWidth /2 +   leaderButton.contentWidth / 2 + 10
      achivButton.x =  leaderButton.x + achivButton.contentWidth /2 +   leaderButton.contentWidth / 2 + 10
      playButton.x = leaderButton.x 
      shopButton.x = leaderButton.x
      packsButton.x = leaderButton.x
      packsIndicator.x =  packsButton.x + 60
      packsIndicator.y =  packsButton.y
      
      shopButton.xScale = playButton.xScale
      packsButton.xScale = shopButton.xScale
      shopButton.yScale = playButton.yScale
      packsButton.yScale = shopButton.yScale

      statsButton.yScale = shopButton.yScale
      leaderButton.yScale = statsButton.yScale
      achivButton.yScale = statsButton.yScale
      statsButton.xScale = shopButton.yScale
      leaderButton.xScale = statsButton.yScale
      achivButton.xScale = statsButton.yScale
      

      playButton.y = display.actualContentHeight * 0.25 - (display.actualContentHeight - display.contentHeight)/2 
      shopButton.y =  playButton.y + (playButton.contentHeight + shopButton.contentHeight)/2 + 10
      packsButton.y =  shopButton.y + (packsButton.contentHeight + shopButton.contentHeight)/2 + 10
    
       playButton.x =  240 - display.actualContentWidth/2  + playButton.contentWidth/2
       shopButton.x =  240 - display.actualContentWidth/2  + shopButton.contentWidth/2
       packsButton.x =  240 - display.actualContentWidth/2  + packsButton.contentWidth/2
       statsButton.x = 240 - display.actualContentWidth/2  + statsButton.contentWidth/2
       leaderButton.x = statsButton.x + (leaderButton.contentWidth*0.75)/2 
       achivButton.x = leaderButton.x + (leaderButton.contentWidth )/2  + 10

        muteButton.y = achivButton.y
        unMuteButton.y = achivButton.y
        fbLikeButton.y = achivButton.y
        
        muteButton.x = achivButton.x + (achivButton.contentWidth )/2  + (muteButton.contentWidth )/2   + 10
        unMuteButton.x = muteButton.x
        fbLikeButton.x = muteButton.x + (muteButton.contentWidth )/2  + fbLikeButton.contentWidth/2 + 10
      
 
      heroSpine =  require ("hero")
      hero = heroSpine.new(0.6, true,false,nil,true)
      
      hero.skeleton.group.x = 390
      hero.skeleton.group.xScale = -1

      hero.skeleton.group.x = hero.skeleton.group.x + (display.actualContentWidth - display.contentWidth)/2
      
      -- local cloudsSpine =  require ("clouds")
      -- clouds = cloudsSpine.new()

      -- clouds.skeleton.group.x = 100
      
      -- clouds.skeleton.group.y = 60

      local params = nil
      local function parseNetworkListener ()
          response = event.response
          decodedResponse = json.decode(response)
          --print (decodedResponse)

      end
      --network.request( “https://api.parse.com/1/classes/coffee” ,”GET”, parseNetworkListener, params)
      --network.request( "https://api.parse.com/little-dribble/classes/test" ,"GET", parseNetworkListener, params)
--https://www.parse.com/apps/little-dribble/collections#class/test
      
      -- local function networkListener( event )
      --       if ( event.isError ) then
      --           print( "Network error - download failed" )
      --       elseif ( event.phase == "began" ) then
      --           print( "Progress Phase: began" )
      --       elseif ( event.phase == "ended" ) then
      --           print( "Displaying response image file" )
      --           -- myImage = display.newImage( event.response.filename, event.response.baseDirectory, 60, 40 )
      --           -- myImage.alpha = 0
      --           -- transition.to( myImage, { alpha=1.0 } )
      --       end
      --   end

      --   local params = {}
      --   params.progress = true


      
      
      
     sceneGroup:insert(background)   
     sceneGroup:insert(abstract)   
     
     
     

     

     --sceneGroup:insert(clouds.skeleton.group)
   
     sceneGroup:insert(hero.skeleton.group)
     
   
     sceneGroup:insert(playButton)
     
     sceneGroup:insert(achivButton)
     sceneGroup:insert(leaderButton) 
     sceneGroup:insert(statsButton)
     sceneGroup:insert(shopButton)
     sceneGroup:insert(packsButton)
     sceneGroup:insert(packsIndicator)
     sceneGroup:insert(logo)   
     
     
     
           
      sceneGroup:insert(fbLikeButton)
      
      sceneGroup:insert(muteButton)
      sceneGroup:insert(unMuteButton)

     
     sceneGroup:insert(splash)
     if splash2 then
    
       sceneGroup:insert(blackRect) 
       sceneGroup:insert(splash2)
     end



     
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

   local function removeSplash()
      if splash then
          splash:removeSelf()
          splash = nil
          loadGameScene()
      end
    
   end

   local function loadRemoteTable(filename , callback )

        local function gpgsSnapshotOpenForReadListener( event )
           print( "gpgsSnapshotOpenForReadListener")
            if event.isError then
              callback(commonData.loadTable(filename))
            else  
                local data = event.snapshot.contents.read() 

                  
                  local decryptedData = cipher:decrypt (decodeB64(data) , dataFileEncKey )
                  print( decryptedData)
                  myTable = json.decode(decryptedData);

                 
                  print( "Read successfully")
                  print( "myTable:", json.prettify(myTable) )
                  
                callback(myTable)
            end
        end
 
       if isSimulator or not commonData.gpgs.isConnected() then
        print( "Load From Local")
        callback(commonData.loadTable(filename))
       else
        print( "Load From Remote")
          commonData.gpgs.snapshots.open({
              filename = filename,
              listener = gpgsSnapshotOpenForReadListener
          })
        end
    end   

    local function loadShopData(shopData )
       commonData.shopItems = shopData

          if ( not commonData.shopItems) then 
            commonData.shopItems = {}

          end  

          commonData.shopItems["Shakes"] =true
          --commonData.shopItems["Neymar"] =true
          
          commonData.shopItems["Default"] =true
          
          commonData.shopItems["NormalBall"] =true
          commonData.shopItems["White"] =true
          
       
          if (not commonData.gameData.selectedSkin or not commonData.shopItems[commonData.gameData.selectedSkin]) then
            commonData.gameData.selectedSkin = "Shakes"
          end

          if (not commonData.gameData.selectedBall or not commonData.shopItems[commonData.gameData.selectedBall]) then
            commonData.gameData.selectedBall = "NormalBall"
          end

           if (not commonData.gameData.selectedShoes or not commonData.shopItems[commonData.gameData.selectedShoes]) then
            commonData.gameData.selectedShoes = "Default"
           end

           if (not commonData.gameData.selectedPants or not commonData.shopItems[commonData.gameData.selectedPants]) then
            commonData.gameData.selectedPants = "defaultPants"
           end

           if (not commonData.gameData.selectedShirt or not commonData.shopItems[commonData.gameData.selectedShirt]) then
              commonData.gameData.selectedShirt = "defaultShirt"
           end

          

         commonData.selectedSkin =   commonData.gameData.selectedSkin 
         
         commonData.selectedBall = commonData.gameData.selectedBall
         commonData.selectedShoes = commonData.gameData.selectedShoes
         commonData.selectedShirt = commonData.gameData.selectedShirt
         commonData.selectedPants = commonData.gameData.selectedPants


         hero:pause()
         hero:reload()
         hero:init()

    end  

    local function loadGameData(data )
     commonData.gameData = data

          if ( not commonData.gameData) then 
            commonData.gameData = {}
            commonData.gameData.highScore = 0
            commonData.gameData.coins = 0
            commonData.gameData.usedcoins = 0
            commonData.gameData.usedpacks = 0 
            commonData.gameData.packs = 0
            commonData.gameData.fbPacks = false
            commonData.gameData.packsBought = 0             
            commonData.gameData.gamesCount = 0
            commonData.gameData.totalScore = 0
            commonData.gameData.bounces = 0
            commonData.gameData.bouncesPerfect = 0
            commonData.gameData.bouncesGood = 0
            commonData.gameData.bouncesEarly = 0
            commonData.gameData.bouncesLate = 0
            commonData.gameData.jumps = 0
            commonData.gameData.adsPressed = 0
            commonData.gameData.madePurchase = false
            commonData.gameData.daysInARow = false
            
            commonData.gameData.unlockedAchivments = {}
            commonData.gameData.unlockedChallenges = {}
            commonData.gameData.selectedSkin = "Shakes"
            commonData.gameData.selectedBall = "NormalBall"
            commonData.gameData.selectedShoes = "Default"
            commonData.gameData.selectedPants = "default"
            commonData.gameData.selectedShirt = "defaultShirt"

            
            
            commonData.gameData.appOpened = 0
          end  

          isFirstGame = (commonData.gameData.gamesCount==0)
         
        
          

          if (not commonData.gameData.packs ) then
            commonData.gameData.packs = 1
          end

          if (not commonData.gameData.packsBought ) then
             commonData.gameData.packsBought = 0
          end
         
          if (not commonData.gameData.usedcoins ) then
            commonData.gameData.usedcoins = 0
          end

          if (not commonData.gameData.usedpacks ) then
            commonData.gameData.usedpacks = 0
          end

          if (not commonData.gameData.adsPressed ) then
            commonData.gameData.adsPressed = 0
          end

          if (not commonData.gameData.daysInARow ) then
            commonData.gameData.daysInARow = 0
          end

          if (not commonData.gameData.appOpened ) then
            commonData.gameData.appOpened = 0
          end

           if (not commonData.gameData.appOpened ) then
            commonData.gameData.appOpened = 0
          end

          if (not commonData.gameData.highestCombo ) then
            commonData.gameData.highestCombo = 0
          end


          loadRemoteTable(SHOP_FILE , loadShopData)        
          
         
        if not isAppOpened then
          commonData.gameData.appOpened = commonData.gameData.appOpened + 1
          commonData.saveTable(commonData.gameData, GAME_DATA_FILE , nil , true)

          if isFlurryReady then
            logAppOpens()
          else

             shouldLogOpens = true
          end  

        end  

         commonData.globalHighScore = commonData.gameData.highScore 


        if (commonData.gameData.packs > 0) then
          -- TOOD: remove
          packsIndicator.alpha = 0
        else  
          packsIndicator.alpha = 0
        end
        
   end

    local function removeSplash2()
      
      if splash2 then
          splash2:removeSelf()
          splash2 = nil          
          blackRect:removeSelf()
          blackRect = nil
      end      
   end

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
      hero:reload()
      local removeTimer  = 0

      if splash2 then
        timer.performWithDelay(2300, removeSplash2, 1)
        removeTimer  = 2000
      end
     
          
     timer.performWithDelay(2000 + removeTimer, removeSplash, 1)
     
     
   elseif ( phase == "did" ) then
    --print("shoooowowiwiw   selectedSkin")
    hero:init()
      hero:menuIdle()

       if splash then
        local splashSound =  audio.loadSound( "sounds/123 Supa Strikas.wav" )
        commonData.playSound(splashSound)
      end
  
    --clouds:init()
       if (commonData.gameData) then 
         commonData.globalHighScore = commonData.gameData.highScore 

          if (commonData.gameData.packs > 0) then
            -- TOOD: remove
            packsIndicator.alpha = 0
          else  
            packsIndicator.alpha = 0
          end
        
       else 

          print("no game data")
          loadRemoteTable(GAME_DATA_FILE , loadGameData)        

          commonData.loadAfterLogin = function ( )
            print("loadAfterLogin")
            loadRemoteTable(GAME_DATA_FILE , loadGameData)        
          end
       end -- end common data not exists

      
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
       --print("menuuuuusuububuubu hideeeee1")
        hero:pause()

   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
     
      --print("menuuuuusuububuubu hideeeee")

      --clouds:pause()
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

