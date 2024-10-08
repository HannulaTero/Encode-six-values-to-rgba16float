

//==================================================================
// 
#region DECLARE : ENCODER THREE7BIT-TWO16FLOAT.


precision highp float;
vec3 three7bit_sanitize(vec3 values);
vec2 three7bit_encode(vec3 values);
vec3 three7bit_decode(vec2 pack);


#endregion
//
//==================================================================
//==================================================================
// 
#region MAIN FUNCTION : EXAMPLE USE.

  
void main()
{
  // Input value is 1x1 texture, contains encoded values.
  vec4 pack = texture2D(gm_BaseTexture, vec2(0.5));
  
  // Decode values.
  vec3 valuesA = three7bit_decode(pack.rg);
  vec3 valuesB = three7bit_decode(pack.ba);

  // Select value to put into buffer.
  int index = int(floor(gl_FragCoord.x));
  
  // Get the value in rudamentary way.
  // -> This is just to get different values for different pixels.
  float value;
       if (index == 0) value = valuesA[0];
  else if (index == 1) value = valuesA[1];
  else if (index == 2) value = valuesA[2];
  else if (index == 3) value = valuesB[0];
  else if (index == 4) value = valuesB[1];
  else if (index == 5) value = valuesB[2];
 
  gl_FragData[0] = vec4(value, 0.0, 0.0, 1.0);
}


#endregion
//
//==================================================================
//==================================================================
// 
#region DEFINE : ENCODER THREE7BIT-TWO16FLOAT.


// For sanitizing input values to be in correct range.
// -> Requirement is to be whole number in range of 0 to 127.
vec3 three7bit_sanitize(vec3 values)
{
  return floor(clamp(values, vec3(0.0), vec3(127.0)));
}


// Encoding three values into two F16 values.
vec2 three7bit_encode(vec3 values)
{
  vec2 result;
  float temp = floor(values[2] / 16.0);
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


#endregion
//
//==================================================================

