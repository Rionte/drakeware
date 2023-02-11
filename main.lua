local mainLibrary = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = mainLibrary.subs.Wait -- Only returns if the GUI has not been terminated. For 'while Wait() do' loops
local pname = game.Players.LocalPlayer.Name
local lplayer = workspace:FindFirstChild(pname)
local inp = game:GetService("UserInputService")
local flySpeed = 100
local flySteps = 2
local bhopSpeed = 30
local selectedGame = "MM"

local gameList = {
    "MM"
}

local PepsisWorld = mainLibrary:CreateWindow({
    Name = "drakeware",
})

local GeneralTab = PepsisWorld:CreateTab({
    Name = "General"
})

local FlySection = GeneralTab:CreateSection({
    Name = "Fly"
})

local BhopSection = GeneralTab:CreateSection({
    Name = "Bhop"
})

local loadGameSection = GeneralTab:CreateSection({
    Name = "Load Game"
})

local UnloadSection = GeneralTab:CreateSection({
    Name = "Unload"
})

loadGameSection:AddDropdown({
    Name = "Game",
    List = gameList,
    Callback = function(v)
        selectedGame = v
        print(selectedGame)
    end
})

loadGameSection:AddButton({
    Name = "Add Game",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Rionte/drakeware/main/murdermystery.lua", true))()
        mainLibrary.unload()
    end
})

UnloadSection:AddButton({
    Name = "Unload UI",
    Callback = function()
        mainLibrary.unload()
    end
})

FlySection:AddToggle({
    Name = "Fly",
    Keybind = 1,
    Callback = function(state)
        tempState = state
        local lplayer = workspace:FindFirstChild(pname)
        lplayer.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        while tempState do
            tempState = state
            local lplayer = workspace:FindFirstChild(pname)

            lplayer.Humanoid.WalkSpeed = flySpeed
            workspace.Gravity = 0
            lplayer.Humanoid.JumpPower = 0

            if inp:IsKeyDown(Enum.KeyCode.Space) then
                lplayer.HumanoidRootPart.CFrame = lplayer.HumanoidRootPart.CFrame * CFrame.new(0, flySteps, 0)
            end

            if inp:IsKeyDown(Enum.KeyCode.LeftControl) then
                lplayer.HumanoidRootPart.CFrame = lplayer.HumanoidRootPart.CFrame * CFrame.new(0, flySteps - flySteps * 2, 0)
            end

            wait(0.01)
        end

        if tempState == false then
            lplayer.Humanoid.WalkSpeed = 17
            lplayer.Humanoid.JumpPower = 55
            workspace.Gravity = 200
            lplayer.Humanoid:ChangeState("Landed")
        end
    end
})

FlySection:AddSlider({
    Name = "Speed",
    Value = 100,
    Precise = 1,
    Min = 0,
    Max = 200,
    Callback = function(v)
        flySpeed = v
    end
})

FlySection:AddSlider({
    Name = "Steps",
    Value = 2,
    Precise = 1,
    Min = 0,
    Max = 5,
    Callback = function(v)
        flySteps = v
    end
})

BhopSection:AddToggle({
    Name = "Bhop",
    Keybind = 1,
    Callback = function(state)
        tempState = state
        -- temp = false
        while tempState do
            local lplayer = workspace:FindFirstChild(pname)
            lplayer.Humanoid.Jump = true
            lplayer.Humanoid.WalkSpeed = bhopSpeed

            if inp:IsKeyDown(Enum.KeyCode.A) or inp:IsKeyDown(Enum.KeyCode.D) or inp:IsKeyDown(Enum.KeyCode.W) or inp:IsKeyDown(Enum.KeyCode.S) then
                if atemp == true then
                    lplayer.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    lplayer.HumanoidRootPart.CFrame = lplayer.HumanoidRootPart.CFrame * CFrame.new(0, 0, (bhopSpeed - bhopSpeed * 2) / 100)
                end
                atemp = false
                lplayer.HumanoidRootPart.CFrame = lplayer.HumanoidRootPart.CFrame * CFrame.new(0, 0, (bhopSpeed - bhopSpeed * 2) / 100)
            else
                atemp = true
            end

            wait()
        end

        if tempState == false then
            lplayer.Humanoid.WalkSpeed = 17
        end
    end
})

BhopSection:AddSlider({
    Name = "Speed",
    Value = 30,
    Precise = 1,
    Min = 0,
    Max = 100,
    Callback = function(v)
        bhopSpeed = v
    end
})