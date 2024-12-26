stellar = require("stellar")

watcher = stellar.create_root_watcher("debug.txt")
watcher.debug()


main = watcher.create_function("main", function(x)
    for i = 1, 5 do
        watcher.plotage_point("iterator", function()
            watcher.plot_var("i", i)
        end)
    end
end)
main()
