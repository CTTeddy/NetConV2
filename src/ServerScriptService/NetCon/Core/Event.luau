local Event = {}
Event.__index = Event


function Event.new(remote)

	local self = setmetatable({}, Event)

	self.Remote = remote
	self.Callback = nil
	self.Validator = nil
	self.Cooldown = nil
	self.LastCall = {}

	return self

end


function Event:OnServer(callback)

	self.Callback = callback

	return self

end


function Event:SetCooldown(time)

	self.Cooldown = time

	return self

end


function Event:SetValidator(callback)

	self.Validator = callback

	return self

end


function Event:FireClient(player,data)

	self.Remote:FireClient(
		player,
		data
	)

end


function Event:FireAll(data)

	self.Remote:FireAllClients(
		data
	)

end


function Event:Handle(player,data)

	if self.Cooldown then

		local last = self.LastCall[player.UserId]

		if last then

			if os.clock() - last < self.Cooldown then
				return
			end

		end


		self.LastCall[player.UserId] = os.clock()

	end


	if self.Validator then

		local result = self.Validator(data)

		if not result then
			return
		end

	end


	if self.Callback then

		self.Callback(
			player,
			data
		)

	end

end


return Event
