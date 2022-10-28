local status, mason = pcall(require, "mason")
if (not status) then return end
local lspconfig_status, lspconfig = pcall(require, "mason-lspconfig")
if (not lspconfig_status) then return end

mason.setup()
lspconfig.setup()
