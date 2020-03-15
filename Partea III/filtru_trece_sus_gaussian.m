function [ ] = filtru_trece_sus_gaussian(denumireFisier, procent)
%Aplicarea filtrului Gaussian trece-sus (high-pass)

%denumireFisier - numele fisierului imagine
%procent - procentul de aplicare

%Exemple de rulare: 
%filtru_trece_sus_gaussian('LENNA.BMP',10);

    imgInit=imread(denumireFisier);
    figure
        imshow(imgInit);
        title('Imagine initiala');
    [m, n, pp]=size(imgInit);
    
    %Transformarea Fourier
    fourier=fft2(imgInit);
    
    %Reasezarea componentelor de frecventa 0 in centru si mutarea frecventelor nule catre mijlocul spectrumului
    fourierShift=fftshift(fourier);
    
    % Algoritmul cu functiile pentru filtare
    p=m/2;
    q=n/2;
    for i=1:m
        for j=1:n
            %distanta dintre punctele m si n raportate la centrul de simetrie
            distanta = sqrt((i-p)^2+(j-q)^2);
            highPass(i,j)=1-exp(-(distanta)^2/(2*(procent^2)));
        end
    end
    
    resultedFilter=zeros(m,n,pp);
    for p1=1:pp
    resultedFilter(:,:, p1) = fourierShift(:,:, p1).*highPass;
    end

    %Inversul procesului de rearanjare prin inverseaza dimensiunile 
    resultInvers=ifftshift(resultedFilter); 
    
    %Inversul procesului de transformare Fourier
    result=abs(ifft2(resultInvers));
    
    resultFinal = uint8(result);
    figure
        imshow(resultFinal)
        title('Imagine finala');
        imwrite(result,'LENNA-filtru-jos-gs.BMP');
end