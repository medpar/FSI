% Dimensiones de la imagen
rows = 256;
cols = 256;

% Definir las funciones A(y) y ω(x)
A = linspace(1, 10, rows)';    % Amplitud creciente a lo largo de y
omega = linspace(0.01, 0.1, cols);  % Frecuencia creciente a lo largo de x

% Crear la imagen sinusoidal
[x_grid, y_grid] = meshgrid(1:cols, 1:rows);  % Crear mallas para x e y
I = A .* cos(omega .* x_grid);  % Aplicar la fórmula I(x, y) = A(y) * cos(ω(x) * x)

% Mostrar la imagen generada con escala ajustada
imshow(I, []);
title('Imagen de señal sinusoidal');
