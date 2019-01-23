pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

function copy_table(orig)
  local copy = {}
  for k, v in pairs(orig) do
    copy[k]=v
  end
  return copy
end

tgt={}
tgt.x=1
tgt.y=1
cur=copy_table(tgt)
max_x=10
max_y=10
-- clue_mode
-- 0: show factors, find product
-- 1: show product, find factors
clue_mode=0
cell_height=10
cell_width=12

function get_new_target()
  new_tgt=copy_table(tgt)
  while(new_tgt==tgt) do
    new_tgt.x=flr(rnd(max_x))+1
    new_tgt.y=flr(rnd(max_y))+1
  end
  tgt=new_tgt
end

function print_clue()
  if (clue_mode == 0) then
    msg = tgt.x .. " x " .. tgt.y .. " = ?"
  else
    msg = "? x ? = " .. tgt.x*tgt.y
  end
  print(msg, 30, 110)
end

function _init()
  get_new_target()
end

function _draw()
  cls()
  print_clue()

  for x=1,max_x do
    for y=1,max_y do
      val = x*y
      cell={}
      cell.x = 4+(x-1)*cell_width
      cell.y = 4+(y-1)*cell_height
      if x == cur.x and y == cur.y then
        col = 2
      elseif x == cur.x then
        col = 8
      elseif y == cur.y then
        col = 12
      else
        col = 5+(x+y)%2
      end
      rectfill(
        cell.x,
        cell.y,
        cell.x+cell_width,
        cell.y+cell_height,
        col
      )

      -- center the text in the square
      cell.x+=1+2*(3-#tostr(val))
      cell.y+=3
      print(val,cell.x,cell.y,7)
    end
  end
end

function has_won()
  result=false
  if (clue_mode == 0) then
    -- return true if the factors are correct
    result = tgt.x == cur.x
      and tgt.y == cur.y
      or tgt.x == cur.y
      and tgt.y == cur.x
  else
    -- return true if the product is correct
    result = tgt.x*tgt.y == cur.x*cur.y
  end
  return result
end

function _update()

  if (has_won()) then
    sfx(1)
    new_a=tgt.x
    new_b=tgt.y
    while(new_a==tgt.x and new_b==tgt.y) do
      new_a=flr(rnd(max_x))+1
      new_b=flr(rnd(max_y))+1
    end
    tgt.x=new_a
    tgt.y=new_b
    clue_mode=flr(rnd(2))
  end
  if (btnp(0)) then
    cur.x-=1
    if (cur.x < 1) then
      cur.x = 1
    else
      sfx(0)
    end
  end
  if (btnp(1)) then
    cur.x+=1
    if (cur.x > max_x) then
      cur.x = max_x
    else
      sfx(0)
    end
  end
  if (btnp(2)) then
    cur.y-=1
    if (cur.y < 1) then
      cur.y = 1
    else
      sfx(0)
    end
  end
  if (btnp(3)) then
    cur.y+=1
    if (cur.y > max_y) then
      cur.y = max_y
    else
      sfx(0)
    end
  end
end
__map__
0000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001000031050340503405034050340502b00029000260002500022000200001e0001c0001a00017000150001400016000170001a0001a0000000000000000000000000000000000000000000000000000000000
010e00000c55511555155551855018555155551855018550185501855500505005050050500505005050050500505005050050500505005050050500505005050050500505005050050500505005050050500505
