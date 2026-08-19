local NetConServer = {}


local ServiceLoader = require(
	script.Parent.Core.ServiceLoader
)

local MarketplaceService = game:GetService(
	"MarketplaceService"
)



local Registry = require(
	script.Parent.Core.Registry
)

local Network = require(
	script.Parent.Core.Network
)

local Started = false


function NetConServer.Event(name)

	local event = Network.CreateEvent(name)

	Registry.AddEvent(
		name,
		event
	)

	return event

end


function NetConServer.Function(name)

	local func = Network.CreateFunction(name)

	Registry.AddFunction(
		name,
		func
	)

	return func

end


function NetConServer.Register(name,callback)

	local event = NetConServer.Event(name)

	event:OnServer(callback)

end


function NetConServer.FireClient(player,name,data)

	local event = Registry.GetEvent(name)

	if event then

		event:FireClient(
			player,
			data
		)

	end

end


function NetConServer.FireAllClients(name,data)

	local event = Registry.GetEvent(name)

	if event then

		event:FireAll(
			data
		)

	end

end


function NetConServer.GetService(name)

	return Registry.GetService(name)

end


function NetConServer.Init()

	if Started then
		return
	end

	Started = true


	Network.Start()


	ServiceLoader.Load()

	ServiceLoader.Start()


	local success, gameName = pcall(function()

		return MarketplaceService:GetProductInfo(
			game.PlaceId
		).Name

	end)


	local targetName = success and gameName or "Unknown Game"


	warn(
		"NetCon V2 Server By CTTeddy Running on " .. targetName
	)

end


return NetConServer
