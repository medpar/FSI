% Cargar las imágenes forest.tif y board.tif
%forest = imread('forest.tif');
[forest, map] = imread('forest.tif');
forest = ind2rgb(forest, map);
board = imread('board.tif');

% Crear una figura para mostrar todas las imágenes
figure;

subplot(2, 4, 1);
imshow(forest);
title('Original: forest.tif');

subplot(2, 4, 5);
imshow(board);
title('Original: board.tif');

%% Método 1: Usar im2gray para convertir a blanco y negro
forest_gray_toolbox = rgb2gray(forest);
board_gray_toolbox = rgb2gray(board);

subplot(2, 4, 2);
imshow(forest_gray_toolbox);
title('forest.tif - rgb2gray');

subplot(2, 4, 6);
imshow(board_gray_toolbox);
title('board.tif - rgb2gray');

%% Método 2: Convertir a blanco y negro calculando la media de las tres componentes (RGB)
% Verifica que la imagen sea RGB antes de calcular la media
forest_gray_mean = mean(forest, 3);
board_gray_mean = mean(board, 3);

% Mostrar imagen en blanco y negro de forest usando la media de RGB
subplot(2, 4, 3);
imshow(forest_gray_mean);
title('forest.tif - Media de RGB');

% Mostrar imagen en blanco y negro de board usando la media de RGB
subplot(2, 4, 7);
imshow(uint8(board_gray_mean));
title('board.tif - Media de RGB');

%% Método 3: Convertir a blanco y negro usando la expresión de luminancia
% Coeficientes de luminancia típicos para RGB
R_weight = 0.2989;
G_weight = 0.5870;
B_weight = 0.1140;

forest_gray_luminance = R_weight * double(forest(:, :, 1)) + G_weight * double(forest(:, :, 2)) + B_weight * double(forest(:, :, 3));
board_gray_luminance = R_weight * double(board(:, :, 1)) + G_weight * double(board(:, :, 2)) + B_weight * double(board(:, :, 3));

subplot(2, 4, 4);
imshow(forest_gray_luminance);
title('forest.tif - Luminancia');

subplot(2, 4, 8);
imshow(uint8(board_gray_luminance));
title('board.tif - Luminancia');
