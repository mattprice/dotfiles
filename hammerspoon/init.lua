-- Automatically reload configuration changes.
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Print out the results of a table.
function printTable(table)
    for k, v in pairs(table) do
        print(k, v)
    end
end
