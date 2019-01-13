pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- config.
cfg={
 -- beats per minute.
 bpm=120,
 
 -- track definition.
 track={
  '...',
  '...',
  'z..',
  'x..',
  'z.x',
  'z..',
  'x.z',
  'x..',
 },
}

-- state.
st={
 -- time per note.
 crochet=60/cfg.bpm,
 
 -- notes hit by player.
 runtime_track=nil,

 -- whether track has started.
 started=false,
 
 -- start time of track.
 start_time=0,
 
 -- secs since track start.
 song_pos=0,

 -- # of player lives.
 player_health=3,
 
 -- current beat.
 cur_beat=0,
 
 -- index of allowed beat.
 allow_beat=0,
 
 -- current measure.
 measure=0,
}

function _init()
 -- init runtime track.
 st.runtime_track={}
 for i=1,#cfg.track do
  local o={nil,nil,nil}
  add(st.runtime_track,o)
 end
end
-->8
-- utils.

function sample()
 return time()/2
end
-->8
-- game loop.

function _update60()
 -- start track and return.
 if not st.started and btn(🅾️) then
  st.started=true
  st.start_time=sample()
  return
 end
 
 -- update state.
 if st.started then
  st.song_pos=sample()-st.start_time
  
  local t=st.song_pos/st.crochet
  
  st.cur_beat=flr(t)

  if st.song_pos >= 0.5 then
   st.allow_beat=ceil(t)
  else
   st.allow_beat=flr(t)
  end
  
  st.measure=flr(st.allow_beat/3)+1
 end
end

function _draw()
 cls(15)
 printh('')
 printh('song_pos: ' .. st.song_pos)
 printh('cur_beat: ' .. st.cur_beat)
 printh('allow_beat: ' .. st.allow_beat)
 printh('measure: ' .. st.measure)
end
-->8
function draw()
 local i=flr(allow_beat%3)+1
 local m=track[measure]
 local r=runtime_track[measure]
 local note
 if m ~= nil then
  note=sub(m,i,i)
  print(note)
  
  -- todo: handle user input.
  
  -- once case.
  if btnp(🅾️) and note=='z' then
   runtime_track[measure][i]=true
  elseif btnp(🅾️) and note=='z' and runtime_track[measure][i] then
   player_health -= 1
  end
  if btnp(❎) and note=='x' then
   runtime_track[measure][i]=true
  elseif btnp(🅾️) and note=='x' and runtime_track[measure][i] then
   player_health -= 1
  end
  
  -- >once case.
  
  -- zero case.
 end
end
__sfx__
000400000000019050200502305026050260502705027050280502805026050230501f0501a05014050120500e0500a0500805007050080500a05010050240500000000000000000000000000000000000000000
