V = 0.8;

[H, S] = meshgrid(0:0.01:1, 0:0.01:1);

% Creamos la matriz tridimensional con los 3 canales
HSV = cat(3, H, S, V * ones(size(H)));

% Convertir la imagen del espacio HSV al espacio RGB
RGB = hsv2rgb(HSV);

% Carta de colores
imshow(RGB);
title('Carta de colores en espacio HSV');
