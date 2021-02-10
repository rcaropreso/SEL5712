close all; clear all; clc;

%Dados do TDNN
OpFile = 'Dados_Operacao_R1.dat';
p     = 5; %entradas da TDNN
eta   = 0.1; %coeficiente de treinamento
alfa  = 0.8 %coeficiente de momentum
epson = 0.5e-06; % margem do erro

n_camadas = 2;
size_Camadas = [10 1];
max_epocas = 10000;

%Carrega os dados
Carrega_Tabela_Treino;

%Pre-Processamento: normalização
maximo = 1%max(DB_X);
minimo = 0%min(DB_X);
% DB_X_Norm = Normaliza( minimo, maximo, DB_X );
DB_X_Norm = DB_X;

%Pre-Processamento: janelamento
dados = janelamento( p, DB_X_Norm );

dados
pause


%Vetor de saida
d = dados(:, p+1);

sizeD = size(dados);
linhas = sizeD(1);

x = [ (-1) * ones( linhas, 1 ) dados ]; %adiciona uma coluna de -1 à matriz de dados
x( :, p+2 ) = []; %remove ultima coluna (dados de saida), o p+2 é porque já inserimos o -1 na linha de cima

x = x';
d = d';

%TREINAMENTO
epoca = 1;
while( epoca < 10 )
    tic
    [W_1, W_2, eqm, epoca] = TDNN_Treino( alfa, eta, epson, x, d, max_epocas, n_camadas, size_Camadas  );
    toc
end;

%Grafico do EQM
plot( 1: length(eqm), eqm );
grid;
title( 'Erro Quadratico Medio - TDNN');
xlabel( 'Epoca' );
ylabel( 'EQM' );

disp 'PAROU'
pause

%OPERACAO
%Carrega os dados
DB_X = Carrega_Tabela_Operacao(OpFile);

%Pre-Processamento: normalização
% DB_X_Norm = Normaliza( 0, 1, DB_X );
DB_X_Norm = DB_X;

%Pre-Processamento: janelamento
dados = janelamento( p, DB_X_Norm );

%Vetor de saida
d = dados(:, p+1);

sizeD = size(dados);
linhas = sizeD(1);

x = [ (-1) * ones( linhas, 1 ) dados ]; %adiciona uma coluna de -1 à matriz de dados
x( :, p+2 ) = []; %remove ultima coluna (dados de saida), o p+2 é porque já inserimos o -1 na linha de cima

x = x';
d = d';

N_Amostras = linhas;

y  = []; %saida real
E = 0;
for k=1: N_Amostras
    y(:, k) = TDNN_Executa( W_1, W_2, x(:,k) );

    %Erro
    E = E + (d(k) - y(k));
end;

E = E / N_Amostras;

%Variancia
variancia = var(d,y)*100;

disp 'EQM'
eqm( length(eqm))

disp 'Erro Relativo Medio';
E
disp 'Variancia'
variancia
pause

figure;
x = [1:N_Amostras];
%Grafico da comparação de saidas
% plot( x,d,x,y );
plot(d, 'ro-');
hold on;
plot(y, 'b+-');
% grid;
title( 'Saida TDNN x Saida Real');
xlabel( 'Amostras' );
ylabel( 'Saidas' );
legend('Teorico', 'Real', 'Location', 'NorthEast');

disp 'Saidas Fornecidas pela Rede:'
y'

