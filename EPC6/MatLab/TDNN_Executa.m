function y = TDNN_Executa( W_1, W_2, X )
%TDNN_Executa Operacao de TDNN
%   entradas    -> vetor com uma entrada
%   pesos       -> matriz de pesos do treinamento

sizeW1 = size(W_1);
sizeW2 = size(W_2);

size_Camadas = [ sizeW1(1) sizeW2(1)];

I_1 = W_1 * X;
Y_1 = logsig( I_1 );

%Ajeita o vetor de saida, adicionando o bias
sizeY = size(Y_1);
Y_1 = [ (-1) * ones( 1, sizeY(2) ); Y_1 ]; %adiciona uma linha de -1 à matriz Y_1

%2a Camada: Neurons Camada Oculta -> Neurons de Saida
I_2 = W_2 * Y_1;
Y_2 = logsig( I_2 );
% Y_2 = I_2; %usando função linear na saida

y = Y_2;