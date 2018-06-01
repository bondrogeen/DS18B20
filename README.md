# DS18B20
 
The plugin DS18B20 for [DoT](https://github.com/bondrogeen/DoT)


## GET or POST request

> Sets a pin in 1-Wire mode.

http://192.168.1.49/DS18B20.lua?init=4 

> Search for all  1-Wire device. Return the number of sensors found

http://192.168.1.49/DS18B20.lua?find=4

> Attention! Before obtaining the temperature, if the sensors are not polled for a long time, you must first send the scan command

http://192.168.1.49/DS18B20.lua?scan=1 

> Getting the temperature of the first sensor found

http://192.168.1.49/DS18B20.lua?get=1 

> Get the temperature of all found sensors. Returns an array of data  ( ["25.8750","23.8125","23.9375"] )

http://192.168.1.49/DS18B20.lua?get=all


or

```lua

pin = 4  -- gpio2

dofile("DS18B20.lua")({init=pin}) -- Sets a pin in 1-Wire mode.

addr = dofile("DS18B20.lua")({find=pin})  --Search for all  1-Wire device.

-- dofile("DS18B20.lua")({scan=1}) -- Command to all devices for temperature conversion

r=dofile("DS18B20.lua")({get=1})  -- Getting the temperature of the first sensor found
print(r)

-- or get the temperature of all found sensors
r=dofile("DS18B20.lua")({get="all"})
print(r[1])
print(r[2])
print(r[3])

```

## Changelog

### 0.0.2 (2018-05-24)
* (bondrogeen) init.



