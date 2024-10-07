

if (device_mouse_check_button(0, mb_left))
{
  array_map_ext(arrOriginals, function()
  {
    return irandom(127);
  });
}



if (device_mouse_check_button(1, mb_left))
|| (device_mouse_check_button(0, mb_right))
{
  step += 1/8;
  if (step >= 128.0)
  {
    step = 0.0;
  }

  array_map_ext(arrOriginals, function()
  {
    return floor(step);
  });
}