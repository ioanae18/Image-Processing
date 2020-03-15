function [] = unsharp_masking(numeFisier, marimeFiltru)
%preluarea unei imagini dintr-un fisier si aplicarea procesului de unsharp masking
%numeFisier - numele fisierului imagine
%marimeFiltru - marimea filtrului

%Exemple de rulare: 
%unsharp_masking('LENNA.BMP',1);

  imagineInitiala=imread(numeFisier);
  [~,~,p1]=size(imagineInitiala);
  
  %daca imaginea nu este monocroma (nu neaparat necesar)
  %if(p1>1) 
  %  imagineInitiala = rgb2gray(imagineInitiala); 
  %end
    figure
      imshow(imagineInitiala); 
      title('Imaginea initiala');
    rezultat = Imsharp_Function(imagineInitiala, marimeFiltru);
    figure
      imshow(rezultat)
      title('Imagine unsharp_masking');
      imwrite(rezultat, 'LENNA-UNSHARPMASK.BMP');
end

function rezultat = Imsharp_Function(imagineInitiala,marimeFiltru)

%duplicarea imaginii
imagineInitiala = double(imagineInitiala); 

%aplicare fitru laplacian si rezulta o imagine blurata
%fspecial('laplacian', alpha) retuneaza o matrice de (3,3) cu valori cuprinse intre 0 si 1
h=fspecial('laplacian', marimeFiltru/100);
%imfilter filtreaza h rezultand o matrice cu aceeasi dimensiune
laplacianMatrix=imfilter(imagineInitiala, h); 

figure
    imshow(laplacianMatrix)
    title('Imagine dupa aplicarea filtrului laplacian');
    imwrite(laplacianMatrix, 'LENNA-LAPLACIAN.BMP');
    
rezultat = imagineInitiala - marimeFiltru*laplacianMatrix;
%returneaza  numarul de perechi key-valoare din matricea rezultat
for counter=1,size(rezultat,1)
    %parcurgerea matricii
    if(rezultat(counter, :) > 255) 
        %populeaza prima linie din matrice cu valoarea 255 sau 0 dupa caz
        rezultat(counter,:) = 255; 
    elseif rezultat(counter, :) < 0
            rezultat(counter,:) = 0;
    end
end
%se converteste rezultatul la formatul uint8 prin revenire la matricea de 1 intreg pe un octet
rezultat = uint8(rezultat);
return; 
end