
%Apartado 1: Cargar y desaturar la imagen

img = imread('peppers.png');
imshow(img);
title('Imagen original');
pause
%Asegurar que la imagen esté en formato double en el rango [0, 1]
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

pause

%Apartado 2: Aplicar tono cálido a la imagen desaturada

% Aumentar los canales rojo y verde y reducir el azul
warm_tone_factor_red = 1.2;   % Incremento del 20% en el canal rojo
warm_tone_factor_green = 1.1; % Incremento del 10% en el canal verde
warm_tone_factor_blue = 0.9;  % Reducción del 10% en el canal azul

% Aplicar los factores a cada canal
img_warm = img_desaturated; % Copiar la imagen desaturada
img_warm(:,:,1) = img_warm(:,:,1) * warm_tone_factor_red;   % Canal rojo
img_warm(:,:,2) = img_warm(:,:,2) * warm_tone_factor_green; % Canal verde
img_warm(:,:,3) = img_warm(:,:,3) * warm_tone_factor_blue;  % Canal azul

% Asegurarse de que los valores están en el rango [0, 1]
img_warm = min(img_warm, 1);

% Mostrar la imagen con tono cálido
imshow(img_warm);
title('Imagen con Tono Cálido Aplicado');


pause

%Apartado 3: Añadir ruido a la imagen cálida

% Usaremos ruido gaussiano para simular el efecto de grano en la imagen

% Definir los parámetros del ruido gaussiano
mean_noise = 0;        % Media del ruido
variance_noise = 0.01; % Varianza del ruido para un efecto moderado

% Añadir ruido gaussiano a la imagen cálida
img_noisy = imnoise(img_warm, 'gaussian', mean_noise, variance_noise);

% Mostrar la imagen con ruido añadido
imshow(img_noisy);
title('Imagen con Ruido Gaussiano Añadido');


pause

%Apartado 4: Crear la máscara de destello ajustada según la posición y el radio

% Dimensiones de la imagen
[rows, cols, ~] = size(img_noisy);

% Definir el centro del destello en la esquina superior derecha
cx = round(cols * 0.75); % Ajustar hacia la derecha (75% del ancho)
cy = round(rows * 0.25); % Ajustar hacia arriba (25% de la altura)

% Ajustar el radio del destello
r = min(rows, cols) / 8; % Reducir el radio para un enfoque más pequeño

% Crear la máscara de destello con la fórmula exacta del enunciado
[X, Y] = meshgrid(1:cols, 1:rows);
mask = 0.5 * exp(-(((X - cx).^2 + (Y - cy).^2) / (2 * r^2)));

% Mostrar la máscara generada
imshow(mask, []);
title('Máscara de Destello');


pause

%Apartado 5: Aplicar la máscara de destello a la imagen con tono cálido y ruido

% Aplicar la máscara de destello a cada canal de la imagen
img_with_glare = img_noisy; % Crear una copia de la imagen con ruido
img_with_glare(:,:,1) = img_with_glare(:,:,1) + mask; % Canal rojo
img_with_glare(:,:,2) = img_with_glare(:,:,2) + mask; % Canal verde
img_with_glare(:,:,3) = img_with_glare(:,:,3) + mask; % Canal azul

% Limitar los valores al rango [0, 1]
img_with_glare = min(img_with_glare, 1);

% Mostrar la imagen con el efecto de destello
imshow(img_with_glare);
title('Imagen con Efecto de Destello Aplicado');


pause

%Apartado 6: Aumentar el brillo de la imagen resultante en un 15%

% Factor de aumento de brillo
brightness_factor = 1.15;

% Aumentar el brillo de la imagen con destello aplicado
img_brighter = img_with_glare * brightness_factor;

% Limitar los valores al rango [0, 1]
img_brighter = min(img_brighter, 1);

% Mostrar la imagen con el brillo incrementado
imshow(img_brighter);
title('Imagen con Aumento de Brillo del 15%');


pause

%Apartado 7: Aplicar corrección de gamma a la imagen con un aumento del 10%

% Definir el valor de gamma (aumentar en un 10%)
gamma_value = 1.1;

% Aplicar la corrección de gamma usando imadjust
img_gamma_corrected = imadjust(img_brighter, [], [], gamma_value);

% Mostrar la imagen con la corrección de gamma aplicada
imshow(img_gamma_corrected);
title('Imagen con Corrección de Gamma del 10%');


pause

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
