local p=_DS18B20 and _DS18B20.pin

local function scan()
local r=ow.reset(p)
ow.write(p,0xCC,1)
ow.write(p,0x44,1)
return r==1
end

local function find()
if not p then return false end
ow.reset_search(p)
local d,a={}
repeat
 a = ow.search(p)
 if a then print(a:byte(1,8)) d[#d+1]=a end
until not a
if(#d>0)then _DS18B20.adr=d scan() end
return #d or false
end

local function temp(x)
local d,t,r=""
ow.reset(p)
ow.select(p,x)
ow.write(p,0xBE,1)
for i=1,9 do d=d.. string.char(ow.read(p))end
if ow.crc8(d:sub(1,8))==d:byte(9)then
t=(d:byte(1)+d:byte(2)*256)*625
r=t/10000 .."."..t%10000
end
return r
end

local function get(x)
if not _DS18B20 or not _DS18B20.adr then return false end
local a,t,r=_DS18B20.adr,{}
x=tonumber(x) or x
if type(x)=="number"then r=(a[x]) and temp(_DS18B20.adr[x]) or false
else for i,v in ipairs(_DS18B20.adr)do t[string.format("%X%X%X%X%X%X", _DS18B20.adr[i]:byte(2,7))]=temp(v) end
r=t
end
scan()
return r
end

local function init(p)
_DS18B20={}
_DS18B20.pin=p
ow.setup(p)
return true
end

return function (t)
 local r
 if(t.init)then r=init(t.init)end
 if(t.find)then r=find()end
 if(t.scan)then r=scan()end
 if(t.get)then r=get(t.get)end
 return r
end
