/*
    Addon id: 5d8b797b-05d3-45b1-9efb-d4bfab61cce1
    Version: v3.4.3 (stable)
*/

if CLIENT then return end
zpn = zpn or {}
zpn.force = zpn.force or {}
if zpn.config.FastDl then

	function zpn.force.AddDir(path)

		local files, folders = file.Find(path .. "/*", "GAME")

		for k, v in pairs(files) do
			resource.AddFile(path .. "/" .. v)
		end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

		for k, v in pairs(folders) do

			zpn.force.AddDir(path .. "/" .. v)
		end
	end

	zpn.force.AddDir("sound/zpn/")

	zpn.force.AddDir("models/zerochain/props_pumpkinnight/")
	zpn.force.AddDir("materials/zerochain/props_pumpkinnight/")

	zpn.force.AddDir("models/zerochain/props_christmas/")
	zpn.force.AddDir("materials/zerochain/props_christmas/")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- cf642873cb32499f35dba0b9202863b898b94cb9ce173bca5096a823cbf6ccb3

	zpn.force.AddDir("materials/zerochain/zpn/")

	resource.AddSingleFile("materials/entities/zpn_candy.png")
	resource.AddSingleFile("materials/entities/zpn_ghost.png")
	resource.AddSingleFile("materials/entities/zpn_npc.png")
	resource.AddSingleFile("materials/entities/zpn_destructable.png")
	resource.AddSingleFile("materials/entities/zpn_bomb.png")
	resource.AddSingleFile("materials/entities/zpn_boss.png")
	resource.AddSingleFile("materials/entities/zpn_minion.png")
	resource.AddSingleFile("materials/entities/zpn_scoreboard.png")
	resource.AddSingleFile("materials/entities/zpn_sign.png")

	resource.AddSingleFile("particles/zpn_candle_vfx.pcf")
	resource.AddSingleFile("particles/zpn_candy_vfx.pcf")
	resource.AddSingleFile("particles/zpn_fire_vfx.pcf")
	resource.AddSingleFile("particles/zpn_fuse_vfx.pcf")
	resource.AddSingleFile("particles/zpn_ghost_vfx.pcf")
	resource.AddSingleFile("particles/zpn_leafstorm.pcf")
	resource.AddSingleFile("particles/zpn_minion_vfx.pcf")
	resource.AddSingleFile("particles/zpn_partypopper_projectile.pcf")
	resource.AddSingleFile("particles/zpn_partypopper_vfx.pcf")
	resource.AddSingleFile("particles/zpn_pumpkin_vfx.pcf")
	resource.AddSingleFile("particles/zpn_pumpkinboss_vfx.pcf")


	resource.AddSingleFile("materials/vgui/entities/zpn_partypopper.vmt")
	resource.AddSingleFile("materials/vgui/entities/zpn_partypopper.vtf")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b

	resource.AddSingleFile("materials/vgui/entities/zpn_partypopper01.vmt")
	resource.AddSingleFile("materials/vgui/entities/zpn_partypopper01.vtf")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- d68356787957a9d405c8e3e0c9975e47a964295cae8ef64a7fc0156949ca6a73

	resource.AddSingleFile("resource/fonts/JollyLodger-Regular.ttf")
	resource.AddSingleFile("resource/fonts/Vampire95.ttf")

else
	resource.AddWorkshop( "1890110902" ) // Zeros PumpkinNight Contentpack
	//https://steamcommunity.com/sharedfiles/filedetails/?id=1890110902
end

for k, v in pairs(zpn.config.Boss.MusicPaths) do
	resource.AddSingleFile("sound/" .. v)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 5425e95d20c7165c47ca3a5a9105e049cb26c294f6013123ef8ecd2e0d06950b
