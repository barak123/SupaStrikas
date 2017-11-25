
local commonData = require( "commonData" )
local composer = require( "composer" )
local widget = require( "widget" )

require( "game_config" )

require "translation"

--local zip = require( "plugin.zip" )
local json = require("json")
local mime=require("mime")
local openssl = require "plugin.openssl"
local isFlurryReady = false
local shouldLogOpens = false
local packsButton = nil
local playButton = nil
local shopButton = nil 

commonData.catalog = require("catalog")

if ( system.getInfo("platformName") == "Android" ) then
  commonData.gpgs = require( "plugin.gpgs" )
end
 
local function gpgsLoginListener( event )
    

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
 
 if ( system.getInfo("platformName") == "Android" ) then
   commonData.gpgs.init( gpgsInitListener )
 end

commonData.kidoz = require( "plugin.kidoz" )
 
local function adListener( event )
 
    if ( event.phase == "init" ) then  -- Successful initialization
        
        -- Load a KIDOZ panel view ad
        commonData.kidoz.load( "panelView", { adPosition="top" } )
 
    elseif ( event.phase == "loaded" ) then  -- The ad was successfully loaded
        
        -- Show the ad
        
    end
end
 
-- Initialize the KIDOZ plugin
commonData.kidoz.init( adListener, { publisherID="13196", securityToken="RS408BBtfq9irLxdzygpjsxHomwskU1W" } )

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
      
         if system.getInfo("environment") ~= "simulator" then
           local version = ""
             if  commonData.gameData.abVersion then
                 version = " in version " .. tostring( commonData.gameData.abVersion)
             end
             
          commonData.analytics.logEvent( "App opened " ..  tostring(commonData.gameData.appOpened) .. " times" .. version, 
            { gamesCount = tostring( commonData.gameData.gamesCount)  ,
              highScore = tostring(  commonData.gameData.highScore) ,
              totalCoins = tostring(  commonData.gameData.coins + commonData.gameData.usedcoins) ,
              avgScore =  tostring(commonData.gameData.totalScore / math.max(commonData.gameData.gamesCount, 1)) } )
        end
        
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
local levelCostText = nil
local levelNameText = nil


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



local prevMem = 0
 local memUsed = 0 
-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view


commonData.selectedSkin = "Klaus"
commonData.selectedBall = "NormalBall"
commonData.selectedField = "Stadium"
commonData.selectedBooster = "fireBall"

 -- timer.performWithDelay(1000 , 
 --      function (  )
 --            prevMem = memUsed
 --             memUsed = (collectgarbage("count"))            
 --             local texUsed = system.getInfo( "textureMemoryUsed" ) / 1048576 -- Reported in Bytes
 --           print( string.format("%.00f", texUsed) .. " / " .. memUsed .. " / " .. memUsed - prevMem)
        
 --      end, -1)

commonData.shopSkin = commonData.selectedSkin 
commonData.shopBall = commonData.selectedBall 

local selectMenuSound =  audio.loadSound( "BtnPress.mp3" )



commonData.gameNetwork = require( "gameNetwork" )
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

local function gameNetworkLoginCallback( event )
  --native.showAlert("debug","gameNetworkLoginCallback" )
   -- print("gameNetworkLoginCallback")
   commonData.gameNetwork.request( "loadLocalPlayer", { listener=loadLocalPlayerCallback } )
   return true
end

-- local function gpgsInitCallback( event )
--    commonData.gameNetwork.request( "login", { userInitiated=true, listener=gameNetworkLoginCallback } )
--    -- native.showAlert("debug", "gpgsInitCallback")

-- end

local function gameNetworkSetup()
   
   if ( system.getInfo("platformName") ~= "Android" ) then
   --    commonData.gameNetwork.init( "google", gpgsInitCallback )
   -- else
      -- print("call gamecenter init")
      commonData.gameNetwork.init( "gamecenter", gameNetworkLoginCallback )
   end
end

------HANDLE SYSTEM EVENTS------
local function systemEvents( event )
   --print("systemEvent " .. event.type)
   if ( event.type == "applicationSuspend" ) then
     -- print( "suspending..........................." )
   elseif ( event.type == "applicationResume" ) then
      --print( "resuming............................." )
   elseif ( event.type == "applicationExit" ) then
      commonData.analytics.logEvent( "SessionEnd", { gamesCount= tostring( commonData.gameData.gamesCount) ,                                                  
                                                highScore= tostring(  commonData.gameData.highScore) ,
                                                reason= tostring(commonData.gameData.appOpened)  } )

      if commonData.gameData.appOpened == 1 then
        commonData.analytics.logEvent( "FirstSessionEnd", { gamesCount= tostring( commonData.gameData.gamesCount) ,                                                  
                                                highScore= tostring(  commonData.gameData.highScore) ,
                                                reason= tostring(commonData.gameData.appOpened) ,
             perfectRatio = string.format("%.00f" , 100 * commonData.gameData.bouncesPerfect / math.max(commonData.gameData.bounces, 1)) .. "%"  
                                                 } )

      end  

   elseif ( event.type == "applicationStart" ) then
      gameNetworkSetup()  --login to the network here
   end
   return true
end


commonData.comma_value = function (n)

  local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
  return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

commonData.getLevel = function ()
  
  -- 50(n+n^2) - score =0
  local d = 2500 + 200 *  commonData.gameData.totalMeters
  local root1  = -0.5 + math.sqrt(d) / 100
  --local root1  = -0.5 - math.sqrt(d) / 100
  
  return math.floor(root1)
end

commonData.getLevelName = function (lvl)
  if lvl < 5 then
    return "ROOKIE"
  elseif lvl < 10 then
    return "BEGINNER"  
  elseif lvl < 15 then
    return "TALENTED"  
  elseif lvl < 20 then  
    return "ADVANCED"  
  elseif lvl < 25 then  
    return "PROFESSIONAL"  
  elseif lvl < 30 then  
    return "EXPERT"  
  elseif lvl < 35 then  
    return "MASTER"      
  else
    return "SUPA STRIKA" 
  end  
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
          --print( "gpgsSnapshotAfterSaveListener", json.prettify(event) )
        end
           
        local function gpgsSnapshotOpenForSaveListener( event )
            if not event.isError then
              -- print("about to save")
              -- print(contents)
              -- print("end of data")
                event.snapshot.contents.write( encodeB64(encryptedData) )  -- Write new data as a JSON string into the snapshot
                commonData.gpgs.snapshots.save({
                    snapshot = event.snapshot,
                    description = "Save slot " .. filename,
                    listener = gpgsSnapshotAfterSaveListener
                })
            end
        end
         
         if ( system.getInfo("platformName") == "Android" ) then
          commonData.gpgs.snapshots.open({  -- Open the save slot
              filename = filename,
              create = true,  -- Create the snapshot if it's not found
              listener = gpgsSnapshotOpenForSaveListener
          })
---            print(filename)
 --           print(contents)
        end
          
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
           
                    
           if ( system.getInfo("platformName") == "Android" ) then
              --commonData.gameNetwork.show( "leaderboards" )
              commonData.gpgs.leaderboards.show()
           else
              commonData.gameNetwork.show( "leaderboards", { leaderboard = {timeScope="AllTime"} } )
           end
          end
           return true
     end

    local function achivListener( event )
         if ( "ended" == event.phase ) then
              commonData.playSound( selectMenuSound ) 
             
             if ( system.getInfo("platformName") == "Android" ) then
              --commonData.gameNetwork.show( "leaderboards" )
              commonData.gpgs.achievements.show()
           else
              commonData.gameNetwork.show("achievements")
           end
        
            
            
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
 
      local gradient = {
          type="gradient",
          color2={ 255/255,241/255,208/255,1}, color1={ 1, 180/255, 0,1 }, direction="up"
      }

     local  buttonsSet = "BlueSet"
      
      -- Create the widget
       playButton = widget.newButton
      {
          x = 160, 
          y = 110,
          id = "playButton",
          -- defaultFile = "MainMenu/PlayBtnUp.png",
          -- overFile = "MainMenu/PlayBtnDown.png",
          onEvent = buttonListener,
          defaultFile = "MainMenu/EmptyBtnUp.png",          
         overFile = "MainMenu/EmptyBtnDown.png",
          
          label = getTransaltedText("Play"),
          --labelAlign = "left",
          font = "UnitedItalicRgHv",  
          fontSize = 80 , 
          labelXOffset = -80,
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } }

      }

       playButton.xScale =  (display.actualContentWidth*0.45) / playButton.width
       playButton.yScale = playButton.xScale  

      -- playButton:scale( playButton.contentWidth / display.actualContentWidth  , 0.5)
      playButton.x = playButton.x - (display.actualContentWidth - display.contentWidth)/2


      shopButton = widget.newButton
      {
          x = 160,
          y = 195,
          id = "shopButton",
          -- defaultFile = "MainMenu/CustomizeUp.png",
          -- overFile = "MainMenu/CustomizeDown.png",
          onEvent = shopListener,
          defaultFile = "MainMenu/EmptyBtnUp.png",          
           overFile = "MainMenu/EmptyBtnDown.png",
          
          
          label = getTransaltedText("Shop"),
          --labelAlign = "left",
          font = "UnitedItalicRgHv",  
          fontSize = 64 , 
          --labelXOffset = 120,
          labelColor = { default={ gradient}, over={ 255/255,241/255,208/255 } }
      }

        shopButton.xScale =  (display.actualContentWidth*0.32) / shopButton.width
       shopButton.yScale = shopButton.xScale  
       shopButton.x = shopButton.x - (display.actualContentWidth - display.contentWidth)/2

       shopButton.y =  playButton.y + shopButton.contentHeight /2  + playButton.contentHeight /2 + 5


     packsButton = widget.newButton
      {
          x = 160,
          y = 195,
          id = "packsButton",
          -- defaultFile = "MainMenu/PacksUp.png",
          -- overFile = "MainMenu/PacksDown.png",
          onEvent = packsListener,
          defaultFile = "MainMenu/EmptyBtnUp.png",          
          overFile = "MainMenu/EmptyBtnDown.png",
          
          
          label = getTransaltedText("Packs"),
          --labelAlign = "left",
          font = "UnitedItalicRgHv",  
          fontSize = 64 , 
          --labelXOffset = 150,
          labelColor = { default={ gradient }, over={ 255/255,241/255,208/255 } }
      }

       packsButton.xScale =  (display.actualContentWidth*0.25) / packsButton.width
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
      leaderButton.yScale =(display.actualContentHeight *0.1) / leaderButton.height
       leaderButton.xScale =  leaderButton.yScale 
      

      local achivButton = widget.newButton
      {
          x = 200,
          y  = 280,
          id = "acivButton",
          defaultFile = "MainMenu/ChallengeUp.png",
          overFile = "MainMenu/ChallengeDown.png",
          onEvent = achivListener
      }

    

       achivButton.yScale = (display.actualContentHeight *0.1) / achivButton.height 
      achivButton.xScale =  achivButton.yScale 
     

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

      
      statsButton.yScale = (display.actualContentHeight *0.1) / statsButton.height
      statsButton.xScale =   statsButton.yScale
      

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

      fbLikeButton.yScale = (display.actualContentHeight *0.1) / fbLikeButton.height
      fbLikeButton.xScale =  fbLikeButton.yScale
    
     
      muteButton = widget.newButton
      {
          left = 280,
          top = 180,
          id = "muteButton",
          defaultFile = "ExtrasMenu/UnMute.png",
          overFile = "ExtrasMenu/UnMuteDown.png",
          onEvent = muteListener
      }

       
      muteButton.yScale = (display.actualContentHeight *0.1) / muteButton.height
      muteButton.xScale =  muteButton.yScale 

       unMuteButton = widget.newButton
      {
          left = 280,
          top = 180,
          id = "unMuteButton",
          defaultFile = "ExtrasMenu/Mute.png",
          overFile = "ExtrasMenu/MuteDown.png",
          onEvent = unMuteListener
      }

       
      unMuteButton.yScale = (display.actualContentHeight *0.1) / unMuteButton.height
      unMuteButton.xScale =   unMuteButton.yScale 

      unMuteButton.alpha = 0

      local changeLangGroup = display.newGroup()

      local function changeLangListener( event )
         if ( "ended" == event.phase ) then
              commonData.playSound( selectMenuSound ) 
              changeLangGroup.alpha = 1 - changeLangGroup.alpha          
          end
           return true
      end

      local function pickLangListener( event )
         if ( "ended" == event.phase ) then
              commonData.playSound( selectMenuSound ) 
              commonData.gameData.language = event.target.id
              --setTransalteLang(event.target.id)  
              changeLangGroup.alpha = 0
              
               playButton:setLabel(getTransaltedText("Play")) 
               shopButton:setLabel(getTransaltedText("Shop")) 
               packsButton:setLabel(getTransaltedText("Packs")) 

               playButton.labelAlign = "left"
               commonData.saveTable(commonData.gameData, GAME_DATA_FILE , nil , true)
          end
           return true
      end
      

      local changeLangButton = widget.newButton
      {
          left = 380,
          top = 180,
          id = "changeLangButton",
          defaultFile = "ExtrasMenu/LangUp.png",
          overFile = "ExtrasMenu/LangDown.png",
          onEvent = changeLangListener
      }

       
      changeLangButton.yScale = (display.actualContentHeight *0.1) / changeLangButton.height
      changeLangButton.xScale =  changeLangButton.yScale 




    
      
      statsButton.x =  35 +   statsButton.contentWidth / 2 + 10
      leaderButton.x =  statsButton.x + statsButton.contentWidth /2 +   leaderButton.contentWidth / 2 + 10
      achivButton.x =  leaderButton.x + achivButton.contentWidth /2 +   leaderButton.contentWidth / 2 + 10
      playButton.x = leaderButton.x 
      shopButton.x = leaderButton.x
      packsButton.x = leaderButton.x
      packsIndicator.x =  packsButton.x + 60
      packsIndicator.y =  packsButton.y
      
      -- shopButton.xScale = playButton.xScale
      -- packsButton.xScale = shopButton.xScale
      -- shopButton.yScale = playButton.yScale
      -- packsButton.yScale = shopButton.yScale

      -- statsButton.yScale = shopButton.yScale
      -- leaderButton.yScale = statsButton.yScale
      -- achivButton.yScale = statsButton.yScale
      -- statsButton.xScale = shopButton.yScale
      -- leaderButton.xScale = statsButton.yScale
      -- achivButton.xScale = statsButton.yScale
      

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
        changeLangButton.y  = achivButton.y
        
        muteButton.x = achivButton.x + (achivButton.contentWidth )/2  + (muteButton.contentWidth )/2   + 10
        unMuteButton.x = muteButton.x
        fbLikeButton.x = muteButton.x + (muteButton.contentWidth )/2  + fbLikeButton.contentWidth/2 + 10
        changeLangButton.x  = fbLikeButton.x + (changeLangButton.contentWidth )/2  + fbLikeButton.contentWidth/2 + 10
      

      local  playIcon = display.newImage("MainMenu/IcoPlay.png")
      local  shopIcon = display.newImage("MainMenu/IcoShop.png")
      local  packsIcon = display.newImage("MainMenu/IcoPacks.png")


      playIcon.yScale = (playButton.contentHeight * 0.5) / playIcon.contentHeight 
      playIcon.xScale = playIcon.yScale
      playIcon.y = playButton.y 
      playIcon.x = playButton.x - playButton.contentWidth/2 + playIcon.contentWidth/2 + 3

      shopIcon.yScale = (shopButton.contentHeight * 0.5) / shopIcon.contentHeight 
      shopIcon.xScale = shopIcon.yScale
      shopIcon.y = shopButton.y
      shopIcon.x = shopButton.x - shopButton.contentWidth/2 + shopIcon.contentWidth/2  + 3
      
       packsIcon.yScale = (packsButton.contentHeight * 0.5) / packsIcon.contentHeight 
      packsIcon.xScale = packsIcon.yScale
      packsIcon.y = packsButton.y
      packsIcon.x = packsButton.x - packsButton.contentWidth/2 + packsIcon.contentWidth/2  + 6


      local  langBar = display.newImage("ExtrasMenu/LangBar.png")
      langBar.yScale = (display.actualContentHeight *0.1) / langBar.height      
       langBar.xScale = langBar.yScale
       changeLangGroup:insert(langBar)
       langBar.y = changeLangButton.y - (changeLangButton.contentHeight )/2  - langBar.contentHeight/2  
       langBar.x  = changeLangButton.x 
      

      local allLanguages = {"en","he","es","de","fr","ar","ru","it","pl","pt"}

      for i=1,#allLanguages do
        local pickLangButton = widget.newButton
          {
              x = changeLangButton.x + (changeLangButton.contentWidth )/2 - 158  + 25 * i,
              y = langBar.y,
              id = allLanguages[i],
              defaultFile = "images/languages/" .. allLanguages[i] .. ".png",
              --overFile = "ExtrasMenu/UnMuteDown.png",
              onEvent = pickLangListener
          }
          changeLangGroup:insert(pickLangButton)
      end

      changeLangGroup.alpha = 0


      
      -- playText.x = playButton.x
      -- playText.y = playButton.y

      -- snapshot.x = playButton.x
      -- snapshot.y = playButton.y

     local levelBar = display.newImage("MainMenu/MainMenuLelBar.png")
     
     levelBar.yScale = (display.actualContentWidth*0.35) / levelBar.width
     levelBar.xScale = levelBar.yScale
     
     levelBar.x = 240 - display.actualContentWidth/2  + levelBar.contentWidth/2
     levelBar.y = playButton.y - levelBar.contentHeight/2 - playButton.contentHeight/2  + 2
      
      local levelTextOptions = 
        {         

            text = "",     
            width = levelBar.contentWidth - 15,            
            font = "UnitedSansRgHv",   
            fontSize = 10,
            align = "left"  --new alignment parameter
        }

      levelCostText = display.newText(levelTextOptions) -- "",0,0, "UnitedSansRgHv" , 24)
      levelCostText.text = "LVL 0"

      levelCostText.x =  levelBar.x
      levelCostText.y = levelBar.y 
      levelCostText:setFillColor(1,0,0)
      

      local levelTextOptions2 = 
        {         

            text = "",     
            width = levelBar.contentWidth -30,
            align="right",
            font = "UnitedSansRgHv",   
            fontSize = 10            
        }

      levelNameText = display.newText(levelTextOptions2) -- "",0,0, "UnitedSansRgHv" , 24)
      levelNameText.text = "SUPA STRIKA!"

      levelNameText.x =  levelBar.x
      levelNameText.y = levelBar.y 
      levelNameText:setFillColor(1,0,0)
      heroSpine =  require ("hero")
      hero = heroSpine.new(0.6, true,false,nil,true)
      
      hero.skeleton.group.x = 390
      hero.skeleton.group.xScale = -1

      hero.skeleton.group.x = hero.skeleton.group.x + (display.actualContentWidth - display.contentWidth)/2
      
     
      
     sceneGroup:insert(background)   
     sceneGroup:insert(abstract)   
     
     
     

     

     --sceneGroup:insert(clouds.skeleton.group)
   
     sceneGroup:insert(hero.skeleton.group)
     
      
     sceneGroup:insert(levelBar)
     sceneGroup:insert(levelCostText)
     sceneGroup:insert(levelNameText)
     
     
     sceneGroup:insert(playButton)
     
     sceneGroup:insert(achivButton)
     sceneGroup:insert(leaderButton) 
     sceneGroup:insert(statsButton)
     sceneGroup:insert(shopButton)
     sceneGroup:insert(packsButton)
     sceneGroup:insert(packsIndicator)
     sceneGroup:insert(logo)   

     sceneGroup:insert(playIcon)   
     sceneGroup:insert(shopIcon)   
     sceneGroup:insert(packsIcon)   
     --sceneGroup:insert(snapshot)   
           
      sceneGroup:insert(fbLikeButton)
      
      sceneGroup:insert(muteButton)
      sceneGroup:insert(unMuteButton)
      sceneGroup:insert(changeLangGroup)
      sceneGroup:insert(changeLangButton)
      
      
      

 
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
          local shopHdl = require("shop")
          shopHdl:initStore()
          loadGameScene()
      end
    
   end

   local function loadRemoteTable(filename , callback )

        local function gpgsSnapshotOpenForReadListener( event )
           
            if event.isError then
              callback(commonData.loadTable(filename))
            else  
                local data = event.snapshot.contents.read() 

                  
                  local decryptedData = cipher:decrypt (decodeB64(data) , dataFileEncKey )
                  
                  myTable = json.decode(decryptedData);

                 
                callback(myTable)
            end
        end
 
       if isSimulator or  system.getInfo("platformName") ~= "Android" or not commonData.gpgs.isConnected() then
        
        callback(commonData.loadTable(filename))
       else
        
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

          commonData.shopItems["Klaus"] =true
          commonData.shopItems["Stadium"] =true
          commonData.shopItems["fireBall"] =true
          commonData.shopItems["NormalBall"] =true
          
       
          if (not commonData.gameData.selectedSkin or not commonData.shopItems[commonData.gameData.selectedSkin]) then
            commonData.gameData.selectedSkin = "Klaus"
          end

          if (not commonData.gameData.selectedBall or not commonData.shopItems[commonData.gameData.selectedBall]) then
            commonData.gameData.selectedBall = "NormalBall"
          end

          if (not commonData.gameData.selectedBooster or not commonData.shopItems[commonData.gameData.selectedBooster]) then
            commonData.gameData.selectedBooster = "fireBall"
          end

          if (not commonData.gameData.selectedField or not commonData.shopItems[commonData.gameData.selectedField]) then
            commonData.gameData.selectedField = "Stadium"
          end

         commonData.selectedSkin =   commonData.gameData.selectedSkin 
         
         commonData.selectedBall = commonData.gameData.selectedBall

         commonData.selectedBooster = commonData.gameData.selectedBooster

         commonData.selectedField = commonData.gameData.selectedField


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
            commonData.gameData.gems = 0
            commonData.gameData.usedgems = 0
            commonData.gameData.usedpacks = 0 
            commonData.gameData.packs = 0
            commonData.gameData.fbPacks = false
            commonData.gameData.packsBought = 0             
            commonData.gameData.gamesCount = 0
            commonData.gameData.totalScore = 0
            commonData.gameData.totalMeters = 0
            commonData.gameData.bounces = 0
            commonData.gameData.bouncesPerfect = 0
            commonData.gameData.bouncesGood = 0
            commonData.gameData.bouncesEarly = 0
            commonData.gameData.bouncesLate = 0
            commonData.gameData.jumps = 0
            commonData.gameData.adsPressed = 0
            commonData.gameData.madePurchase = false
            commonData.gameData.daysInARow = false
            commonData.gameData.language = system.getPreference( "locale", "language" )
            commonData.gameData.unlockedAchivments = {}
            commonData.gameData.unlockedChallenges = {}
            commonData.gameData.selectedSkin = "Klaus"
            commonData.gameData.selectedBall = "NormalBall"
            commonData.gameData.selectedField = "Stadium"
            commonData.gameData.selectedBooster = "fireBall"
            
            commonData.gameData.appOpened = 0  
            commonData.gameData.abVersion = 3
          end  

          isFirstGame = (commonData.gameData.gamesCount==0)
         
        
          if (not commonData.gameData.packs ) then
            commonData.gameData.packs = 0
          end

          if (not commonData.gameData.language ) then
           commonData.gameData.language = system.getPreference( "locale", "language" )
          end
          playButton:setLabel(getTransaltedText("Play")) 
          shopButton:setLabel(getTransaltedText("Shop")) 
          packsButton:setLabel(getTransaltedText("Packs")) 

          if (not commonData.gameData.packsBought ) then
             commonData.gameData.packsBought = 0
          end
         
          if (not commonData.gameData.usedcoins ) then
            commonData.gameData.usedcoins = 0
          end

          if (not commonData.gameData.usedgems ) then
            commonData.gameData.usedgems = 0
          end

          if (not commonData.gameData.gems ) then
            commonData.gameData.gems = 0
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

          if (not commonData.gameData.totalMeters ) then
            commonData.gameData.totalMeters = 0
          end

          local lvl = commonData.getLevel() 
          levelCostText.text = "LVL " .. lvl
          levelNameText.text =  commonData.getLevelName(lvl)
         

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
    
    hero:init()
      hero:menuIdle()

       if splash then
        local splashSound =  audio.loadSound( "sounds/123 Supa Strikas.mp3" )
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

          
          loadRemoteTable(GAME_DATA_FILE , loadGameData)        

          commonData.loadAfterLogin = function ( )
            
            loadRemoteTable(GAME_DATA_FILE , loadGameData)        
          end
       end -- end common data not exists

      
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.

      if commonData.gameData and commonData.gameData.totalMeters then
        local lvl = commonData.getLevel() 
            levelCostText.text = "LVL " .. lvl
            levelNameText.text =  commonData.getLevelName(lvl)
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
       --
        hero:pause()

   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
     
      

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

