% Lectura y reproducción de un vídeo en formato mpg
% Precarga la estructura de datos.
vidObj = VideoReader('testvideo.mpeg');
s = struct('cdata', zeros(vidObj.Height, vidObj.Width, 3, 'uint8'), 'colormap', []);

numFrames = 0;
nframes = 10;
Duration = vidObj.CurrentTime;

% Cargar los primeros nframes del video
while numFrames < nframes
    numFrames = numFrames + 1;
    s(numFrames).cdata = readFrame(vidObj);
    Duration = vidObj.CurrentTime;
end

m = vidObj.Height;
n = vidObj.Width;

vf = [];

% Repetición 10 veces de la primera imagen en formato de columna
for i = 1:nframes
    vf = [vf, im2col(rgb2gray(s(1).cdata)', [1,1], 'distinct')];
end

% Transponer frame para que el im2col lea por filas
% Obtener la imagen original a partir de las propiedades de vidObj
fimagen = double(rgb2gray(s(1).cdata));  % Convertir la imagen a escala de grises y a tipo double

% Obtener la frecuencia de línea de muestreo (flinea) basada en la resolución de la imagen
flinea = 1 / (m * n);  % Ajusta según la necesidad de la aplicación

% Obtener la frecuencia de muestreo a partir de flinea
fs = flinea * n;  % Frecuencia de muestreo basada en la imagen

Ts = 1 / fs;  % Periodo de muestreo

% Ajustar t para que coincida con la longitud de vf
t = linspace(0, (size(vf, 2) - 1) * Ts, size(vf, 2));

% Realizar la transformada de Fourier
Vf = 1/fs * fftshift(abs(fft(vf)));
f = linspace(-fs/2, fs/2, size(vf, 2));

% Gráfica del contenido de la señal en el tiempo
figure;
plot(t, vf);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal en el tiempo');

% Gráfica del espectro de frecuencia
figure;
plot(f, Vf);
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');
title('Espectro de frecuencia');
axis([-2.5*flinea, 2.5*flinea, 0, max(Vf)]);
