pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- rhythm game prototype
-- by @nucleartide

-- config
bpm=60
fps=60

-- computed
fpm=fps*60  -- 60*60    = 3600
fpb=fpm/bpm -- 3600/120 = 30

-- frames per note.
-- we're using triplets.
fpn=fpb/3

-- pattern to play.
t=0
pattern={
'z..',
'x..',
'z.x',
'z..',
'x.z',
'x..',
}

extcmd('rec')

function _update60()
 local beat=flr(t/fpb)+1
 if beat>#pattern then
  extcmd('video')
  stop()
 end

-- get expected note index. 
local a=t%fpb
local b=fpb/3
note=
 a<b   and 1 or
 a<2*b and 2 or
 a<3*b and 3 or
 nil

-- get expected note.
expected=pattern[beat]
if expected ~= nil then
expected=sub(expected,note,note)
end

 -- advance t.
 t+=1
end

function _draw()
 if expected=='z' then
  cls(8)
 elseif expected=='x' then
  cls(9)
 elseif expected=='.' then
  cls()
 else
  --no-op
  --assert(false)
 end
 if expected ~= nil then
 print(expected,hcenter(expected),vcenter(expected),7)
 end
 if note ~= nil then
 print(note,0,0,7)
 end
end

function hcenter(s)
  -- screen center minus the
  -- string length times the 
  -- pixels in a char's width,
  -- cut in half
  return 64-#s*2
end
 
function vcenter(s)
  -- screen center minus the
  -- string height in pixels,
  -- cut in half
  return 61
end
