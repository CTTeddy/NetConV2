local Registry = {}

local Services = {}
local Events = {}
local Functions = {}


function Registry.AddService(name,service)

	Services[name] = service

end


function Registry.GetService(name)

	return Services[name]

end


function Registry.AddEvent(name,event)

	Events[name] = event

end


function Registry.GetEvent(name)

	return Events[name]

end


function Registry.AddFunction(name,func)

	Functions[name] = func

end


function Registry.GetFunction(name)

	return Functions[name]

end


return Registry
