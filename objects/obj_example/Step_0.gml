/// @desc CHANGE VALUES.


if (device_mouse_check_button(0, mb_left))
{
  dirtyCache = true;
  array_map_ext(arrValues, function()
  {
    return irandom(current.maxValue);
  });
}



if (device_mouse_check_button(0, mb_right))
|| (device_mouse_check_button(1, mb_left)) 
{
  current.step += current.speed;
  if (current.step > current.maxValue)
  {
    current.step = 0.0;
  }

  dirtyCache = true;
  array_map_ext(arrValues, function()
  {
    return floor(current.step);
  });
}