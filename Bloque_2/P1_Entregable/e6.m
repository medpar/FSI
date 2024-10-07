% Parte 1: Sin dithering
img_no_dither = ind2rgb(masked_image_no_dither, map_no_dither);
[img1, map1] = rgb2ind(img_no_dither, 8, 'nodither');

% Parte 2: Con dithering
img_dither = ind2rgb(masked_image_dither, map_dither);
[img2, map2] = rgb2ind(img_dither, 8, "dither");


subplot(1, 2, 1);
imshow(img1, map1);
title('Imagen enmascarada cuantificada (3 bits) sin dithering');
subplot(1, 2, 2);
imshow(img2, map2);
title('Imagen enmascarada cuantificada (3 bits) con dithering');

