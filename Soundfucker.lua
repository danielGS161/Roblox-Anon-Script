-- GUI para tocar som local com debug (feito para exploit)

if game.CoreGui:FindFirstChild("MusicGui") then
    game.CoreGui.MusicGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "MusicGui"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 230)
frame.Position = UDim2.new(0.5, -150, 0.5, -115)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Botão Fechar
local closeButton = Instance.new("TextButton", frame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "❌"
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextScaled = true
closeButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Título
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "Tocar Música + Debug"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left

-- Input de ID
local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.9, 0, 0, 40)
textBox.Position = UDim2.new(0.05, 0, 0.25, 0)
textBox.PlaceholderText = "ID da música"
textBox.Text = ""
textBox.TextColor3 = Color3.new(0, 0, 0)
textBox.Font = Enum.Font.SourceSans
textBox.TextScaled = true
textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

-- Botão Tocar
local playButton = Instance.new("TextButton", frame)
playButton.Size = UDim2.new(0.42, 0, 0, 40)
playButton.Position = UDim2.new(0.05, 0, 0.5, 0)
playButton.Text = "Tocar"
playButton.Font = Enum.Font.SourceSansBold
playButton.TextScaled = true
playButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
playButton.TextColor3 = Color3.new(1, 1, 1)

-- Botão Pausar
local pauseButton = Instance.new("TextButton", frame)
pauseButton.Size = UDim2.new(0.42, 0, 0, 40)
pauseButton.Position = UDim2.new(0.53, 0, 0.5, 0)
pauseButton.Text = "Pausar"
pauseButton.Font = Enum.Font.SourceSansBold
pauseButton.TextScaled = true
pauseButton.BackgroundColor3 = Color3.fromRGB(170, 85, 0)
pauseButton.TextColor3 = Color3.new(1, 1, 1)

-- Botão Verificar FilteringEnabled
local checkButton = Instance.new("TextButton", frame)
checkButton.Size = UDim2.new(0.9, 0, 0, 30)
checkButton.Position = UDim2.new(0.05, 0, 0.8, 0)
checkButton.Text = "Verificar FilteringEnabled"
checkButton.Font = Enum.Font.SourceSansBold
checkButton.TextScaled = true
checkButton.BackgroundColor3 = Color3.fromRGB(0, 90, 170)
checkButton.TextColor3 = Color3.new(1, 1, 1)

-- Variável global do som
local currentSound = nil

-- Tocar
playButton.MouseButton1Click:Connect(function()
    local id = textBox.Text
    if not tonumber(id) then
        warn("[Música] ID inválido.")
        return
    end

    local soundService = game:GetService("SoundService")

    -- Reusar se já existir
    if currentSound and currentSound:IsDescendantOf(soundService) then
        currentSound:Play()
        warn("[Música] Reproduzindo som existente.")
        return
    end

    -- Limpar anteriores
    for _, s in pairs(soundService:GetChildren()) do
        if s:IsA("Sound") and s.Name == "ExploitMusic" then
            s:Destroy()
        end
    end

    -- Criar som
    local sound = Instance.new("Sound")
    sound.Name = "ExploitMusic"
    sound.SoundId = "rbxassetid://" .. id
    sound.Volume = 1
    sound.Looped = true
    sound.Parent = soundService
    sound:Play()

    currentSound = sound
    warn("[Música] Tocando: " .. sound.SoundId)
end)

-- Pausar
pauseButton.MouseButton1Click:Connect(function()
    if currentSound and currentSound.IsPlaying then
        currentSound:Pause()
        warn("[Música] Pausado.")
    else
        warn("[Música] Nenhum som ativo para pausar.")
    end
end)

-- Verificar FilteringEnabled
checkButton.MouseButton1Click:Connect(function()
    local isEnabled = game:GetService("Workspace").FilteringEnabled
    warn("[Debug] FilteringEnabled:", isEnabled)
end)
