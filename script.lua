wait()
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- @CloneTrooper1019, 2015
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Tool = Instance.new("HopperBin")
Tool.Parent = game.Players.LocalPlayer.Backpack
Tool.Name = "NoClip"

wait(1)
local c = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local userInput = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local starterPlayer = game:GetService("StarterPlayer")

local selected = false
local speed = 60
local lastUpdate = 0

function getNextMovement(deltaTime)
	local nextMove = Vector3.new()
	-- Left/Right
	if userInput:IsKeyDown("A") or userInput:IsKeyDown("Left") then
		nextMove = Vector3.new(-1,0,0)
	elseif userInput:IsKeyDown("D") or userInput:IsKeyDown("Right") then
		nextMove = Vector3.new(1,0,0)
	end
	-- Forward/Back
	if userInput:IsKeyDown("W") or userInput:IsKeyDown("Up") then
		nextMove = nextMove + Vector3.new(0,0,-1)
	elseif userInput:IsKeyDown("S") or userInput:IsKeyDown("Down") then
		nextMove = nextMove + Vector3.new(0,0,1)
	end
	-- Up/Down
	if userInput:IsKeyDown("Space") then
		nextMove = nextMove + Vector3.new(0,1,0)
	elseif userInput:IsKeyDown("LeftControl") then
		nextMove = nextMove + Vector3.new(0,-1,0)
	end
	return CFrame.new( nextMove * (speed * deltaTime) )
end

game.Players.LocalPlayer.Backpack.NoClip.Selected:connect()
	local char = player.Character
	if char then
		local humanoid = char:WaitForChild("Humanoid")
		local root = char:WaitForChild("HumanoidRootPart")
		currentPos = root.Position
		selected = true
		root.Anchored = true
		lastUpdate = tick()
		humanoid.PlatformStand = true
		while selected do
			wait()
			local delta = tick()-lastUpdate
			local look = (c.Focus.p-c.CoordinateFrame.p).unit
			local move = getNextMovement(delta)
			local pos = root.Position
			root.CFrame = CFrame.new(pos,pos+look) * move
			lastUpdate = tick()
		end
		root.Anchored = false
		root.Velocity = Vector3.new()
		humanoid.PlatformStand = false
	end

game.Players.LocalPlayer.Backpack.NoClip.Deselected:connect()
	selected = false