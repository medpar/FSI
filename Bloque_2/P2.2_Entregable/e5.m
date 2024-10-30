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
