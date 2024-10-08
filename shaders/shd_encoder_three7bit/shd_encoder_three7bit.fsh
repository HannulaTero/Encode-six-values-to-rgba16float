

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

  
uniform vec3 uniValuesA;
uniform vec3 uniValuesB;
void main()
{
  // Encoding the data.
  // -> To ensure correct encoding, values should be sanitized.
  // -> If you are "sure" about the values, you don't need to sanitize.
  vec4 encoded = vec4(
    three7bit_encode(three7bit_sanitize(uniValuesA)), 
    three7bit_encode(three7bit_sanitize(uniValuesB))
  );
  
  // Decoding the data.
  vec3 valuesA = three7bit_decode(encoded.rg);
  vec3 valuesB = three7bit_decode(encoded.ba);
  
  // Anyway, store the encoded.
  gl_FragData[0] = encoded;
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
