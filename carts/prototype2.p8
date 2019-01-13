pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- hi!!!
-->8
-- game loop.

-- props.
bpm=120

-- derived props.
crochet=60/bpm -- time per note.

-- state.
started=false
start_time=0

-- more state.
song_pos=0 -- secs since start.
cur_beat=0 -- current beat.
allow_beat=0 -- index of allowed beat.

function _update60()
 if not started and btn(🅾️) then
  started=true
  start_time=sample()
  return
 end

 if started then
  -- update current position.
  song_pos=sample()-start_time
  cur_beat=flr(song_pos/crochet)

  if song_pos >= 0.5 then
   allow_beat=ceil(cur_beat)
  else
   allow_beat=flr(cur_beat)
  end
 end
end

function _draw()
 cls(15)
 ?allow_beat
 
 local measure=flr(allow_beat/3)+1
 print(measure)
 
 local i=flr(allow_beat%3)+1
 local m=track[measure]
 local note
 if m ~= nil then
  note=sub(m,i,i)
  print(note)
 end
end
-->8
-- track.

function def_track()
 track={
  '...',
  '...',
  'z..',
  'x..',
  'z.x',
  'z..',
  'x.z',
  'x..',
 }
end

def_track()
-->8
-- time utils.

function sample()
 return time()/2
end
__sfx__
000400000000019050200502305026050260502705027050280502805026050230501f0501a05014050120500e0500a0500805007050080500a05010050240500000000000000000000000000000000000000000
