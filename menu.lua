
local commonData = require( "commonData" )
local composer = require( "composer" )
local widget = require( "widget" )
--parse = require( "mod_parse" )
require( "game_config" )
local facebook = require( "plugin.facebook.v4" )
local zip = require( "plugin.zip" )
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
local fbAppID = "608674832569283"  --"612089632227803" -- prod -->"608674832569283"  --replace with your Facebook App ID
commonData.friendsScore = {}
commonData.accessTokenFromFacebookLogin = nil
commonData.facebook_user_id = nil
local isFirstLogin =true
local isFullLogin =false
local isFirstResponse =true
local isGetMeRequest = true
local isGetScores = false
local isGetAvatars = false

local isFirstGame = false
local isShopBackup = false
local isShopRestore = false

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
local fbConected = nil
local isLoginFromToken = false
local extraBackground = nil
local extrasGroup = nil

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

function submitHighScoreToFacebook()

  -- print("====================submit highScore=====================")
  -- print(facebook_user_id)


  -- print(accessTokenFromFacebookLogin)
  -- print(globalHighScore)
  if (commonData.accessTokenFromFacebookLogin and commonData.facebook_user_id and commonData.globalHighScore)  then

          local function fbNetworkListener( event )
              if ( event.isError ) then
  --                print( "submit error" )

              elseif ( event.phase == "began" ) then
    --              print( "Progress Phase: began" )
              elseif ( event.phase == "ended" ) then
      --            print( "score submitted" )
                
              end
            end
      --print ("submit hige score of ".. globalHighScore)         
      local params = {}
      params.body = "&score=".. commonData.globalHighScore .."&access_token=".. commonData.accessTokenFromFacebookLogin
      

      --TODO: remove
      -- network.request( "https://graph.facebook.com/".. commonData.facebook_user_id .. "/scores", "POST", fbNetworkListener, params)

                
  end
end 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

local function facebookListener( event )

  local maxStr = 20   -- set maximum string length
  local endStr
  
  for k,v in pairs( event ) do
    local valueString = tostring(v)
    
      endStr = ")"
    --print( "   " .. tostring( k ) .. "(" .. tostring( valueString ) .. endStr )
  end

    -- print( "event.name:" .. event.name )  --"fbconnect"
    -- print( "isError: " .. tostring( event.isError ) )

    -- print( "didComplete: " .. tostring( event.didComplete ) )
    -- print( "event.type:" .. event.type )  --"session", "request", or "dialog"
    --"session" events cover various login/logout events
    --"request" events handle calls to various Graph API calls
    --"dialog" events are standard popup boxes that can be displayed
 
    if ( "session" == event.type ) then
        --options are "login", "loginFailed", "loginCancelled", or "logout"
        if ( "login" == event.phase ) then
           commonData.accessTokenFromFacebookLogin = event.token
           if (isFirstLogin) then
             isFirstLogin = false
             isGetMeRequest = true
             isGetAvatars = false
             isPostAvatar = false
             isGetScores = false
             facebook.login(  facebookListener, {"publish_actions" } )
      
           else
            if (isGetMeRequest ) then
                facebook.request("me")

            else
              --local scoreParams = {fields="score,user.fields(id,name,picture)"}
              --facebook.request(fbAppID .."/scores","GET",scoreParams)
            end  

           end 
            --code for tasks following a successful login
        end

    elseif ( "request" == event.type ) then
        --print("facebook request")


            local response = json.decode( event.response )
            --printTable( response, "User Info", 3 )
      

        
        if ( not event.isError ) then
        
            if (isGetMeRequest ) then
                isFirstLogin = false
                
                commonData.facebook_user_id = response.id
                isGetMeRequest = false
                isGetAvatars = false
                isGetScores = true
                isPostAvatar = false
                isShopRestore = false
                isShopBackup = false


               
                local scoreParams = {fields="score,user.fields(id,name,picture,littledribble:customize.limit(1))"}
                facebook.request(fbAppID .."/scores","GET",scoreParams)            
                
            elseif  (isShopRestore) then
               
                  --print("restoreShop")
                if #response.data == 0 then
                  -- create new shop object
                else
                  
                  if response.data[1] and  response.data[1].data and response.data[1].data.shopitems then
                    --print("have data")
                    local decodeditems = decodeB64(response.data[1].data.shopitems)
                    local decryptedData = cipher:decrypt (decodeditems , dataFileEncKey )
                    local serverShopItems = json.decode(decryptedData);

                    for k,v in pairs(serverShopItems) do
                      --print(k)
                      commonData.shopItems[k] = v
                    end
                    
                    commonData.saveTable(commonData.shopItems , SHOP_FILE)

                  end  
                end
                isShopRestore = false
             elseif  (isShopBackup) then 
              isShopBackup = false

              
              if response.id  then
                commonData.gameData.shopObjId = response.id 
              
              end 
             elseif  (isPostAvatar) then 
              isPostAvatar = false

               if response.id  then
                commonData.gameData.avatarObjId = response.id               
              end 

            elseif isGetAvatars then
              isGetAvatars = false  
              commonData.avatars = response    

                  
              -- If the connected to fb from the game over screen
              local currentSceneName = composer.getSceneName( "current" )
                if ( currentSceneName== "game" ) then
                    local gameOverScene = composer.getScene( "gameOver"  )

                    if (gameOverScene) then
                     gameOverScene:outerDrawFriends(commonData.gameData)

                     if (not commonData.gameData.fbPacks) then
                       commonData.gameData.packs = commonData.gameData.packs + 1
                       commonData.gameData.fbPacks = true
                       commonData.saveTable(commonData.gameData , GAME_DATA_FILE)
                     end
                    end 
                end    

            

            elseif isGetScores  then-- get scores

                       --print ("************ got friends ************* "  )  
                      isFullLogin = true
                      isGetScores = false
                      isLoginFromToken = false
                      fbConected.alpha = 1

                      if (not commonData.gameData.isConnectedToFB) then
                       commonData.analytics.logEvent( "fbFullLogin" )
                        commonData.gameData.isConnectedToFB = true                
                      end

                      submitHighScoreToFacebook()

                      commonData.friendsScore = {}

                      local avatarIds = ""
                      local pAvatarId = nil

                      local isAvatarExists = false
                      if response.data then

                        
                            for i=1,#response.data do
                                

                              
                                if response.data[i].user["littledribble:customize"] and 
                                     response.data[i].user["littledribble:customize"].data[1] and
                                     response.data[i].user["littledribble:customize"].data[1].data.avatar then

                                     pAvatarId = response.data[i].user["littledribble:customize"].data[1].data.avatar.id
                                     avatarIds = avatarIds .. pAvatarId .. ","
                                     isAvatarExists = true
                        
                                else
                                  pAvatarId = nil     
                        
                                end 

                                 if (commonData.facebook_user_id ~= response.data[i].user.id) then
                        


                                    commonData.friendsScore[response.data[i].score] = {name = response.data[i].user.name ,
                                                                            picUrl = response.data[i].user.picture.data.url,
                                                                            id = response.data[i].user.id, 
                                                                            avatarId = pAvatarId,
                                                                            rank = i
                                                                          }
                                      -- print ("get friend : " .. response.data[i].user.name )  
                                      -- print("friends num : " .. commonData.friendsScore[response.data[i].score].name  )

                                      --printTable(commonData.friendsScore)

                                      if (not fileExists(commonData.friendsScore[response.data[i].score].id .. ".jpg")) then

                                          local function downloadImgListener( event )
                                          end

                                          network.download(
                                             commonData.friendsScore[response.data[i].score].picUrl,
                                             "GET",
                                             downloadImgListener,
                                             nil,
                                             commonData.friendsScore[response.data[i].score].id .. ".jpg",
                                             system.TemporaryDirectory
                                          )
                                      end    
                                  end
                            end
                      end     


                      if isAvatarExists then
                       
                        isGetAvatars = true                
                        isPostAvatar = false
                        local avatarParams = {ids= string.sub(avatarIds, 1, -2)}
                     
                        facebook.request("me","GET",avatarParams)
                      end


            else
                --print ("*************** unknown response *****************")  
            end  
        else
        end

    elseif ( "dialog" == event.type ) then
        --print( "dialog", event.response )
        --handle dialog results here
    end
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

local selectMenuSound = nil

selectMenuSound = audio.loadSound( "BtnPress.mp3" )


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


commonData.shopBackup = function (shopDataToStore , encryptedData )

  --print(tostring(shopDataToStore))
      local function onCreateObject( event )

       -- printTable(event)
         
       end
       --local dataTable = { ["id"] = 123 }
       --parse:createObject( "test", dataTable, onCreateObject )
        

      --   local function onGetObjects( event )

      --     printTable(event)
      --   if not event.error then
      --      local dataTable = { ["googleUser"] = googlePlayerId , ["shopData"] = tostring(shopDataToStore) }
           
      --     if  #event.results == 0 then
      --       parse:createObject( "shop", dataTable, onCreateObject )
      --     else
      --        parse:updateObject( "shop", event.results[1].objectId, dataTable, onCreateObject )
      --     end  

          
         
      --   end
      -- end
      -- local queryTable = { 
      --   ["where"] = { ["googleUser"] =  googlePlayerId  }
      -- }

      -- backup to parse if have googleID
      -- if (googlePlayerId) then
      --   parse:getObjects( "shop", queryTable, onGetObjects )
      -- end

      -- backup to facebook graph
      
      if (isFullLogin) then
      --   local attachment = {
      --   name = "Developing a Facebook Connect app using the Corona SDK!",
      --   link = "http://www.coronalabs.com/links/forum",
      --   caption = "Link caption",
      --   description = "Corona SDK for developing iOS and Android apps with the same code base.",
      --   picture = "http://www.coronalabs.com/links/demo/Corona90x90.png",
      --   actions = json.encode( { { name = "Learn More", link = "http://coronalabs.com" } } )
      -- }
                 
            isGetMeRequest = false
            isGetScores = false
            isGetAvatars = false
            isShopBackup = true
            isShopRestore = false


--            {"og:url":"http:\/\/samples.ogp.me\/703237053113060","og:title":"Sample Avatar","og:type":"littledribble:avatar","og:image":"https:\/\/fbstatic-a.akamaihd.net\/images\/devsite\/attachment_blank.png","og:description":"","fb:app_id":608674832569283,"littledribble:shoes":"Sample shoes"}
             -- local params = {
             --  object='{"og:url":"http://samples.ogp.me/678908255545940","og:title":"Sample Shop",' ..
             --                      '"og:type":"littledribble:shop","og:shopitems":"","og:image":"https://fbstatic-a.akamaihd.net/images/devsite/attachment_blank.png","og:description":"","fb:app_id":608674832569283}'}
              
            -- local encodedShopDataToStore  = string.gsub(shopDataToStore, "\"", "&quot;")
             local jsonToFb = "{\"og:url\":\"http://www.facebook.com/Little-Dribble-860357334028562\",\"og:title\":\"Little Dribble\"," ..
                                  "\"og:type\":\"littledribble:shop\",\"littledribble:shopitems\":\"" ..  tostring(encodeB64(encryptedData)) ..
                      "\",\"og:image\":\"https://fbstatic-a.akamaihd.net/images/devsite/attachment_blank.png\",\"og:description\":\"\",\"fb:app_id\":608674832569283}"
              --print(jsonToFb)                      
             local params = {object= jsonToFb}
             

            -- local params = {
            --   object  = json.encode( { ogurl = "http://samples.ogp.me/678908255545940",
            --                            ogtitle = "Dribble Shop" ,
            --                            ogtype = "littledribble:shop",
            --                            ogshopitems = shopDataToStore,
            --                            ogimage = "https://fbstatic-a.akamaihd.net/images/devsite/attachment_blank.png",
            --                            ogdescription = "",
            --                            fbapp_id = 608674832569283

            --                         } )  }          
             if  commonData.gameData.shopObjId  then
                facebook.request(tostring(commonData.gameData.shopObjId),"POST",params)            
             else 
                  facebook.request("me/objects/littledribble:shop","POST",params)            
              end
       end
end

local function restoreShop( )
    
            

      -- local function onGetObjects( event )

      --     printTable(event)
      --   if not event.error then
           
      --     if  #event.results > 0 then
           
      --       local serverShopItems = json.decode(event.results[1].shopData)

      --       for k,v in pairs(serverShopItems) do
      --         shopItems[k] = v
      --       end
            
      --       saveTable(shopItems , SHOP_FILE)
      --     end  
         
      --   end
      -- end

      -- if googlePlayerId then
      --       local queryTable = { 
      --         ["where"] = { ["googleUser"] =  googlePlayerId  }
      --       }
      --       parse:getObjects( "shop", queryTable, onGetObjects )  
      -- end 

      if isFullLogin then

        isGetMeRequest = false
        isShopBackup = false
        isShopRestore = true
        isGetScores = false
        isGetAvatars = false
       facebook.request("me/objects/littledribble:shop","GET")                    
     end  
end

commonData.saveTable = function (t, filename, isPostAvatar , ignoreFbStatus)

    if filename == GAME_DATA_FILE then

      if not ignoreFbStatus then

        t.isConnectedToFB = isFullLogin 
      end
        if isPostAvatar then
            isGetMeRequest = false
            isShopBackup = false
            isShopRestore = false
            isGetAvatars = false
            isPostAvatar = true
            isGetScores = false



--            {"og:url":"http:\/\/samples.ogp.me\/703237053113060","og:title":"Sample Avatar","og:type":"littledribble:avatar","og:image":"https:\/\/fbstatic-a.akamaihd.net\/images\/devsite\/attachment_blank.png","og:description":"","fb:app_id":608674832569283,"littledribble:shoes":"Sample shoes"}
            
             local jsonToFb = "{\"og:url\":\"http://www.facebook.com/Little-Dribble-860357334028562\",\"og:title\":\"Little Dribble\"," ..
                                  "\"og:type\":\"littledribble:avatar\",\"littledribble:shoes\":\"" .. commonData.selectedShoes ..
                      "\",\"littledribble:skin\":\"" .. commonData.selectedSkin .."\", \"littledribble:ball\":\"" .. commonData.selectedBall ..
                      "\",\"littledribble:shirt\":\"" .. commonData.selectedShirt .."\", \"littledribble:pants\":\"" .. commonData.selectedPants  ..
                      "\",\"og:image\":\"https://fbstatic-a.akamaihd.net/images/devsite/attachment_blank.png\",\"og:description\":\"\",\"fb:app_id\":608674832569283}"
              --print(jsonToFb)                      
             local params = {avatar= jsonToFb}
             

            -- local params = {
            --   object  = json.encode( { ogurl = "http://samples.ogp.me/678908255545940",
            --                            ogtitle = "Dribble Shop" ,
            --                            ogtype = "littledribble:shop",
            --                            ogshopitems = shopDataToStore,
            --                            ogimage = "https://fbstatic-a.akamaihd.net/images/devsite/attachment_blank.png",
            --                            ogdescription = "",
            --                            fbapp_id = 608674832569283

            --                         } )  }          
            
             if  commonData.gameData.avatarObjId  then
                facebook.request(tostring(commonData.gameData.avatarObjId),"POST",params)            
             else 
                facebook.request("me/littledribble:customize","POST",params)   
             end
             
        end     

    end  

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
        if filename == SHOP_FILE and not isShopRestore then

          commonData.shopBackup(contents,encryptedData )
         -- print(tostring(encodeB64(encryptedData)))
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

      extrasGroup = display.newGroup()
  
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
      
     


     splash = display.newImage("images/Splash.jpg")
     splash.x = 240
     splash.y = 160


     splash.xScale = display.actualContentWidth / splash.contentWidth 
     splash.yScale = display.actualContentHeight  / splash.contentHeight



     

     
      local function nullListener( event )
      
          return true
      end

 
     splash:addEventListener("touch", nullListener )
           

     local extras = display.newImage("ExtrasMenu/ExtasWindow.png")
     extras.x = 380
     extras.y = 160


     extras.yScale =  display.actualContentHeight / extras.contentHeight
     extras.xScale = extras.yScale



     --extras.x = display.screenOriginX  + display.actualContentWidth - extras.contentWidth /2


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

            local options = {params = {gameData = commonData.gameData, isTutorial=isTutorial}}
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
                     
            -- facebook.showDialog( "requests", 
            --     { 
            --         message = "You should download this game!",
            --         filter = "APP_NON_USERS"
            --     })

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

    local function moreListener( event )
         if ( "ended" == event.phase ) then
          commonData.playSound( selectMenuSound ) 
          
          extrasGroup.alpha= 1 - extrasGroup.alpha

          extraBackground.alpha= 0.01 - extraBackground.alpha
         end 
           return true
     end

    local function settingsListener( event )
         if ( "ended" == event.phase ) then

         end 
           return true
     end
     
      local function fbLikeListener( event )
         if ( "ended" == event.phase ) then
            --isGetMeRequest = true
         --   gameData.packs = 5
             commonData.analytics.logEvent( "fbLikePressed" )
             system.openURL( "https://m.facebook.com/Little-Dribble-860357334028562" )
 
         
          end
           return true
     end

     commonData.doFbLogin = function () 

        if facebook.isActive then

                   facebook.setFBConnectListener( facebookListener )
                    
                    commonData.analytics.logEvent( "fbLoginPressed" )
                    local accessToken = facebook.getCurrentAccessToken()
                    if ( accessToken ) then


                        -- print ("have fb token - get friends")
                        -- printTable( accessToken, "User Info", 3 )
                        
                        commonData.accessTokenFromFacebookLogin =  accessToken.token 
                        commonData.facebook_user_id = accessToken.userId  
                        isFullLogin = true
                        fbConected.alpha = 1
                        isGetMeRequest = false
                        isGetAvatars = false
                        isPostAvatar = false
                        isGetScores = true
                        isLoginFromToken = true
                       local scoreParams = {fields="score,user.fields(id,name,picture,littledribble:customize.limit(1))"}
                       facebook.request(fbAppID .."/scores","GET",scoreParams)

                    else
                       isFirstLogin = true
                       isGetMeRequest = true
                       isGetScores = false
                       facebook.login(  facebookListener, { "user_friends" } )
            
                      --  facebook.login( facebookListener )
                    end
             end       
             
     end 

     local fbLoginCounter = 3

     commonData.doFbLogin2 = function() 

        --print(" ********* Try to login **************** : " .. fbLoginCounter)
        if facebook.isActive then

                   facebook.setFBConnectListener( facebookListener )
                    
                    commonData.analytics.logEvent( "fbLoginPressed" )
                    local accessToken = facebook.getCurrentAccessToken()
                    if ( accessToken ) then


                        -- print ("have fb token - get friends")
                        -- printTable( accessToken, "User Info", 3 )
                        
                        commonData.accessTokenFromFacebookLogin =  accessToken.token 
                        commonData.facebook_user_id = accessToken.userId  
                        isFullLogin = true
                        isLoginFromToken = true
                        fbConected.alpha = 1
                        isGetMeRequest = false
                        isGetAvatars = false
                        isPostAvatar = false
                        isGetScores = true
                       local scoreParams = {fields="score,user.fields(id,name,picture,littledribble:customize.limit(1))"}
                       facebook.request(fbAppID .."/scores","GET",scoreParams)

                    else
                       if (fbLoginCounter > 0) then

                         timer.performWithDelay(5000, commonData.doFbLogin2 , 1)
                         fbLoginCounter = fbLoginCounter - 1
                       else  
                        timer.performWithDelay(1, commonData.doFbLogin , 1)
                       end
                      --  facebook.login( facebookListener )
                    end
             end       
             
     end 

     commonData.fbLoginListener = function ( event )
         if ( "ended" == event.phase ) then
            --print("fbLogin")
            commonData.doFbLogin() 

             
          end
           return true
     end

    local function tweetListener( event )
         if ( "ended" == event.phase ) then
             commonData.analytics.logEvent( "tweetFollowPressed" )
             --isABTesting = not isABTesting

              -- twitter.login(function()  twitter.follow("LittleDribbleRV", 
              --   function()
              --      commonData.analytics.logEvent( "tweetFollowSucceed" )
              --   end  ) end)         
          
          end
           return true
     end

    local function restoreListener( event )
         if ( "ended" == event.phase ) then
             commonData.analytics.logEvent( "restoreShopPressed" )
         
            restoreShop()       
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


     --fbAudienceNetwork = require( "plugin.fbAudienceNetwork" )
     --print( "require audiance network")

           -- Pre-declare a placement ID
      commonData.placementID = "608674832569283_710307765739322"

      local function adListener( event )
       --     print( "barak" )
            printTable(event)

          if ( event.phase == "init" ) then  -- Successful initialization
         --     print( event.isError )
              -- Load a banner ad
              --fbAudienceNetwork.load( "interstitial", placementID )

          elseif ( event.phase == "loaded" ) then  -- The ad was successfully loaded
              -- print( event.type )
              -- print( event.placementId )

          elseif ( event.phase == "failed" ) then  -- The ad failed to load
              -- print( event.type )
              -- print( event.placementId )
              -- print( event.isError )
              -- print( event.response )
          end
      end


      
      -- Initialize the Facebook Audience Network
      --fbAudienceNetwork.init( adListener , "2d23566016dda2b6f917aaf19aa0b645,893596c6d3c57ee55057c65d76889931a868ccea")
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
     
     
      local settingsButton = widget.newButton
      {
          x = 35,
          y = 280,
          id = "settingsButton",
          defaultFile = buttonsSet .. "/Main/OptionsUp.png",
          overFile = buttonsSet .. "/Main/OptionsDown.png",
          onEvent = settingsListener
      }

      settingsButton.xScale =  (display.actualContentWidth*0.08) / settingsButton.width
      settingsButton.yScale = settingsButton.xScale  
     
      local moreButton = widget.newButton
      {
          x = 440,
          y = 280,
          id = "moreButton",
          defaultFile = buttonsSet .. "/Main/OptionsUp.png", -- MoreUp.png
          overFile = buttonsSet .. "/Main/OptionsDown.png", -- MoreDown.png
          onEvent = moreListener
      }

      --backButton.x = display.screenOriginX  + backButton.contentWidth /2

      
      moreButton.yScale =  achivButton.contentHeight / moreButton.contentHeight
      moreButton.xScale = moreButton.yScale  

      --moreButton.x = moreButton.x + (display.actualContentWidth - display.contentWidth) /2
     

      local lessButton = widget.newButton
      {
          x = 440,
          y = 273,
          id = "lessButton",
          defaultFile = "ExtrasMenu/Back.png",
          overFile = "ExtrasMenu/BackDown.png",
          onEvent = moreListener
      }

      lessButton.xScale =  (display.actualContentWidth*0.03) / lessButton.width
      lessButton.yScale = lessButton.xScale  

     -- lessButton.x = lessButton.x + (display.actualContentWidth - display.contentWidth) /2



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

     local tweetFollowButton = widget.newButton
      {
          left = 380,
          top = 180,
          id = "tweetFollowButton",
          defaultFile = "ExtrasMenu/TweetFollow.png",
          overFile = "ExtrasMenu/TweetFollowDown.png",
          onEvent = tweetListener
      }

       tweetFollowButton.xScale =  (display.actualContentWidth*0.07) / tweetFollowButton.width
      tweetFollowButton.yScale = tweetFollowButton.xScale 

      muteButton = widget.newButton
      {
          left = 280,
          top = 180,
          id = "tweetFollowButton",
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
          id = "tweetFollowButton",
          defaultFile = "ExtrasMenu/UnMute.png",
          overFile = "ExtrasMenu/MuteDown.png",
          onEvent = unMuteListener
      }

       unMuteButton.xScale =  (display.actualContentWidth*0.07) / unMuteButton.width
      unMuteButton.yScale = unMuteButton.xScale 
      unMuteButton.alpha = 0



      local fbLoginButton = widget.newButton
      {
          left = 225,
          top = 100,
          id = "fbLoginButton",
          defaultFile = "ExtrasMenu/FBLogin.png",
          overFile = "ExtrasMenu/FBLoginDown.png",
          onEvent = commonData.fbLoginListener
      }

      fbLoginButton.xScale =  (display.actualContentWidth*0.25) / fbLoginButton.width
      fbLoginButton.yScale = fbLoginButton.xScale 

      fbConected = display.newImage("ExtrasMenu/Connected.png")
      local function nullListener( event )      
          return true
       end

       fbConected.width = fbLoginButton.contentWidth
       fbConected.height = fbLoginButton.contentHeight
       fbConected.x = fbLoginButton.x
       fbConected.y = fbLoginButton.y

       fbConected:addEventListener("touch", nullListener )

       if isFullLogin then
        fbConected.alpha = 1
       else 
         fbConected.alpha = 0
       end


      local restoreButton = widget.newButton
      {
          left = 225,
          top = 142,
          id = "restoreButton",
          defaultFile = "ExtrasMenu/RestoreUp.png",
          overFile = "ExtrasMenu/RestoreDown.png",
          onEvent = restoreListener
      }

      restoreButton.xScale =  (display.actualContentWidth*0.25) / restoreButton.width
      restoreButton.yScale = restoreButton.xScale 

      local tutorialButton = widget.newButton
      {
          left = 225,
          top = 70,
          id = "tutorialButton",
         defaultFile = "ExtrasMenu/ReplayTutorial.png",
          overFile = "ExtrasMenu/ReplayTutorialDown.png",
          onEvent = buttonListener
      }

      tutorialButton.xScale =  (display.actualContentWidth*0.25) / tutorialButton.width
      tutorialButton.yScale = tutorialButton.xScale 

      settingsButton.x =  settingsButton.x - (display.actualContentWidth - display.contentWidth)/2
      statsButton.x =  settingsButton.x + settingsButton.contentWidth /2 +   statsButton.contentWidth / 2 + 10
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
      moreButton.xScale = statsButton.xScale
      moreButton.yScale = statsButton.yScale


      playButton.y = display.actualContentHeight * 0.25 - (display.actualContentHeight - display.contentHeight)/2 
      shopButton.y =  playButton.y + (playButton.contentHeight + shopButton.contentHeight)/2 + 10
      packsButton.y =  shopButton.y + (packsButton.contentHeight + shopButton.contentHeight)/2 + 10
    
       playButton.x =  240 - display.actualContentWidth/2  + playButton.contentWidth/2
       shopButton.x =  240 - display.actualContentWidth/2  + shopButton.contentWidth/2
       packsButton.x =  240 - display.actualContentWidth/2  + packsButton.contentWidth/2
       statsButton.x = 240 - display.actualContentWidth/2  + statsButton.contentWidth/2
       leaderButton.x = statsButton.x + (leaderButton.contentWidth*0.75)/2 
       achivButton.x = leaderButton.x + (leaderButton.contentWidth )/2  + 10

        moreButton.x = display.screenOriginX  + display.actualContentWidth - moreButton.contentWidth /2


       local function boosterRectListener( event )   
         extrasGroup.alpha = 0 
         extraBackground.alpha = 0  
            return true
       end

      extraBackground = display.newRect(240, 160, 700,400)
      extraBackground:setFillColor(0, 0, 0)
      extraBackground.alpha = 0
      extraBackground:addEventListener("touch", boosterRectListener )

      extrasGroup:insert(extras)
      extrasGroup:insert(tutorialButton)
      extrasGroup:insert(fbLoginButton)
      extrasGroup:insert(restoreButton)
      extrasGroup:insert(fbConected)
      
      extrasGroup:insert(fbLikeButton)
      extrasGroup:insert(tweetFollowButton)      
      extrasGroup:insert(muteButton)
      extrasGroup:insert(unMuteButton)
      extrasGroup:insert(lessButton)
      
      
      
      extrasGroup.alpha = 0
      extrasGroup.x =  extrasGroup.x + (display.actualContentWidth - display.contentWidth)/2 + 13
      extrasGroup.y =  extrasGroup.y + 10
      
      -- parse:init({ 
      -- appId = "eUQ1wmy1Mio3KVYrXl2ZlaKNh7UmjYt4AGqZ3Lwy", 
      -- apiKey = "qRa4UQVUUTnVfbjTUYFONj32G9bihakGoRr172TC"
      -- })

      -- parse.showStatus = true
      
      -- parse:appOpened()
      -- -- log events
      

    
      --twitter.init("BSwidOskNjdyNfvQd9QpPbnSe", "BrFDGYkWIHywcvrpedjkfg8pWI0YrJzYEXEnr0RlL3uM72tS8r")


      heroSpine =  require ("hero")
      hero = heroSpine.new(0.6, true)
      
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


      
      settingsButton.alpha = 0 
      
     sceneGroup:insert(background)   
     sceneGroup:insert(abstract)   
     

     

     --sceneGroup:insert(clouds.skeleton.group)
   
     sceneGroup:insert(hero.skeleton.group)
     sceneGroup:insert(extraBackground)
   
     sceneGroup:insert(playButton)
     
     sceneGroup:insert(achivButton)
     sceneGroup:insert(leaderButton) 
     sceneGroup:insert(statsButton)
     sceneGroup:insert(shopButton)
     sceneGroup:insert(packsButton)
     sceneGroup:insert(packsIndicator)
     
     
     sceneGroup:insert(settingsButton)
     sceneGroup:insert(moreButton)
     sceneGroup:insert(extrasGroup)
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
          commonData.shopItems["DribbleGirl"] =true
          
          
          commonData.shopItems["defaultPants"] =true
          commonData.shopItems["Default"] =true
          commonData.shopItems["defaultShirt"] =true
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

            
            commonData.gameData.isConnectedToFB  = false
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
          

         -- timer.performWithDelay(5000,function()

                 --print ("fb timer reached")
         if commonData.gameData.isConnectedToFB  then
             --print ("was logged in")
            commonData.doFbLogin2()
          end 
 
         --end,1)


         
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


         if (isFullLogin and not isLoginFromToken) then

                            --print ("get friends after game")
                      isGetMeRequest = false
                      isGetAvatars = false
                      isGetScores = true
                      isPostAvatar = false
                      isLoginFromToken = false
                       local scoreParams = {fields="score,user.fields(id,name,picture,littledribble:customize.limit(1))"}
                       facebook.request(fbAppID .."/scores","GET",scoreParams)            
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
     extrasGroup.alpha = 0 
     extraBackground.alpha = 0  
     
   elseif ( phase == "did" ) then
    --print("shoooowowiwiw   selectedSkin")
    hero:init()
      hero:menuIdle()
  
    --clouds:init()
       if (commonData.gameData) then 
         commonData.globalHighScore = commonData.gameData.highScore 

          if (commonData.gameData.packs > 0) then
            -- TOOD: remove
            packsIndicator.alpha = 0
          else  
            packsIndicator.alpha = 0
          end

         if (isFullLogin and not isLoginFromToken) then

                            --print ("get friends after game")
                      isGetMeRequest = false
                      isGetAvatars = false
                      isGetScores = true
                      isPostAvatar = false
                      isLoginFromToken = false
                       local scoreParams = {fields="score,user.fields(id,name,picture,littledribble:customize.limit(1))"}
                       facebook.request(fbAppID .."/scores","GET",scoreParams)            
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

