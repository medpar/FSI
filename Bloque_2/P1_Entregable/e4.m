% Cuantificar la imagen del ejercicio 3 utilizando rgb2ind con una profundidad de 3 bits
% Aplicar una cuantificación de mínima varianza con y sin dithering 

% Parte 1: Sin dithering
[indexed_image_no_dither, map_no_dither] = rgb2ind(rgb_img, 8, 'nodither');

subplot(1, 2, 1);
imshow(indexed_image_no_dither, map_no_dither);
title('Imagen cuantificada (3 bits) sin dithering');

% Parte 2: Con dithering
[indexed_image_dither, map_dither] = rgb2ind(rgb_img, 8, 'dither');

subplot(1, 2, 2);
imshow(indexed_image_dither, map_dither);
title('Imagen cuantificada (3 bits) con dithering');