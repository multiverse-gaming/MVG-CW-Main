-- basically blue's shadows cleaned up
-- Credit to @Beast

--[[
    Example use:

    function panel:Paint( w, h )
        local x, y = self:LocalToScreen()

        xLib.Shadows.BeginShadow()
            draw.RoundedBox(0, x, y, w, h, color_white)
        xLib.Shadows.EndShadow(1, 2, 2)
    end
]]

xLib.Shadows = xLib.Shadows or {
    Material = CreateMaterial( "shadows", "UnlitGeneric", {
        [ "$translucent" ] = 1,
        [ "$vertexalpha" ] = 1,
        [ "alpha" ] = 1
    } ),
    MaterialGreyscale = CreateMaterial( "shadows_greyscale", "UnlitGeneric", {
        [ "$translucent" ] = 1,
        [ "$vertexalpha" ] = 1,
        [ "alpha" ] = 1,
        [ "$color" ] = "0 0 0",
        [ "$color2" ] = "0 0 0"
    } )
}

function xLib.Shadows.Initialize()
    local w = ScrW()
    local h = ScrH()

    xLib.Shadows.RenderTarget = GetRenderTarget( "shadows_original", w, h )
    xLib.Shadows.RenderTarget2 = GetRenderTarget( "shadows_shadow", w, h )
end
hook.Add( "ResolutionChanged", "xLib.Shadows.Initialize", xLib.Shadows.Initialize )

xLib.Shadows.Initialize()

function xLib.Shadows.BeginShadow()
    if xLib.Config.DisableMenuShadows then return end

    render.PushRenderTarget( xLib.Shadows.RenderTarget )

    render.OverrideAlphaWriteEnable( true, true )
    render.Clear( 0, 0, 0, 0 )
    render.OverrideAlphaWriteEnable( true, true )

    cam.Start2D()
end

xLib.Shadows.Start = xLib.Shadows.Begin

function xLib.Shadows.Finish( intensity, opacity, direction, distance, shadowOnly )
    if xLib.Config.DisableMenuShadows then return end

    xLib.Shadows.MaterialGreyscale:SetTexture( "$basetexture", xLib.Shadows.RenderTarget2 )

    local rads = math.rad( direction )
    local x = math.sin( rads ) * distance
    local y = math.cos( rads ) * distance

    xLib.Shadows.MaterialGreyscale:SetFloat( "$alpha", opacity / 255 )

    render.SetMaterial( xLib.Shadows.MaterialGreyscale )

    for i = 1, math.ceil( intensity ) do
        render.DrawScreenQuadEx( x, y, ScrW(), ScrH() )
    end

    if !shadowOnly then
        xLib.Shadows.Material:SetTexture( "$basetexture", xLib.Shadows.RenderTarget )

        render.SetMaterial( xLib.Shadows.Material )
        render.DrawScreenQuad()
    end
end

function xLib.Shadows.EndShadow( intensity, spread, blur, opacity, direction, distance, shadowOnly )
    if xLib.Config.DisableMenuShadows then return end

    opacity = opacity or 255
    direction = direction or 0
    distance = distance or 0
    shadowOnly = shadowOnly or false

    render.CopyRenderTargetToTexture( xLib.Shadows.RenderTarget2 )

    if blur > 0 then
        render.OverrideAlphaWriteEnable( true, true )
        render.BlurRenderTarget( xLib.Shadows.RenderTarget2, spread, spread, blur )
        render.OverrideAlphaWriteEnable( true, true )
    end

    render.PopRenderTarget()

    xLib.Shadows.Material:SetTexture( "$basetexture", xLib.Shadows.RenderTarget )

    xLib.Shadows.Finish( intensity, opacity, direction, distance, shadowOnly )

    cam.End2D()
end

function xLib.Shadows.Texture( intensity, spread, blur, opacity, direction, distance, shadowOnly )
    if xLib.Config.DisableMenuShadows then return end
    
    opacity = opacity or 255
    direction = direction or 0
    distance = distance or 0
    shadowOnly = shadowOnly or false

    render.CopyTexture( texture, xLib.Shadows.RenderTarget2 )

    if blur > 0 then
        render.PushTarget( xLib.Shadows.RenderTarget2 )
        render.OverrideAlphaWriteEnable( true, true )
        render.BlurRenderTarget( xLib.Shadows.RenderTarget2, spread, spread, blur )
        render.OverrideAlphaWriteEnable( true, true )
        render.PopRenderTarget()
    end

    xLib.Shadows.Finish( intensity, opacity, direction, distance, shadowOnly )
end