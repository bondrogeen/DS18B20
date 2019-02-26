local pin = _DS18B20 and _DS18B20.pin

local function scan()
  local r = ow.reset(pin)
  ow.write(pin, 0xCC, 1)
  ow.write(pin, 0x44, 1)
  return r == 1
end

local function find()
  ow.reset_search(pin)
  local sensors, address = {}
  repeat
    address = ow.search(pin)
    if address then
--      print(address:byte(1,8))
      sensors[#sensors + 1] = address
    end
  until not address
  _DS18B20.adr = sensors
  if(#sensors > 0)then scan()end
  return #sensors or false
end

local function getTemp(adrress)
  local data, value, r = ""
  ow.reset(pin)
  ow.select(pin, adrress)
  ow.write(pin, 0xBE, 1)
  for i=1, 9 do
    data = data .. string.char(ow.read(pin))
  end

  if ow.crc8(data:sub(1, 8)) == data:byte(9) then
    value = (data:byte(1) + data:byte(2) * 256) * 625
    r = value / 10000 .. "." .. value % 10000
  end
  return r
end

local function get(number)
  local sensors, tab, r = _DS18B20.adr, {}, false
  if number > 0 then
    r = sensors[number] and getTemp(sensors[number]) or r
  else
    for i, sensor in ipairs(sensors)do
      tab[string.format("%X%X%X%X%X%X", sensors[i]:byte(2,7))] = getTemp(sensor)
    end
    r = tab
  end
  scan()
  return r
end

local function init(pin)
  _DS18B20 = {}
  _DS18B20.pin = pin
  ow.setup(pin)
  return true
end

return function (t)
  local r = false
  if (t.init) then r = init(t.init) end
  if (t.find and pin) then r = find() end
  if (t.scan and pin) then r = scan() end
  if (t.get and pin) then r = get(t.get) end
 return r
end
