I = imread('cameraman.tif');

% Submuestreo sin promedio (simple selección de píxeles)
subsamp_rates = [2, 4, 8]; % Tasas de submuestreo
figure;
for i = 1:length(subsamp_rates)
    subsampx = subsamp_rates(i);
    subsampy = subsamp_rates(i);
    I_sub = I(1:subsampy:end, 1:subsampx:end); % Submuestreo simple
    subplot(1, length(subsamp_rates), i);
    imshow(I_sub);
    title(['Submuestreo: ', num2str(subsamp_rates(i)), 'x']);
end

% Submuestreo con promedio
figure;
for i = 1:length(subsamp_rates)
    subsampx = subsamp_rates(i);
    subsampy = subsamp_rates(i);
    I_sub_avg = blockproc(double(I)/255, [subsampy, subsampx], ...
                          @(blockstruct) mean(blockstruct.data(:)));
    subplot(1, length(subsamp_rates), i);
    imshow(I_sub_avg);
    title(['Submuestreo promedio: ', num2str(subsamp_rates(i)), 'x']);
end

%%%%%%%%%%%%%

I_dob = double(I) / 255; % Normalización
bit_depths = [1, 2, 4, 8]; % Niveles de bits para cuantificación
figure;
for i = 1:length(bit_depths)
    N_cuant = 2^bit_depths(i);
    I_cuant = fix(N_cuant * I_dob) / (N_cuant); % Cuantificación
    subplot(1, length(bit_depths), i);
    imshow(I_cuant);
    title(['Cuantificación: ', num2str(bit_depths(i)), ' bits']);
end

%%%%%%%%%%%

I_color = imread('peppers.png');
I_yuv = rgb2ycbcr(I_color);

% Submuestreo en canales de crominancia
I_yuv_sub = I_yuv;
I_yuv_sub(:,:,2) = imresize(I_yuv(:,:,2), 0.5); % Cb submuestreado
I_yuv_sub(:,:,3) = imresize(I_yuv(:,:,3), 0.5); % Cr submuestreado

% Escalar de nuevo al tamaño original para visualizar
I_yuv_sub(:,:,2) = imresize(I_yuv_sub(:,:,2), [size(I_yuv, 1), size(I_yuv, 2)]);
I_yuv_sub(:,:,3) = imresize(I_yuv_sub(:,:,3), [size(I_yuv, 1), size(I_yuv, 2)]);

% Convertir de vuelta a RGB
I_rgb_sub = ycbcr2rgb(I_yuv_sub);
imshow(I_rgb_sub);
title('Submuestreo en crominancia (Cb y Cr)');

