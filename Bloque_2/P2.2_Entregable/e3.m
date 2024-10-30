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
