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
