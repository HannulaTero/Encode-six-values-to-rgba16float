// This is simpler example how to utilize vec3 instead.
// You don't need 6 item array then, instead call three-function twice, 
// and just use swizzling to get correct components.


// To ensure encoding doesn't break on lower hardware.
precision highp float;


// Encoding three values into two F16 values.
vec2 three7bit_encode(vec3 values)
{
  vec2 result;
  float temp = floor((values[2] + 0.5) / 16.0);
  result.r = values[0] * 16.0 + values[2] - temp * 16.0;
  result.g = values[1] * 16.0 + temp;
  return result;
}


// Decoding two F16 values into three values.
vec3 three7bit_decode(vec2 pack)
{
  vec3 result;
  result[0] = floor((pack.r + 0.5) / 16.0);
  result[1] = floor((pack.g + 0.5) / 16.0);
  result[2] = (pack.r - result[0] * 16.0) + (pack.g - result[1] * 16.0) * 16.0;
  return result;
}


// Dummy main function.
void main()
{
  gl_FragData[0] = vec4(1.0);
}



