stellar = require("stellar")

watcher = stellar.create_root_watcher("debug.txt")

b = watcher.create_function("b", function(x, y)
    watcher.plotage_point("args", function()
        watcher.plot_var("x", x)
        watcher.plot_var("y", y)
    end)

    for i = 1, 10 do
        watcher.plotage_point("iterator", function()
            watcher.plot_var("i", i)
        end)
    end
end)

a = watcher.create_function("a", function(x)
    b(2, 3)
end)
a()
