-- 这个组件用于清除 side effect
local Player = Class(function(self, inst)
	self.inst = inst
end)

function Player:Destroy()
	local player = self.inst

	aipPrint("Player leave:", player.name, "(", player.userid, ")")

	---------------------------------- Client ----------------------------------

	---------------------------------- Server ----------------------------------
	if not TheWorld.ismastersim then
		return
	end

	-- Mine Car
	if player:HasTag("aip_minecar_driver") then
		local x, y, z = player.Transform:GetWorldPosition()
		local mineCars = TheSim:FindEntities(x, y, z, 10, { "aip_minecar" })

		aipPrint(">>> Search Driving Mine Car count:", #mineCars)

		for i, mineCar in ipairs(mineCars) do
			local aipc_minecar = mineCar.components.aipc_minecar
			if aipc_minecar and aipc_minecar.driver == player then
				aipPrint(">>> Remove Driver")
				aipc_minecar:RemoveDriver(player)
			end
		end
	end
end

Player.OnRemoveEntity = MineCar.Destroy

return Player