% Cargar la imagen
I = imread('cameraman.tif');
I = double(I); % Convertir a double para cálculos

% Parámetros iniciales
block_size = 8;
[Filas, Columnas] = size(I);

% Preprocesar la imagen
fun = @(block_struct) block_struct.data - 128;
I_blocks = blockproc(I, [block_size block_size], fun);

% Aplicar DCT por bloques
fun_dct = @(block_struct) dct2(block_struct.data);
I_dct = blockproc(I_blocks, [block_size block_size], fun_dct);

% Calcular PSNR para diferentes porcentajes de coeficientes seleccionados (Modo 1)
percentages = 5:5:100;                        % Porcentajes de coeficientes
PSNR_values_mode1 = zeros(size(percentages)); % Almacenar valores de PSNR
images_reconstructed_mode1 = {};              % Almacenar imágenes reconstruidas

for idx = 1:length(percentages)
    k = round((percentages(idx) / 100) * Filas * Columnas); % Número de coeficientes
    Mascara = zigzag(Filas, Columnas, k); % Generar máscara de coeficientes
    
    % Aplicar la máscara
    I_dct_zigzag = I_dct .* Mascara;
    
    % Reconstrucción con IDCT
    fun_idct = @(block_struct) idct2(block_struct.data);
    I_reconstructed = blockproc(I_dct_zigzag, [block_size block_size], fun_idct);
    images_reconstructed_mode1{idx} = I_reconstructed; % Guardar la imagen reconstruida
    
    % Calcular PSNR
    MSE = mean((I - I_reconstructed).^2, 'all');
    PSNR_values_mode1(idx) = 10 * log10(255^2 / MSE);
end

% Graficar la curva PSNR (Modo 1)
figure;
plot(percentages, PSNR_values_mode1, '-o');
xlabel('Porcentaje de coeficientes seleccionados (%)');
ylabel('PSNR (dB)');
title('Curva PSNR vs Porcentaje de Coeficientes Seleccionados (Modo 1)');
grid on;

% Visualizar imágenes reconstruidas (Modo 1)
figure;
num_to_display = min(5, length(percentages)); % Mostrar hasta 5 ejemplos
for i = 1:num_to_display
    subplot(1, num_to_display, i);
    imshow(uint8(images_reconstructed_mode1{i}));
    title([num2str(percentages(i)) '% Coeficientes']);
end
sgtitle('Reconstrucción de la Imagen (Modo 1)');

% Calcular PSNR para el modo 2 (cuantificación basada en tabla.dat)
% Cargar la tabla de cuantificación
load('tabla.dat'); % Suponiendo que tabla.dat está disponible en el directorio de trabajo

% Cuantificación según el estándar JPEG
fun_quant = @(block_struct) round(block_struct.data ./ tabla);
I_dct_quant = blockproc(I_dct, [block_size block_size], fun_quant);

% Reconstrucción usando la tabla
fun_dequant = @(block_struct) block_struct.data .* tabla;
I_dct_dequant = blockproc(I_dct_quant, [block_size block_size], fun_dequant);

% Reconstrucción con IDCT
I_reconstructed_mode2 = blockproc(I_dct_dequant, [block_size block_size], fun_idct);

% Calcular PSNR para el modo 2
MSE_mode2 = mean((I - I_reconstructed_mode2).^2, 'all');
PSNR_mode2 = 10 * log10(255^2 / MSE_mode2);

% Comparar PSNR del modo 2 con el valor seleccionado en el modo 1
fprintf('PSNR (Modo 2): %.2f dB\n', PSNR_mode2);

% Mostrar el valor de PSNR más alto del modo 1
[max_psnr_mode1, max_idx] = max(PSNR_values_mode1);
fprintf('PSNR más alto (Modo 1): %.2f dB (con %.0f%% de coeficientes seleccionados)\n', ...
    max_psnr_mode1, percentages(max_idx));


% Visualizar imágenes reconstruidas (Modo 2)
figure;
subplot(1, 2, 1);
imshow(uint8(I));
title('Imagen Original');
subplot(1, 2, 2);
imshow(uint8(I_reconstructed_mode2));
title('Reconstrucción (Modo 2)');
sgtitle('Reconstrucción de la Imagen (Modo 2)');
