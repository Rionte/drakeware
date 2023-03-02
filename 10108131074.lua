local mainLibrary = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = mainLibrary.subs.Wait -- Only returns if the GUI has not been terminated. For 'while Wait() do' loops
local pname = game.Players.LocalPlayer.Name
local lplayer = workspace:FindFirstChild(pname)
local inp = game:GetService("UserInputService")
local flySpeed = 100
local flySteps = 2
local bhopSpeed = 30
local mouse = game.Players.LocalPlayer:GetMouse()
local esp
local cclosest
local cdistance
local clickDelay
local packet
local tpTarget = game.Players.LocalPlayer.Name

local worlds = {
    "1",
    "2",
    "3"
}
local world

local zones = {}
local zone

for i = 1, 30 do
    table.insert(zones, i)
end

local PepsisWorld = mainLibrary:CreateWindow({
    Name = "drakeware"
})

local GeneralTab = PepsisWorld:CreateTab({
    Name = "General"
})

    local FlySection = GeneralTab:CreateSection({
        Name = "Fly"
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

    local BhopSection = GeneralTab:CreateSection({
        Name = "Bhop"
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

    local AimbotSection = GeneralTab:CreateSection({
        Name = "Aimbot (Universal)"
    })

        AimbotSection:AddToggle({
            Name = "Aimbot",
            Keybind = 1,
            Callback = function(state)
                tempState = state
                while tempState do
                    if inp:IsKeyDown(Enum.KeyCode.LeftShift) then
                        local cameraPosition = game.Workspace.CurrentCamera.CFrame.Position
                        local cameraLookVector = game.Workspace.CurrentCamera.CFrame.LookVector
                        local fov = math.rad(game.Workspace.CurrentCamera.FieldOfView) / 12
                        local closestPart = nil
                        local magnitude = math.huge
                        for _, player in ipairs(game.Players:GetPlayers()) do
                            if player.Character then
                                local direction = player.Character.HumanoidRootPart.Position - cameraPosition
        
                                if magnitude <= direction.Magnitude then continue end
        
                                local angle = math.acos(cameraLookVector:Dot(direction.Unit))
        
                                if angle > fov then continue end
        
                                closestPart = player.Character.HumanoidRootPart
                                magnitude = direction.Magnitude
        
                                workspace.Camera.CFrame = CFrame.lookAt(workspace.Camera.CFrame.Position, Vector3.new(closestPart.Position.X, closestPart.Position.Y + 1.5, closestPart.Position.Z))
                            end
                        end
                    end
                    wait()
                end
            end 
        })
            

    local AutoClickSection = GeneralTab:CreateSection({
        Name = "Auto-Packet"
    })

        AutoClickSection:AddToggle({
            Name = "Execute Packet",
            Keybind = 1,
            Callback = function(state)
                tempState = state
                while tempState do
                    packet()
        
                    wait(clickDelay)
                end
            end
        })

        AutoClickSection:AddTextbox({
            Name = "Packet",
            Value = "",
            Placeholder = "Insert Packet",
            MultiLine = true,
            Rich = true,
            Scaled = true,
            Callback = function(v)
                packet = loadstring(v)
            end
        })

        AutoClickSection:AddSlider({
            Name = "Delay",
            Value = 1,
            Precise = 1,
            Min = 0,
            Max = 5,
            Callback = function(v)
                clickDelay = v
            end
        })

    local TPSection = GeneralTab:CreateSection({
        Name = "Teleport To Player",
        Side = "Right"
    })

        TPSection:AddTextbox({
            Name = "Player",
            Value = "",
            Placeholder = "Player Name",
            Callback = function(v)
                tpTarget = v
                if workspace:FindFirstChild(tpTarget).HumanoidRootPart then
                    print("YES")
                else
                    print("NO")
                end
            end
        })

        TPSection:AddButton({
            Name = "Teleport",
            Callback = function()
                local lplayer = workspace:FindFirstChild(pname)
                lplayer.HumanoidRootPart.CFrame = workspace:FindFirstChild(tpTarget):FindFirstChild("HumanoidRootPart").CFrame
            end
        })

    local OtherSection = GeneralTab:CreateSection({
        Name = "Other",
        Side = "Right"
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
            Name = "Anchored",
            Callback = function(state)
                if state then
                    lplayer.HumanoidRootPart.Anchored = true
                else
                    lplayer.HumanoidRootPart.Anchored = false
                end
            end
        })

    local UnloadSection = GeneralTab:CreateSection({
        Name = "Unload",
        Side = "Right"
    })

        UnloadSection:AddButton({
            Name = "Unload UI",
            Callback = function()
                mainLibrary.unload()
            end
        })

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local MowTab = PepsisWorld:CreateTab({
    Name = "Mow The Lawn"
})

    local SwapZones = MowTab:CreateSection({
        Name = "Swap Zones"
    })

        SwapZones:AddDropdown({
            Name = "Swap World",
            List = worlds,
            Value = worlds[1],
            Callback = function(v)
                world = v
            end
        })

        SwapZones:AddDropdown({
            Name = "Swap Zone",
            List = zones,
            Value = zones[1],
            Callback = function(v)
                zone = v
            end
        })

    local AutoDamage = MowTab:CreateSection({
        Name = "Auto-Damage"
    })

        AutoDamage:AddToggle({
            Name = "Auto-Damage",
            Callback = function(state)
                tempState = state
                while tempState do
                    tempState = state

                    for _, v in pairs(workspace.Map.Zones:FindFirstChild(world):FindFirstChild(zone).Obstacles:GetChildren()) do
                        local args = {
                            [1] = workspace.Map.Zones:FindFirstChild(world):FindFirstChild(zone).Obstacles:FindFirstChild(v.name),
                            [2] = true
                        }

                        game:GetService("ReplicatedStorage").Remotes.Game.ClientToggleDamageObstacle:FireServer(unpack(args))

                        local args = {
                            [1] = workspace.Map.Zones:FindFirstChild(world):FindFirstChild(zone).Obstacles:FindFirstChild(v.name),
                            [2] = true
                        }

                        game:GetService("ReplicatedStorage").Remotes.Game.Pet.ClientToggleTargetPetsAttackObstacle:FireServer(unpack(args))
                    end

                    wait(1)
                end
            end
        })

    local ExtraSection = MowTab:CreateSection({
        Name = ""
    })
    
        ExtraSection:AddToggle({
            Name = "Auto Mow",
            Callback = function(state)
                tempState = state
                while tempState do
                    tempState = state

                    local args = {
                        [1] = tostring(zone)
                    }

                    game:GetService("ReplicatedStorage").Remotes.Game.ClientMowGrass:FireServer(unpack(args))


                    wait()
                end
            end
        })

        ExtraSection:AddButton({
            Name = "Refill",
            Callback = function()
                local args = {
                    [1] = workspace.Map.Zones:FindFirstChild(world):FindFirstChild(zone).GasStation.GasPumps,
                    [2] = true
                }

                game:GetService("ReplicatedStorage").Remotes.Game.ClientToggleUseGasStation:FireServer(unpack(args))
            end
        })