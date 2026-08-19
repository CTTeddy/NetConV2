local Network = {}

local ReplicatedStorage = game:GetService(
	"ReplicatedStorage"
)


local Event = require(
	script.Parent.Event
)


local Folder = ReplicatedStorage:FindFirstChild(
	"NetCon"
)


if not Folder then

	Folder = Instance.new("Folder")
	Folder.Name = "NetCon"
	Folder.Parent = ReplicatedStorage

end


local EventsFolder = Folder:FindFirstChild(
	"Events"
)


if not EventsFolder then

	EventsFolder = Instance.new("Folder")
	EventsFolder.Name = "Events"
	EventsFolder.Parent = Folder

end


local FunctionsFolder = Folder:FindFirstChild(
	"Functions"
)


if not FunctionsFolder then

	FunctionsFolder = Instance.new("Folder")
	FunctionsFolder.Name = "Functions"
	FunctionsFolder.Parent = Folder

end


local Events = {}


function Network.CreateEvent(name)


	if Events[name] then

		return Events[name]

	end


	local remote = EventsFolder:FindFirstChild(
		name
	)


	if not remote then

		remote = Instance.new("RemoteEvent")
		remote.Name = name
		remote.Parent = EventsFolder

	end


	local event = Event.new(
		remote
	)


	remote.OnServerEvent:Connect(function(player,data)

		event:Handle(
			player,
			data
		)

	end)


	Events[name] = event


	return event

end



function Network.CreateFunction(name)

	local remote = FunctionsFolder:FindFirstChild(
		name
	)


	if not remote then

		remote = Instance.new("RemoteFunction")
		remote.Name = name
		remote.Parent = FunctionsFolder

	end


	return remote

end



function Network.Start()

end


return Network
