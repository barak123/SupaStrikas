
      packCategories = {}
      packCategories[1] = {}
      packCategories[2] = {}
      packCategories[3] = {}
      packCategories[4] = {}
      
      items = {}
      items.shirts = {}
      items.shoes = {}
      items.skins = {}
      items.balls = {}
     
      items.pants = {}


      items.shirts.category = "shirts"
      items.shoes.category = "shoes"
      items.balls.category = "balls"
      items.skins.category = "skins"
      items.pants.category = "pants"

      items.shirts.index = 2
      items.shoes.index = 4
      items.balls.index = 5
      items.skins.index = 1
      items.pants.index = 3


      seletedCategory = "skins"
    
	local shirtIdx = 1
	
    items.shirts[shirtIdx] = {}
    items.shirts[shirtIdx].name = "red shirt"
    items.shirts[shirtIdx].coinsCost = 0
    items.shirts[shirtIdx].image = "images/shop/shirts/DefaultShirt.png"
    items.shirts[shirtIdx].id = "defaultShirt"
    items.shirts[shirtIdx].shirt = "default"
    --items.shirts[1].color = {r=math.random(100)/100,g=math.random(100)/100,b=math.random(100)/100}              
    items.shirts[shirtIdx].packCategory = 9
    
-- 	shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "white shirt"
--     items.shirts[shirtIdx].coinsCost = 200
--     items.shirts[shirtIdx].image = "images/shop/shirts/White.png"
--     items.shirts[shirtIdx].id = "White"
--     items.shirts[shirtIdx].shirt = "White"
--     items.shirts[shirtIdx].packChance = 30 
--     items.shirts[shirtIdx].packCategory = 9

--     shirtIdx =shirtIdx +  1
-- 	items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "black shirt"
--     items.shirts[shirtIdx].coinsCost = 250
--     items.shirts[shirtIdx].image = "images/shop/shirts/Black.png"
--     items.shirts[shirtIdx].id = "Black"
--     items.shirts[shirtIdx].shirt = "Black"
--     items.shirts[shirtIdx].packCategory = 4
        
-- 	shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "yellow shirt"
--     items.shirts[shirtIdx].coinsCost = 300
--     items.shirts[shirtIdx].image = "images/shop/shirts/Yellow.png"
--     items.shirts[shirtIdx].id = "Yellow"
--     items.shirts[shirtIdx].shirt = "Yellow"
--     items.shirts[shirtIdx].packCategory = 4
    
-- 	shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "blue shirt"
--     items.shirts[shirtIdx].coinsCost = 350
--     items.shirts[shirtIdx].image = "images/shop/shirts/Blue.png"
--     items.shirts[shirtIdx].id = "Blue"
--     items.shirts[shirtIdx].shirt = "Blue"
--     items.shirts[shirtIdx].packCategory = 4
    
-- 	shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "Love"
--     items.shirts[shirtIdx].coinsCost = 400
--     items.shirts[shirtIdx].image = "images/shop/shirts/Pink.png"
--     items.shirts[shirtIdx].id = "Pink"
--     items.shirts[shirtIdx].shirt = "Pink"
--     items.shirts[shirtIdx].packCategory = 4
    
-- 	shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "The Ref"
--     items.shirts[shirtIdx].coinsCost = 500
--     items.shirts[shirtIdx].image = "images/shop/shirts/REF.png"
--     items.shirts[shirtIdx].id = "REF"
--     items.shirts[shirtIdx].shirt = "REF"
--     items.shirts[shirtIdx].packCategory = 4
  
--   shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "Super Dribbler"
--     items.shirts[shirtIdx].coinsCost = 500
--     items.shirts[shirtIdx].image = "images/shop/shirts/SuperDribbler.png"
--     items.shirts[shirtIdx].id = "SuperDribbler"
--     items.shirts[shirtIdx].shirt = "SuperDribbler"
--     items.shirts[shirtIdx].packCategory = 4
  
--   shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "Green Hood"
--     items.shirts[shirtIdx].coinsCost = 500
--     items.shirts[shirtIdx].image = "images/shop/shirts/GreenHood.png"
--     items.shirts[shirtIdx].id = "GreenHood"
--     items.shirts[shirtIdx].shirt = "GreenHood"
--     items.shirts[shirtIdx].packCategory = 4
  
--   shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "Red Jacket"
--     items.shirts[shirtIdx].coinsCost = 500
--     items.shirts[shirtIdx].image = "images/shop/shirts/RedJacketRect.png"
--     items.shirts[shirtIdx].id = "RedJacket"
--     items.shirts[shirtIdx].shirt = "RedJacket"
--     items.shirts[shirtIdx].packCategory = 4
  
--   shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "Neon"
--     items.shirts[shirtIdx].coinsCost = 500
--     items.shirts[shirtIdx].image = "images/shop/shirts/SportBlackYellow.png"
--     items.shirts[shirtIdx].id = "SportBlackYellow"
--     items.shirts[shirtIdx].shirt = "SportBlackYellow"
--     items.shirts[shirtIdx].packCategory = 4
  
--   shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "Smile"
--     items.shirts[shirtIdx].coinsCost = 500
--     items.shirts[shirtIdx].image = "images/shop/shirts/Smile.png"
--     items.shirts[shirtIdx].id = "Smile"
--     items.shirts[shirtIdx].shirt = "Smile"
--     items.shirts[shirtIdx].packCategory = 4
  
--   shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "Orange Stripes"
--     items.shirts[shirtIdx].coinsCost = 500
--     items.shirts[shirtIdx].image = "images/shop/shirts/OrangeStripes.png"
--     items.shirts[shirtIdx].id = "OrangeStripes"
--     items.shirts[shirtIdx].shirt = "OrangeStripes"
--     items.shirts[shirtIdx].packCategory = 4
    
-- 	shirtIdx =shirtIdx +  1
-- --  Teams
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "munich"
--     items.shirts[shirtIdx].coinsCost = 1000
--     items.shirts[shirtIdx].image = "images/shop/shirts/Munich.png"
--     items.shirts[shirtIdx].id = "Munich"
--     items.shirts[shirtIdx].shirt = "Munich"
--     items.shirts[shirtIdx].packCategory = 3
    
-- 	shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "Milan Blue"
--     items.shirts[shirtIdx].coinsCost = 1100
--     items.shirts[shirtIdx].image = "images/shop/shirts/Milan.png"
--     items.shirts[shirtIdx].id = "Milan"
--     items.shirts[shirtIdx].shirt = "Milan"
--     items.shirts[shirtIdx].packCategory = 3
    
-- 	shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "London Blue"
--     items.shirts[shirtIdx].coinsCost = 1200
--     items.shirts[shirtIdx].image = "images/shop/shirts/Chelsea.png"
--     items.shirts[shirtIdx].id = "Chelsea"
--     items.shirts[shirtIdx].shirt = "Chelsea"
--     items.shirts[shirtIdx].packCategory = 3
    
-- 	shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "Manchester Red"
--     items.shirts[shirtIdx].coinsCost = 1300
--     items.shirts[shirtIdx].image = "images/shop/shirts/Manchester.png"
--     items.shirts[shirtIdx].id = "Manchester"
--     items.shirts[shirtIdx].shirt = "Manchester" 
--     items.shirts[shirtIdx].packCategory = 3
    
-- 	shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "Madrid"
--     items.shirts[shirtIdx].coinsCost = 1500
--     items.shirts[shirtIdx].image = "images/shop/shirts/Madrid.png"
--     items.shirts[shirtIdx].id = "Madrid"
--     items.shirts[shirtIdx].shirt = "Madrid" 
--     items.shirts[shirtIdx].packCategory = 3
    
-- 	shirtIdx =shirtIdx +  1
--     items.shirts[shirtIdx] = {}
--     items.shirts[shirtIdx].name = "Barcelona"
--     --items.shirts[shirtIdx].coinsCost = 3500
--     items.shirts[shirtIdx].image = "images/shop/shirts/Barca.png"
--     items.shirts[shirtIdx].id = "Barca"
--     items.shirts[shirtIdx].shirt = "Barca"
--     items.shirts[shirtIdx].packCategory = 2
--     items.shirts[shirtIdx].googleStoreId =  "rvstyle.little.barcashirt"
 
-- Pants
	local pantsIdx = 1
	
    items.pants[pantsIdx] = {}
    items.pants[pantsIdx].name = "Red Pants"
    items.pants[pantsIdx].coinsCost = 0
    items.pants[pantsIdx].image = "images/shop/pants/Default.png"
    items.pants[pantsIdx].id = "defaultPants"
    items.pants[pantsIdx].imgScale = 0.8
    items.pants[pantsIdx].packCategory = 9
    
--     pantsIdx =pantsIdx+  1
-- 	items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "Style Jeans"
--     items.pants[pantsIdx].coinsCost = 300
--     items.pants[pantsIdx].image = "images/shop/pants/CoolJeans.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "CoolJeans"
--     items.pants[pantsIdx].packCategory = 4
    
-- 	pantsIdx =pantsIdx+  1
--     items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "Sweat Blue"
--     items.pants[pantsIdx].coinsCost = 400
--     items.pants[pantsIdx].image = "images/shop/pants/DidasSweats.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "DidasSweats"
--     items.pants[pantsIdx].packCategory = 4

-- pantsIdx =pantsIdx+  1
--     items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "Cool Jeans"
--     items.pants[pantsIdx].coinsCost = 400
--     items.pants[pantsIdx].image = "images/shop/pants/CoolJeansFaded.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "CoolJeansFaded"
--     items.pants[pantsIdx].packCategory = 4

-- pantsIdx =pantsIdx+  1
--     items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "Orange Shorts"
--     items.pants[pantsIdx].coinsCost = 400
--     items.pants[pantsIdx].image = "images/shop/pants/SweatsShortOrange.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "SweatsShortOrange"
--     items.pants[pantsIdx].packCategory = 4

-- pantsIdx =pantsIdx+  1
--     items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "Sweats Black"
--     items.pants[pantsIdx].coinsCost = 400
--     items.pants[pantsIdx].image = "images/shop/pants/SweatsBlack.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "SweatsBlack"
--     items.pants[pantsIdx].packCategory = 4

-- pantsIdx =pantsIdx+  1
--     items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "Sweats White"
--     items.pants[pantsIdx].coinsCost = 400
--     items.pants[pantsIdx].image = "images/shop/pants/SweatsWhite.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "SweatsWhite"
--     items.pants[pantsIdx].packCategory = 4

-- pantsIdx =pantsIdx+  1
--     items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "Sweats Pink"
--     items.pants[pantsIdx].coinsCost = 400
--     items.pants[pantsIdx].image = "images/shop/pants/SweatsPink.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "SweatsPink"
--     items.pants[pantsIdx].packCategory = 4

-- pantsIdx =pantsIdx+  1
--     items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "Pink Tights"
--     items.pants[pantsIdx].coinsCost = 1
--     items.pants[pantsIdx].image = "images/shop/pants/PinkTights.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "PinkTights"
--     items.pants[pantsIdx].packCategory = 4


-- 	pantsIdx =pantsIdx+  1
--     items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "Munich"
--     items.pants[pantsIdx].coinsCost = 1000
--     items.pants[pantsIdx].image = "images/shop/pants/Munich.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "MunichPants"
--   items.pants[pantsIdx].packCategory = 3
  
--     pantsIdx =pantsIdx+  1
--     items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "London Blue"
--     items.pants[pantsIdx].coinsCost = 1100
--     items.pants[pantsIdx].image = "images/shop/pants/Chelsea.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "ChelseaPants"
--     items.pants[pantsIdx].packCategory = 3

-- 	pantsIdx =pantsIdx+  1
--     items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "Milan Blue"
--     items.pants[pantsIdx].coinsCost = 1200
--     items.pants[pantsIdx].image = "images/shop/pants/Milan.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "MilanPants"
--     items.pants[pantsIdx].packChance = 30 
--     items.pants[pantsIdx].packCategory = 3

-- 	pantsIdx =pantsIdx+  1
--     items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "Manchester Red"
--     items.pants[pantsIdx].coinsCost = 1300
--     items.pants[pantsIdx].image = "images/shop/pants/Manchester.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "ManchesterPants"
--   items.pants[pantsIdx].packCategory = 3

-- 	pantsIdx =pantsIdx+  1
--     items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "Madrid"
--     items.pants[pantsIdx].coinsCost = 1500
--     items.pants[pantsIdx].image = "images/shop/pants/Madrid.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "MadridPants"
--     items.pants[pantsIdx].packCategory = 3
  
--   pantsIdx =pantsIdx+  1
--   items.pants[pantsIdx] = {}
--     items.pants[pantsIdx].name = "Barcelona"
--     --items.pants[pantsIdx].coinsCost = 1500
--     items.pants[pantsIdx].image = "images/shop/pants/Barca.png"
--     items.pants[pantsIdx].imgScale = 0.8
--     items.pants[pantsIdx].id = "BarcaPants"
--     items.pants[pantsIdx].packCategory = 2
--     items.pants[pantsIdx].googleStoreId =  "rvstyle.little.barcapants"
 

      local skinIdx = 1
  --    items.skins[skinIdx] = {}
      -- items.skins[skinIdx].name = "little Dribbler"
      -- items.skins[skinIdx].coinsCost = 0
      -- items.skins[skinIdx].image = "images/shop/skins/Default.png"
      -- items.skins[skinIdx].id = "littleDribbler" 
      -- items.skins[skinIdx].packCategory = 9

      -- skinIdx =skinIdx +  1
      -- items.skins[skinIdx] = {}
      -- items.skins[skinIdx].name = "Dribble Girl"
      -- items.skins[skinIdx].coinsCost = 200
      -- items.skins[skinIdx].image = "images/shop/skins/Girl.png"
      -- items.skins[skinIdx].id = "DribbleGirl" 


--      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Shakes"
      items.skins[skinIdx].coinsCost = 300
      items.skins[skinIdx].image = "images/shop/skins/Shakes.png"
      items.skins[skinIdx].id = "Shakes" 


      skinIdx =skinIdx +  1





      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "CoolJoe"
      items.skins[skinIdx].coinsCost = 300
      items.skins[skinIdx].image = "images/shop/skins/CoolJoe.png"
      items.skins[skinIdx].id = "CoolJoe" 


      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "ElMatador"
      items.skins[skinIdx].coinsCost = 400
      items.skins[skinIdx].image = "images/shop/skins/ElMatador.png"
      items.skins[skinIdx].id = "ElMatador" 

        skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Klaus"
      items.skins[skinIdx].coinsCost = 400
      items.skins[skinIdx].image = "images/shop/skins/Klaus.png"
      items.skins[skinIdx].id = "Klaus" 


      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "NorthShaw"
      items.skins[skinIdx].coinsCost = 400
      items.skins[skinIdx].image = "images/shop/skins/NorthShaw.png"
      items.skins[skinIdx].id = "NorthShaw" 




      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "TwistingTiger"
      items.skins[skinIdx].coinsCost = 1000
      items.skins[skinIdx].image = "images/shop/skins/TwistingTiger.png"
      items.skins[skinIdx].id = "TwistingTiger" 
   


   --    skinIdx =skinIdx +  1
   --    items.skins[skinIdx] = {}
   --    items.skins[skinIdx].name = "Little JJ"
   --    items.skins[skinIdx].coinsCost = 1200
   --    items.skins[skinIdx].image = "images/shop/skins/KSI.png"
   --    items.skins[skinIdx].id = "KSI" 
   --    items.skins[skinIdx].packCategory = 3
   --    items.skins[skinIdx].googleStoreId = "rvstyle.little.ksi"

      
	  -- skinIdx =skinIdx +  1
   --    items.skins[skinIdx] = {}
   --    items.skins[skinIdx].name = "Little Pew"
   --    items.skins[skinIdx].coinsCost = 1500
   --    items.skins[skinIdx].image = "images/shop/skins/PewDiePie.png"
   --    items.skins[skinIdx].id = "PewDiePie" 
   --    items.skins[skinIdx].packCategory = 3
   --    items.skins[skinIdx].googleStoreId = "rvstyle.little.pewdiepie"


   --    skinIdx =skinIdx +  1
   --    items.skins[skinIdx] = {}
   --    items.skins[skinIdx].name = "Zombie"
   --    items.skins[skinIdx].coinsCost = 2000	
   --    items.skins[skinIdx].image = "images/shop/skins/Zombie.png"
   --    items.skins[skinIdx].id = "Zombie" 
   --    items.skins[skinIdx].packChance = 1
   --    items.skins[skinIdx].packCategory = 2
   --    items.skins[skinIdx].googleStoreId = "rvstyle.little.zombie"

   --   skinIdx =skinIdx +  1
   --    items.skins[skinIdx] = {}
   --    items.skins[skinIdx].name = "Dribble Bot"
   --    items.skins[skinIdx].coinsCost = 3000 
   --    items.skins[skinIdx].image = "images/shop/skins/DribbleBot.png"
   --    items.skins[skinIdx].id = "DribbleBot" 
   --    items.skins[skinIdx].packChance = 1
   --    items.skins[skinIdx].packCategory = 2
   --    items.skins[skinIdx].googleStoreId = "rvstyle.little.bot"

	  
   --    skinIdx =skinIdx +  1
   --    items.skins[skinIdx] = {}
   --    items.skins[skinIdx].name = "Little Wayne"
   --    items.skins[skinIdx].coinsCost = 3000
   --    --items.skins[skinIdx].cashCost = 3
   --    items.skins[skinIdx].image = "images/shop/skins/Rooney.png"
   --    items.skins[skinIdx].id = "Rooney" 
   --    items.skins[skinIdx].packChance = 1
   --    items.skins[skinIdx].packCategory = 2
   --    items.skins[skinIdx].googleStoreId = "rvstyle.little.rooney"

   --    skinIdx =skinIdx +  1
   --    items.skins[skinIdx] = {}
   --    items.skins[skinIdx].name = "Little Tot"
   --    items.skins[skinIdx].coinsCost = 3000
   --    --items.skins[skinIdx].cashCost = 3
   --    items.skins[skinIdx].image = "images/shop/skins/Totti.png"
   --    items.skins[skinIdx].id = "Totti" 
   --    items.skins[skinIdx].packChance = 1
   --    items.skins[skinIdx].packCategory = 2
   --    items.skins[skinIdx].googleStoreId = "rvstyle.little.totti"
 
   --    --items.skins[skinIdx].googleStoreId = "rvs

   --    skinIdx =skinIdx +  1
   --    items.skins[skinIdx] = {}
   --    items.skins[skinIdx].name = "Big Ibra"
   --    items.skins[skinIdx].coinsCost = 3500
   --    --items.skins[5].cashCost = 3
   --    items.skins[skinIdx].image = "images/shop/skins/Zlatan.png"
   --    items.skins[skinIdx].id = "Zlatan" 
   --    items.skins[skinIdx].packChance = 1
   --    items.skins[skinIdx].packCategory = 2
   --    items.skins[skinIdx].googleStoreId = "rvstyle.little.zlatan"

   --    skinIdx =skinIdx +  1
   --    items.skins[skinIdx] = {}
   --    items.skins[skinIdx].name = "little warrior"
   --    items.skins[skinIdx].coinsCost = 3500
   --    --items.skins[5].cashCost = 3
   --    items.skins[skinIdx].image = "images/shop/skins/Steph.png"
   --    items.skins[skinIdx].id = "Steph" 
   --    items.skins[skinIdx].packChance = 1
   --    items.skins[skinIdx].packCategory = 2
   --    items.skins[skinIdx].googleStoreId = "rvstyle.little.warrior"

      

   --      skinIdx =skinIdx +  1
   --    items.skins[skinIdx] = {}
   --    items.skins[skinIdx].name = "Little Ney"
   --    items.skins[skinIdx].coinsCost = 4000
   --    items.skins[skinIdx].image = "images/shop/skins/Neymar.png"
   --    items.skins[skinIdx].id = "Neymar" 
   --    items.skins[skinIdx].packCategory = 2
   --    items.skins[skinIdx].googleStoreId = "rvstyle.little.neymar"
   --    --items.skins[5].googleStoreId = "rvstyle.little.messi"

   --    skinIdx =skinIdx +  1
   --    items.skins[skinIdx] = {}
   --    items.skins[skinIdx].name = "Little Ron"
      
   --    items.skins[skinIdx].image = "images/shop/skins/Rolando.png"
   --    items.skins[skinIdx].id = "Rolando" 
   --    items.skins[skinIdx].packChance = 1
   --    items.skins[skinIdx].packCategory = 1
   --    items.skins[skinIdx].googleStoreId = "rvstyle.little.ronaldo"


   --    skinIdx =skinIdx +  1
   --    items.skins[skinIdx] = {}
   --    items.skins[skinIdx].name = "Little Mess"
   --    --items.skins[skinIdx].cashCost = "10.90 ₪"
   --    items.skins[skinIdx].image = "images/shop/skins/Messi.png"
   --    items.skins[skinIdx].id = "Nessi" 
   --    items.skins[skinIdx].packChance = 1
   --    items.skins[skinIdx].packCategory = 1
   --    items.skins[skinIdx].googleStoreId = "rvstyle.little.messi"



      local ballIdx = 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "NormalBall"
      items.balls[ballIdx].coinsCost = 0
      items.balls[ballIdx].image = "balls/NormalBall.png"
      items.balls[ballIdx].imgScale = 1  
      items.balls[ballIdx].id = "NormalBall" 
      items.balls[ballIdx].packCategory = 9

      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Cuju Ball"
      items.balls[ballIdx].coinsCost = 200
      items.balls[ballIdx].image = "balls/CujuBall.png"
      items.balls[ballIdx].imgScale = 1      
      items.balls[ballIdx].id = "CujuBall"       
      items.balls[ballIdx].packCategory = 4      
	  
      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "OldBall"
      items.balls[ballIdx].coinsCost = 300
      items.balls[ballIdx].image = "balls/OldBall.png"
      items.balls[ballIdx].imgScale = 1  
      items.balls[ballIdx].id = "OldBall" 
      items.balls[ballIdx].packCategory = 4

      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "PowerBall"
      items.balls[ballIdx].coinsCost = 300
      items.balls[ballIdx].image = "balls/PowerBall.png"
      items.balls[ballIdx].imgScale = 1   
      items.balls[ballIdx].id = "PowerBall" 
      items.balls[ballIdx].packCategory = 4

      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "RedBall"
      items.balls[ballIdx].coinsCost = 400
      items.balls[ballIdx].image = "balls/RedBall.png"
      items.balls[ballIdx].imgScale = 1  
      items.balls[ballIdx].id = "RedBall"       
      items.balls[ballIdx].packCategory = 4

      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "SuperleagueWhiteBall"
      items.balls[ballIdx].coinsCost = 500
      items.balls[ballIdx].image = "balls/SuperleagueWhiteBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "SuperleagueWhiteBall"       
      items.balls[ballIdx].packCategory = 3

      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "SuperleagueYellowBall"
      items.balls[ballIdx].coinsCost = 500
      items.balls[ballIdx].image = "balls/SuperleagueYellowBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "SuperleagueYellowBall"       
      items.balls[ballIdx].packCategory = 3

      

	  ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "WhiteBall"
      items.balls[ballIdx].coinsCost = 700
      items.balls[ballIdx].image = "balls/WhiteBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "WhiteBall"       
      items.balls[ballIdx].packCategory = 3

       ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "ReedBall"
      items.balls[ballIdx].coinsCost = 800
      items.balls[ballIdx].image = "balls/ReedBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "ReedBall"       
      items.balls[ballIdx].packCategory = 3


      

       ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "YellowBall"
      items.balls[ballIdx].coinsCost = 900
      items.balls[ballIdx].image = "balls/YellowBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "YellowBall"       
      items.balls[ballIdx].packCategory = 3

   --    ballIdx =  ballIdx + 1
   --    items.balls[ballIdx] = {}
   --    items.balls[ballIdx].name = "English White"
   --    items.balls[ballIdx].coinsCost = 1000
   --    items.balls[ballIdx].image = "balls/EnglishWhite.png"
   --    items.balls[ballIdx].imgScale = 1   
   --    items.balls[ballIdx].id = "EnglishWhite"
   --    items.balls[ballIdx].packChance = 30 
	  -- items.balls[ballIdx].packCategory = 3	
   --  items.balls[ballIdx].googleStoreId = "rvstyle.litte.englishwhite"
    

   --    ballIdx =  ballIdx + 1
   --    items.balls[ballIdx] = {}
   --    items.balls[ballIdx].name = "English Blue"
   --    items.balls[ballIdx].coinsCost = 1100
   --    items.balls[ballIdx].image = "balls/EnglishBlu.png"
   --    items.balls[ballIdx].imgScale = 1   
   --    items.balls[ballIdx].id = "EnglishBlu"
   --    items.balls[ballIdx].packCategory = 3
   --     items.balls[ballIdx].googleStoreId =  "rvstyle.little.englishblue"
      
   --    ballIdx =  ballIdx + 1
   --    items.balls[ballIdx] =   {}
   --    items.balls[ballIdx].name = "English Winter"
   --    items.balls[ballIdx].coinsCost = 1200
   --    items.balls[ballIdx].image = "balls/EnglishWinter.png"
   --    items.balls[ballIdx].imgScale = 1   
   --    items.balls[ballIdx].id = "EnglishWinter"
   --    items.balls[ballIdx].packCategory = 3
   --     items.balls[ballIdx].googleStoreId =  "rvstyle.little.englishwinter"

   --    ballIdx =  ballIdx + 1
   --    items.balls[ballIdx] = {}
   --    items.balls[ballIdx].name = "English Yellow"
   --    items.balls[ballIdx].coinsCost = 1300
   --    items.balls[ballIdx].image = "balls/EnglishYellow.png"
   --    items.balls[ballIdx].imgScale = 1   
   --    items.balls[ballIdx].id = "EnglishYellow" 
   --    items.balls[ballIdx].packCategory = 3
   --     items.balls[ballIdx].googleStoreId =  "rvstyle.little.englishyellow"
      
   --    ballIdx =  ballIdx + 1
   --    items.balls[ballIdx] = {}
   --    items.balls[ballIdx].name = "FINALE"
   --    items.balls[ballIdx].coinsCost = 1500
   --    items.balls[ballIdx].image = "balls/FIN01.png"
   --    items.balls[ballIdx].imgScale = 1   
   --    items.balls[ballIdx].id = "FIN01" 
   --    items.balls[ballIdx].packCategory = 3
   --     items.balls[ballIdx].googleStoreId =  "rvstyle.little.finale"

   --    ballIdx =  ballIdx + 1
   --    items.balls[ballIdx] = {}
   --    items.balls[ballIdx].name = "WINTER NEW"
   --    items.balls[ballIdx].coinsCost = 1500
   --    items.balls[ballIdx].image = "balls/NICE02.png"
   --    items.balls[ballIdx].imgScale = 1   
   --    items.balls[ballIdx].id = "NICE02" 
   --    items.balls[ballIdx].packCategory = 3
   --     items.balls[ballIdx].googleStoreId =  "rvstyle.little.winternew"

   --    ballIdx =  ballIdx + 1
   --    items.balls[ballIdx] = {}
   --    items.balls[ballIdx].name = "SPANISH NEW"
   --    items.balls[ballIdx].coinsCost = 1600
   --    items.balls[ballIdx].image = "balls/NICE03.png"
   --    items.balls[ballIdx].imgScale = 1   
   --    items.balls[ballIdx].id = "NICE03" 
   --    items.balls[ballIdx].packCategory = 3
   --     items.balls[ballIdx].googleStoreId =  "rvstyle.little.spanishnew"
      

   --    ballIdx =  ballIdx + 1
   --    items.balls[ballIdx] = {}
   --    items.balls[ballIdx].name = "Europa 16"
   --    items.balls[ballIdx].coinsCost = 1
   --    items.balls[ballIdx].image = "balls/Europa16.png"
   --    items.balls[ballIdx].imgScale = 1   
   --    items.balls[ballIdx].id = "Europa16" 
   --    items.balls[ballIdx].packCategory = 3
   --    --items.balls[ballIdx].googleStoreId =  "rvstyle.little.spanishnew"
      
   --    ballIdx =  ballIdx + 1
   --    items.balls[ballIdx] = {}
   --    items.balls[ballIdx].name = "NICE Prime"
   --    items.balls[ballIdx].coinsCost = 1
   --    items.balls[ballIdx].image = "balls/NICE Prime.png"
   --    items.balls[ballIdx].imgScale = 1   
   --    items.balls[ballIdx].id = "NICE Prime" 
   --    items.balls[ballIdx].packCategory = 3
      


   --    ballIdx =  ballIdx + 1
   --    items.balls[ballIdx] = {}
   --    items.balls[ballIdx].name = "ENGLISH NEW"
   --    items.balls[ballIdx].coinsCost = 1700
   --    items.balls[ballIdx].image = "balls/NICE01.png"
   --    items.balls[ballIdx].imgScale = 1   
   --    items.balls[ballIdx].id = "NICE01"
   --    items.balls[ballIdx].packCategory = 3
   --     items.balls[ballIdx].googleStoreId =  "rvstyle.little.englishnew"
      
   --    ballIdx =  ballIdx + 1
   --    items.balls[ballIdx] = {}
   --    items.balls[ballIdx].name = "New Cup"
   --    items.balls[ballIdx].coinsCost = 2000
   --    items.balls[ballIdx].image = "balls/NewCup.png"
   --    items.balls[ballIdx].imgScale = 1   
   --    items.balls[ballIdx].id = "NewCup" 
   --    items.balls[ballIdx].packCategory = 2
   --    items.balls[ballIdx].googleStoreId = "rvsylte.little.newcup"
       

   --    ballIdx =  ballIdx + 1
   --    items.balls[ballIdx] = {}
   --    items.balls[ballIdx].name = "FINALE YELLOW"
      
   --    items.balls[ballIdx].image = "balls/FIN02.png"
   --    items.balls[ballIdx].imgScale = 1   
   --    items.balls[ballIdx].id = "FIN02" 
   --    items.balls[ballIdx].packCategory = 2
   --    items.balls[ballIdx].googleStoreId = "rvstyle.little.finaleyellow"
      

      local function createShoes()

        local shoeIdx  = 1
        items.shoes[shoeIdx] = {}    
        items.shoes[shoeIdx].name = "Dribble Shoes"
        items.shoes[shoeIdx].coinsCost = 0
        items.shoes[shoeIdx].image = "shoes/Default/LegFrontShoe.png"
        items.shoes[shoeIdx].image2 = "shoes/Default/LegBackShoe.png"
        items.shoes[shoeIdx].imgScale = 1.5  
        items.shoes[shoeIdx].id = "Default"  
        items.shoes[shoeIdx].packCategory = 9

 --         shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "Classic Black"
 --        items.shoes[shoeIdx].coinsCost = 200
 --        items.shoes[shoeIdx].image = "shoes/Classic Black/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/Classic Black/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "Classic Black"      
 --        items.shoes[shoeIdx].packCategory = 4

 --         shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "ALL WHITE"
 --        items.shoes[shoeIdx].coinsCost = 250
 --        items.shoes[shoeIdx].image = "shoes/Didas White/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/Didas White/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "Didas White"      
 --        items.shoes[shoeIdx].packCategory = 4

		
 --        shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "Skate Blue"
 --        items.shoes[shoeIdx].coinsCost = 400
 --        items.shoes[shoeIdx].image = "shoes/SkateBlue/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/SkateBlue/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "SkateBlue"      
 --        items.shoes[shoeIdx].packCategory = 4


 --        shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "Skate Red"
 --        items.shoes[shoeIdx].coinsCost = 500
 --        items.shoes[shoeIdx].image = "shoes/SkateRed/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/SkateRed/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "SkateRed"      
 --        items.shoes[shoeIdx].packCategory = 4

 --        shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "Didas Lizard"
 --        items.shoes[shoeIdx].coinsCost = 500
 --        items.shoes[shoeIdx].image = "shoes/Didas Lizard/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/Didas Lizard/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "Didas Lizard"      
 --        items.shoes[shoeIdx].packChance = 30
	-- 	items.shoes[shoeIdx].packCategory = 4

	-- 	shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "Didas Attack"
 --        items.shoes[shoeIdx].coinsCost = 600
 --        items.shoes[shoeIdx].image = "shoes/Didas Attack/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/Didas Attack/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "Didas Attack"      
 --        items.shoes[shoeIdx].packCategory = 4

 --        shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "BLACK WHITE"
 --        items.shoes[shoeIdx].coinsCost = 700
 --        items.shoes[shoeIdx].image = "shoes/Didas B&W/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/Didas B&W/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "Didas B&W"       
	-- 	items.shoes[shoeIdx].packCategory = 4

 --        shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "DIDAS F"
 --        items.shoes[shoeIdx].coinsCost = 1000
 --        items.shoes[shoeIdx].image = "shoes/DIDAS F/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/DIDAS F/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "DIDAS F"       
	-- 	items.shoes[shoeIdx].packCategory = 3
 --     items.shoes[shoeIdx].googleStoreId = "rvstyle.little.prince"
    

 --        shoeIdx = shoeIdx +1 

 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "NICE Green"
 --        items.shoes[shoeIdx].coinsCost = 1100
 --        items.shoes[shoeIdx].image = "shoes/NICE Green/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/NICE Green/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "NICE Green"      
	-- 	items.shoes[shoeIdx].packCategory = 3
 --      items.shoes[shoeIdx].googleStoreId = "rvstyle.little.nicegreen"
    

 --        shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "NICE Silver"
 --        items.shoes[shoeIdx].coinsCost = 1200
 --        items.shoes[shoeIdx].image = "shoes/NICE Silver/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/NICE Silver/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "NICE Silver"      
	-- 	items.shoes[shoeIdx].packCategory = 3
 --      items.shoes[shoeIdx].googleStoreId = "rvstyle.little.nicesilver"
    
      
 --        shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "NICE White"
 --        items.shoes[shoeIdx].coinsCost = 1300
 --        items.shoes[shoeIdx].image = "shoes/NICE White/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/NICE White/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "NICE White"      
 --    items.shoes[shoeIdx].packCategory = 3
 --          items.shoes[shoeIdx].googleStoreId = "rvstyle.little.nicewhite"
    
 --        shoeIdx = shoeIdx +1 
 --         items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "Gold"
 --        items.shoes[shoeIdx].coinsCost = 1400
 --        items.shoes[shoeIdx].image = "shoes/NICE Gold/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/NICE Gold/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "NICE Gold"      
 --    items.shoes[shoeIdx].packCategory = 3
 --        items.shoes[shoeIdx].googleStoreId = "rvstyle.little.gold"
    
 --        shoeIdx = shoeIdx +1 
 --         items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "Didas X Black"
 --        items.shoes[shoeIdx].coinsCost = 1500
 --        items.shoes[shoeIdx].image = "shoes/Didas X Black/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/Didas X Black/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "Didas X Black"      
 --    items.shoes[shoeIdx].packCategory = 3
 --     items.shoes[shoeIdx].googleStoreId = "rvstyle.little.xblack"
	    
 --     shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "Future"
 --        items.shoes[shoeIdx].coinsCost = 2000
 --        items.shoes[shoeIdx].image = "shoes/Future/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/Future/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "Future"      
 --        items.shoes[shoeIdx].packCategory = 2
 --        items.shoes[shoeIdx].googleStoreId = "rvstyle.little.future"

 --        shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "Multicolor"
 --        items.shoes[shoeIdx].coinsCost = 2500
 --        items.shoes[shoeIdx].image = "shoes/Feline Multicolor/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/Feline Multicolor/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "Feline Multicolor"      
 --    items.shoes[shoeIdx].packCategory = 2
 --     items.shoes[shoeIdx].googleStoreId = "rvstyle.little.multicolor"

	
	-- shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "Nessie Limited"
 --        items.shoes[shoeIdx].coinsCost = 3000
 --        items.shoes[shoeIdx].image = "shoes/Nessie Limited/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/Nessie Limited/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "Nessie Limited"      
 --        items.shoes[shoeIdx].packCategory = 2 
 --        items.shoes[shoeIdx].googleStoreId = "rvstyle.little.limitedm10"

 
 --        shoeIdx = shoeIdx +1 
 --        items.shoes[shoeIdx] = {}    
 --        items.shoes[shoeIdx].name = "Didas GLOW"
        
 --        items.shoes[shoeIdx].image = "shoes/Didas GLOW/LegFrontShoe.png"
 --        items.shoes[shoeIdx].image2 = "shoes/Didas GLOW/LegBackShoe.png"
 --        items.shoes[shoeIdx].imgScale = 1.5  
 --        items.shoes[shoeIdx].id = "Didas GLOW"      
 --        items.shoes[shoeIdx].packCategory = 2   
 --        items.shoes[shoeIdx].googleStoreId = "rvstyle.little.glownew"
 
    
    

      end
      
      createShoes()
      totalPackChance = 0


for key,cat in pairs(items) do
  for i=1,#cat do
  
    if (cat[i].packChance) then
      totalPackChance = totalPackChance + cat[i].packChance
    end 

    local itemCat = nil
    if cat[i].packCategory then
      itemCat = cat[i].packCategory
    else   
      itemCat = 4  
    end  
      
      local idx

      if packCategories[itemCat] then
      else
        packCategories[itemCat] ={}
      end
       local idx = #packCategories[itemCat] 
       packCategories[itemCat][idx + 1] = cat[i]  
      cat[i].itemCategory = key
        
     --   if ( system.getInfo("platformName") == "Android"  and cat[i].googleStoreId) then
            cat[i].storeId = cat[i].googleStoreId
     --   end  

        -- if ( system.getInfo("platformName") ~= "Android"  and cat[i].appleStoreId) then
        --     cat[i].storeId = cat[i].appleStoreId
        -- end  

    cat[i].coinsCost = 0

  end
end

