local log = hs.logger.new('hyper')
local status, hyperModeAppMappings = pcall(require, 'keyboard.hyper-apps')

if not status then
  log:w('Unable to load keyboard.hyper-apps; using defaults:', hyperModeAppMappings)
  hyperModeAppMappings = require('keyboard.hyper-apps-defaults')
end

for i, mapping in ipairs(hyperModeAppMappings) do
  local key = mapping[1]
  local app = mapping[2]
  hs.hotkey.bind({'shift', 'ctrl', 'alt', 'cmd'}, key, function()
    if (type(app) == 'string') then
      hs.application.open(app)
    elseif (type(app) == 'function') then
      app()
    else
      log:e('Invalid mapping for Hyper +', key)
    end
  end)
end
