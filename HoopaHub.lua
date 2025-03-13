local HoopaHub = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- GUI Properties
HoopaHub.Name = "HoopaHub"
HoopaHub.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = HoopaHub
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)

Title.Name = "Title"
Title.Parent = MainFrame
Title.Text = "Hoopa Hub"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(100, 0, 255)

ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Parent = MainFrame
ScrollFrame.Size = UDim2.new(1, 0, 1, -50)
ScrollFrame.Position = UDim2.new(0, 0, 0, 50)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
ScrollFrame.ScrollBarThickness = 6

UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Function for Auto-Hop with Job ID
local function autoHop(targetBoss)
    local function findServer()
        local servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/2753915549/servers/Public?sortOrder=Asc&limit=100"))
        for _, server in pairs(servers.data) do
            if server.playing > 0 and server.id ~= game.JobId then
                return server.id
            end
        end
        return nil
    end

    while wait(2) do
        local serverId = findServer()
        if serverId then
            game:GetService("TeleportService"):TeleportToPlaceInstance(2753915549, serverId, game.Players.LocalPlayer)
            break
        end
    end
end

-- Create Hop Buttons
local bosses = {
    "Rip Indra", "Dough King", "Soul Reaper",
    "Mirage Island", "Kitsune Island",
    "Full Moon", "Low Player Server"
}

for _, boss in pairs(bosses) do
    local Button = Instance.new("TextButton")
    Button.Parent = ScrollFrame
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.Text = "Auto Hop " .. boss
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
    Button.MouseButton1Click:Connect(function()
        autoHop(boss)
    end)
end
