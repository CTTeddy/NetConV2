local ControllerLoader = {}


local ControllersFolder = game.Players.LocalPlayer
	:WaitForChild("PlayerScripts")
	:WaitForChild("NetCon")
	:WaitForChild("Controllers")


local LoadedControllers = {}


function ControllerLoader.Start()

	for _,module in ipairs(ControllersFolder:GetChildren()) do

		if module:IsA("ModuleScript") then

			local controller = require(module)

			LoadedControllers[module.Name] = controller


			if controller.Start then

				task.spawn(function()

					controller:Start()

				end)

			end

		end

	end

end


return ControllerLoader
