local NetCon = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")


local Folder = ReplicatedStorage
	:WaitForChild("NetCon")


local EventsFolder = Folder
	:WaitForChild("Events")


local FunctionsFolder = Folder
	:WaitForChild("Functions")


local Events = {}
local Functions = {}


local EventClass = {}


function EventClass:Fire(data)

	self.Remote:FireServer(
		data
	)

end


function EventClass:OnClient(callback)

	self.Callback = callback

end



local FunctionClass = {}


function FunctionClass:Invoke(data)

	return self.Remote:InvokeServer(
		data
	)

end



function NetCon.Event(name)


	if Events[name] then
		return Events[name]
	end


	local remote = EventsFolder:WaitForChild(name)


	local event = setmetatable(
		{
			Remote = remote
		},
		{
			__index = EventClass
		}
	)


	remote.OnClientEvent:Connect(function(data)

		if event.Callback then

			event.Callback(
				data
			)

		end

	end)


	Events[name] = event


	return event

end


local EventsFolder = ReplicatedStorage
	:WaitForChild("NetCon")
	:WaitForChild("Events")


function NetCon.Fire(name,data)

	local event = EventsFolder:FindFirstChild(name)

	if not event then
		warn(
			"NetCon Missing Event:",
			name
		)
		return
	end


	event:FireServer(data)

end

function NetCon.Function(name)


	if Functions[name] then
		return Functions[name]
	end


	local remote = FunctionsFolder:WaitForChild(name)


	local func = setmetatable(
		{
			Remote = remote
		},
		{
			__index = FunctionClass
		}
	)


	Functions[name] = func


	return func

end



function NetCon.Fire(name,data)

	local event = NetCon.Event(name)

	event:Fire(data)

end



function NetCon.On(name,callback)

	local event = NetCon.Event(name)

	event:OnClient(callback)

end



function NetCon.Init()

	local success,gameName = pcall(function()

		return MarketplaceService:GetProductInfo(
			game.PlaceId
		).Name

	end)


	warn(
		"NetCon V2 Client By CTTeddy Running on "
			.. (success and gameName or "Unknown Game")
	)

end



return NetCon
