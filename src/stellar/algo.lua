private_steallar_functions.is_inside = function(array, item)
    for i = 1, #array do
        if array[i] == item then
            return true
        end
    end
    return false
end
