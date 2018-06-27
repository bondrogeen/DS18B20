local p=_ds18b20 and _ds18b20.pin

local function scan()
local r=ow.reset(p)
ow.write(p,0xCC,1)
ow.write(p,0x44,1)
return r==1
end

local function find()
if not p then return end
ow.reset_search(p)
local d,a={}
repeat
 a = ow.search(p)
 if a then print(a:byte(1,8)) d[#d+1]=a end
until not a
if(#d>0)then _ds18b20.adr=d scan(p) end
return #d
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

local function getTemp(x)
if not _ds18b20 then return"first init 1-Wire" end
if not _ds18b20.adr then return"find device" end
local a,t,r=_ds18b20.adr,{}
x=tonumber(x)and tonumber(x)or x
if type(x)=="number"then
 if a and x<=#a then r=temp(_ds18b20.adr[x])else r="none"end
else for i,v in ipairs(_ds18b20.adr)do t[string.format("%X%X%X%X%X%X", _ds18b20.adr[i]:byte(2,7))]=temp(v) end
 r=t
end
scan()
return r
end

local function init(p)
_ds18b20={}
_ds18b20.pin=p
ow.setup(p)
return true
end

return function (t)
 local r
 if(t.init)then r=init(t.init) end
 if(t.find)then r=find() end
 if(t.scan)then r=scan() end
 if(t.get)then r=getTemp(t.get) end
 return r
end
