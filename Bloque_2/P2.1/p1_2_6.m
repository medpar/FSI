%%%%%%%% APARTADO 2.6 %%%%%%%%


M = 256;
N = 256;
k = 6;
Nb = 2^k;

x = linspace(0, 1, N);
xq = fix((Nb*x))/(Nb - 1);
I = repmat(xq, M, 1);

k = 5;
Nmap = 2^k;
mapa = repmat(linspace(0, 1, Nmap)', 1, 3);
mapa2 = colormap(summer(Nmap));
J = gray2ind(I, Nmap);
figure(1);
imshow(J, mapa2);
colormap(mapa2);
