% Generar una carta de colores 256x256 trabajando en el espacio HSV
% El canal de tinte variará en diagonal para todo su rango siguiendo 
% una matriz de Toeplitz

size = 256;
hue = toeplitz(linspace(1, 0, size));

saturation = ones(size);
value = ones(size);

% Combinar los canales para crear la imagen en espacio HSV
hsv_img = cat(3, hue, saturation, value);

% Convertir la imagen de HSV a RGB para visualizarla
rgb_img = hsv2rgb(hsv_img);

imshow(rgb_img);
title('Carta de colores HSV con variación diagonal del tinte');