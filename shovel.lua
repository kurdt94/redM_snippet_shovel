-- string, int, string, bool, bool, bool, int
function StartAnimation(animDict,flags,playbackListName,p3,p4,groundZ,time)
	Citizen.CreateThread(function()
		local player = PlayerPedId()
		local aCoord = GetEntityCoords(player)
		local pCoord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), -10.0, 0.0, 0.0)

		local pRot = GetEntityRotation(player)

		if groundZ then
			local a, groundZ = GetGroundZAndNormalFor_3dCoord( aCoord.x, aCoord.y, aCoord.z + 10 )
			aCoord = {x=aCoord.x, y=aCoord.y, z=groundZ}
		end

		local animScene = Citizen.InvokeNative(0x1FCA98E33C1437B3, animDict, flags, playbackListName, 0, 1)
			-- SET_ANIM_SCENE_ORIGIN
	    Citizen.InvokeNative(0x020894BF17A02EF2, animScene, aCoord.x, aCoord.y, aCoord.z, pRot.x, pRot.y, pRot.z, 2) 
	    -- SET_ANIM_SCENE_ENTITY
	    Citizen.InvokeNative(0x8B720AD451CA2AB3, animScene, "player", player, 0)
	    
	    -- DIG UP A CHEST
	    --local chest = CreateObjectNoOffset(GetHashKey('p_strongbox_muddy_01x'), pCoord, true, true, false, true)
	    --Citizen.InvokeNative(0x8B720AD451CA2AB3, animScene, "CHEST", chest, 0)

	    -- LOAD_ANIM_SCENE
	    Citizen.InvokeNative(0xAF068580194D9DC7, animScene) 
	    Citizen.Wait(1000)
	    -- START_ANIM_SCENE
	    print('START_ANIM_SCENE: '.. animScene)
	    Citizen.InvokeNative(0xF4D94AF761768700, animScene) 
	    if time then
	    	Citizen.Wait(tonumber(time))	
	    else
	   	Citizen.Wait(10000) 
	    end
			
	    -- SET CHEST AS OPENED AFTER DUG UP
	    -- Citizen.InvokeNative(0x188F8071F244B9B8, chest, 1) -- found native sets CHEST as OPENED
			
	    -- _DELETE_ANIM_SCENE
	    Citizen.InvokeNative(0x84EEDB2C6E650000, animScene) 
   end) 
end

--- DIG UP AND FIND NOTHING
StartAnimation('script@mech@treasure_hunting@nothing',0,'PBL_NOTHING_01',0,1,true,10000)

--- DIG UP AND GRAB SOMETHING
-- StartAnimation('script@mech@treasure_hunting@grab',0,'PBL_GRAB_01',0,1,true,10000)

--- DIG UP CHEST ( NOTE: UNCOMMENT LINES to spawn chest )
-- StartAnimation('script@mech@treasure_hunting@chest',0,'PBL_CHEST_01',0,1,true,10000)
