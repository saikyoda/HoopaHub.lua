repeat wait() until game:IsLoaded()

-- Services
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
local UIListLayout = Instance.new("UIListLayout", Frame)

Frame.Size = UDim2.new(0, 250, 0, 300)
Frame.Position = UDim2.new(0.5, -125, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 255) -- Chromatic color

UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.Padding = UDim.new(0, 5)

-- Categories
local categories = {
    {Name = "Info", Options = {"Welcome to Hoopa Hub!", "Made by Asif", "Join: discord.gg/rExhMVQb46"}},
    {Name = "Hop Bosses", Options = {"Rip Indra", "Dough King", "Soul Reaper"}},
    {Name = "Hop Server", Options = {"Full Moon", "Low Player Server"}},
    {Name = "Hop Islands", Options = {"Mirage Island", "Kitsune Island"}}
}

for _, category in pairs(categories) do
    local CategoryButton = Instance.new("TextButton", Frame)
    CategoryButton.Size = UDim2.new(1, 0, 0, 30)
    CategoryButton.Text = category.Name
    CategoryButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

    CategoryButton.MouseButton1Click:Connect(function()
        for _, option in pairs(category.Options) do
            local OptionButton = Instance.new("TextButton", Frame)
            OptionButton.Size = UDim2.new(1, 0, 0, 25)
            OptionButton.Text = option
            OptionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)

            OptionButton.MouseButton1Click:Connect(function()
                AutoHop(option)
            end)
        end
    end)
end

-- Function to handle teleportation
function AutoHop(target)
    print("Searching for:", target)

    -- Fetch server list
    local Servers = {}
    local PlaceId = game.PlaceId
    local Cursor = ""

    repeat
        local Response = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100&cursor="..Cursor))
        if Response and Response.data then
            for _, Server in pairs(Response.data) do
                if Server.playing < Server.maxPlayers then
                    table.insert(Servers, Server.id)
                end
            end
        end
        Cursor = Response.nextPageCursor
        wait(0.5)
    until not Cursor

    -- Find correct server
    for _, ServerId in pairs(Servers) do
        TeleportService:TeleportToPlaceInstance(PlaceId, ServerId, LocalPlayer)
        wait(10) -- Wait for teleport
    end
end
