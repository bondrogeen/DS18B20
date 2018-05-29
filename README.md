# DS18B20
 
The plugin DS18B20 for [DoT](https://github.com/bondrogeen/DoT)

or

```
pin = 4  -- gpio2

dofile("DS18B20.lua")({init=pin}) -- Sets a pin in 1-Wire mode.

addr = dofile("DS18B20.lua")({find=pin})  --Search for all  1-Wire device.

-- dofile("DS18B20.lua")({scan=pin}) -- Command to all devices for temperature conversion

print(#addr) -- Number of found devices

if #addr>0 then
r=dofile("DS18B20.lua")({temp={p=pin,a=addr[1]}})  -- Getting the temperature of the first sensor found
print(r)
end

```

## Changelog

### 0.0.1 (2018-05-24)
* (bondrogeen) init.



