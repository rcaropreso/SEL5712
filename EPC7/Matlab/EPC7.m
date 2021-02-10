clear;
clc;

%Carrega os dados
Carrega_Tabela_Treino;

%Monta vetores de amostras
eta = 0.01; %coeficiente de treinamento
epson = 1e-07; % margem do erro

N_Entradas = 2; %entradas do RBF
n_camadas = 2;
size_Camadas = [8 1];
N_Saidas = size_Camadas(2);
N_Camada_Oculta = size_Camadas(1);
N_Amostras = length(DB_X1);

%PRIMEIRO ESTAGIO DE TREINAMENTO - INICIO
X = [DB_X1 DB_X2];
[W_1 sigma] = RBF_Estagio1_Treino(X, N_Entradas, N_Camada_Oculta);

disp 'Centroides'
W_1

disp 'Variancias'
sigma'

Plota_Cluster( DB_X1, DB_X2, DB_D, W_1, sigma );

% [cc, ss] = Caminhos(X, N_Camada_Oculta);
% 
% disp 'Centroides'
% cc
% disp 'Variancias'
% ss
% 
% W_1 = cc;
% sigma = ss;

pause
%PRIMEIRO ESTAGIO DE TREINAMENTO - FIM

%SAIDAS DA CAMADA NEURAL INTERMEDIARIA - INICIO
[ Y_1 ] = RBF_Estagio1_Operacao( X, W_1, sigma );
%SAIDAS DA CAMADA NEURAL INTERMEDIARIA - FIM

%SEGUNDO ESTAGIO DE TREINAMENTO - INICIO
%monta matriz de entradas
x = [];
x = [ (-1)*ones(N_Amostras, 1) Y_1 ]';

d =  [DB_D]';
max_epocas = 20000;

d 
pause

%Treinamento
tic
[W_2, eqm, epoca ] = RBF_Estagio2_Treino( eta, epson, x, d, max_epocas, 1, N_Saidas );
t = toc
%SEGUNDO ESTAGIO DE TREINAMENTO - FIM

disp 'Pesos da Rede Treinada'
W_2
pause

%Grafico do EQM
plot( 1: length(eqm), eqm );
grid;
title( 'Erro Quadratico Medio - RBF');
xlabel( 'Epoca' );
ylabel( 'EQM' );

pause

%OPERACAO - BEGIN
%Carrega os dados
Carrega_Tabela_Operacao;

N_Amostras = length(DB_X1);

%Estagio 1
X = [DB_X1 DB_X2];
[ Y_1 ] = RBF_Estagio1_Operacao( X, W_1, sigma );

%Estagio 2
%monta matriz de entradas
x = [];
x = [ (-1)*ones(N_Amostras, 1) Y_1 ];

d =  [DB_D]';

y  = []; %saida real
yp = []; %saida pós processada

%Executa Rede
total_acertos = 0;
for k=1: N_Amostras
    
    y(:, k) = RBF_Estagio2_Operacao( W_2, x(k, :)' ); 

    %Pos processamento
    acertos_por_saida = 0;
    for i=1: N_Saidas
        if( y(i, k) >= 0 )
            yp(i, k) = 1;
        else
            yp(i, k) = -1;
        end;
        
        %Compara as saidas, computando acertos a cada neuronio
        if( yp(i,k) == d(i,k) )
            acertos_por_saida = acertos_por_saida + 1;
        end;           
    end;
    
    %Se todas as saidas sao iguais às desejadas, temos um acerto geral
    if( acertos_por_saida == N_Saidas )
        total_acertos = total_acertos + 1;
    end;    
end;

total_acertos
N_Amostras
pause

disp 'Saidas Reais do RBF';
y'

%Pos processamento
disp 'Saidas Pós-Processadas do RBF';
yp'

disp 'Saidas Desejadas';
d'

%Verifica taxa de acerto
disp 'Taxa de acerto';
(total_acertos / N_Amostras) * 100
