
      packCategories = {}
      packCategories[1] = {}
      packCategories[2] = {}
      packCategories[3] = {}
      packCategories[4] = {}
     
      items = {}
      items.skins = {}
      items.balls = {}
      items.fields = {}
     
     
      items.balls.category = "balls"
      items.skins.category = "skins"
      items.fields.category = "fields"
      
      items.skins.index = 1    
      items.balls.index = 2
      items.fields.index = 3

      seletedCategory = "skins"
    
	

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
      items.skins[skinIdx].coinsCost = 200
      items.skins[skinIdx].image = "images/shop/skins/Shakes.png"
      items.skins[skinIdx].id = "Shakes" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 0

      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Big Bo"
      items.skins[skinIdx].coinsCost = 200
      items.skins[skinIdx].image = "images/shop/skins/BigBo.png"
      items.skins[skinIdx].id = "BigBo" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].packCategory = 1
      items.skins[skinIdx].level = 2

      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Klaus"
      items.skins[skinIdx].coinsCost = 300
      items.skins[skinIdx].image = "images/shop/skins/Klaus.png"
      items.skins[skinIdx].id = "Klaus" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 3

      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Blok"
      items.skins[skinIdx].coinsCost = 500
      items.skins[skinIdx].image = "images/shop/skins/Blok.png"
      items.skins[skinIdx].id = "Blok" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].packCategory = 2
      items.skins[skinIdx].level = 6


      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "North Shaw"
      items.skins[skinIdx].coinsCost = 1000
      items.skins[skinIdx].image = "images/shop/skins/NorthShaw.png"
      items.skins[skinIdx].id = "NorthShaw" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 10

      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Twisting Tiger"
      items.skins[skinIdx].coinsCost = 1500
      items.skins[skinIdx].image = "images/shop/skins/TwistingTiger.png"
      items.skins[skinIdx].id = "TwistingTiger" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 15
   
      skinIdx =skinIdx +  1


      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Cool Joe"
      items.skins[skinIdx].coinsCost = 2000
      items.skins[skinIdx].image = "images/shop/skins/CoolJoe.png"
      items.skins[skinIdx].id = "CoolJoe" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 20
    
      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "El Matador"
      items.skins[skinIdx].coinsCost = 2500
      items.skins[skinIdx].image = "images/shop/skins/ElMatador.png"
      items.skins[skinIdx].id = "ElMatador"
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 25

      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Rasta"
      items.skins[skinIdx].coinsCost = 3000
      items.skins[skinIdx].image = "images/shop/skins/Rasta.png"
      items.skins[skinIdx].id = "Rasta" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 30


      local ballIdx = 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "NormalBall"
      items.balls[ballIdx].coinsCost = 0
      items.balls[ballIdx].image = "balls/NormalBall.png"
      items.balls[ballIdx].imgScale = 1  
      items.balls[ballIdx].id = "NormalBall" 
      items.balls[ballIdx].packCategory = 4
      items.balls[ballIdx].level = 0


      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Old Ball"
      items.balls[ballIdx].coinsCost = 50
      items.balls[ballIdx].image = "balls/OldBall.png"
      items.balls[ballIdx].imgScale = 1  
      items.balls[ballIdx].id = "OldBall" 
      items.balls[ballIdx].packCategory = 4
      items.balls[ballIdx].level = 1


      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "White Ball"
      items.balls[ballIdx].coinsCost = 100
      items.balls[ballIdx].image = "balls/WhiteBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "WhiteBall"       
      items.balls[ballIdx].packCategory = 3
      items.balls[ballIdx].level = 3


       ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Reed Ball"
      items.balls[ballIdx].coinsCost = 150
      items.balls[ballIdx].image = "balls/ReedBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "ReedBall"       
      items.balls[ballIdx].packCategory = 3
      items.balls[ballIdx].level = 5

      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Red Ball"
      items.balls[ballIdx].coinsCost = 150
      items.balls[ballIdx].image = "balls/RedBall.png"
      items.balls[ballIdx].imgScale = 1  
      items.balls[ballIdx].id = "RedBall"       
      items.balls[ballIdx].packCategory = 4
      items.balls[ballIdx].level = 6


       ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Yellow Ball"
      items.balls[ballIdx].coinsCost = 200
      items.balls[ballIdx].image = "balls/YellowBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "YellowBall"       
      items.balls[ballIdx].packCategory = 3
      items.balls[ballIdx].level = 8


      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Cuju Ball"
      items.balls[ballIdx].coinsCost = 300
      items.balls[ballIdx].image = "balls/CujuBall.png"
      items.balls[ballIdx].imgScale = 1      
      items.balls[ballIdx].id = "CujuBall"       
      items.balls[ballIdx].packCategory = 4    
      items.balls[ballIdx].level = 10  
	  
      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Power Ball"
      items.balls[ballIdx].coinsCost = 500
      items.balls[ballIdx].image = "balls/PowerBall.png"
      items.balls[ballIdx].imgScale = 1   
      items.balls[ballIdx].id = "PowerBall" 
      items.balls[ballIdx].packCategory = 4
      items.balls[ballIdx].level = 13

      

      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Super league White"
      items.balls[ballIdx].coinsCost = 800
      items.balls[ballIdx].image = "balls/SuperleagueWhiteBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "SuperleagueWhiteBall"       
      items.balls[ballIdx].packCategory = 3
      items.balls[ballIdx].level = 17

      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Super league Yellow"
      items.balls[ballIdx].coinsCost = 1000
      items.balls[ballIdx].image = "balls/SuperleagueYellowBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "SuperleagueYellowBall"       
      items.balls[ballIdx].packCategory = 3
      items.balls[ballIdx].level = 21


       local fieldIdx = 1
      items.fields[fieldIdx] = {}
      items.fields[fieldIdx].name = "Stadium"
      items.fields[fieldIdx].coinsCost = 0
      items.fields[fieldIdx].image = "fields/Normalfield.png"
      items.fields[fieldIdx].imgScale = 1  
      items.fields[fieldIdx].id = "Stadium" 
      items.fields[fieldIdx].packCategory = 4
      items.fields[fieldIdx].level = 0


      fieldIdx =  fieldIdx + 1
      items.fields[fieldIdx] = {}
      items.fields[fieldIdx].name = "Glacier"
      items.fields[fieldIdx].coinsCost = 50
      items.fields[fieldIdx].image = "fields/Oldfield.png"
      items.fields[fieldIdx].imgScale = 1  
      items.fields[fieldIdx].id = "Glacier" 
      items.fields[fieldIdx].packCategory = 4
      items.fields[fieldIdx].level = 1


      fieldIdx =  fieldIdx + 1
      items.fields[fieldIdx] = {}
      items.fields[fieldIdx].name = "Desert"
      items.fields[fieldIdx].coinsCost = 100
      items.fields[fieldIdx].image = "images/shop/fields/Desert.png"
      items.fields[fieldIdx].imgScale = 1        
      items.fields[fieldIdx].id = "Desert"       
      items.fields[fieldIdx].packCategory = 3
      items.fields[fieldIdx].level = 3


       fieldIdx =  fieldIdx + 1
      items.fields[fieldIdx] = {}
      items.fields[fieldIdx].name = "Castle"
      items.fields[fieldIdx].coinsCost = 150
      items.fields[fieldIdx].image = "fields/Reedfield.png"
      items.fields[fieldIdx].imgScale = 1        
      items.fields[fieldIdx].id = "Castle"       
      items.fields[fieldIdx].packCategory = 3
      items.fields[fieldIdx].level = 5

      fieldIdx =  fieldIdx + 1
      items.fields[fieldIdx] = {}
      items.fields[fieldIdx].name = "Eagle"
      items.fields[fieldIdx].coinsCost = 150
      items.fields[fieldIdx].image = "fields/Redfield.png"
      items.fields[fieldIdx].imgScale = 1  
      items.fields[fieldIdx].id = "EagleField"       
      items.fields[fieldIdx].packCategory = 4
      items.fields[fieldIdx].level = 6

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

   -- cat[i].coinsCost = 0

  end
end

