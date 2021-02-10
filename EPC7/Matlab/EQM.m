function EM = EQM( X, d, W_2 )
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
I_2 = W_2 * X;
Y_2 = I_2;

% Calcula o erro para as amostras atuais
E_k = ( (d - Y_2) .^2 );
E_k = sum( E_k, 1 ) / 2; %soma os elementos de cada coluna entre si

EM  = sum( E_k ) / N_amostras;

