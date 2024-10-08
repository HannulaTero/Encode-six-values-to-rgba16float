/// @desc DO THE ENCODING & DECODING.


// Make sure surfaces exist.
var _rgba = 4;
var _dsize = buffer_sizeof(buffer_f16);
if (!surface_exists(surfEncoded))
{
  dirtyCache = true;
  surfEncoded = surface_create(1, 1, surface_rgba16float);
  buffer_resize(buffEncoded, _rgba * _dsize);
}

if (!surface_exists(surfDecoded))
{
  dirtyCache = true;
  surfDecoded = surface_create(6, 1, surface_rgba16float);
  buffer_resize(buffDecoded, 6 * _rgba * _dsize);
  // HTML5 doesn't support "r16float", so rest components are just padding.
  // This doesn't matter as this is just for making example.
}
  

// Skip if cache is fine.
if (!dirtyCache)
{
  exit;
}
dirtyCache = true;


// Encode the values into rgba16float.
surface_set_target(surfEncoded);
draw_clear_alpha(0, 0);
shader_set(current.shaderEncode);
{
  var _uniValuesA = shader_get_uniform(current.shaderEncode, "uniValuesA");
  var _uniValuesB = shader_get_uniform(current.shaderEncode, "uniValuesB");
  gpu_set_blendenable(false);
  gpu_set_tex_filter(false);
  shader_set_uniform_f(_uniValuesA, arrValues[0], arrValues[1], arrValues[2]);
  shader_set_uniform_f(_uniValuesB, arrValues[3], arrValues[4], arrValues[5]);
  draw_sprite_stretched(spr_1x1, 0, 0, 0, 1, 1);
  gpu_set_tex_filter(true);
  gpu_set_blendenable(true);
}
shader_reset();
surface_reset_target();


// Decode the values, store each value in their own pixel.
surface_set_target(surfDecoded);
shader_set(current.shaderDecode);
{
  gpu_set_blendenable(false);
  gpu_set_tex_filter(false);
  draw_surface_stretched(surfEncoded, 0, 0, 6, 1);
  gpu_set_tex_filter(true);
  gpu_set_blendenable(true);
}
shader_reset();
surface_reset_target();


// Get the results to the CPU.
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
  var _r = buffer_read(buffDecoded, buffer_f16); // decoded value.
  var _g = buffer_read(buffDecoded, buffer_f16); // padding.
  var _b = buffer_read(buffDecoded, buffer_f16); // padding.
  var _a = buffer_read(buffDecoded, buffer_f16); // padding.
  arrDecoded[i] = _r;
  arrDifferences[i] = (arrValues[i] - _r);
}









