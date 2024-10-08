  
  
varying vec2 vCoord;
uniform float uniMaxValue;
void main()
{  
  // Input value is 6x1 texture, contains results of encode/decode.
  float value = texture2D(gm_BaseTexture, vCoord).r;
  
  // Visualize the result, draw as vertical bars.
  float current = vCoord.y * uniMaxValue;
  gl_FragData[0] = (current < value)
    ? vec4(0.7, 0.8, 0.9, 1.0)
    : vec4(0.3, 0.2, 0.1, 1.0);
}








