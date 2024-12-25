stellar = require("stellar")

watcher = stellar.create_root_watcher("debug.txt")

b = watcher.create_function("b", function(x)
    for i = 1, 10 do
        watcher.stream("plot:b[7]\n")
        watcher.stream("i = " .. i .. "\n")
    end
end)

a = watcher.create_function("a", function(x)
    b()
end)


a(1)
