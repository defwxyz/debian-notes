#! /usr/bin/lua

function waitfornext()
    start = os.time()
    while (os.time() == start) do
    end
end

function jiffy() 
    loops_per_jiffy = 1
    while 1 do
        start = os.time()
        for i=1,loops_per_jiffy do
        end
        stop = os.time()
        if (stop - start > 0) then 
            break;
        end
        loops_per_jiffy = loops_per_jiffy + 1
    end
    return loops_per_jiffy
end

min = 1000000
for k=1,1 do
    waitfornext()
    j=jiffy()
    if (j < min) then
        min = j
    end
end
print("ok - " .. string.format("%.2f", min / 500) .. " BogoMips")

