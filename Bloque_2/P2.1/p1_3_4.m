N = 256;
M = 256;

h = 0.1*ones(N,1);
s=ones(N,1);
v=(linspace(0,1,N))';

map = hsv2rgb([h s v]);
imagen = repmat(1:N, M, 1);

figure;
imshow(imagen,map);