# StellarTrace
A lua Lib to generate observability by allowing to view each var and functions
trace of algorithics

## Installing
StellarTrace its a single file lib, for usage just download the [Amalgamation](https://github.com/OUIsolutions/StellarTrace/releases/download/0.001/stellar.lua)
and import with
```lua
stellar = require("stellar")
```

## Basic

these shows a basic trace into 2 functions (main,add)
```lua
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

```
it will create the **debug.txt** with the following text:

```txt
point: 1 trace change:[main]
point: 2 trace change:[main][add]
point: 3 plotage point:[main][add][args]
	x:2
	y:3

trace change:[main]

point: 4 plotage point:[main][result]
	result:5

trace change:[global]

```
Its also possible to plot tables into the coide
```lua
stellar = require("stellar")
watcher = stellar.create_root_watcher("debug.txt")
watcher.debug()
main = watcher.create_function("main", function(x)
    local test_table = {}
    for i = 1, 5 do
        test_table[#test_table + 1] = i * 10
        watcher.plotage_point("iterator", function()
            watcher.plot_var("test_table", test_table)
        end)
    end
end)
main()
```
it will output:
```txt
point: 1 trace change:[main]
point: 2 plotage point:[main][iterator]
test_table[1]:10

point: 3 plotage point:[main][iterator]
test_table[1]:10
test_table[2]:20

point: 4 plotage point:[main][iterator]
test_table[1]:10
test_table[2]:20
test_table[3]:30

point: 5 plotage point:[main][iterator]
test_table[1]:10
test_table[2]:20
test_table[3]:30
test_table[4]:40

point: 6 plotage point:[main][iterator]
test_table[1]:10
test_table[2]:20
test_table[3]:30
test_table[4]:40
test_table[5]:50
trace change:[global]
```

## Api References
## stellar.create_root_watcher
creates the main watcher object, passing the point to store the logs
```lua
watcher = stellar.create_root_watcher("debug.txt")
```
## watcher.debug
these fucntion  its require to start the debug mode ,note that if you dont
call these function, the code will work normally
```lua
watcher = stellar.create_root_watcher("debug.txt")
watcher.debug()
```


## watcher.create_function
creates a function to be looged, if not debug , the function will work as
a normal fucntion
```lua

add = watcher.create_function("add", function(x, y)
    return x + y
end)
```
## watcher.plotage_point
creates a plotage point that will be executed if codes reach that part
```lua
watcher.plotage_point("args", function()
    watcher.plot_var("x", x)
    watcher.plot_var("y", y)
end)
```
