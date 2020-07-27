-- Automatically reload configuration changes.
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Print out the results of a table.
function printTable(table)
    for k, v in pairs(table) do
        print(k, v)
    end
end

-- Automatically set the screen resolution to 1080p@1x when the TV is connected.
function screenCallback(data)
    screen = hs.screen("SAMSUNG")
    if (screen) then
        screen:setMode(1920, 1080, 1)
    end
end
screenWatcher = hs.screen.watcher.new(screenCallback)
screenWatcher:start()
