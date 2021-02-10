clear;
clc;

%Carrega os dados
Carrega_Tabela_Treino;

%Monta vetores de amostras
N_entradas = 4; %entradas do MLP
eta = 0.1; %coeficiente de treinamento
alfa = 0.7; %taxa de momentum
epson = 1e-05; % margem do erro
n_camadas = 2;
size_Camadas = [15 3];
N_Saidas = size_Camadas(2);

DB_X1_Norm = DB_X1;
DB_X2_Norm = DB_X2;
DB_X3_Norm = DB_X3;
DB_X4_Norm = DB_X4;

N_Amostras = length(DB_X1_Norm);

x = [];
%monta matriz de entradas
for k=1: length(DB_X1_Norm)
    x(:, k) = [ -1 DB_X1_Norm(k) DB_X2_Norm(k) DB_X3_Norm(k) DB_X4_Norm(k)]';
end;

d =  [DB_D1 DB_D2 DB_D3]';
max_epocas = 10000;

%TREINAMENTO
tic
[W_1, W_2, eqm, epoca] = MLP_Treino( eta, epson, x, d, max_epocas, n_camadas, size_Camadas  );
t = toc

%Grafico do EQM
plot( 1: length(eqm), eqm );
grid;
title( 'Erro Quadratico Medio - MLP');
xlabel( 'Epoca' );
ylabel( 'EQM' );

%OPERACAO
%Carrega os dados
Carrega_Tabela_Operacao;

%Monta vetores de amostras
DB_X1_Norm = DB_X1;
DB_X2_Norm = DB_X2;
DB_X3_Norm = DB_X3;
DB_X4_Norm = DB_X4;

DB_D1_Norm = DB_D1;
DB_D2_Norm = DB_D2;
DB_D3_Norm = DB_D3;

d =  [DB_D1 DB_D2 DB_D3]';

N_Amostras = length( DB_X1_Norm );

x  = [];
y  = []; %saida real
yp = []; %saida pós processada
%monta matriz de entradas
total_acertos = 0;
for k=1: N_Amostras
    y(:, k) = MLP_Executa( W_1, W_2, [-1 DB_X1_Norm(k) DB_X2_Norm(k) DB_X3_Norm(k) DB_X4_Norm(k)]' );

    %Pos processamento
    acertos_por_saida = 0;
    for i=1: N_Saidas
        if( y(i, k) >= 0.5 )
            yp(i, k) = 1;
        else
            yp(i, k) = 0;
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

disp 'Saidas Reais do MLP';
y'

%Pos processamento
disp 'Saidas Pós-Processadas do MLP';
yp'

disp 'Saidas Desejadas';
d'

%Verifica taxa de acerto
disp 'Taxa de acerto';
(total_acertos / N_Amostras) * 100
