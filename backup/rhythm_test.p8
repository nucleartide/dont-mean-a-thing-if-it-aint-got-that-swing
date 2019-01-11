pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
t=0
last=0
function _update60()
 t+=1
 if btnp(🅾️) then
  printh(t-last)
  last=t
 end
end
