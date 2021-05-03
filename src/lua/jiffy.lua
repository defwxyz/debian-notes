#! /usr/bin/lua

function jiffy(start)
    k=0
    while (os.time() == start) do
      k=k+1
    end
    return k
end

function average(data) 
  sum = 0
  for k=1,20 do
     sum = sum + data[k]
  end
  return (sum / 20.0)
end

measures={}
start = os.time()
jiffy(start)
for k=1,20 do
    start = os.time()
    measures[k] = jiffy(start)
    print(start, measures[k])
end

min = average(measures)
print("ok - " .. string.format("%.2f", min / 500) .. " BogoMips")

