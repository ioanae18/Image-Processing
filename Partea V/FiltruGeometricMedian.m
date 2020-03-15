function [ ] = FiltruGeometricMedian(imagine, procent)
%imagine : 'LENNAGRAY3.BMP'
%procent : dimensiunea maxima a filtrului

%Exemple de rulare: 
%FiltruGeometricMedian('LENNAGRAY3.BMP', 12);

I = imread('LENNAGRAY3.BMP');

%afisarea imaginii originale
figure(1);
subplot(2,2,1);
imshow(I);
title('Imaginea originala');

%calcularea dimensiunii imaginii
[rows, columns] = size(I);

%generarea zgomotului Gaussian pentru dimensiunile date
mu = 0;
sigma = sqrt(0.01);
Gauss_noise = mu + sigma*randn(rows,columns);

%adaugarea zgomotului imaginii
image = im2double(I);
noisy = zeros(size(image));
for i =1:rows
   for j=1:columns
     noisy(i,j)= image(i,j)+ Gauss_noise(i,j);
   end
end

%afisarea imaginii cu zgomot
subplot(2,2,2);
imshow(noisy,[]);
title('Imaginea corupta de zgomotul Gaussian');

%pregatirea pentru filtrarea dimensiunii vecinilor m x n (presupunem ca m, n sunt impare)
m =3;
n =3;

%umplerea imaginii cu dimensiunea corespunzatoare
padded_image = zeros((m-1)+size(noisy,1), (n-1)+size(noisy,2));
padded_image((m-1)/2+1:(m-1)/2+size(noisy,1),(n-1)/2+1:(n-1)/2+size(noisy,2)) = noisy;

%filtrarea utilizand filtrul geometric median
filtered_image = zeros(size(noisy));
for i = (m-1)/2 + 1:(m-1)/2 + size(noisy,1)
    for j= (n-1)/2+1:(n-1)/2+size(noisy,2)
       %extragerea vecinilor m x n
       S_xy = padded_image(i-(m-1)/2:i+(m-1)/2,j-(m-1)/2:j+(m-1)/2);
       %operatii specifice asupra vecinilor (calcularea medianei geometrice a
       %valorilor pixelilor in S_xy)
       filtered_image(i,j) = (prod(S_xy(:)))^(1/(m*n));
    end
end

%afisarea imaginii filtrate
subplot(2,2,4);
imshow(filtered_image,[]);
title('Imaginea filtrata cu filtrul geometric median');