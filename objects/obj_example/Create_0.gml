


// Getting and storing results.
buffEncoded = buffer_create(1, buffer_grow, 1);
buffDecoded = buffer_create(1, buffer_grow, 1);
surfEncoded = -1;
surfDecoded = -1;
dirtyCache = true;


// Current example.
current = {
  name: "three 7bit to two f16",
  shaderEncode: shd_example_encoder_three7bit_encode,
  shaderDecode: shd_example_encoder_three7bit_decode,
  maxValue: 127.0,
  speed: 0.5,
  step: 0
}


// For visualizing and comparing the results.
arrValues = [
  0, 0, 0, 0, 0, 0
];

arrEncoded = [
  0, 0, 0, 0
];

arrDecoded = [
  0, 0, 0, 0, 0, 0
];

arrDifferences = [
  0, 0, 0, 0, 0, 0
];
