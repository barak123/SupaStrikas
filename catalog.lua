local M = {}

      local packCategories = {}
      packCategories[1] = {}
      packCategories[2] = {}
      packCategories[3] = {}
      packCategories[4] = {}
     
      local items = {}
      items.gems = {}
      items.skins = {}
      items.balls = {}
      items.fields = {}
      items.boosts = {}
      items.cards = {}

      local itemsByLevel = {}

      local skills = {}

     
     
      items.balls.category = "balls"
      items.skins.category = "skins"
      items.fields.category = "fields"
      items.gems.category = "gems"
      items.boosts.category = "boosts"
      items.cards.category = "cards"
      
      items.gems.index = 1    
      items.skins.index = 2    
      items.balls.index = 3
      items.fields.index = 4
      items.boosts.index = 5
      items.cards.index = 6

      seletedCategory = "gems"
    

      local gemIdx = 1
 
      items.gems[gemIdx] = {}
      items.gems[gemIdx].name = "Starter pack"
      items.gems[gemIdx].cashCost = 3
      items.gems[gemIdx].image = "images/shop/gems/NorthShawIcon.png"      
      items.gems[gemIdx].id = "starterPack"       
      items.gems[gemIdx].storeId = "com.ld.starterpack" 
      items.gems[gemIdx].hidden = true
      items.gems[gemIdx].specialOffer = true
      
      gemIdx =gemIdx +  1
      items.gems[gemIdx] = {}
      items.gems[gemIdx].name = "Value pack"
      items.gems[gemIdx].cashCost = 3
      items.gems[gemIdx].image = "images/shop/gems/ShakesPromo.png"      
      items.gems[gemIdx].id = "shakesPack"       
      items.gems[gemIdx].storeId = "com.ld.shakespack" 
      items.gems[gemIdx].hidden = true
      items.gems[gemIdx].specialOffer = true
      
      gemIdx =gemIdx +  1
      items.gems[gemIdx] = {}
      items.gems[gemIdx].name = "Value pack"
      --items.gems[gemIdx].cashCost = 3
      items.gems[gemIdx].image = "images/shop/gems/RastaMatadorPromo.png"      
      items.gems[gemIdx].id = "megaPack"       
      items.gems[gemIdx].storeId = "com.ld.promopack" 
      items.gems[gemIdx].hidden = true
      items.gems[gemIdx].specialOffer = true

      gemIdx =gemIdx +  1
      items.gems[gemIdx] = {}
      items.gems[gemIdx].name = "FREE GEM"
      --items.gems[gemIdx].cashCost = 0
      --items.gems[gemIdx].image = "images/shop/gems/1 Gem.png"
      items.gems[gemIdx].id = "freeGem" 
      items.gems[gemIdx].gemsCount = 1
      

      gemIdx =gemIdx +  1
      items.gems[gemIdx] = {}
      items.gems[gemIdx].name = "3 SUPA GEMS"
      items.gems[gemIdx].cashCost = 3
      items.gems[gemIdx].image = "images/shop/gems/3.png"
      items.gems[gemIdx].id = "3supaGems" 
      items.gems[gemIdx].gemsCount = 3
      items.gems[gemIdx].storeId = "com.ld.3supagems" 
      
      
      gemIdx =gemIdx +  1
      items.gems[gemIdx] = {}
      items.gems[gemIdx].name = "10 SUPA GEMS"
      items.gems[gemIdx].cashCost = 10
      items.gems[gemIdx].image = "images/shop/gems/10.png"
      items.gems[gemIdx].gemsCount = 10
      items.gems[gemIdx].id = "10supaGems" 
      items.gems[gemIdx].storeId = "com.ld.10supagems" 
      
      gemIdx =gemIdx +  1
      items.gems[gemIdx] = {}
      items.gems[gemIdx].name = "20 SUPA GEMS"
      items.gems[gemIdx].cashCost = 20
      items.gems[gemIdx].image = "images/shop/gems/20.png"
      items.gems[gemIdx].gemsCount = 20
      items.gems[gemIdx].id = "20supaGems" 
      items.gems[gemIdx].storeId = "com.ld.20supagems" 


      gemIdx =gemIdx +  1
      items.gems[gemIdx] = {}
      items.gems[gemIdx].name = "40 SUPA GEMS"
      items.gems[gemIdx].cashCost = 40
      items.gems[gemIdx].image = "images/shop/gems/40.png"
      items.gems[gemIdx].gemsCount = 40
      items.gems[gemIdx].id = "40supaGems" 
      items.gems[gemIdx].storeId = "com.ld.40supagems" 


      gemIdx =gemIdx +  1
      items.gems[gemIdx] = {}
      items.gems[gemIdx].name = "80 SUPA GEMS"
      items.gems[gemIdx].cashCost = 80
      items.gems[gemIdx].image = "images/shop/gems/80.png"
      items.gems[gemIdx].gemsCount = 80
      items.gems[gemIdx].id = "80supaGems" 
      items.gems[gemIdx].storeId = "com.ld.80supagems" 


      gemIdx =gemIdx +  1
      items.gems[gemIdx] = {}
      items.gems[gemIdx].name = "REMOVE ADS"
      items.gems[gemIdx].cashCost = 3
      items.gems[gemIdx].image = "images/shop/RemoveAds.png"      
      items.gems[gemIdx].id = "removeads" 
      items.gems[gemIdx].storeId = "com.ld.removeads" 

      
      local skinIdx = 1
 
       
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Klaus"
      items.skins[skinIdx].coinsCost = 500
      items.skins[skinIdx].gemsCost = 5
      items.skins[skinIdx].image = "images/shop/skins/Klaus.png"
      items.skins[skinIdx].id = "Klaus" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 0
      skills["Klaus"] = {speed = 6, power = 5 , skill = 7 , shoot = 7 }

      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Big Bo"
      items.skins[skinIdx].coinsCost = 700
      items.skins[skinIdx].gemsCost = 7
      items.skins[skinIdx].image = "images/shop/skins/BigBo.png"
      items.skins[skinIdx].id = "BigBo" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].packCategory = 1
      items.skins[skinIdx].level = 1
      skills["BigBo" ] = {speed = 6, power = 9 , skill = 5, shoot = 3 }

     

      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Blok"
      items.skins[skinIdx].coinsCost = 700
      items.skins[skinIdx].gemsCost = 7
      items.skins[skinIdx].image = "images/shop/skins/Blok.png"
      items.skins[skinIdx].id = "Blok" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].packCategory = 2
      items.skins[skinIdx].level = 1
      skills["Blok" ] = {speed = 7, power = 9 , skill = 5, shoot = 4 }


      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "North Shaw"
      items.skins[skinIdx].coinsCost = 1000
      items.skins[skinIdx].gemsCost = 10
      items.skins[skinIdx].image = "images/shop/skins/NorthShaw.png"
      items.skins[skinIdx].id = "NorthShaw" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 2
      skills["NorthShaw" ] = {speed = 9, power = 6 , skill = 6 , shoot = 5}

      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Twisting Tiger"
      items.skins[skinIdx].coinsCost = 3000
      items.skins[skinIdx].gemsCost = 20
      items.skins[skinIdx].image = "images/shop/skins/TwistingTiger.png"
      items.skins[skinIdx].id = "TwistingTiger" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 3
      skills["TwistingTiger" ] = {speed = 9, power = 2 , skill = 8 , shoot = 7}
   
      skinIdx =skinIdx +  1


      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Cool Joe"
      items.skins[skinIdx].coinsCost = 6500
      items.skins[skinIdx].gemsCost = 40
      items.skins[skinIdx].image = "images/shop/skins/CoolJoe.png"
      items.skins[skinIdx].id = "CoolJoe" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 4
      skills["CoolJoe" ] = {speed = 6, power = 7 , skill = 8 , shoot = 6}

      skinIdx =skinIdx +  1

      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Shakes"      
      items.skins[skinIdx].gemsCost = 50
      items.skins[skinIdx].image = "images/shop/skins/Shakes.png"
      items.skins[skinIdx].id = "Shakes" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 5
      skills["Shakes" ] = {speed = 9, power = 7 , skill = 9 , shoot = 9}
    
      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "El Matador"      
      items.skins[skinIdx].gemsCost = 60
      items.skins[skinIdx].image = "images/shop/skins/ElMatador.png"
      items.skins[skinIdx].id = "ElMatador"
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 6
      skills["ElMatador" ] = {speed = 7, power = 9 , skill = 8 , shoot = 9}

      skinIdx =skinIdx +  1
      items.skins[skinIdx] = {}
      items.skins[skinIdx].name = "Rasta"      
      items.skins[skinIdx].gemsCost = 70
      items.skins[skinIdx].image = "images/shop/skins/Rasta.png"
      items.skins[skinIdx].id = "Rasta" 
      items.skins[skinIdx].imgScale = 1
      items.skins[skinIdx].level = 7   
      skills["Rasta" ] = {speed = 8, power = 9 , skill = 6 , shoot = 7}   


      local ballIdx = 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "NormalBall"
      items.balls[ballIdx].coinsCost = 50
      items.balls[ballIdx].gemsCost = 1
      items.balls[ballIdx].image = "balls/NormalBall.png"
      items.balls[ballIdx].imgScale = 1  
      items.balls[ballIdx].id = "NormalBall" 
      items.balls[ballIdx].packCategory = 4
      items.balls[ballIdx].level = 0


      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Old Ball"
      items.balls[ballIdx].coinsCost = 100
      items.balls[ballIdx].gemsCost = 1
      items.balls[ballIdx].image = "balls/OldBall.png"
      items.balls[ballIdx].imgScale = 1  
      items.balls[ballIdx].id = "OldBall" 
      items.balls[ballIdx].packCategory = 4
      items.balls[ballIdx].level = 1


      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "White Ball"
      items.balls[ballIdx].coinsCost = 150
      items.balls[ballIdx].gemsCost = 1
      items.balls[ballIdx].image = "balls/WhiteBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "WhiteBall"       
      items.balls[ballIdx].packCategory = 3
      items.balls[ballIdx].level = 4


       ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Reed Ball"
      items.balls[ballIdx].coinsCost = 300
      items.balls[ballIdx].gemsCost = 2
      items.balls[ballIdx].image = "balls/ReedBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "ReedBall"       
      items.balls[ballIdx].packCategory = 3
      items.balls[ballIdx].level = 5

      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Red Ball"
      items.balls[ballIdx].coinsCost = 400
      items.balls[ballIdx].gemsCost = 2
      items.balls[ballIdx].image = "balls/RedBall.png"
      items.balls[ballIdx].imgScale = 1  
      items.balls[ballIdx].id = "RedBall"       
      items.balls[ballIdx].packCategory = 4
      items.balls[ballIdx].level = 6


       ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Yellow Ball"
      items.balls[ballIdx].coinsCost = 500
      items.balls[ballIdx].gemsCost = 2
      items.balls[ballIdx].image = "balls/YellowBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "YellowBall"       
      items.balls[ballIdx].packCategory = 3
      items.balls[ballIdx].level = 8


      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Cuju Ball"
      items.balls[ballIdx].coinsCost = 100
      items.balls[ballIdx].gemsCost = 4
      items.balls[ballIdx].image = "balls/CujuBall.png"
      items.balls[ballIdx].imgScale = 1      
      items.balls[ballIdx].id = "CujuBall"       
      items.balls[ballIdx].packCategory = 4    
      items.balls[ballIdx].level = 10  
	  
      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Power Ball"      
      items.balls[ballIdx].gemsCost = 6
      items.balls[ballIdx].image = "balls/PowerBall.png"
      items.balls[ballIdx].imgScale = 1   
      items.balls[ballIdx].id = "PowerBall" 
      items.balls[ballIdx].packCategory = 4
      items.balls[ballIdx].level = 11

      

      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Super league White"      
      items.balls[ballIdx].gemsCost = 10
      items.balls[ballIdx].image = "balls/SuperleagueWhiteBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "SuperleagueWhiteBall"       
      items.balls[ballIdx].packCategory = 3
      items.balls[ballIdx].level = 17

      ballIdx =  ballIdx + 1
      items.balls[ballIdx] = {}
      items.balls[ballIdx].name = "Super league Yellow"
      items.balls[ballIdx].gemsCost = 10
      items.balls[ballIdx].image = "balls/SuperleagueYellowBall.png"
      items.balls[ballIdx].imgScale = 1        
      items.balls[ballIdx].id = "SuperleagueYellowBall"       
      items.balls[ballIdx].packCategory = 3
      items.balls[ballIdx].level = 21


       local fieldIdx = 1
      items.fields[fieldIdx] = {}
      items.fields[fieldIdx].name = "Stadium"
      items.fields[fieldIdx].coinsCost = 300
      items.fields[fieldIdx].gemsCost = 2
      items.fields[fieldIdx].image = "images/shop/fields/LVLIconSoccerField.png"
      items.fields[fieldIdx].imgScale = 1  
      items.fields[fieldIdx].id = "Stadium" 
      items.fields[fieldIdx].packCategory = 4
      items.fields[fieldIdx].level = 0


      fieldIdx =  fieldIdx + 1
      items.fields[fieldIdx] = {}
      items.fields[fieldIdx].name = "Glacier"
      items.fields[fieldIdx].coinsCost = 300
      items.fields[fieldIdx].gemsCost = 2
      items.fields[fieldIdx].image = "images/shop/fields/LVLIconIcySeas.png"
      items.fields[fieldIdx].imgScale = 1  
      items.fields[fieldIdx].id = "Glacier" 
      items.fields[fieldIdx].packCategory = 4
      items.fields[fieldIdx].level = 5


      fieldIdx =  fieldIdx + 1
      items.fields[fieldIdx] = {}
      items.fields[fieldIdx].name = "Desert"
      items.fields[fieldIdx].coinsCost = 300
      items.fields[fieldIdx].gemsCost = 2
      items.fields[fieldIdx].image = "images/shop/fields/LVLIconDeasert.png"
      items.fields[fieldIdx].imgScale = 1        
      items.fields[fieldIdx].id = "Desert"       
      items.fields[fieldIdx].packCategory = 3
      items.fields[fieldIdx].level = 7


       fieldIdx =  fieldIdx + 1
      items.fields[fieldIdx] = {}
      items.fields[fieldIdx].name = "Castle"
      items.fields[fieldIdx].coinsCost = 300
      items.fields[fieldIdx].gemsCost = 2
      items.fields[fieldIdx].image = "images/shop/fields/LVLIconCastle.png"
      items.fields[fieldIdx].imgScale = 1        
      items.fields[fieldIdx].id = "Castle"       
      items.fields[fieldIdx].packCategory = 3
      items.fields[fieldIdx].level = 9

      fieldIdx =  fieldIdx + 1
      items.fields[fieldIdx] = {}
      items.fields[fieldIdx].name = "Eagle"
      items.fields[fieldIdx].coinsCost = 300
      items.fields[fieldIdx].gemsCost = 2
      items.fields[fieldIdx].image = "images/shop/fields/LVLIconEagleMountain.png"
      items.fields[fieldIdx].imgScale = 1  
      items.fields[fieldIdx].id = "EagleField"       
      items.fields[fieldIdx].packCategory = 4
      items.fields[fieldIdx].level = 12


       local boostIdx = 1
      
      
      items.boosts[boostIdx] = {}
      items.boosts[boostIdx].name = "Fire"
      items.boosts[boostIdx].coinsCost = 300
      items.boosts[boostIdx].gemsCost = 2
      items.boosts[boostIdx].image = "images/boostparticles/ShopImgToonFire.png"
      items.boosts[boostIdx].imgScale = 1  
      items.boosts[boostIdx].id = "fireBall"       
      items.boosts[boostIdx].packCategory = 4
      items.boosts[boostIdx].level = 1

      boostIdx =  boostIdx + 1
      items.boosts[boostIdx] = {}
      items.boosts[boostIdx].name = "purpleSmoke"
      items.boosts[boostIdx].coinsCost = 400
      items.boosts[boostIdx].gemsCost = 2
      items.boosts[boostIdx].image = "images/boostparticles/ShopImgPurpleSmoke.png"
      items.boosts[boostIdx].imgScale = 1  
      items.boosts[boostIdx].id = "purpleSmoke"       
      items.boosts[boostIdx].packCategory = 4
      items.boosts[boostIdx].level = 2


      boostIdx =  boostIdx + 1
      items.boosts[boostIdx] = {}
      items.boosts[boostIdx].name = "Rainbow"
      items.boosts[boostIdx].coinsCost = 750
      items.boosts[boostIdx].gemsCost = 3
      items.boosts[boostIdx].image = "images/boostparticles/ShopImgRGBBall.png"
      items.boosts[boostIdx].imgScale = 1  
      items.boosts[boostIdx].id = "rgbGlow"       
      items.boosts[boostIdx].packCategory = 4
      items.boosts[boostIdx].level = 3

      

         boostIdx =  boostIdx + 1
      items.boosts[boostIdx] = {}
      items.boosts[boostIdx].name = "Ice"
      items.boosts[boostIdx].coinsCost = 1000
      items.boosts[boostIdx].gemsCost = 4
      items.boosts[boostIdx].image = "images/boostparticles/ShopImgIcyBall.png"
      items.boosts[boostIdx].imgScale = 1  
      items.boosts[boostIdx].id = "ice"       
      items.boosts[boostIdx].packCategory = 4
      items.boosts[boostIdx].level = 6


        boostIdx =  boostIdx + 1
       items.boosts[boostIdx] = {}
      items.boosts[boostIdx].name = "Ultra"
      items.boosts[boostIdx].gemsCost = 5
      items.boosts[boostIdx].image = "images/boostparticles/ClassicFire.png"
      items.boosts[boostIdx].imgScale = 1  
      items.boosts[boostIdx].id = "ultraBall" 
      items.boosts[boostIdx].packCategory = 4
      items.boosts[boostIdx].level = 10

      

       boostIdx =  boostIdx + 1
      items.boosts[boostIdx] = {}
      items.boosts[boostIdx].name = "Electric"
      items.boosts[boostIdx].gemsCost = 6
      items.boosts[boostIdx].image = "images/boostparticles/ShopImgElectric.png"
      items.boosts[boostIdx].imgScale = 1  
      items.boosts[boostIdx].id = "electric"       
      items.boosts[boostIdx].packCategory = 4
      items.boosts[boostIdx].level = 13

      boostIdx =  boostIdx + 1
      items.boosts[boostIdx] = {}
      items.boosts[boostIdx].name = "Pixel"
      items.boosts[boostIdx].gemsCost = 7
      items.boosts[boostIdx].image = "images/boostparticles/PixelFire.png"
      items.boosts[boostIdx].imgScale = 1  
      items.boosts[boostIdx].id = "pixelBall"       
      items.boosts[boostIdx].packCategory = 4
      items.boosts[boostIdx].level = 14

      
     

          local cardIdx = 1
      items.cards[cardIdx] = {}
      items.cards[cardIdx].name = "1 Common Pack"
      items.cards[cardIdx].gemsCost = 1
      items.cards[cardIdx].image = "images/shop/cards/CommonPackItem.png"
      items.cards[cardIdx].imgScale = 1  
      items.cards[cardIdx].id = "1common" 
      items.cards[cardIdx].packCategory = 4
      items.cards[cardIdx].level = 0
      items.cards[cardIdx].commonPacks = 1

       cardIdx =  cardIdx + 1
      items.cards[cardIdx] = {}
      items.cards[cardIdx].name = "1 Rare Pack"
      items.cards[cardIdx].gemsCost = 3
      items.cards[cardIdx].image = "images/shop/cards/RarePackItem.png"
      items.cards[cardIdx].imgScale = 1  
      items.cards[cardIdx].id = "1rare" 
      items.cards[cardIdx].packCategory = 4
      items.cards[cardIdx].level = 0
      items.cards[cardIdx].rarePacks = 1

        cardIdx =  cardIdx + 1
      items.cards[cardIdx] = {}
      items.cards[cardIdx].name = "1 Epic Pack"
      items.cards[cardIdx].gemsCost = 5
      items.cards[cardIdx].image = "images/shop/cards/EpicPackItem.png"
      items.cards[cardIdx].imgScale = 1  
      items.cards[cardIdx].id = "1epic" 
      items.cards[cardIdx].packCategory = 4
      items.cards[cardIdx].level = 0
      items.cards[cardIdx].epicPacks = 1

        cardIdx =  cardIdx + 1
      items.cards[cardIdx] = {}
      items.cards[cardIdx].name = "5 Common Pack"
      items.cards[cardIdx].gemsCost = 4
      items.cards[cardIdx].image = "images/shop/cards/Common5PackItem.png"
      items.cards[cardIdx].imgScale = 1  
      items.cards[cardIdx].id = "5common" 
      items.cards[cardIdx].packCategory = 4
      items.cards[cardIdx].level = 0
      items.cards[cardIdx].commonPacks = 5

       cardIdx =  cardIdx + 1
      items.cards[cardIdx] = {}
      items.cards[cardIdx].name = "5 Rare Packs"
      items.cards[cardIdx].gemsCost = 12
      items.cards[cardIdx].image = "images/shop/cards/RarePack5Item.png"
      items.cards[cardIdx].imgScale = 1  
      items.cards[cardIdx].id = "5rare" 
      items.cards[cardIdx].packCategory = 4
      items.cards[cardIdx].level = 0
      items.cards[cardIdx].rarePacks = 5

        cardIdx =  cardIdx + 1
      items.cards[cardIdx] = {}
      items.cards[cardIdx].name = "5 Epic Packs"
      items.cards[cardIdx].gemsCost = 20
      items.cards[cardIdx].image = "images/shop/cards/EpicPack5Item.png"
      items.cards[cardIdx].imgScale = 1  
      items.cards[cardIdx].id = "5epic" 
      items.cards[cardIdx].packCategory = 4
      items.cards[cardIdx].level = 0
      items.cards[cardIdx].epicPacks = 5

        cardIdx =  cardIdx + 1
      items.cards[cardIdx] = {}
      items.cards[cardIdx].name = "10 Common Packs"
      items.cards[cardIdx].gemsCost = 6
      items.cards[cardIdx].image = "images/shop/cards/Common10PackItem.png"
      items.cards[cardIdx].imgScale = 1  
      items.cards[cardIdx].id = "10common" 
      items.cards[cardIdx].packCategory = 4
      items.cards[cardIdx].level = 0
      items.cards[cardIdx].commonPacks = 10

       cardIdx =  cardIdx + 1
      items.cards[cardIdx] = {}
      items.cards[cardIdx].name = "10 Rare Packs"
      items.cards[cardIdx].gemsCost = 18
      items.cards[cardIdx].image = "images/shop/cards/RarePack10Item.png"
      items.cards[cardIdx].imgScale = 1  
      items.cards[cardIdx].id = "10rare" 
      items.cards[cardIdx].packCategory = 4
      items.cards[cardIdx].level = 0
      items.cards[cardIdx].rarePacks = 10

        cardIdx =  cardIdx + 1
      items.cards[cardIdx] = {}
      items.cards[cardIdx].name = "10 Epic Pack"
      items.cards[cardIdx].gemsCost = 30
      items.cards[cardIdx].image = "images/shop/cards/EpicPack10Item.png"
      items.cards[cardIdx].imgScale = 1  
      items.cards[cardIdx].id = "10epic" 
      items.cards[cardIdx].packCategory = 4
      items.cards[cardIdx].level = 0
      items.cards[cardIdx].epicPacks = 10


   --   items.boosts[boostIdx].color = {r= g b}



    



      
      totalPackChance = 0


for key,cat in pairs(items) do
  for i=1,#cat do
  
    local itemCat = nil
    if cat[i].packCategory then
      itemCat = cat[i].packCategory
      
      local idx

      if packCategories[itemCat] then
      else
        packCategories[itemCat] ={}
      end
       local idx = #packCategories[itemCat] 
       packCategories[itemCat][idx + 1] = cat[i]  

       
      cat[i].itemCategory = key
     
    end  


       if cat[i].level then
            if itemsByLevel[cat[i].level] then
            else
              itemsByLevel[cat[i].level] ={}
            end
             local newIdx = #itemsByLevel[cat[i].level] 
             itemsByLevel[cat[i].level][newIdx + 1] = cat[i]  

       end  
    
  end
end

      M.items = items 
      M.packCategories = packCategories 
      M.itemsByLevel = itemsByLevel
      M.skills = skills

      M.getActiveItems = function (cat)
              local index = 1    
              local activeItems = {}
            
               
            if (items[cat]) then  
                  for i=1,#items[cat] do
                        if (not items[cat][i].hidden) then
                              activeItems[index] =items[cat][i]
                              index = index + 1
                        end          
                  end
            end

            return activeItems
              
      end

return M
