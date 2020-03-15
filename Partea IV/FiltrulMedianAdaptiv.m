function FiltrulMedianAdaptiv(image,MaxSizeFilter)
%elimina zgomotul schimband marimea filtrului
%image : LENNAGRAY2.PNG
%MaxSizeFilter : dimensiunea maxima a filtrului

%Exemple de rulare: 
%FiltrulMedianAdaptiv('LENNAGRAY3.BMP', 13);

image = imread('LENNAGRAY3.BMP');
[r,c] = size(image);
NImage = imnoise(image,'salt & pepper',1);
row = 3;
col = 3;
MaxSize = 11;
%adauga zero pe restul liniilor si coloanelor
filter = zeros(row,col);

%afisare
subplot(2,2,1); imshow(image); title('Imaginea originala');
subplot(2,2,2); imshow(NImage); title('Imaginea cu zgomot');

MedianFilterImage = zeros(r,c);
for i=1:r-2
    for j=1:c-2
        for k=0:2
            for l=0:2
                Med(k+l+1) = NImage(i+k,j+l);
                MedianFilterImage(i,j) = median(Med);
            end
        end
    end
end 

subplot(2,2,3); imshow(MedianFilterImage); title('Imaginea dupa aplicarea filtrului median adaptiv');
AdaptiveMedianFilterImage = zeros(r,c);

for i=1:r-2
    for j=1:c-2
        for k=0:2 
            for l=0:2
                %nivelul A
                %nivelul de gri la coordonate
                Med(k+l+1) = NImage(i+k,j+l);
                %minimul si maximul nivel de gri
                a1 = median(Med) - min(Med);
                a2 = median(Med) - max(Med);             
                if(a1>0 && a2<0)
                    b1 = NImage(i,j) - min(Med);
                    b2 = NImage(i,j) - max(Med);
                    %nivelul B
                    if(b1>0 && b2<0)
                        AdaptiveMedianFilterImage(i,j) = Nimage(i,j);
                    else
                        AdaptiveMedianFilterImage(i,j) = median(Med);
                    end
                else
                    %creste marimea imaginii
                    rol = rol + 2;
                    col = col + 2;
                    filter = zeros(rol,col);
                    %daca marimea imaginii este mai mica decat maximul
                    %permis
                    if(rol<=MaxSize)
                        %repeta nivelul A
                        b1 = NImage(i,j) - min(Med);
                        b2 = NImage(i,j) - max(Med);
                          %nivelul B
                          if(b1>0 && b2<0)
                             AdaptiveMedianFilterImage(i,j) = Nimage(i,j);
                          else
                             AdaptiveMedianFilterImage(i,j) = median(Med);
                          end
                    end
                end
            end
        end
    end
end 

%afisare
figure(1); 
set(gcf, 'Position', get(0, 'ScreenSize'));
subplot(2), imshow(image), title('Imaginea originala');
subplot(2), imshow(NImage), title('Imaginea cu zgomot');
subplot(4), imshow(AdaptiveMedianFilterImage), title('Imaginea dupa aplicarea filtrului median adaptiv');


%subplot(2,2,4); 
%imshow(AdaptiveMedianFilterImage); 
%title('Adaptive Median Filtered Image');
