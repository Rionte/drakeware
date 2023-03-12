local ss = loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
game.CoreGui:FindFirstChild("SimpleSpy2"):Destroy()

local mainLibrary = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Wait = mainLibrary.subs.Wait -- Only returns if the GUI has not been terminated. For 'while Wait() do' loops
local pname = game.Players.LocalPlayer.Name
local flyBypasses = {"none", "back alley sim"}
local flyBypass = flyBypasses[1]
local lplayer = workspace:FindFirstChild(pname)
local inp = game:GetService("UserInputService")
local mouse = game.Players.LocalPlayer:GetMouse()
local flySpeed = 100
local flySteps = 2
local esp
local clickDelay
local packet
local tpTarget = game.Players.LocalPlayer.Name
local speed
local radius
local number_of_parts
local aimTarget
local raycast
local rayToggle
local rayPacket
local useMMR = false
local flySpeedBypass = false
local freeSpeed
local freeSteps
local walkPoint = false
local wtp
local aat
local mmr
local nocl
local flyUseImp
local setCF
local infJump

local gameIDs = {
    142823291, -- Murder Mystery
    1345139196, -- Treasure Hunt
    6403373529, -- Slap Battles
    10108131074, -- Mow The Lawn!
}

for _, v in pairs(gameIDs) do
    if game.PlaceId == v then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Rionte/drakeware/main/" .. v ..  ".lua", true))()
        mainLibrary.unload()
    end
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
                if flyBypass == "none" then
                    while tempState do
                        tempState = state
                        local lplayer = workspace:FindFirstChild(pname)
    
                        if inp:IsKeyDown(Enum.KeyCode.Space) then
                            lplayer.HumanoidRootPart.CFrame += Vector3.new(0, flySteps, 0)
                        end
            
                        if inp:IsKeyDown(Enum.KeyCode.LeftControl) then
                            lplayer.HumanoidRootPart.CFrame += Vector3.new(0, flySteps - flySteps * 2, 0)
                        end
            
                        if flySpeedBypass then
                            if inp:IsKeyDown(Enum.KeyCode.W) then
                                lplayer.HumanoidRootPart:ApplyImpulse(lplayer.HumanoidRootPart.CFrame.LookVector * flySteps)
                            end
                        end
    
                        if flyUseImp then
                            lplayer.HumanoidRootPart:ApplyImpulse(Vector3.new(0, flySteps, 0))
                            lplayer.HumanoidRootPart.Velocity = Vector3.new(lplayer.HumanoidRootPart.Velocity.X, 0, lplayer.HumanoidRootPart.Velocity.Z)
                        end
    
                        if setCF then
                            lplayer.HumanoidRootPart.CFrame += lplayer.HumanoidRootPart.CFrame.LookVector * (speed / 100)
                        end
    
                        if not flyUseImp and not setCF then
                            lplayer.Humanoid.WalkSpeed = flySpeed
                            workspace.Gravity = 0
                            lplayer.Humanoid.JumpPower = 0
                        end
            
                        wait()
                    end
                else
                    workspace.Gravity = 0
                    lplayer.Humanoid.JumpPower = 0
                    flySpeed = 30
                    flySteps = 5

                    task.spawn(function()
                        while tempState do
                            tempState = state

                            if flyBypass == flyBypasses[2] and not inp:IsKeyDown(Enum.KeyCode.Space) and not inp:IsKeyDown(Enum.KeyCode.LeftControl) then
                                lplayer.HumanoidRootPart.CFrame += lplayer.HumanoidRootPart.CFrame.LookVector * (flySpeed / 10)
                                wait(0.5)
                            end

                            wait()
                        end
                    end)

                    while tempState do
                        tempState = state

                        if inp:IsKeyDown(Enum.KeyCode.Space) then
                            lplayer.HumanoidRootPart.CFrame += Vector3.new(0, flySteps, 0)
                        end
            
                        if inp:IsKeyDown(Enum.KeyCode.LeftControl) then
                            lplayer.HumanoidRootPart.CFrame += Vector3.new(0, flySteps - flySteps * 2, 0)
                        end

                        wait()
                    end
                end
        
                if tempState == false then
                    lplayer.Humanoid.WalkSpeed = 17
                    lplayer.Humanoid.JumpPower = 55
                    workspace.Gravity = 200
                    lplayer.Humanoid:ChangeState("Landed")
                end
            end
        })

        FlySection:AddDropdown({
            Name = "Bypass",
            Value = flyBypass,
            List = flyBypasses,
            Callback = function(o)
                flyBypass = o
            end
        })

        FlySection:AddToggle({
            Name = "Speed Bypass",
            Callback = function(state)
                flySpeedBypass = state
            end
        })

        FlySection:AddToggle({
            Name = "Gravity Bypass",
            Callback = function(state)
                flyUseImp = state
            end
        })

        FlySection:AddToggle({
            Name = "Set CFrame Bypass",
            Callback = function(state)
                setCF = state
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
            Name = "Enable",
            Callback = function(state)
                tempState = state
                infJump:Set(false)
                while tempState do
                    tempState = state

                    inp.InputBegan:Connect(function(key)
                        if key.KeyCode == Enum.KeyCode.W or key.KeyCode == Enum.KeyCode.S or key.KeyCode == Enum.KeyCode.A or key.KeyCode == Enum.KeyCode.D then
                            lplayer.HumanoidRootPart.Velocity = Vector3.zero
                            lplayer.HumanoidRootPart:ApplyImpulse(lplayer.HumanoidRootPart.CFrame.LookVector * 2)
                        end
                    end)

                    wait()
                end
            end
        })

    local StrafeSection = GeneralTab:CreateSection({
        Name = "TargetStrafe"
    })

        StrafeSection:AddToggle({
            Name = "Enable",
            Keybind = 1,
            Callback = function(state)
                tempState = state
                local circle = math.pi * 2
                while tempState do
                    tempState = state

                    closest = ""
                    local lplayer = workspace:FindFirstChild(pname)
                    if pcall(function()
                        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                            if not player.Name == game.Players.LocalPlayer.Name and player:FindFirstChild("HumanoidRootPart") and not player.Humanoid:GetState() == Enum.HumanoidStateType.Dead and player.Humanoid.Health > 0 then
                                if closest == "" then
                                    closest = player
                                else
                                    if player:DistanceFromCharacter(lplayer.HumanoidRootPart.Position) < game.Players.LocalPlayer:DistanceFromCharacter(closest.Character.HumanoidRootPart.Position) then
                                        closest = player
                                    end
                                end
                            end
                        end
                    end) then
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
                    else
                        wait()
                        continue
                    end

                    for i=1, number_of_parts do
                        if not tempState then
                            break
                        end

                        local angle = circle / number_of_parts * i
                        local x_pos = math.cos(angle) * radius
                        local y_pos = math.sin(angle) * radius

                        local closestPos = closest.Character.HumanoidRootPart.Position
                        local latx, laty, latz = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, Vector3.new(closestPos.X, closestPos.Y, closestPos.Z)):ToOrientation()

                        if aimTarget then
                            for _, v in pairs(lplayer:GetDescendants()) do
                                if v:IsA("BasePart") then
                                    v.CanCollide = false
                                end
                            end
                            lplayer.HumanoidRootPart.CFrame = workspace:FindFirstChild(closest.name).HumanoidRootPart.CFrame + Vector3.new(x_pos, 0, y_pos)
                            workspace.CurrentCamera.CFrame = CFrame.fromOrientation(latx, laty - 0.1, latz) + workspace:FindFirstChild(closest.name).HumanoidRootPart.CFrame.Position + Vector3.new(x_pos, 0, y_pos)
                        else
                            if walkPoint then
                                lplayer.HumanoidRootPart.Anchored = false
                                lplayer.Humanoid.WalkSpeed = 200
                                lplayer.Humanoid:MoveTo(workspace:FindFirstChild(closest.name).HumanoidRootPart.CFrame.Position + Vector3.new(x_pos, 0, y_pos))
                                local angle = circle / number_of_parts * (i + 1)
                                local x_pos = math.cos(angle) * radius
                                local y_pos = math.sin(angle) * radius
                                local tx, ty, tz = CFrame.lookAt(workspace:FindFirstChild(closest.name).HumanoidRootPart.CFrame.Position + Vector3.new(x_pos, 0, y_pos), Vector3.new(x_pos, 0, y_pos)):ToOrientation()
                                lplayer.HumanoidRootPart.Velocity = Vector3.new(tx, lplayer.HumanoidRootPart.Velocity.Y, tz)
                                lplayer.Humanoid.MoveToFinished:Wait()
                            else
                                for _, v in pairs(lplayer:GetDescendants()) do
                                    if v:IsA("BasePart") then
                                        v.CanCollide = false
                                    end
                                end
                                lplayer.HumanoidRootPart.CFrame = workspace:FindFirstChild(closest.name).HumanoidRootPart.CFrame + Vector3.new(x_pos, 0, y_pos)
                            end

                            if useMMR then
                                local vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(closest.Character.Head.Position)
                                local dist = (Vector2.new(vector.X, vector.Y) - Vector2.new(mouse.X,mouse.Y)).Magnitude
                                local magnitudeX = mouse.X - vector.X
                                local magnitudeY = mouse.Y - vector.Y
                                if onScreen then
                                    mousemoverel(-magnitudeX*0.8, -magnitudeY*0.8)
                                else
                                    mousemoverel(150, 0)
                                end
                            end
                        end

                        if raycast then
                            local rayOrigin = lplayer.HumanoidRootPart.Position
                            local rayDirection =  workspace:FindFirstChild(closest.name).HumanoidRootPart.Position - rayOrigin
                            local params = RaycastParams.new()
                            params.IgnoreWater = true
                            params.FilterType = Enum.RaycastFilterType.Exclude
                            params.FilterDescendantsInstances = {lplayer, closest.Character:FindFirstChildOfClass("Tool")}
                            local ray = workspace:Raycast(rayOrigin, rayDirection, params)

                            if ray and ray.Instance and ray.Instance.Parent.Name == closest.Name then
                                if rayPacket == "click" then
                                    mouse1click()
                                else
                                    if pcall(rayPacket) then
                                        rayPacket()
                                    end
                                end
                            end
                        end

                        wait(speed / 10)
                    end

                    wait()
                end

                if not state then
                    mainLibrary.Notify({ Text = "DISABLED" })
                    lplayer.HumanoidRootPart.Anchored = false
                end
            end
        })

        --[[ wtp = StrafeSection:AddToggle({
            Name = "Walk To Point",
            Callback = function(state)
                if state then
                    walkPoint = true
                    aat:Set(false)
                    aat:Lock()
                    aimTarget = false
                    mmr:Set(false)
                    mmr:Lock()
                    useMMR = false
                else
                    walkPoint = false
                    aat:Unlock()
                    mmr:Unlock()
                end
            end
        }) ]]

        wtp = StrafeSection:AddToggle({
            Name = "Walk To Point",
            Callback = function(state)
                if state then
                    walkPoint = true
                else
                    walkPoint = false
                end
            end
        })
        
        --[[ aat = StrafeSection:AddToggle({
            Name = "Aim At Target",
            Callback = function(state)
                if state then
                    aimTarget = true
                    wtp:Set(false)
                    wtp:Lock()
                    walkPoint = false
                else
                    if not useMMR then
                        wtp:Unlock()
                    end
                    aimTarget = false
                end
            end
        }) ]]

        aat = StrafeSection:AddToggle({
            Name = "Aim At Target",
            Callback = function(state)
                if state then
                    aimTarget = true
                else
                    aimTarget = false
                end
            end
        })

        --[[ mmr = StrafeSection:AddToggle({
            Name = "Use mousemoverel",
            Callback = function(state)
                if state then
                    useMMR = true
                    wtp:Set(false)
                    wtp:Lock()
                    walkPoint = false
                else
                    if not aimTarget then
                        wtp:Unlock()
                    end
                    useMMR = false
                end
            end
        }) ]]

        mmr = StrafeSection:AddToggle({
            Name = "Use mousemoverel",
            Callback = function(state)
                if state then
                    useMMR = true
                else
                    useMMR = false
                end
            end
        })

        --[[ StrafeSection:AddToggle({
            Name = "TEST",
            Callback = function(state)
                if state then
                    wtp:RawSet(true)
                    walkPoint = true
                    aat:RawSet(true)
                    aimTarget = true
                    mmr:RawSet(true)
                    useMMR = true
                else
                    wtp:RawSet(false)
                    walkPoint = false
                    aat:RawSet(false)
                    aimTarget = false
                    mmr:RawSet(false)
                    useMMR = false
                end
            end
        }) ]]

        StrafeSection:AddToggle({
            Name = "Fire Packet on Raycast",
            Callback = function(state)
                if state then
                    raycast = true
                else
                    raycast = false
                end
            end
        })

        StrafeSection:AddTextbox({
            Name = "Packet",
            Value = "",
            Placeholder = "Insert Packet",
            Callback = function(v)
                if v == "click" then
                    rayPacket = v
                else
                    rayPacket = loadstring(v)
                end
            end
        })

        StrafeSection:AddSlider({
            Name = "Speed",
            Value = 0.5,
            Min = 0,
            Max = 1,
            Precise = 1,
            Callback = function(v)
                speed = v
            end
        })

        StrafeSection:AddSlider({
            Name = "Radius",
            Value = 5,
            Min = 0,
            Max = 10,
            Callback = function(v)
                radius = v
            end
        })

        StrafeSection:AddSlider({
            Name = "Precision",
            Value = 50,
            Min = 0,
            Max = 100,
            Callback = function(v)
                number_of_parts = v
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
                        local cameraPosition = workspace.CurrentCamera.CFrame.Position
                        local cameraLookVector = workspace.CurrentCamera.CFrame.LookVector
                        local fov = math.rad(workspace.CurrentCamera.FieldOfView) / 12
                        local closestPart = nil
                        local magnitude = math.huge
                        for _, player in ipairs(game.Players:GetPlayers()) do
                            if player.Character then
                                local direction = player.Character.HumanoidRootPart.Position - cameraPosition
        
                                if magnitude <= direction.Magnitude then continue end
        
                                local angle = math.acos(cameraLookVector:Dot(direction.Unit))
        
                                if angle > fov then continue end

                                local vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(player.Character.Head.Position)
                                local dist = (Vector2.new(vector.X, vector.Y) - Vector2.new(mouse.X,mouse.Y)).Magnitude
                                local magnitudeX = mouse.X - vector.X
                                local magnitudeY = mouse.Y - vector.Y
                                if onScreen then
                                    mousemoverel(-magnitudeX*0.8, -magnitudeY*0.8)
                                else
                                    mousemoverel(150, 0)
                                end
        
                                --workspace.Camera.CFrame = CFrame.lookAt(workspace.Camera.CFrame.Position, Vector3.new(closestPart.Position.X, closestPart.Position.Y + 1.5, closestPart.Position.Z))

                            end
                        end
                    end
                    wait()
                end
            end 
        })
            

    local AutoPacket = GeneralTab:CreateSection({
        Name = "Auto-Packet",
        Side = "Right"
    })

        AutoPacket:AddToggle({
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

        AutoPacket:AddTextbox({
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

        AutoPacket:AddSlider({
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

    local FreecamSection = GeneralTab:CreateSection({
        Name = "Freecam"
    })

        FreecamSection:AddToggle({
            Name = "Enable",
            Keybind = 1,
            Callback = function(state)
                tempState = state

                if tempState then
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
                    lplayer.HumanoidRootPart.Anchored = true
                else
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                    lplayer.HumanoidRootPart.Anchored = false
                end

                while tempState do
                    tempState = state

                    if inp:IsKeyDown(Enum.KeyCode.W) then
                        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame + Vector3.new(0, 0, freeSpeed / 15)
                    end

                    if inp:IsKeyDown(Enum.KeyCode.S) then
                        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame + Vector3.new(0, 0, -freeSpeed / 15)
                    end

                    if inp:IsKeyDown(Enum.KeyCode.A) then
                        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame + Vector3.new(freeSpeed / 15, 0, 0)
                    end

                    if inp:IsKeyDown(Enum.KeyCode.D) then
                        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame + Vector3.new(-freeSpeed / 15, 0, 0)
                    end

                    if inp:IsKeyDown(Enum.KeyCode.Space) then
                        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, freeSteps, 0)
                    end
        
                    if inp:IsKeyDown(Enum.KeyCode.LeftControl) then
                        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, freeSteps - freeSteps * 2, 0)
                    end

                    wait()
                end
            end 
        })

        FreecamSection:AddSlider({
            Name = "Freecam Speed",
            Value = 50,
            Min = 0,
            Max = 100,
            Callback = function(v)
                freeSpeed = v
            end
        })

        FreecamSection:AddSlider({
            Name = "Freecam Steps",
            Value = 2,
            Min = 0,
            Max = 5,
            Callback = function(v)
                freeSteps = v
            end
        })

    local BlinkSection = GeneralTab:CreateSection({
        Name = "Blink"
    })

        BlinkSection:AddToggle({
        Name = "Enable",
        Keybind = 1,
        Callback = function(state)
            local clones = {}
            tempState = state

            while tempState do
                lplayer.Archivable = true
                local cloned = lplayer:Clone()
                table.insert(clones, cloned)
                cloned.Parent = workspace
                cloned.HumanoidRootPart.CFrame = lplayer.HumanoidRootPart.CFrame
                cloned.Name = ""
                cloned.Humanoid.DisplayDistanceType = "None"
                cloned.HumanoidRootPart.Anchored = true

                task.spawn(function()
                    for i,v in pairs(cloned:GetDescendants()) do
                        if v:IsA("BasePart") or v:IsA("Decal") then
                            v.Transparency = 0.5
                        end
                    end

                    wait(3)

                    cloned:Destroy()
                end)

                wait(0.25)
            end

            if not tempState then
                for _, v in pairs(clones) do
                    v:Destroy()
                end
            end
        end
    })

    local OtherSection = GeneralTab:CreateSection({
        Name = "Other",
        Side = "Right"
    })

        OtherSection:AddSlider({
            Name = "Player Speed",
            Value = 16,
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
                local function noclip()
                    for _, v in pairs(lplayer:GetDescendants()) do
                        if v:IsA("BasePart") and v.CanCollide then
                            v.CanCollide = false
                        end
                    end
                end

                if state then
                    nocl = game.RunService.Stepped:Connect(noclip)
                else
                    print("STOPPED")
                    nocl:Disconnect()
                end
            end
        })
        
        infJump = OtherSection:AddToggle({
            Name = "Infinite Jump",
            Callback = function(state)
                tempState = state

                game:GetService("UserInputService").JumpRequest:connect(function()
                    if tempState then
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