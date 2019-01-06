pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
x = 64 y = 64
function _update()
  dx = 0
  dy = 0
  f = 2
  if (btn(0)) then dx = -1 end
  if (btn(1)) then dx = 1 end
  if (btn(2)) then dy = -1 end
  if (btn(3)) then dy = 1 end

  if (btn(4)) then
    f=5
  elseif (btn(5)) then
    f=1
  end

  x+=dx*f
  y+=dy*f
  if x > 127 then x = 127 end
  if x < 0 then x = 0 end
  if y > 127 then y = 127 end
  if y < 0 then y = 0 end
end

function _draw()
  cls()
  circfill(x,y,7,14)
end
