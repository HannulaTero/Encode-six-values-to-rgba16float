


//==================================================================
// 
#region DECLARE : ENCODER THREE10BIT-TWO16FLOAT.


precision highp float;
vec3 three10bit_sanitize(vec3 values);
vec2 three10bit_encode(vec3 values);
vec3 three10bit_decode(vec2 pack);


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
  gl_FragData[0] = vec4(
    three10bit_encode(three10bit_sanitize(uniValuesA)), 
    three10bit_encode(three10bit_sanitize(uniValuesB))
  );
}


#endregion
//
//==================================================================
//==================================================================
// 
#region DEFINE : ENCODER THREE10BIT-TWO16FLOAT.


// For sanitizing input values to be in correct range.
// -> Requirement is to be whole number in range of 0 to 1023.
vec3 three10bit_sanitize(vec3 values)
{
  return floor(clamp(values, vec3(0.0), vec3(1023.0)));
}


// Function encodes three 10bit whole numbers into two 16bit floats.
vec2 three10bit_encode(vec3 values)
{
  // Split one value in two.
  vec2 valuePart;
  valuePart[0] = floor(values[2] / 32.0);
  valuePart[1] = values[2] - valuePart[0] * 32.0;
  
  // Encode into two f16.
  vec2 pack;
  for(int i = 0; i < 2; i++)
  {
    // Encode into parts of f16.
    float signBit = (valuePart[i] < 16.0) ? +1.0 : -1.0;
    float exponent = (valuePart[i] + (signBit * 8.0 - 8.0)) * 2.0 - 15.0;
    float mantissa = values[i] / 1024.0 + 1.0;
    
    // Last modification to avoid subnormals.
    // -> Utilizes otherwise non-used bit.
    exponent = (exponent <= -15.0) ? -14.0 : exponent;
    pack[i] = signBit * pow(2.0, exponent) * mantissa;
  }
  
  return pack;
}


// Function decodes decodes two 16bit floats into three 10bit whole numbers.
vec3 three10bit_decode(vec2 pack)
{
  // Extract bits.
  vec3 values;
  vec2 valuePart;
  for(int i = 0; i < 2; i++)
  {
    // Extract f16 parts.
    float signBit = (pack[i] >= 0.0) ? +1.0 : -1.0;
    pack[i] *= signBit; // To remove signedness.
    float exponent = floor(log2(pack[i]));
    float mantissa = pack[i] / pow(2.0, exponent);
    
    // Get the value, and valuepart.
    values[i] = (mantissa - 1.0) * 1024.0;
    exponent = (exponent <= -14.0) ? -15.0 : exponent;
    valuePart[i] = (exponent + 15.0) * 0.5 - (signBit * 8.0 - 8.0);
  }
  
  // Construct final value.
  values[2] = valuePart[0] * 32.0 + valuePart[1];  
  return values;
}


#endregion
//
//==================================================================







