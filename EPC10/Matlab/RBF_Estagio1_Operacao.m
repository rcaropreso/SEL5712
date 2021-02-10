function [ Y_1 ] = RBF_Estagio1_Operacao( X, W_1, sigma )
%RBF_Estagio1_Operacao Executa o primeiro estagio da RBF
%N_Amostras      -> quantidade de amostras de entradas
%N_Camada_OCulta -> quantidade de funcoes da camada intermediaria
%X               -> vetor de entradas
%W_1             -> matriz de pesos (sinapses - cada linha = 1 neuron, cada
%coluna = 1 sinapse), basicamente as coordenadas do centroide de cada
%funcao radial
%sigma           -> vetor de variancias (cada linha = 1 neuron)

N_Amostras = size(X, 1); %qdte de linhas  = amostras
N_Entradas = size(X, 2); %qdte de colunas = entradas da rede
N_Camada_Oculta = size(W_1, 1); %qdte de linhas  = neurons

for k=1:N_Amostras
    for j=1:N_Camada_Oculta
        soma = 0;
        for i=1:N_Entradas
            soma = soma + ( X( k, i ) - W_1( j, i ) )^2;            
            Y_1(k, j) = exp(-soma/(2*sigma(j)^2));
        end;
    end;
end;
