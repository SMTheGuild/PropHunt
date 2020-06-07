CreativeFlatWorld = class( nil )

CreativeFlatWorld.terrainScript = "$GAME_DATA/Scripts/game/terrain/terrain_flat.lua"
CreativeFlatWorld.enableSurface = true
CreativeFlatWorld.enableAssets = false
CreativeFlatWorld.enableClutter = false
CreativeFlatWorld.enableCreations = false
CreativeFlatWorld.enableNodes = false
CreativeFlatWorld.enableCellScripts = false

function CreativeFlatWorld.server_onProjectile( self, hitPos, hitTime, hitVelocity, projectileName, attacker, damage, userData  )
	-- Prop attack detection
	local hit, result = sm.physics.raycast( hitPos - hitVelocity:normalize() / 40, hitPos + hitVelocity / 40 )
	if hit and result.type == "body" then
		local body = result:getBody()
		if body:isDynamic() and body:getCreationBodies()[2] == nil then
			sm.event.sendToGame( "sv_propHit", body )
		end
	end
end