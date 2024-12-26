stellar = require("stellar")

watcher = stellar.create_root_watcher("debug.txt")
watcher.debug()


add = watcher.create_function("add", function(x, y)
    watcher.plotage_point("args", function()
        watcher.plot_var("x", x)
        watcher.plot_var("y", y)
    end)

    return x + y
end)

main = watcher.create_function("main", function(x)
    local result = add(2, 3)
    watcher.plotage_point("result", function()
        watcher.plot_var("result", result)
    end)
    print(result)
end)
main()
