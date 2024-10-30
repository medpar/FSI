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
