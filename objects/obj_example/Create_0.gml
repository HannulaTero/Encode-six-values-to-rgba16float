
device_mouse_dbclick_enable(true);
step = 0;

buffEncoded = buffer_create(1, buffer_grow, 1);
buffDecoded = buffer_create(1, buffer_grow, 1);
surfEncoded = -1;
surfDecoded = -1;

arrOriginals = [
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