M = 256;
N = 256;
H = 0.1 * ones(M, N);
S = ones(M, N);
V = repmat(linspace(0, 1, N), N, 1);

Ic = zeros(M, N, 3);
Ic(:, :, 1) = H;
Ic(:, :, 2) = S;
Ic(:, :, 3) = V;
Irgb = hsv2rgb(Ic);
imshow(Irgb);