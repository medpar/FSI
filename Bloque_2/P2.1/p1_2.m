% Filas y columnas
M  =256;
N = 256;
K = 6;      % Parametro de profundidad
Nb = 2^K;

x = linspace(0, 1, N);

% Ahora lo cuantificamos
xq = fix((Nb*x))/(Nb - 1);  % Normalizamos al rango (0:1)
I = repmat(xq, M, 1);

% Comando para representar imagenes. Si la matriz es doble, considera que
% el rango dinamico esta entre 0 y 1. Si es en formato dinamico, entre 0 y
% 255. Se puede forzar a que ocupe todo el rango dinamico con los corchetes
figure(1);
imshow(I);
figure(2);
imshow(I,[]);

% imagesc() considera la imagen como un campo vectorial. Utiliza un mapa de
% colores estandar de MLab.
% imagesc(I);

I2 = uint8(I);  % Convertir la img a este formato (aunque sea doble)
imshow(I2);     % Se ve oscuro
% Convertimos una imagen doble a formato entero
I3 = uint8(round(I*255));
figure(3);
imshow(I3);     % Se ve correctamente

I4 = double(I3);
figure(4);
imshow(I4);
I5 = double(I3)/255;
figure(5);
imshow(I5);

figure(100);
imagesc(I);




