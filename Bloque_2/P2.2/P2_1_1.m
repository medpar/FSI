% Parte 1: Obtener información del video
info = mmfileinfo('testVideo.mpeg');
disp(info);

% Parte 2: Crear un objeto VideoReader y mostrar propiedades
v = VideoReader('testVideo.mpeg');
numBitsPerPixel = v.BitsPerPixel;
duration = v.Duration;
frameRate = v.FrameRate;
numFrames = v.NumFrames;

% Mostrar las propiedades
fprintf('Número de bits por píxel: %d\n', numBitsPerPixel);
fprintf('Duración del video: %.2f segundos\n', duration);
fprintf('Frame rate: %.2f fps\n', frameRate);
fprintf('Número de frames: %d\n', numFrames);
disp(v);

% Parte 3: Crear una estructura para almacenar frames y visualizar el video
s = struct('cdata', zeros(v.Height, v.Width, 3, 'uint8'), 'colormap', []);
numFrames = 0;
while hasFrame(v)
    numFrames = numFrames + 1;
    s(numFrames).cdata = readFrame(v);
end

% Visualizar el video
%implay(s, v.FrameRate);

% Mostrar la duración y el número de frames
fprintf('Duración del video: %.2f segundos\n', v.Duration);
fprintf('Número de frames: %d\n', numFrames);

% Parte 4: Modificaciones adicionales

% a) Visualizar la secuencia de video a cámara lenta y rápida
implay(s, v.FrameRate * 0.5);
implay(s, v.FrameRate * 2);

% b) Visualizar la secuencia en sentido inverso
sReversed = flip(s);
implay(sReversed, v.FrameRate);

% c) Visualizar la secuencia con los frames rotados 90 grados
for i = 1:numFrames
    s(i).cdata = imrotate(s(i).cdata, 90);
end
implay(s, v.FrameRate);

