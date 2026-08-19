local ServiceLoader = {}

local Registry = require(
	script.Parent.Registry
)

local ServicesFolder = script.Parent.Parent.Services

local LoadedServices = {}


function ServiceLoader.Load()

	for _, module in ipairs(ServicesFolder:GetChildren()) do

		if module:IsA("ModuleScript") then

			local success, service = pcall(require, module)

			if success and service then

				local serviceName = module.Name


				function service:GetService(name)

					return Registry.GetService(name)

				end


				LoadedServices[serviceName] = service


				Registry.AddService(
					serviceName,
					service
				)


		

			else

				warn(
					"[NetCon Load Error]",
					module.Name
				)

			end

		end

	end

end


function ServiceLoader.Start()

	for serviceName, service in pairs(LoadedServices) do

		if service.Start then

			local success, err = pcall(function()

				service:Start()

			end)


			if not success then

				warn(
					"[NetCon Service Error]",
					serviceName,
					err
				)

			end

		end

	end

end


return ServiceLoader
