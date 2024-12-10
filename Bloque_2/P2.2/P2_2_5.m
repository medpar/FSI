% Cargar la imagen y mostrar el histograma original
I = imread('pout.tif');
figure;
subplot(2,2,1), imshow(I), title('Imagen Original');
subplot(2,2,2), imhist(I, 64), title('Histograma Original'); 

% 2. Ecualización de histograma
I_eq = histeq(I);
subplot(2,2,3), imshow(I_eq), title('Imagen Ecualizada');
subplot(2,2,4), imhist(I_eq, 64), title('Histograma Ecualizado');

% 3. Obtener y mostrar la curva de transformación de la ecualización
[counts, binLocations] = imhist(I, 256);% Función de distribución acumulativa
figure;
plot(binLocations, cdf), title('Curva de Transformación de Ecualización');
xlabel('Intensidad de Gris');
ylabel('Distribución Acumulativa Normalizada');

% 4. Ecualización manual sin usar histeq
[counts, ~] = imhist(I, 256); % Histograma con 256 bins
pdf = counts / numel(I); % Densidad de probabilidad
cdf_manual = cumsum(pdf); % Función de distribución acumulativa manual
I_eq_manual = uint8(cdf_manual(double(I) + 1) * 255); % Aplicar mapeo de niveles de gris

% Mostrar la imagen ecualizada manualmente y su histograma
figure;
subplot(1,2,1), imshow(I_eq_manual), title('Imagen Ecualizada Manualmente');
subplot(1,2,2), imhist(I_eq_manual, 64), title('Histograma Ecualizado Manualmente');

% 5. Comparación de curvas de transformación
figure;
plot(binLocations, cdf, 'b-', 'DisplayName', 'Transformación histeq'); hold on;
plot(binLocations, cdf_manual, 'r--', 'DisplayName', 'Transformación Manual');
legend;
title('Comparación de Curvas de Transformación');
xlabel('Intensidad de Gris');
ylabel('Distribución Acumulativa Normalizada');
hold off;
