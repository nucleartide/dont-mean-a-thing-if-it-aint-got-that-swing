pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- config.
cfg={
 -- beats per minute.
 bpm=120,

 -- beats per measure.
 beats_per_measure=3,
 
 -- track definition.
 track={
  '...',
  '...',
  '...',
  'z..',
  'x..',
  'z.x',
  'z..',
  'x.z',
  'x..',
  '...',
  '...',
  '...',
  '...',
  '...',
  '...',
  '...',
  '...',
 },
}

-- state.
st={
 -- time per note.
 -- units: seconds per min,
 -- beats per min.
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
 
 -- current beat, zero-indexed.
 cur_beat=0,
 
 -- allowed beat, zero-indexed.
 allow_beat=0,
 
 -- current measure,
 -- zero-indexed.
 measure=0,

 -- current note.
 note='',
 
 -- last note.
 last_note='',
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

function update60()
 -- start track.
 if
  not st.started and btn(🅾️)
 then
  st.started=true
  st.start_time=sample()
 end

 -- early return.
 if not st.started then
  return
 end

 --
 -- update state.
 --
 
 -- song pos
 st.song_pos=
   sample()
  -st.start_time
 
 -- temp var.
 local t=st.song_pos/st.crochet
 
 -- current beat.
 st.cur_beat=flr(t)

 -- allowed beat.
 if (t%1) >= 0.5 then
  st.allow_beat=ceil(t)
 else
  st.allow_beat=flr(t)
 end
 
 -- measure.
 st.measure=
  flr(
   st.allow_beat/
   cfg.beats_per_measure
  )

 --
 -- compute note and last_note.
 --

 -- current measure.
 local m=cfg.track[st.measure+1]

 -- current note within
 -- measure.
 local i=1+
  st.allow_beat%
  cfg.beats_per_measure
 
 -- note.
 if m ~= nil then
  st.note=sub(m,i,i)
 else
  st.note=''
 end
 
 -- last note.
 if m~=nil and i>1 then
  st.last_note=sub(m,i-1,i-1)
 else
  local m=
   cfg.track[st.measure+1-1]
  st.last_note=
   m~=nil and sub(m,3,3) or ''
 end

 --
 -- once case.
 --

 local measure=st.measure+1
 local beat=i
 local pressed=st.runtime_track
  [measure]
  [beat]

 if
  btnp(🅾️) and st.note=='z' or
  btnp(❎) and st.note=='x'
 then
  -- if already pressed,
  -- decrement health.
  if pressed then
   st.player_health -= 1
  else
   -- mark note as handled.
   st.runtime_track
    [measure]
    [beat]
    =true
  end
 end

 --
 -- zero case.
 --
 -- this is the case where
 -- we missed a note
 -- completely.
 --

 local last_measure = beat==1
  and measure-1
  or  measure

 local last_beat = beat==1
  and cfg.beats_per_measure
  or  (beat-1)

 local had_last_note=false
  or st.last_note == 'z'
  or st.last_note == 'x'
 
 local rt=
  st.runtime_track
   [last_measure]

 local handled_last_beat=
  rt
  and rt[last_beat]
  or false

 -- if there was a last note,
 -- and we didn't hit,
 -- then decrement health and
 -- mark last note as
 -- processed.
 if true
  and had_last_note
  and not handled_last_beat
 then
  st.player_health -= 1
  st.runtime_track
   [last_measure]
   [last_beat]
   =true
 end
end

function draw()
 cls(15)
 
 -- debug info.
 ?'started:'..tostr(st.started)
 ?'songpos:'..tostr(st.song_pos)
 ?'hp:'..tostr(st.player_health)
 ?'curbeat:'..tostr(st.cur_beat)
 ?'allow:'..tostr(st.allow_beat)
 ?'measure:'..tostr(st.measure)
 ?'note:'..tostr(st.note)
 ?'last:'..tostr(st.last_note)
 do return end

 -- for each measure in the track,
 for i=1,#cfg.track do
  -- for each note in the measure,
  for j=1,cfg.beats_per_measure do
   -- compute note position
   local note_pos = 0
    + (i-1) * cfg.beats_per_measure
    + (j-1)

   -- only draw a circle if the note is a z
   local measure = cfg.track[i]
   local note    = sub(measure, j, j)

   -- if the note position exceeds the current song position,
   if note_pos*st.crochet > st.song_pos and note == 'z' then
    -- draw a circle for that note.
    circfill(64-10, 94 - (note_pos*st.crochet - st.song_pos) * 20, 5, 7)
   end
  end
 end

 circ(64-10,94,5,7)
 circ(64+10,94,5,7)
end
