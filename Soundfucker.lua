-- GUI para tocar som local (feito para exploit)

-- Remover GUIs antigas, se houver
if game.CoreGui:FindFirstChild("MusicGui") then
    game.CoreGui.MusicGui:Destroy()
end

-- Criar ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "MusicGui"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

-- Criar frame principal
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Criar botão de fechar (X)
local closeButton = Instance.new("TextButton", frame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "❌"
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextScaled = true
closeButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.BorderSizePixel = 0

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Criar título
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "Tocar Música (Som Local)"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left

-- Caixa de texto para ID da música
local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.9, 0, 0, 40)
textBox.Position = UDim2.new(0.05, 0, 0.3, 0)
textBox.PlaceholderText = "ID da música"
textBox.Text = ""
textBox.TextColor3 = Color3.new(0, 0, 0)
textBox.Font = Enum.Font.SourceSans
textBox.TextScaled = true
textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

-- Botão "Tocar"
local playButton = Instance.new("TextButton", frame)
playButton.Size = UDim2.new(0.42, 0, 0, 40)
playButton.Position = UDim2.new(0.05, 0, 0.65, 0)
playButton.Text = "Tocar"
playButton.Font = Enum.Font.SourceSansBold
playButton.TextScaled = true
playButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
playButton.TextColor3 = Color3.new(1, 1, 1)

-- Botão "Pausar"
local pauseButton = Instance.new("TextButton", frame)
pauseButton.Size = UDim2.new(0.42, 0, 0, 40)
pauseButton.Position = UDim2.new(0.53, 0, 0.65, 0)
pauseButton.Text = "Pausar"
pauseButton.Font = Enum.Font.SourceSansBold
pauseButton.TextScaled = true
pauseButton.BackgroundColor3 = Color3.fromRGB(170, 85, 0)
pauseButton.TextColor3 = Color3.new(1, 1, 1)

-- Referência ao som
local currentSound = nil

-- Lógica do botão Tocar
playButton.MouseButton1Click:Connect(function()
    local id = textBox.Text
    if not tonumber(id) then return end

    local soundService = game:GetService("SoundService")

    -- Se já existe um som, apenas dá play de novo
    if currentSound and currentSound:IsDescendantOf(soundService) then
        currentSound:Play()
        return
    end

    -- Remover som antigo
    for _, s in pairs(soundService:GetChildren()) do
        if s:IsA("Sound") and s.Name == "ExploitMusic" then
            s:Destroy()
        end
    end

    -- Criar novo som
    local sound = Instance.new("Sound")
    sound.Name = "ExploitMusic"
    sound.SoundId = "rbxassetid://" .. id
    sound.Volume = 1
    sound.Looped = true
    sound.Parent = soundService
    sound:Play()
    currentSound = sound
end)

-- Lógica do botão Pausar
pauseButton.MouseButton1Click:Connect(function()
    if currentSound and currentSound.IsPlaying then
        currentSound:Pause()
    end
end)
