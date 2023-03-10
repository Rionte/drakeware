-- Treasure Hunt Simulator

local library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = library.subs.Wait -- Only returns if the GUI has not been terminated. For 'while Wait() do' loops
local pname = game.Players.LocalPlayer.Name
local lplayer = workspace:FindFirstChild(pname)
local inp = game:GetService("UserInputService")
local flySpeed = 100
local flySteps = 2
local bhopSpeed = 30

local PepsisWorld = library:CreateWindow({
    Name = "drakeware"
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

    local OtherSection = GeneralTab:CreateSection({
        Name = "Other"
    })

    local UnloadSection = GeneralTab:CreateSection({
        Name = "Unload"
    })

local THSTab = PepsisWorld:CreateTab({
    Name = "Treasure Hunt Simulator"
})

    local autoTunnelSection = THSTab:CreateSection({
        Name = "Auto Tunnel"
    })

UnloadSection:AddButton({
    Name = "Unload UI",
    Callback = function()
        library.unload()
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

OtherSection:AddSlider({
    Name = "Player Speed",
    Value = 16,
    Precise = 1,
    Min = 0,
    Max = 100,
    Callback = function(v)
        lplayer.Humanoid.WalkSpeed = v
    end
})

OtherSection:AddSlider({
    Name = "Player Jump Power",
    Value = 50,
    Precise = 1,
    Min = 0,
    Max = 100,
    Callback = function(v)
        lplayer.Humanoid.JumpPower = v
    end
})

OtherSection:AddToggle({
    Name = "No Collisions",
    Callback = function(state)
        if state then
            lplayer.HumanoidRootPart.CanCollide = false
        else
            lplayer.HumanoidRootPart.CanCollide = true
        end
    end
})

autoTunnelSection:AddToggle({
    Name = "Auto Tunnel",
    Keybind = 1,
    Callback = function(state)
        tempState = state
        while tempState do
            

            wait()
        end
    end
})