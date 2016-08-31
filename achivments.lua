local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------

-- local forward references should go here

---------------------------------------------------------------------------------

-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view


      items = {}
      items.shirts = {}
      items.shoes = {}
      items.hats = {}

      items.shirts.category = "shirts"
      items.shoes.category = "shoes"
      items.hats.category = "hats"

      items.shirts[1] = {}
      items.shirts[1].name = "red shirt"
      items.shirts[1].coinsCost = 20
      items.shirts[1].image = "blackShirt"

      items.shirts[2] = {}
      items.shirts[2].name = "blue shirt"
      items.shirts[2].coinsCost = 15
      items.shirts[2].image = "whiteShirt"

    --everything from here down to the return line is what makes
     --up the scene so... go crazy
     local background = display.newImage("images/background.png")
     background.x = 240
     background.y = 160

     
     local buyButton = display.newImage("images/playButton.png")
     buyButton.x = 440
     buyButton.y = 300
     buyButton:scale(0.25,0.25)

     categories = display.newGroup()
     slides = display.newGroup()



local widget = require( "widget" )

    sceneGroup:insert(background)
   -- sceneGroup:insert(slides)
     sceneGroup:insert(categories)     
     sceneGroup:insert(buyButton)
     --this is what gets called when playButton gets touched
     --the only thing that is does is call the transition
     --from this scene to the game scene, "downFlip" is the
     --name of the transition that the director uses
     
     local function backButtonListener( event )

      
          composer.gotoScene( "menu" )
          return true
     end

     local function buyButtonListener( event )
      
          composer.gotoScene( "menu" )
          return true
     end

   
     --this is a little bit different way to detect touch, but it works
     --well for buttons. Simply add the eventListener to the display object
     --that is the button send the event "touch", which will call the function
     --buttonListener everytime the displayObject is touched.
     
     buyButton:addEventListener("touch", buyButtonListener )
    
 
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   local sceneGroup = self.view
  local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
  local tabBarHeight = composer.getVariable( "tabBarHeight" )
  local themeID = composer.getVariable( "themeID" )

  -- Set color variables depending on theme
  tableViewColors = {
    rowColor = { default = { 1 }, over = { 30/255, 144/255, 1 } },
    lineColor = { 220/255 },
    catColor = { default = { 150/255, 160/255, 180/255, 200/255 }, over = { 150/255, 160/255, 180/255, 200/255 } },
    defaultLabelColor = { 0, 0, 0, 0.6 },
    catLabelColor = { 0 }
  }
  if ( themeID == "widget_theme_android_holo_dark" ) then
    tableViewColors.rowColor.default = { 48/255 }
    tableViewColors.rowColor.over = { 72/255 }
    tableViewColors.lineColor = { 36/255 }
    tableViewColors.catColor.default = { 80/255, 80/255, 80/255, 0.9 }
    tableViewColors.catColor.over = { 80/255, 80/255, 80/255, 0.9 }
    tableViewColors.defaultLabelColor = { 1, 1, 1, 0.6 }
    tableViewColors.catLabelColor = { 1 }
  elseif ( themeID == "widget_theme_android_holo_light" ) then
    tableViewColors.rowColor.default = { 250/255 }
    tableViewColors.rowColor.over = { 240/255 }
    tableViewColors.lineColor = { 215/255 }
    tableViewColors.catColor.default = { 220/255, 220/255, 220/255, 0.9 }
    tableViewColors.catColor.over = { 220/255, 220/255, 220/255, 0.9 }
    tableViewColors.defaultLabelColor = { 0, 0, 0, 0.6 }
    tableViewColors.catLabelColor = { 0 }
  end
  
  -- Forward reference for the tableView
  --local tableView
  
  -- Text to show which item we selected
  local itemSelected = display.newText( "User selected row ", 0, 0, native.systemFont, 16 )
  itemSelected:setFillColor( unpack(tableViewColors.catLabelColor) )
  itemSelected.x = display.contentWidth+itemSelected.contentWidth
  itemSelected.y = display.contentCenterY
  sceneGroup:insert( itemSelected )
  
  -- Function to return to the tableView
  local function goBack( event )
    transition.to( tableView, { x=display.contentWidth*0.5, time=600, transition=easing.outQuint } )
    transition.to( itemSelected, { x=display.contentWidth+itemSelected.contentWidth, time=600, transition=easing.outQuint } )
    transition.to( event.target, { x=display.contentWidth+event.target.contentWidth, time=480, transition=easing.outQuint } )
  end
  
  -- Back button
  local backButton = widget.newButton {
    width = 128,
    height = 32,
    label = "back",
    onRelease = goBack
  }
  backButton.x = display.contentWidth+backButton.contentWidth
  backButton.y = itemSelected.y+itemSelected.contentHeight+16
  sceneGroup:insert( backButton )
  
  -- Listen for tableView events
  local function tableViewListener( event )
    local phase = event.phase
    --print( "Event.phase is:", event.phase )
  end

  -- Handle row rendering
  local function onRowRender( event )
    local phase = event.phase
    local row = event.row

    local groupContentHeight = row.contentHeight
    
    local rowTitle = display.newText( row, "Row " .. row.index, 0, 0, nil, 14 )
    rowTitle.x = 10
    rowTitle.anchorX = 0
    rowTitle.y = groupContentHeight * 0.5
    if ( row.isCategory ) then
      rowTitle:setFillColor( unpack(row.params.catLabelColor) )
      rowTitle.text = rowTitle.text.." (category)"
    else
      rowTitle:setFillColor( unpack(row.params.defaultLabelColor) )
    end
  end
  
  -- Handle row updates
  local function onRowUpdate( event )
    local phase = event.phase
    local row = event.row
    --print( row.index, ": is now onscreen" )
  end
  
  -- Handle touches on the row
  local function onRowTouch( event )
    local phase = event.phase
    local row = event.target
    if ( "release" == phase ) then
      itemSelected.text = "User selected row " .. row.index
      transition.to( tableView, { x=((display.contentWidth/2)+ox+ox)*-1, time=600, transition=easing.outQuint } )
      transition.to( itemSelected, { x=display.contentCenterX, time=600, transition=easing.outQuint } )
      transition.to( backButton, { x=display.contentCenterX, time=750, transition=easing.outQuint } )
    end
  end
  
  -- Create a tableView
  tableView = widget.newTableView
  {
    top = 32-oy,
    left = -ox,
    width = display.contentWidth+ox+ox, 
    height = display.contentHeight-tabBarHeight+oy+oy-32,
    hideBackground = true,
    listener = tableViewListener,
    onRowRender = onRowRender,
    onRowUpdate = onRowUpdate,
    onRowTouch = onRowTouch,
  }
  sceneGroup:insert( tableView )

end

-- "scene:show()"
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then

      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
      if(event.params and event.params.gameData) then

            -- Create 75 rows
            for i = 1,75 do
              local isCategory = false
              local rowHeight = 32
              local rowColor = { 
                default = tableViewColors.rowColor.default,
                over = tableViewColors.rowColor.over,
              }
              -- Make some rows categories
              if i == 20 or i == 40 or i == 60 then
                isCategory = true
                rowHeight = 32
                rowColor = {
                  default = tableViewColors.catColor.default,
                  over = tableViewColors.catColor.over
                }
              end
              -- Insert the row into the tableView
              tableView:insertRow
              {
                isCategory = isCategory,
                rowHeight = rowHeight,
                rowColor = rowColor,
                lineColor = tableViewColors.lineColor,
                params = { defaultLabelColor=tableViewColors.defaultLabelColor, catLabelColor=tableViewColors.catLabelColor }
              }
            end
           
            
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

