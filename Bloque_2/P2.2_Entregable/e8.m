%Apartado 8: Realzar bordes de la imagen antes de ajustar brillo y gamma

% Aplicar un filtro de realce de bordes
edge_enhanced_img = img_with_glare; % Copiar la imagen con destello
edge_enhanced_img = imsharpen(edge_enhanced_img); % Aplicar realce de bordes

% Aumentar el brillo en un 15% después del realce de bordes
brightness_factor = 1.15;
img_brighter_with_edges = edge_enhanced_img * brightness_factor;
img_brighter_with_edges = min(img_brighter_with_edges, 1); % Limitar valores a [0, 1]

% Aplicar corrección de gamma del 10% a la imagen con bordes realzados
gamma_value = 1.1;
img_gamma_corrected_with_edges = imadjust(img_brighter_with_edges, [], [], gamma_value);

% Mostrar la imagen final con realce de bordes, aumento de brillo y corrección de gamma
imshow(img_gamma_corrected_with_edges);
title('Imagen con Realce de Bordes, Brillo y Corrección de Gamma');

% Comparación visual con la imagen sin realce de bordes
figure;
subplot(1, 2, 1);
imshow(img_gamma_corrected);
title('Imagen sin Realce de Bordes');

subplot(1, 2, 2);
imshow(img_gamma_corrected_with_edges);
title('Imagen con Realce de Bordes');
