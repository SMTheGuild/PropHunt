CreativeGame = class( nil )
CreativeGame.enableLimitedInventory = false
CreativeGame.enableRestrictions = false

g_godMode = true

function CreativeGame.client_onCreate( self )
	sm.game.setTimeOfDay( 0.5 )
	sm.render.setOutdoorLighting( 0.5 )
end

function CreativeGame.server_onCreate( self )
	self:sv_init()
end

function CreativeGame.server_onRefresh( self )
	self:sv_init()
end

function CreativeGame.sv_init( self )
	self:sv_restart()
end

function CreativeGame.sv_newInterface( self, interface )
	self:sv_restart()
	self.interface = interface
end

function CreativeGame.sv_restart( self )
	if self.interface and sm.exists(self.interface) then
		self.interface:getShape():destroyShape()
	end
	self.interface = nil
	self.possessors = {}
end

function CreativeGame.sv_propHit( self, body )
	for _, data in pairs( self.possessors ) do
		if data.body == body then
			sm.event.sendToInteractable( self.interface, "sv_damagePossessor", {player = data.player, body = nil, old_body = data.body, position = position} )
		end
	end
end

function CreativeGame.sv_changePossessor( self, params )
	self.possessors[params.player.id] = params.body and {player = params.player, body = params.body}
end