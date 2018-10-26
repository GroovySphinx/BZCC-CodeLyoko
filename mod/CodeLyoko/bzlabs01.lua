--[[
This Lua is for the prototyping of the Code lyoko BZCC mod
The scipt was created by Bzone Lord with awesome help from
Nielk1
JJ (AI_UNIT)
Janne
Black Ensign
]]


local spawned = false;
local testSpawn = false

local WayTow = "xbtoweW"
local Team0T = "xbtoweB"
local Team1T = "xbtoweG"
local Team2T = "xbtoweR"

local Team0 = 0
local Team1 = 1
local Team2 = 2

Ally(Team1, Team0)
Ally(Team2, Team0)
Ally(Team0, Team1)
Ally(Team0, Team2)

local Tower = {}
local TowerTrans = {}
local TowerT = {}

local Team1Tow = {}

local posSet = false



local tics = 0

function Start()
print("starting...")

--SPAWNING TOWERS--
	for i = 1, 8 do
		t = BuildObject("xbtowe",0,("testSpawn%d"):format(i))
		table.insert(Tower, t)
		Trans = GetTransform(t)
		table.insert(TowerTrans, Trans)
	
	end
end

function Update()
Player1 = GetPlayerHandle(1)


--SPAWNING SMOKE/TEAM COLOURS--
	if not spawned then
		for i=1,8 do
			Smoke = BuildObject(Team0T,0, TowerTrans[i]) -- fixed
			table.insert(TowerT, Smoke)
			spawned = true
		end
	end


--CAPTURING TOWERS --
	--if AtTerminal(Player1)==Tower2 and not testSpawn then
	for i=1, #Tower do
		if not testSpawn and Player1==Tower[i] and GetTeamNum(TowerT[i])~=Team1 then
			RemoveObject(TowerT[i])
			TowerT[i] = BuildObject(Team1T,1,TowerTrans[i])
			Tower2R = BuildObject(("xbfact%d"):format(i),1,TowerTrans[i])
			HopOut(Player1)
			table.insert(Team1Tow, Tower[i])
			testSpawn = true
		end
		testSpawn = false
	end

--TELEPORTATION--

	for i = 1, #Tower do
		if InBuilding(Player1) == Tower[i] then
			if GetPosition(Player1).y <= (GetPosition(Tower[i])).y -43 then
				if #Team1Tow~=0 and GetTeamNum(TowerT[i])==Team1 then
					local towerPos = GetPosition(Team1Tow[math.random(# Team1Tow)]) --change to GetRandomFloat
					towerPos.y = towerPos.y - 23
					SetPosition(Player1, towerPos)
				else
					local towerPos = GetPosition(Tower[i])
					towerPos.y = towerPos.y - 23
					SetPosition(Player1, towerPos)
				end
			end
		end
	end

--[[
NEVER USE math.random
first, it's getrandomfloat
store it into a variable and use floor on it
also, account for the edge case
0 to 5.0 for 5 items could give you a very very rare 5.0
so make sure you turn that 5 into a 4
then you'd need to +1 because lua indexes are 1 based, not 0 based
and finally use it as an array index to your array of towers
]]

print(#Team1Tow)
--print(GetPosition(Player1))

end