% Aplicar la máscara obtenida en el apartado 1 a las imágenes cuantificadas

% Aplicar la máscara a las imágenes cuantificadas
masked_image_no_dither = indexed_image_no_dither;
masked_image_no_dither(~mask) = 0;
masked_image_dither = indexed_image_dither;
masked_image_dither(~mask) = 0;

subplot(1, 2, 1);
imshow(masked_image_no_dither, map_no_dither);
title('Imagen cuantificada sin dithering enmascarada');

subplot(1, 2, 2);
imshow(masked_image_dither, map_dither);
title('Imagen cuantificada con dithering enmascarada');