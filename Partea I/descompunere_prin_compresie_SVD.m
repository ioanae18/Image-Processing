function [] = descompunere_prin_compresie_SVD(numeFisier, procentaj)
%Descompunerea SVD a unei imagini
%numeFisier - numele fisierului imagine
%procentaj- procentul utilizat pentru a permite modificarea  pozei

%Exemple de rulare: 
 %descompunere_prin_compresie_SVD('LENNA.BMP', 10);

 pozaInitiala=imread(numeFisier);
  [~,~,p]=size(pozaInitiala);
  %daca imaginea nu este monocroma
   if(p>1) 
    pozaInitiala = rgb2gray(pozaInitiala);
   end
   figure
      imshow(pozaInitiala);
      title('Imagine convertita in gri');
      
   %convertim pozaInitiala  din unit8 in double
   pozaInitiala = double(pozaInitiala); 
   % prin utilizarea functiei svd realizam un proces de descompunere a pozaInitiala in 3 matrici ortogonale
   % S - este matricea diagonala, unde pe diagonala sunt reprezentate valorile singulare 
   [U,S,V]=svd(pozaInitiala);
  

   %calcularea numarului de valori singulare prin extragerea diagonalei sub forma de vector si
   %calcularea numarului de elemente
   valoriSingulare = numel(diag(S));
   nrValSingularePastrate = round(((valoriSingulare*procentaj)/100), 0);

   %copiem noua matrice
   S2=S;
   %completam cu 0 restul matricei
   S2(nrValSingularePastrate:end, :)=0;
   S2(:, nrValSingularePastrate:end)=0;
   
   imagineRezultat = U*S2*V';
  
   %convertim imaginea din double la unit8
   imagineRezultat = uint8(imagineRezultat);
   figure
   %afisare imagine finala
      imshow(imagineRezultat); 
      title('Imagine rezultat');
      imwrite(imagineRezultat, 'LENNA-DESCOMPUNERE-SVD.BMP');
end
   
   
      
      