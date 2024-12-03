%Apartado 1: Cargar y desaturar la imagen

img = imread('peppers.png');
%Asegurar que la imagen esté en formato double en el rango [0, 1]
imshow(img);
title('Imagen original');
pause
img = im2double(img);

% Convertir la imagen al espacio de color HSV
img_hsv = rgb2hsv(img);

% Desaturar la imagen entre un 40% y 60%
% Ajustar el canal de saturación (S) con un factor de ponderación
desaturation_factor = 0.5; % Ajuste entre 0.4 y 0.6
img_hsv(:,:,2) = img_hsv(:,:,2) * desaturation_factor;

% Convertir la imagen de nuevo al espacio RGB
img_desaturated = hsv2rgb(img_hsv);

% Mostrar la imagen desaturada
imshow(img_desaturated);
title('Imagen desaturada al 50%');
