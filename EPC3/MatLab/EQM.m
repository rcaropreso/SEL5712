function EM = EQM( X, d, W_1, W_2 )
%EQM Calcula o erro quadratico medio
% X  -> entradas do MLP
% d  -> saidas desejadas

sizeW = size(X);
N_entradas = sizeW(1);
N_amostras = sizeW(2);

%Repete o FeedForward para calcular o ERRO
% for k=1:N_amostras
%FeedForward
%1a Camada: Entrada -> Neurons da camada oculta
I_1 = W_1 * X;
Y_1 = logsig( I_1 );

%Ajeita o vetor de saida, adicionando o bias
% sizeY = size(Y_1);
% Y_1 = [ (-1) * ones( 1, sizeY(2) ); Y_1 ]; %adiciona uma linha de -1 à matriz Y_1

%2a Camada: Neurons Camada Oculta -> Neurons de Saida
I_2 = W_2 * Y_1;
% Y_2 = logsig( I_2 );
Y_2 = I_2; %usando função linear na saida

% Calcula o erro para as amostras atuais
E_k = ( (d - Y_2) .^2 ) / 2;
EM  = sum( E_k ) / N_amostras;
% end;

