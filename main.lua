-- local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Rionte/drakeware/main/customui.lua"))()
local Wait = library.subs.Wait -- Only returns if the GUI has not been terminated. For 'while Wait() do' loops
local pname = game.Players.LocalPlayer.Name
local lplayer = workspace:FindFirstChild(pname)
local lc = 0
local inp = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local flySpeed = 100
local flySteps = 2
local bhopSpeed = 30
local glow
local gunGlow
local sheriffGlow
local callOutToggle = false
local foundGun = false

local PepsisWorld = library:CreateWindow({
    Name = "drakeware",
    Themeable = {
        Info = "Discord Server: VzYTJ7Y"
    }
})

local GeneralTab = PepsisWorld:CreateTab({
    Name = "General"
})

local MMTab = PepsisWorld:CreateTab({
    Name = "Murder Mystery"
})

local FlySection = GeneralTab:CreateSection({
    Name = "Fly"
})

local BhopSection = GeneralTab:CreateSection({
    Name = "Bhop"
})

local MurderFinderSection = MMTab:CreateSection({
    Name = "Murderer Finder"
})

local SheriffFinderSection = MMTab:CreateSection({
    Name = "Sheriff Finder"
})

local GunFinderSection = MMTab:CreateSection({
    Name = "Gun Drop Finder"
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

MurderFinderSection:AddToggle({
    Name = "Murderer ESP",
    Keybind = 1,
    Callback = function(state)
        tempState = state
        local lplayer = workspace:FindFirstChild(pname)
        while tempState do
            for _, player in game.Players:GetPlayers() do
                if player.Character:FindFirstChild("Knife") then
                    if not player.Character:FindFirstChildOfClass("Highlight") then
                        glow = Instance.new("Highlight")
                        glow.Parent = player.Character

                        if callOutToggle then
                            local args = {
                                [1] = player.Name .. " is the murderer!",
                                [2] = "normalchat"
                            }
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))                            
                        end
                    end
                end
            end

            print("MURDER")
            wait(0.2)
        end

        if tempState == false then
            glow:Destroy()
        end
    end
})

MurderFinderSection:AddToggle({
    Name = "Auto Call Out",
    Callback = function(state)
        callOutToggle = state
    end
})

SheriffFinderSection:AddToggle({
    Name = "Sheriff ESP",
    Callback = function(state)
        tempState = state
        local lplayer = workspace:FindFirstChild(pname)
        while tempState do
            for _, player in game.Players:GetPlayers() do
                if player.Character:FindFirstChild("Gun") then
                    if not player.Character:FindFirstChildOfClass("Highlight") then
                        sheriffGlow = Instance.new("Highlight")
                        sheriffGlow.FillColor = Color3.new(0, 255, 0)
                        sheriffGlow.Parent = player.Character
                    end
                end
            end

            print("SHERIFF")
            wait(1)
        end

        if tempState == false then
            sheriffGlow:Destroy()
        end
    end
})

GunFinderSection:AddToggle({
    Name = "Gun Drop ESP",
    Callback = function(state)
        tempState = state
        local lplayer = workspace:FindFirstChild(pname)
        while tempState do
            if workspace:FindFirstChild("GunDrop") then
                if not workspace.GunDrop:FindFirstChildOfClass("Highlight") then
                    gunGlow = Instance.new("Highlight")
                    gunGlow.FillColor = Color3.new(0, 0, 255)
                    gunGlow.Parent = workspace.GunDrop
                    foundGun = true
                end
            end

            print("GUN")
            wait(1)
        end

        if tempState == false then
            foundGun = false
        end
    end
})

GunFinderSection:AddButton({
    Name = "Teleport To Gun",
    Callback = function()
        if foundGun then
            local lplayer = workspace:FindFirstChild(pname)
            lplayer.HumanoidRootPart.CFrame = workspace.GunDrop.CFrame
        end
    end
})