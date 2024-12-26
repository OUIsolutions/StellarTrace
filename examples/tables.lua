stellar = require("stellar")

watcher = stellar.create_root_watcher("debug.txt")
watcher.debug()


main = watcher.create_function("main", function(x)
    local test_table = {}
    for i = 1, 5 do
        test_table[#test_table + 1] = "a"
        watcher.plotage_point("iterator", function()
            watcher.plot_var("test_table", test_table)
        end)
    end
end)
main()
