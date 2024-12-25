stellar = require("stellar")

watcher = stellar.create_root_watcher("debug.txt")

remove_coment = watcher.create_function("remove_coment", function(x)
    for i = 1, 10 do
        watcher.plotage_point("iterator", function()
            watcher.plot_var("i", i)
        end)
    end
end)
