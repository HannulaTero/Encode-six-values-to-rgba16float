/// @desc CHANGE EXAMPLE.

if (keyboard_check_pressed(ord("1")))
|| (device_mouse_check_button(2, mb_left))
{
  current.name = "three 7bit to two f16";
  current.shaderEncode = shd_example_encoder_three7bit_encode;
  current.shaderDecode = shd_example_encoder_three7bit_decode;
  current.maxValue = 127.0;
  current.speed = 0.5;
  current.step = 0;
}


if (keyboard_check_pressed(ord("2")))
|| (device_mouse_check_button(3, mb_left))
{
  current.name = "three 10bit to two f16";
  current.shaderEncode = shd_example_encoder_three10bit_encode;
  current.shaderDecode = shd_example_encoder_three10bit_decode;
  current.maxValue = 1023.0;
  current.speed = 4;
  current.step = 0;
}