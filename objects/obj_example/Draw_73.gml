/// @desc VISUALIZE RESULTS.

var i = 2;
draw_text(640, 32 * i++, "Press left to change values randomly.");
draw_text(640, 32 * i++, "Press right to change values incrementally.");
i++;
draw_text(640, 32 * i++, "Press 1 to change decoder to [three 7bit to two f16].");
draw_text(640, 32 * i++, "Press 2 to change decoder to [three 10bit to two f16].");
i++;
i++;
i++;
draw_text(640, 32 * i++, $"Current example : {current.name}");
draw_text(640, 32 * i++, $"Current range   : [0, {current.maxValue}]");
i++;
i++;
draw_text(660, 32 * i++, $"Encoding six values into rgba:");
draw_text(660, 32 * i++, $" - Original values : {arrValues}");
draw_text(660, 32 * i++, $" - Encoded values  : {arrEncoded}");
draw_text(660, 32 * i++, $" - Decoded values  : {arrDecoded}");
draw_text(660, 32 * i++, $" - Differences     : {arrDifferences}");


// Visualize the results, encodes separately.
if (surface_exists(surfDecoded))
{
  shader_set(shd_example_visualize);
  {
    var _uniMaxValue = shader_get_uniform(shd_example_visualize, "uniMaxValue");
    gpu_set_tex_filter(false);
    shader_set_uniform_f(_uniMaxValue, current.maxValue);
    draw_surface_stretched(surfDecoded, 64, 64, 512, 512);
    gpu_set_tex_filter(true);
  }
  shader_reset();
}