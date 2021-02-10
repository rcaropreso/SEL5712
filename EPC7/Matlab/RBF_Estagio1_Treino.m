function [W_1, var] = RBF_Estagio1_Treino(X, N_Entradas, N_Camada_Oculta)
%RBF_Estagio1 Executa o Primeiro Estagio da RBF
%Calcula os centroides (pesos) e variancias

%Vetor de inicialização do k-means (alocaçao do "chute inicial de cada
%centroide")
start = [];
for i=1:N_Camada_Oculta
    start = [start; X(i,:)];
end;

% start = [ X(1,:); X(3,:) ];
% start 
% pause

%Etapa1: Clusterização por K-Means
[idx, c] = kmeans( X, N_Camada_Oculta, 'Start', start );
% [idx, c] = kmeans( X, N_Camada_Oculta );

for j=1:size(c,1) %'j' -> cada linha corresponde a um centroide
    soma = 0;
    for k=1:length(idx)
        if( idx(k) == j ) %verifica se aquela amostra pertence ao cluster 'j'
            for i=1:N_Entradas
                soma = soma + (X(k, i) - c(j, i))^2;
            end;
        end;
    end;
    sigma(j) = sqrt(soma / length(find(idx==j))); %verifica quantos elementos em idx pertencem ao cluster 'j'
end;

W_1 = c;
var = sigma;
