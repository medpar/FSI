% Parte 1: Aplicar la máscara a la imagen original (enmascarar)
masked_rgb_img = bsxfun(@times, rgb_img, cast(mask, 'like', rgb_img));

% Cuantificación sin dithering sobre la imagen enmascarada
[indexed_image_no_dither_masked, map_no_dither_masked] = rgb2ind(masked_rgb_img, 8, 'nodither');

subplot(2, 2, 1);
imshow(indexed_image_no_dither_masked, map_no_dither_masked);
title('Imagen enmascarada cuantificada (3 bits) sin dithering');

% Cuantificación con dithering sobre la imagen enmascarada
[indexed_image_dither_masked, map_dither_masked] = rgb2ind(masked_rgb_img, 8, 'dither');

subplot(2, 2, 2);
imshow(indexed_image_dither_masked, map_dither_masked);
title('Imagen enmascarada cuantificada (3 bits) con dithering');
