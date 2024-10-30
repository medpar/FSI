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
