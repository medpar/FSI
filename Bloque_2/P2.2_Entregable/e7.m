%Apartado 7: Aplicar corrección de gamma a la imagen con un aumento del 10%

% Definir el valor de gamma (aumentar en un 10%)
gamma_value = 1.1;

% Aplicar la corrección de gamma usando imadjust
img_gamma_corrected = imadjust(img_brighter, [], [], gamma_value);

% Mostrar la imagen con la corrección de gamma aplicada
imshow(img_gamma_corrected);
title('Imagen con Corrección de Gamma del 10%');
