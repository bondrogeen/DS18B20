local function scan(p)
ow.reset(p)
ow.write(p,0xCC,1)
ow.write(p,0x44,1)
end

local function find(p)
ow.reset_search(p)
local d,a={}
repeat
 a = ow.search(p)
 if a then print(a:byte(1,8)) d[#d+1]=a end
until not a
if(#d>0)then scan(p)end
return d
end

local function temp(x)
local d,t,r=""
ow.reset(x.p)
ow.select(x.p,x.a)
ow.write(x.p,0xBE,1)
for i=1,9 do d=d.. string.char(ow.read(x.p))end
--print(d:byte(1,9))
if ow.crc8(d:sub(1,8))==d:byte(9)then
t=(d:byte(1)+d:byte(2)*256)*625
r=t/10000 .."."..t%10000
end
scan(x.p)
return r
end

local function init(p)
ow.setup(p)
end

return function (t)
 local r
 if(t.init)then r=init(t.init) end
 if(t.find)then r=find(t.find) end
 if(t.temp)then r=temp(t.temp) end
 if(t.scan)then r=scan(t.scan) end
 return r
end
