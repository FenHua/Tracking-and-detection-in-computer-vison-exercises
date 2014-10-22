
deviation = 1;
size = 3*deviation;
one_side = floor(size/2);
interval = -one_side:one_side;

[X, Y] = meshgrid(interval, interval);

kernel = (1\(2*pi*deviation^2))*exp(-0.5*(X.^2 + Y.^2)/(deviation^2));
kernel = kernel /(sum(kernel(:)));