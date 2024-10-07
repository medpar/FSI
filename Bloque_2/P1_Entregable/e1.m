% Generar y representar una imagen binaria de tamaño 256x256
% correspondiente a la máscara con radios de 32 y 128 píxeles

size = 256;
radio_a = 32;
radio_b = 128;

mask = zeros(size);
center = size / 2;

% Recorrer cada píxel de la imagen para verificar si está dentro de la corona circular
for x = 1:size
    for y = 1:size
        dist = sqrt((x - center)^2 + (y - center)^2);
        if dist >= radio_a && dist <= radio_b
            mask(x, y) = 1;
        end
    end
end

% Representar la imagen binaria
imshow(mask);
colormap(gray);
title('Máscara binaria con radios 32 y 128 píxeles');