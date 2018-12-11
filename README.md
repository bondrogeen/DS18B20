# DS18B20
 
The plugin DS18B20 for [DoT](https://github.com/bondrogeen/DoT)

![alt-текст](https://raw.githubusercontent.com/bondrogeen/DS18B20/master/doc/Screenshot1.jpg "Screenshot1.jpg")

## GET or POST request

> Sets a pin in 1-Wire mode.

http://192.168.1.49/DS18B20.lua?init=4 

> Search for all  1-Wire device. Return the number of sensors found

http://192.168.1.49/DS18B20.lua?find=true

> Attention! Before obtaining the temperature, if the sensors are not polled for a long time, you must first send the scan command

http://192.168.1.49/DS18B20.lua?scan=true

> Getting the temperature of the first sensor found

http://192.168.1.49/DS18B20.lua?get=1 

> Get the temperature of all found sensors. Returns an object of data  ( "124EAB300":"30.2500","FFF63116153":"32.5000","FFC73816153":"32.5625"} )

http://192.168.1.49/DS18B20.lua?get=all


or

```lua

pin = 4  -- gpio2

dofile("DS18B20.lua")({init=pin}) -- Sets a pin in 1-Wire mode.

print(dofile("DS18B20.lua")({find=true})) --Search for all  1-Wire device. Return the number of sensors found

-- dofile("DS18B20.lua")({scan=1}) -- Command to all devices for temperature conversion

print(dofile("DS18B20.lua")({get=1})) -- Getting the temperature of the first sensor found

-- or get the temperature of all found sensors

 r=dofile("DS18B20.lua")({get="all"})
 
 for i, v in pairs(r) do
  print(i.." : "..v)
 end

```

## Changelog

### 0.0.4 (2018-06-27)
* (bondrogeen) minor fix.
### 0.0.2 (2018-05-24)
* (bondrogeen) init.



