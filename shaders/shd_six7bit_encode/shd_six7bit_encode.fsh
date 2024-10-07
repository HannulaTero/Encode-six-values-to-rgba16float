precision highp float;


uniform float uniValues[6];


float six7bit[6];
vec4 six7bit_encode()
{
  vec4 result;
  float lower = floor((six7bit[2] + 0.5) / 16.0);
  float upper = floor((six7bit[5] + 0.5) / 16.0);
  result.r = six7bit[0] * 16.0 + six7bit[2] - lower * 16.0;
  result.g = six7bit[1] * 16.0 + lower;
  result.b = six7bit[3] * 16.0 + six7bit[5] - upper * 16.0;
  result.a = six7bit[4] * 16.0 + upper;
  return result;
}

  
void main()
{
  // Get the values, make sure they are in acceptable range and format.
  for(int i = 0; i < 6; i++)
  {
    six7bit[i] = clamp(floor(uniValues[i]), 0.0, 127.0);
  }
  
  // Encode the values.
  vec4 result = six7bit_encode();
  
  // Store the result. Target is 1x1 texture for now.
  gl_FragData[0] = result;
}
