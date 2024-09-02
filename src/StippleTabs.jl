module StippleTabs

using Stipple, StippleUI.API

export tabs

const assets_config = Genie.Assets.AssetsConfig(package="StippleTabs.jl")

import Stipple.Genie.Renderer.Html: register_normal_element, normal_element

register_normal_element("st__tabs", context=@__MODULE__)


function tabs(;kwargs...)
    st_tabs(;kw([kwargs...])...)
end

function gb_component_routes()
    package_subpath_part = "stippletabs" # change these, keep the other parts as defined below

    # don't change these
    # GenieDevTools identifies the components by their asset path, which must be of the form /components/stipplemarkdown/gb_component/
    prefix = "components"
    gb_component_path = "gb_component"
    assets_folder_path = "$package_subpath_part/$gb_component_path"
    icons_folder_path = "icons"

    [
    Genie.Router.route(Genie.Assets.asset_route(
        assets_config,
        "", # type
        file="definitions.json",
        path=assets_folder_path,
        prefix=prefix,
        ext=""
    ),
    named=:get_gb_component_stippletabs_definitionsjson) do
        Genie.Renderer.WebRenderable(
            Genie.Assets.embedded(
                Genie.Assets.asset_file(cwd=normpath(joinpath(@__DIR__, "..")),
                file="definitions.json",
                path=gb_component_path,
                type="")
            ),
            :json) |> Genie.Renderer.respond
    end

    Genie.Router.route(Genie.Assets.asset_route(
        assets_config,
        "", # type
        file="canvas.css",
        path=assets_folder_path,
        prefix=prefix,
        ext=""
    ),
    named=:get_gb_component_stippletabs_canvascss) do
        Genie.Renderer.WebRenderable(
            Genie.Assets.embedded(
                Genie.Assets.asset_file(cwd=normpath(joinpath(@__DIR__, "..")),
                file="canvas.css",
                path=gb_component_path,
                type="")
            ),
            :css) |> Genie.Renderer.respond
    end

    Genie.Router.route(Genie.Assets.asset_route(
        assets_config,
        "", # type
        file="library_icon.png",
        path="$assets_folder_path/$icons_folder_path",
        prefix=prefix,
        ext=""
    ),

    named=:get_gb_component_stippletabs_icons_stippletabs) do
        Genie.Renderer.WebRenderable(
            Genie.Assets.embedded(
                Genie.Assets.asset_file(cwd=normpath(joinpath(@__DIR__, "..")),
                file="library_icon.png",
                path=joinpath(gb_component_path, icons_folder_path),
                type="")
            ),
            :png) |> Genie.Renderer.respond
    end
    ]
end

function deps_routes()
    haskey(ENV, "GB_JULIA_PATH") && gb_component_routes()

    Genie.Assets.external_assets(Stipple.assets_config) && return nothing
    
    Genie.Router.route(Genie.Assets.asset_route(assets_config, :js, file="02_stippletabs"), named=:get_stippletabsjs) do
        Genie.Renderer.WebRenderable(
            Genie.Assets.embedded(Genie.Assets.asset_file(cwd=normpath(joinpath(@__DIR__, "..")), file="02_stippletabs.js")),
            :javascript) |> Genie.Renderer.respond
    end

    Genie.Router.route(Genie.Assets.asset_route(assets_config, :css, file="tabs"), named=:get_stippletabscss) do
        Genie.Renderer.WebRenderable(
            Genie.Assets.embedded(Genie.Assets.asset_file(cwd=normpath(joinpath(@__DIR__, "..")), type="css", file="tabs.css")),
            :css) |> Genie.Renderer.respond
    end

    nothing
end

function css_deps()
    [
        Stipple.Elements.stylesheet(Genie.Assets.asset_path(assets_config, :css, file="tabs"))
    ]
end

function deps()
    [
        Genie.Renderer.Html.script(src=Genie.Assets.asset_path(assets_config, :js, file="02_stippletabs"))
    ]
end

function __init__()
    deps_routes()
    Stipple.add_css(css_deps)
    Stipple.deps!(@__MODULE__, deps)
end

end
