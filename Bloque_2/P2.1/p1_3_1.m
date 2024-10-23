% Dimensiones de la imagen
rows = 256;
cols = 256;

% Definir el canal H (tinte) fijo en 0.1 para un color naranja
H = 0.1 * ones(rows, cols);

% Definir el canal S (saturación) fijo en 1
S = ones(rows, cols);

% Definir el canal V (luminancia) que varía de 0 a 1 de izquierda a derecha
V = repmat(linspace(0, 1, cols), rows, 1);

% Crear la imagen HSV combinando los tres canales
HSV = cat(3, H, S, V);

% Convertir la imagen del espacio HSV al espacio RGB
RGB = hsv2rgb(HSV);

% Mostrar la imagen resultante
figure;
imshow(RGB);
title('Degradado naranja');
