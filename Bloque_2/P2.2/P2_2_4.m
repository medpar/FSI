% 1. Cálculo de la media local mediante una convolución con una máscara 5x5
I = imread('cameraman.tif'); % Carga tu imagen en escala de grises
%I = im2double(I);
h = ones([5, 5]) / 25;
If = filter2(h, I);

% 2. Degradar la imagen con ruido "salt & pepper" y aplicar el filtro
I_noise_sp = imnoise(I, 'salt & pepper', 0.05);
If_filtered_sp = filter2(h, I_noise_sp);

% 3. Filtrado con máscara gaussiana
If_gauss = imgaussfilt(I_noise_sp, 2);

% 4. Aplicación de un filtro de mediana
If_med = medfilt2(I_noise_sp, [5 5]);

figure;
subplot(2,3,1), imshow(I), title('Imagen Original');
subplot(2,3,2), imshow(I_noise_sp), title('Imagen con Ruido S&P');
subplot(2,3,3), imshow(If_filtered_sp, []), title('Filtro Promedio');
subplot(2,3,4), imshow(If_gauss), title('Filtro Gaussiano');
subplot(2,3,5), imshow(If_med), title('Filtro de Mediana');

% 5. Repetir pasos anteriores para ruido gaussiano
I_noise_gauss = imnoise(I, 'gaussian', 0, 0.05);
If_filtered_gauss = filter2(h, I_noise_gauss);
If_gauss2 = imgaussfilt(I_noise_gauss, 2);
If_med2 = medfilt2(I_noise_gauss, [5 5]);

% 6. Realce de bordes usando imsharpen
I_sharpened = imsharpen(I, 'Amount', 1.2, 'Radius', 1.5);

% 7. Filtro paso alto de tamaño 7x7 y comparación
h_highpass = fspecial('laplacian', 0.2);
I_highpass = imfilter(I, h_highpass);
I_combined = I + I_highpass;

figure;
subplot(1,3,1), imshow(I_sharpened), title('Realzada con imsharpen');
subplot(1,3,2), imshow(I_highpass), title('Filtro Paso Alto');
subplot(1,3,3), imshow(I_combined, []), title('Original + Paso Alto');
