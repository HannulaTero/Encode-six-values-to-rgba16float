# Encode six values in rgba16float
 For GameMaker to be used mainly with web exports, as version of WebGL doesn't support MRT or rgba32float textures.
 
 There are two encoders:
 * Simpler for encoding three 7bit values in two F16
 * More complex for encoding three 10bit values in two F16.

 Encoders encode three values into two, which can be used to store six values in rgba16float.
 * Value range for simpler is 0 to 127
 * Value rangee for complex is 0 to 1023
 * Encoders assume whole numbers as inputs, and will give them as outputs. Rerange them however necessary. 

 - - -
 GX.games example:
 
 https://gx.games/games/g7pmw7/encode-six-7bit-values-into-rgba16float/tracks/cb249102-5272-4217-9a37-29bad7fce564/


 HTML5 example:
 
 https://terohannula.itch.io/encode-six-7bit-values-in-rgba16float
