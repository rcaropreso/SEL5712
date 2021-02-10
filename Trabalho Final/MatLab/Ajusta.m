function matriz = Ajusta (matrizNormal)

numColunas = size(matrizNormal);
numColunas = numColunas(1,2);

for i=1:numColunas
    correcao(1,i) = -1;  
end

matriz=[correcao;matrizNormal];
    
    



