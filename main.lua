display.setStatusBar(display.HiddenStatusBar)
--by telling Corona to require "director" we are
--telling it to include everything in that file,
--giving us easy access to its functions. This is
--also how you would include any functions or
--"classes" that you created in outside files.
local composer = require( "composer" )
local mainGroup = display.newGroup()

local commonData = require( "commonData" )
	
if ( system.getInfo("platformName") == "Android" ) then
	local licensing = require( "licensing" )
	licensing.init( "google" )
end

local main = function()
     --this creates a view that we will use to load
     --the other scenes into, so as our game progresses
     --technically we are staying in the main.lua file
     --and just loading new views or scenes into it
    -- mainGroup:insert(director.directorView)
     --we tell the director to load the first scene which
     --is going to be the menu
      composer.gotoScene( "menu" )
end
--be sure to actually call the main function

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


local function notificationListener( event )
 
    if ( event.type == "remote" ) then
        -- Handle the push notification
 
    elseif ( event.type == "local" ) then
       commonData.isTropyOnHighScore = true
 
    end
end
 
Runtime:addEventListener( "notification", notificationListener )

local launchArgs = ...
 
if ( launchArgs and launchArgs.notification ) then
    notificationListener( launchArgs.notification )
end


main()