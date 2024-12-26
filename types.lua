---@class PrivateStellarFunction
---@field stream_formmated_str fun(data:string, stream:fun(data:string))
---@field plot_var_table fun(path:string, value:table, stream:fun(data:string))
---@field plot_var fun(name:string, value:any, stream:fun(data:string))



---@class StellarRequiredFunctions
---@field error fun(msg:string)
---@field type fun(value:any): "number"| "string"| "boolean"| "table"| "function"| "thread"| "userdata"
---@field concat (fun(itens:string[]):string )| nil
---@field get_keys_and_index  fun(target:table):(string | number)[]
---@field sub fun(str:string,start:number,end:number):string
---@field open fun(filename:string,mode:string):file*

---@class StellarWatcher
---@field debug fun()
---@field create_function fun(name,callback):function
---@field plotage_point fun(name,callback:fun()|nil)
---@field print_raw fun(data:string)
---@field print_format fun(format:string,...)


---@class StellarModule
---@field create_root_watcher fun(logfile:string):StellarWatcher
---@field required_functions StellarRequiredFunctions


---@type StellarModule
stellar = stellar
---type PrivateStellarFunction
private_steallar_functions = private_steallar_functions
