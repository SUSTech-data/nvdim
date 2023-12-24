local pylance_install = function()
    local Pkg = require("mason-core.package")
    local path = require("mason-core.path")

    local function installer(ctx)
        local script = [[
        curl -L -o pylance.vsix https://github.com/mochaaP/pylance-standalone/archive/dist.zip
        ]]
        ctx.receipt:with_primary_source(ctx.receipt.unmanaged)
        ctx.spawn.bash({ "-c", script:gsub("\n", " ") })
        ctx.spawn.unzip({ "pylance.vsix" })
        ctx:link_bin(
            "pylance",
            ctx:write_node_exec_wrapper(
                "pylance",
                path.concat({ "pylance-standalone-dist", "server.bundle.js" })
            )
        )
    end

    return Pkg.new({
        name = "pylance",
        desc = [[Fast, feature-rich language support for Python]],
        homepage = "https://github.com/microsoft/pylance",
        languages = { Pkg.Lang.Python },
        categories = { Pkg.Cat.LSP },
        install = installer,
    })
end
return pylance_install()
