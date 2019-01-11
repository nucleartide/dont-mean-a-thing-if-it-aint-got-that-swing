pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- todo: use time()
-- to derive song_pos.

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

started=false
start_time=nil
song_pos=0 -- zero-indexed.

bpm=120

-- # of seconds per crochet.
crotchet=60/bpm

--[[

if (conductor.songposition > crotchet * beatnumber)
-- perform an action.
-- mark as performed.
islitup = true;

}

]]

function _update60()
 if not started and btn(🅾️) then
  started=true
  start_time=sample()
  return
 end

 if started then
  song_pos=sample()-start_time
 end
end

function sample()
 return time()/2
end

function _draw()
 cls(15)
 print(song_pos)
end
__sfx__
00040000000000d05012050130501405015050160501705018050190501b0501d0501f050210502305025050280502b05030050350503d0503f05000000000000000000000000000000000000000000000000000
