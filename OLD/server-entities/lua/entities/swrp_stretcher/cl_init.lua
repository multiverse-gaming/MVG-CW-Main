include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

local old,newtbl,pairs = halo.Render,{},pairs

halo.Render = function(tbl)
	newtbl={}
	for k,v in pairs(tbl.Ents) do
		if IsValid(v) then
			if not (v:GetColor().a == 0) then
				newtbl[#newtbl+1]=v
			end
		end
	end
	tbl.Ents=newtbl
	return old(tbl)
end 

