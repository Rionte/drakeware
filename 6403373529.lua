-- Slap Battles

local mainLibrary = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = mainLibrary.subs.Wait -- Only returns if the GUI has not been terminated. For 'while Wait() do' loops
local pname = game.Players.LocalPlayer.Name
local lplayer = workspace:FindFirstChild(pname)
local inp = game:GetService("UserInputService")
local flySpeed = 100
local flySteps = 2
local bhopSpeed = 30
local esp
local closest

local PepsisWorld = mainLibrary:CreateWindow({
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

local SBTab = PepsisWorld:CreateTab({
    Name = "Slap Battles"
})

    local KASection = SBTab:CreateSection({
        Name = "Killaura"
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
        local lplayer = workspace:FindFirstChild(pname)
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
        local lplayer = workspace:FindFirstChild(pname)
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

OtherSection:AddToggle({
    Name = "Infinite Jump",
    Callback = function(state)
        game:GetService("UserInputService").JumpRequest:connect(function()
            if state then
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
            end
        end)

        if not state then
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Standing")
        end
    end
})

OtherSection:AddToggle({
    Name = "ESP",
    Callback = function(state)
        while state do
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if not player.Character:FindFirstChildOfClass("Highlight") then
                    esp = Instance.new("Highlight")
                    esp.Name = "esp"
                    esp.FillColor = Color3.new(0, 0, 255)
                    esp.Parent = player.Character
                end
            end
            
            wait(5)
        end

        if not state then
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player.Character:FindFirstChildOfClass("Highlight") then
                    player.Character.esp:Destroy()
                end
            end
        end
    end
})

OtherSection:AddToggle({
    Name = "No Collisions",
    Callback = function(state)
        if state then
            lplayer.HumanoidRootPart.Anchored = true
        else
            lplayer.HumanoidRootPart.Anchored = false
        end
    end
})

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

KASection:AddToggle({
    Name = "Killaura",
    Callback = function(state)
        local part = game:GetService("Workspace").Lobby.GloveStands.Diamond.SlapsInfoPart
        tempState = state
        while tempState do
            tempState = state
            
            closest = "";
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player.Name == game.Players.LocalPlayer.Name == false then
                    if closest == "" then
                        closest = player
                    else
                        if player:DistanceFromCharacter(lplayer.HumanoidRootPart.Position) < game.Players.LocalPlayer:DistanceFromCharacter(closest.Character.HumanoidRootPart.Position) then
                            closest = player
                        end
                    end
                end
            end

            local closestH = closest.Character.HumanoidRootPart
            lplayer.HumanoidRootPart.CFrame = CFrame.lookAt(lplayer.HumanoidRootPart.Position, Vector3.new(closestH.Position.X, lplayer.HumanoidRootPart.Position.Y, closestH.Position.Z))

            local args = {
                [1] = game:GetService("Players"):FindFirstChild(closest.Name).Character:FindFirstChild("Head")
            }

            game:GetService("ReplicatedStorage").b:FireServer(unpack(args))

            wait()
        end
    end
})