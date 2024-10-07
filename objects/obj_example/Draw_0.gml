//shader_enable_corner_id(false);


// Make sure surfaces exist.
var _dsize = buffer_sizeof(buffer_f16);
if (!surface_exists(surfEncoded))
{
  surfEncoded = surface_create(1, 1, surface_rgba16float);
  buffer_resize(buffEncoded, 4 * _dsize);
}

if (!surface_exists(surfDecoded))
{
  // HTML5 doesn't support r16float.
  surfDecoded = surface_create(6, 1, surface_rgba16float);
  buffer_resize(buffDecoded, 6 * 4 * _dsize);
}
  
  
// Encode the values into rgba16float.
surface_set_target(surfEncoded);
draw_clear_alpha(0, 0);
shader_set(shd_six7bit_encode);
{
  var _uniValues = shader_get_uniform(shd_six7bit_encode, "uniValues");
  gpu_set_blendenable(false);
  shader_set_uniform_f_array(_uniValues, arrOriginals);
  draw_sprite_stretched(spr_1x1, 0, 0, 0, 1, 1);
  gpu_set_blendenable(true);
}
shader_reset();
surface_reset_target();


// Visualize the results, encodes separately.
shader_set(shd_six7bit_visualize);
{
  var _uniPos = shader_get_uniform(shd_six7bit_visualize, "uniPos");
  var _uniSize = shader_get_uniform(shd_six7bit_visualize, "uniSize");
  var _x = 32;
  var _y = 32;
  var _w = 6 * 64;
  var _h = 512;
  shader_set_uniform_f(_uniPos, _x, _y);
  shader_set_uniform_f(_uniSize, _w, _h);
  draw_surface_stretched(surfEncoded, _x, _y, _w, _h);
}
shader_reset();


// Decode the values, store each in own pixel.
surface_set_target(surfDecoded);
shader_set(shd_six7bit_decode);
{
  gpu_set_blendenable(false);
  draw_surface_stretched(surfEncoded, 0, 0, 6, 1);
  gpu_set_blendenable(true);
}
shader_reset();
surface_reset_target();


// Get the results.
buffer_get_surface(buffEncoded, surfEncoded, 0);
buffer_get_surface(buffDecoded, surfDecoded, 0);

buffer_seek(buffEncoded, buffer_seek_start, 0);
for(var i = 0; i < 4; i++)
{
  arrEncoded[i] = buffer_read(buffEncoded, buffer_f16);
}

buffer_seek(buffDecoded, buffer_seek_start, 0);
for(var i = 0; i < 6; i++)
{
  var _r = buffer_read(buffDecoded, buffer_f16);
  var _g = buffer_read(buffDecoded, buffer_f16);
  var _b = buffer_read(buffDecoded, buffer_f16);
  var _a = buffer_read(buffDecoded, buffer_f16);
  arrDecoded[i] = _r;
  arrDifferences[i] = (arrOriginals[i] - _r);
}




