precision highp float;


float six7bit[6];
void six7bit_decode(vec4 pack)
{
  // Get the first three values.
  six7bit[0] = floor((pack.r + 0.5) / 16.0);
  six7bit[1] = floor((pack.g + 0.5) / 16.0);
  six7bit[2] = (pack.r - six7bit[0] * 16.0) + (pack.g - six7bit[1] * 16.0) * 16.0;
  
  // Get the next three values, works same as first one.
  six7bit[3] = floor((pack.b + 0.5) / 16.0);
  six7bit[4] = floor((pack.a + 0.5) / 16.0);
  six7bit[5] = (pack.b - six7bit[3] * 16.0) + (pack.a - six7bit[4] * 16.0) * 16.0;
}

  
void main()
{
  // Input value is 1x1 texture, contains encoded values.
  vec4 pack = texture2D(gm_BaseTexture, vec2(0.5));
  
  // Decode values, results are stored in global array.
  six7bit_decode(pack);

  // Select value to put into buffer.
  int index = int(floor(gl_FragCoord.x));
  
  // HTML5 safe way.
  float value = 0.0;
  for(int i = 0; i < 6; i++)
  {
    if (index == i)
    {
      value = six7bit[i];
      break;
    }
  }
  
  gl_FragData[0] = vec4(value, 0.0, 0.0, 1.0);
}



