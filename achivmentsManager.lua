local commonData = require( "commonData" )

local achivments = {}
local newAchivments = {}


local challenges = {}
local newChalenges = {}

challenges["reacehedMeters10"] = {}
challenges["reacehedMeters20"] = {}
challenges["reacehedMeters50"] = {}
challenges["reacehedMeters100"] = {}
challenges["reacehedMeters150"] = {}
challenges["reacehedMeters200"] = {}
challenges["reacehedMeters300"] = {}
challenges["kick5time"] = {}
challenges["collectCoin"] = {}
challenges["jumpObstecale"] = {}
--challenges["buyPack"] = {}
-- challenges["swap6"] = {}
--challenges["changeBall"] = {}
challenges["perfect4"] = {}
challenges["perfect6"] = {}
challenges["scoreGoal"] = {}
challenges["noJump60"] = {}
challenges["runFromBully"] = {}
challenges["maxSpeed"] = {}


challenges["collectSpreeCoins"] = {}
challenges["collectSpreeCoins2"] = {}
challenges["topScore350"] = {}
challenges["topScore3100"] = {}

challenges["hattrick"] = {}
challenges["fireGoal"] = {}
challenges["headerGoal"] = {}
challenges["saltaGoal"] = {}
challenges["marathon"] = {}
challenges["goldDigger"] = {}


challenges["reacehedMeters10"].name = "reacehedMeters10"
challenges["reacehedMeters20"].name = "reacehedMeters20"
challenges["reacehedMeters50"].name =  "reacehedMeters50"
challenges["reacehedMeters100"].name =  "reacehedMeters100"
challenges["reacehedMeters150"].name =  "reacehedMeters150"
challenges["reacehedMeters200"].name =  "reacehedMeters200"
challenges["reacehedMeters300"].name =  "reacehedMeters300"
challenges["kick5time"].name =  "kick5time"
challenges["collectCoin"].name =  "collectCoin"
challenges["jumpObstecale"].name =  "jumpObstecale"
--challenges["buyPack"] = {}
-- challenges["swap6"].name =  "swap6"
--challenges["changeBall"] = {}
challenges["perfect4"].name =  "perfect4"
challenges["perfect6"].name =  "perfect6"
challenges["scoreGoal"].name =  "scoreGoal"
challenges["noJump60"].name =  "noJump60"
challenges["runFromBully"].name =  "runFromBully"
challenges["maxSpeed"].name =  "maxSpeed"


challenges["collectSpreeCoins"].name =  "collectSpreeCoins"
challenges["collectSpreeCoins2"].name =  "collectSpreeCoins2"
challenges["topScore350"].name =  "topScore350"
challenges["topScore3100"].name =  "topScore3100"

challenges["hattrick"].name =  "hattrick"
challenges["fireGoal"].name =  "fireGoal"
challenges["headerGoal"].name =  "headerGoal"
challenges["saltaGoal"].name =  "saltaGoal"
challenges["marathon"].name =  "marathon"
challenges["goldDigger"].name =  "goldDigger"


-- challenges["changeShoes"] = {}
-- challenges["changeShirt"] = {}
-- challenges["changePants"] = {}
-- challenges["changeCharacter"] = {}


challenges["reacehedMeters10"].text = "Reach 10 Meters"
challenges["reacehedMeters20"].text = "Reach 20 Meters"
challenges["reacehedMeters50"].text = "Reach 50 Meters"
challenges["reacehedMeters100"].text = "Reach 100 Meters" 
challenges["reacehedMeters150"].text = "Reach 150 Meters"  
challenges["reacehedMeters200"].text = "Reach 200 Meters" 
challenges["reacehedMeters300"].text = "Reach 300 Meters" 
challenges["kick5time"].text = "Kick the ball 5 times"
challenges["collectCoin"].text = "Collect a coin"
challenges["jumpObstecale"].text = "Jump over obstacle"
-- challenges["swap6"].text = "Swap legs 6 times"
challenges["perfect4"].text = "Perfect kick 4 times"
challenges["perfect6"].text = "Perfect kick 6 times"
challenges["scoreGoal"].text = "Score a goal"
challenges["noJump60"].text = "Reach 60 Meters without jumping"
challenges["runFromBully"].text = "Run away from the bully"
challenges["maxSpeed"].text = "Reach maximum speed"
challenges["collectSpreeCoins"].text = "Collect 4 coins in perfect spree"
challenges["collectSpreeCoins2"].text = "Collect 6 coins in perfect spree"
challenges["topScore350"].text = "Reach 50 meters 3 games in a row"
challenges["topScore3100"].text = "Reach 100 meters 3 games in a row"
challenges["hattrick"].text = "Score a goal 3 games in a row"
challenges["fireGoal"].text = "Score a goal with fire ball"
challenges["headerGoal"].text = "Score a goal with a header"
challenges["saltaGoal"].text = "Score a goal with a bicycle kick"
challenges["marathon"].text = "Run a marthon"
challenges["goldDigger"].text = "Collect a coin from the edge"




challenges["reacehedMeters10"].coins = 5
challenges["reacehedMeters20"].coins = 5
challenges["reacehedMeters50"].coins = 10
challenges["reacehedMeters100"].coins = 20
challenges["reacehedMeters150"].coins = 20
challenges["reacehedMeters200"].coins = 30
challenges["reacehedMeters300"].coins = 50
challenges["kick5time"].coins = 5
challenges["collectCoin"].coins = 5
challenges["jumpObstecale"].coins = 5
--challenges["buyPack"].coins = 25
-- challenges["swap6"].coins = 5
--challenges["changeBall"].coins = 25
challenges["perfect4"].coins = 5
challenges["perfect6"].coins = 5
challenges["scoreGoal"].coins = 10
challenges["noJump60"].coins = 20
challenges["runFromBully"].coins = 10
challenges["maxSpeed"].coins = 15
-- challenges["changeShoes"].coins = 25
-- challenges["changeShirt"].coins = 25
-- challenges["changePants"].coins = 25
-- challenges["changeCharacter"].coins = 25

challenges["collectSpreeCoins"].coins = 10
challenges["collectSpreeCoins2"].coins = 10
challenges["topScore350"].coins = 10
challenges["topScore3100"].coins = 20
challenges["hattrick"].coins = 20
challenges["fireGoal"].coins = 30
challenges["headerGoal"].coins = 10
challenges["saltaGoal"].coins = 30
challenges["marathon"].coins = 100
challenges["goldDigger"].coins = 10





challenges["reacehedMeters10"].isUnlocked = false
challenges["reacehedMeters20"].isUnlocked = false
challenges["reacehedMeters50"].isUnlocked = false
challenges["reacehedMeters100"].isUnlocked = false
challenges["reacehedMeters150"].isUnlocked = false
challenges["reacehedMeters200"].isUnlocked = false
challenges["reacehedMeters300"].isUnlocked = false
challenges["kick5time"].isUnlocked = false
challenges["collectCoin"].isUnlocked = false
challenges["jumpObstecale"].isUnlocked = false
--challenges["buyPack"].isUnlocked = false
-- challenges["swap6"].isUnlocked =  (commonData.gameData.abVersion == 3) --false
--challenges["changeBall"].isUnlocked = false
challenges["perfect4"].isUnlocked = false
challenges["perfect6"].isUnlocked = false
challenges["scoreGoal"].isUnlocked = false
challenges["noJump60"].isUnlocked = false
challenges["runFromBully"].isUnlocked = false
challenges["maxSpeed"].isUnlocked = false
-- challenges["changeShoes"].isUnlocked = false
-- challenges["changeShirt"].isUnlocked = false
-- challenges["changePants"].isUnlocked = false
-- challenges["changeCharacter"].isUnlocked = false

challenges["collectSpreeCoins"].isUnlocked = false
challenges["collectSpreeCoins2"].isUnlocked = false
challenges["topScore350"].isUnlocked = false
challenges["topScore3100"].isUnlocked = false

challenges["hattrick"].isUnlocked = false
challenges["fireGoal"].isUnlocked = false
challenges["headerGoal"].isUnlocked = false
challenges["saltaGoal"].isUnlocked = false
challenges["marathon"].isUnlocked = false
challenges["goldDigger"].isUnlocked = false


challenges["reacehedMeters10"].isAvailable = false
challenges["reacehedMeters20"].isAvailable = false
challenges["reacehedMeters50"].isAvailable = false
challenges["reacehedMeters100"].isAvailable = false
challenges["reacehedMeters150"].isAvailable = false
challenges["reacehedMeters200"].isAvailable = false
challenges["reacehedMeters300"].isAvailable = false
challenges["kick5time"].isAvailable = false
challenges["collectCoin"].isAvailable = false
challenges["jumpObstecale"].isAvailable = false
--challenges["buyPack"].isAvailable = false
-- challenges["swap6"].isAvailable = false
--challenges["changeBall"].isAvailable = false
challenges["perfect4"].isAvailable = false
challenges["perfect6"].isAvailable = false
challenges["scoreGoal"].isAvailable = false
challenges["noJump60"].isAvailable = false
challenges["runFromBully"].isAvailable = false
challenges["maxSpeed"].isAvailable = false
-- challenges["changeShoes"].isAvailable = false
-- challenges["changeShirt"].isAvailable = false
-- challenges["changePants"].isAvailable = false
-- challenges["changeCharacter"].isAvailable = false

challenges["collectSpreeCoins"].isAvailable = false
challenges["collectSpreeCoins2"].isAvailable = false
challenges["topScore350"].isAvailable = false
challenges["topScore3100"].isAvailable = false


challenges["hattrick"].isAvailable = false
challenges["fireGoal"].isAvailable = false
challenges["headerGoal"].isAvailable = false
challenges["saltaGoal"].isAvailable = false
challenges["marathon"].isAvailable = false
challenges["goldDigger"].isAvailable = false




local orderIdx = 1 



challenges["kick5time"].order = orderIdx
orderIdx = orderIdx + 1
challenges["reacehedMeters10"].order = orderIdx
orderIdx = orderIdx + 1
challenges["collectCoin"].order = orderIdx
orderIdx = orderIdx + 1
challenges["jumpObstecale"].order = orderIdx
orderIdx = orderIdx + 1
challenges["reacehedMeters20"].order = orderIdx
orderIdx = orderIdx + 1
-- challenges["swap6"].order = orderIdx
-- orderIdx = orderIdx + 1
challenges["perfect4"].order = orderIdx
orderIdx = orderIdx + 1
challenges["reacehedMeters50"].order =orderIdx
orderIdx = orderIdx + 1
challenges["scoreGoal"].order = orderIdx
orderIdx = orderIdx + 1
challenges["perfect6"].order = orderIdx
orderIdx = orderIdx + 1


challenges["reacehedMeters100"].order = orderIdx
orderIdx = orderIdx + 1
-- challenges["buyPack"].order = orderIdx
-- orderIdx = orderIdx + 1
challenges["topScore350"].order = orderIdx
orderIdx = orderIdx + 1

challenges["reacehedMeters150"].order = orderIdx
orderIdx = orderIdx + 1

challenges["goldDigger"].order = orderIdx
orderIdx = orderIdx + 1

-- challenges["changeBall"].order = orderIdx
-- orderIdx = orderIdx + 1
challenges["noJump60"].order = orderIdx
orderIdx = orderIdx + 1
challenges["runFromBully"].order = orderIdx
orderIdx = orderIdx + 1
challenges["collectSpreeCoins"].order = orderIdx
orderIdx = orderIdx + 1

challenges["maxSpeed"].order = orderIdx
orderIdx = orderIdx + 1

challenges["headerGoal"].order = orderIdx
orderIdx = orderIdx + 1

challenges["topScore3100"].order = orderIdx
orderIdx = orderIdx + 1

challenges["hattrick"].order = orderIdx
orderIdx = orderIdx + 1

challenges["reacehedMeters200"].order = orderIdx
orderIdx = orderIdx + 1
challenges["reacehedMeters300"].order = orderIdx
orderIdx = orderIdx + 1

challenges["saltaGoal"].order = orderIdx
orderIdx = orderIdx + 1

challenges["collectSpreeCoins2"].order = orderIdx
orderIdx = orderIdx + 1



challenges["fireGoal"].order = orderIdx
orderIdx = orderIdx + 1


challenges["marathon"].order = orderIdx
orderIdx = orderIdx + 1


-- challenges["changeShoes"].order = orderIdx
-- orderIdx = orderIdx + 1
-- challenges["changeShirt"].order = orderIdx
-- orderIdx = orderIdx + 1
-- challenges["changePants"].order = orderIdx
-- orderIdx = orderIdx + 1
-- challenges["changeCharacter"].order = orderIdx
-- orderIdx = orderIdx + 1


challenges["kick5time"].category = nil
challenges["reacehedMeters10"].category = 1
challenges["collectCoin"].category = nil
challenges["jumpObstecale"].category = nil
challenges["reacehedMeters20"].category = 1
-- challenges["swap6"].category = nil
challenges["perfect4"].category = nil
challenges["reacehedMeters50"].category = 1
challenges["scoreGoal"].category = 4
challenges["perfect6"].category = 2
challenges["reacehedMeters100"].category = 1
--challenges["buyPack"].category = nil
challenges["reacehedMeters150"].category = 1
--challenges["changeBall"].category = nil
challenges["noJump60"].category = nil
challenges["runFromBully"].category = nil
challenges["maxSpeed"].category = nil
challenges["reacehedMeters200"].category = 1
challenges["reacehedMeters300"].category = 1
-- challenges["changeShoes"].category = nil
-- challenges["changeShirt"].category = nil
-- challenges["changePants"].category = nil
-- challenges["changeCharacter"].category = nil

challenges["collectSpreeCoins"].category = 2
challenges["collectSpreeCoins2"].category = 2
challenges["topScore350"].category = 3
challenges["topScore3100"].category = 3


challenges["hattrick"].category = 3
challenges["fireGoal"].category = 4
challenges["headerGoal"].category = 4
challenges["saltaGoal"].category = 4
challenges["marathon"].category = nil
challenges["goldDigger"].category = nil






achivments["LittleDribbler"] = {}
achivments["LittleMexican"] = {}
achivments["LittleBolt"] = {}
achivments["BigMexican"] = {}
achivments["MasterLaSombrero"] = {}
achivments["LittleBigBolt"] = {}
achivments["PiniBalili"] = {}
achivments["BigDribbler"] = {}
achivments["DribbleMaster"] = {}
achivments["LittleBigSpender"] = {}
achivments["YouLittleRunner"] = {}
achivments["NoSkill"] = {}
achivments["LittlePerfectSombrero"] = {}
achivments["LittleGoldDigger"] = {}
achivments["LittleCoward"] = {}
achivments["LittlePerfectCollector"] = {}
achivments["LittleJumper"] = {}
achivments["LittlePerformer"] = {}
achivments["LittleMexicanBird"] = {}
achivments["GOAL"] = {}
achivments["PackWinner"] = {}
achivments["MoneyMachine"] = {}
achivments["LittleBragger"] = {}


achivments["LittleDribbler"].code = 		"CgkI_YzqptgFEAIQAg"
achivments["LittleMexican"].code = 			"CgkI_YzqptgFEAIQCA"
achivments["LittleBolt"].code = 			"CgkI_YzqptgFEAIQAw"
achivments["BigMexican"].code = 			"CgkI_YzqptgFEAIQBg"
achivments["MasterLaSombrero"].code = 		"CgkI_YzqptgFEAIQCQ"
achivments["LittleBigBolt"].code = 			"CgkI5qOApf8bEAIQBw" -- ???
achivments["PiniBalili"].code = 			"CgkI5qOApf8bEAIQIg" 
achivments["BigDribbler"].code = 			"CgkI_YzqptgFEAIQBA"
achivments["DribbleMaster"].code = 			"CgkI5qOApf8bEAIQCw"
achivments["LittleBigSpender"].code = 		"CgkI_YzqptgFEAIQCg"
achivments["YouLittleRunner"].code =  		"CgkI_YzqptgFEAIQCw"
achivments["NoSkill"].code = 				"CgkI5qOApf8bEAIQDg"
achivments["LittlePerfectSombrero"].code =  "CgkI5qOApf8bEAIQDw"
achivments["LittleGoldDigger"].code =	    "CgkI5qOApf8bEAIQEQ"
achivments["LittleCoward"].code = 			"CgkI5qOApf8bEAIQEg"
achivments["LittlePerfectCollector"].code = "CgkI5qOApf8bEAIQEw"
achivments["LittleJumper"].code = 			"CgkI5qOApf8bEAIQFA"
achivments["LittlePerformer"].code = 		"CgkI_YzqptgFEAIQDA"
achivments["LittleMexicanBird"].code = 		"CgkI5qOApf8bEAIQFg"
achivments["GOAL"].code = 					"CgkI_YzqptgFEAIQBQ"
achivments["PackWinner"].code = 			"CgkI_YzqptgFEAIQDQ"
achivments["MoneyMachine"].code = 			"CgkI_YzqptgFEAIQDg"
achivments["LittleBragger"].code = 			"CgkI_YzqptgFEAIQDw"

achivments["LittleDribbler"].isUnlocked = false
achivments["LittleMexican"].isUnlocked = false
achivments["LittleBolt"].isUnlocked = false
achivments["BigMexican"].isUnlocked = false
achivments["MasterLaSombrero"].isUnlocked = false
achivments["LittleBigBolt"].isUnlocked = false
achivments["PiniBalili"].isUnlocked = false
achivments["BigDribbler"].isUnlocked = false
achivments["DribbleMaster"].isUnlocked = false
achivments["LittleBigSpender"].isUnlocked = false
achivments["YouLittleRunner"].isUnlocked = false
achivments["NoSkill"].isUnlocked = false
achivments["LittlePerfectSombrero"].isUnlocked = false

achivments["LittleGoldDigger"].isUnlocked = false
achivments["LittleCoward"].isUnlocked = false
achivments["LittlePerfectCollector"].isUnlocked = false
achivments["LittleJumper"].isUnlocked = false
achivments["LittlePerformer"].isUnlocked = false
achivments["LittleMexicanBird"].isUnlocked = false
achivments["GOAL"].isUnlocked = false
achivments["PackWinner"].isUnlocked = false
achivments["MoneyMachine"].isUnlocked = false
achivments["LittleBragger"].isUnlocked = false



function unlockAchivment(name, autoPost)
	local isNew = false 
	if (not achivments[name].isUnlocked) then
		achivments[name].isUnlocked = true
		newAchivments[name] = achivments[name]
		isNew = true

		if autoPost then
			if ( system.getInfo( "platformName" ) == "Android" ) then
				commonData.gpgs.achievements.unlock({
                                              achievementId=achivments[name].code
                                            })
			else
				commonData.gameNetwork.request( "unlockAchievement", {
	                                            achievement = {
	                                              identifier=achivments[name].code
	                                            }
	                                          }); 
			end	
		end	
	end

	return isNew
end


function unlockChallenge(name)
	local isNew = false 

	
	if (challenges[name] and challenges[name].isAvailable and  not challenges[name].isUnlocked) then
		challenges[name].isUnlocked = true
		newChalenges[name] = challenges[name]
		isNew = true
	end

	return isNew
end

function startGameTracking()
	newAchivments = {}
	newChalenges = {}
end

function initAchivments(pUnlockedAchivments)
	
	if (pUnlockedAchivments) then
		for i=1,#pUnlockedAchivments do
			achivments[pUnlockedAchivments[i]].isUnlocked = true
		end
	end
end

function getUnlockedAchivments()
	local unlockedAchivments = {}
	local index = 1;
	for k,v in pairs(achivments) do
		if (v.isUnlocked) then
			unlockedAchivments[index] = k
			index = index + 1
		end
	end
	
	return unlockedAchivments
end

function getNewUnlockedAchivments()
	local unlockedAchivments = {}
	local index = 1;
	for k,v in pairs(newAchivments) do
	
		unlockedAchivments[index] = v
		index = index + 1
	
	end
	
	return unlockedAchivments
end



function initChallenges(pUnlockedChalenges)
	--print("initAchivments")
	if (pUnlockedChalenges) then
		for i=1,#pUnlockedChalenges do
			if challenges[pUnlockedChalenges[i]] then
				challenges[pUnlockedChalenges[i]].isUnlocked = true
			end
		end
	end
end

function getChallengeByID(challengeId)
	return challenges[challengeId]
end


function getChalenges()
	--print("getChalenges")
	local nextChalenges= {}
	local orderedChalenges= {}
	local locked= {}
	local unlocked= {}
	local categories= {}

	
	local index = 1;
	local lockedIndex = 1;
	local unlockedIndex = 1;


	for k,v in pairs(challenges) do
		--print(k)
		orderedChalenges[v.order] = {}
		orderedChalenges[v.order] = v		
	end

	for i=1,#orderedChalenges do
			--challenges[pUnlockedChalenges[i]].isUnlocked = true
		if (orderedChalenges[i].isUnlocked) then
			unlocked[unlockedIndex] = orderedChalenges[i]			
			unlockedIndex = unlockedIndex + 1
			
		else

			local catExist = false
			if orderedChalenges[i].category  then			
				if categories[orderedChalenges[i].category] then
					catExist = true				
				end

			   categories[orderedChalenges[i].category]  = true			
			end

			if not catExist then
				locked[lockedIndex] = orderedChalenges[i]			
				lockedIndex = lockedIndex + 1		
			end
			
		end
	end
	
	local lockedSlots = 3
	if unlockedIndex < 4  then
		lockedSlots = 7 - unlockedIndex
	end	


	for i= #unlocked , #unlocked -2 , -1 do
			--challenges[pUnlockedChalenges[i]].isUnlocked = true
		if (i > 0) then	
			nextChalenges[index] = unlocked[i]
			index = index + 1
		end
	end

	if index >= 4  then
		local tempChal = nextChalenges[1]
		nextChalenges[1] = nextChalenges[3]
		nextChalenges[3] = tempChal
	end	

	for i= 1, #locked do
		
		locked[i].isAvailable = true
		nextChalenges[index] = locked[i]
		index = index + 1

		if index > 6 then
			break;
		end	
	end

	return nextChalenges
end

function getUnlockedChallenges()
	local unlockedChalenges= {}
	local index = 1;
	for k,v in pairs(challenges) do
		if (v.isUnlocked) then
			unlockedChalenges[index] = k
			index = index + 1
		end
	end
	
	return unlockedChalenges
end

function getNewUnlockedChalenges()
	local unlockedChalenges = {}
	local index = 1;
	for k,v in pairs(newChalenges) do
	
		unlockedChalenges[index] = v
		index = index + 1
	
	end
	
	return unlockedChalenges
end
