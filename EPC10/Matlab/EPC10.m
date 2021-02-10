clear;
clc;

id_treino = input('Identificador do Treinamento(1-3): ');
id_rede   = input('Identificador da Rede(1-3): ');

N1 = 5; %default

if( id_rede == 1 )
    N1 = 5;
end;

if( id_rede == 2 )
    N1 = 10;
end;

if( id_rede == 3 )
    N1 = 15;
end;

%Carrega os dados
Carrega_Tabela_Treino;

%Monta vetores de amostras
eta = 0.01; %coeficiente de treinamento
epson = 1e-07; % margem do erro

N_Entradas = 3; %entradas do RBF
n_camadas = 2;
size_Camadas = [N1 1];
N_Saidas = size_Camadas(2);
N_Camada_Oculta = size_Camadas(1);
N_Amostras = length(DB_X1);

%PRIMEIRO ESTAGIO DE TREINAMENTO - INICIO
X = [DB_X1 DB_X2 DB_X3];
[W_1 sigma] = RBF_Estagio1_Treino(X, N_Entradas, N_Camada_Oculta);

disp 'Centroides'
W_1

disp 'Variancias'
sigma'

% Plota_Cluster( DB_X1, DB_X2, DB_X3, DB_D, W_1, sigma );

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

disp(sprintf('Epocas: %d, EQM: %f', epoca, eqm(length(eqm))));

pause

%OPERACAO - BEGIN
%Carrega os dados
Carrega_Tabela_Operacao;

N_Amostras = length(DB_X1);

%Estagio 1
X = [DB_X1 DB_X2 DB_X3];
[ Y_1 ] = RBF_Estagio1_Operacao( X, W_1, sigma );

Y_1
disp 'Pronto'

%Estagio 2
%monta matriz de entradas
x = [];
x = [ (-1)*ones(N_Amostras, 1) Y_1 ];

d =  [DB_D]';

y  = []; %saida real
yp = []; %saida pós processada
erro = []; %matriz de erro (d-y)

%Executa Rede
total_acertos = 0;
for k=1: N_Amostras

    y(:, k) = RBF_Estagio2_Operacao( W_2, x(k, :)' );

    e(k) = y(:, k) - d(:, k);
end;


disp 'Saidas Reais do RBF';
y'

%Pos processamento
disp 'Saidas desejadas do RBF';
d'

disp 'Erro';
e'

disp 'Media e Variancia'
mean(e)
var(e)

%Salva dados
saveas( gcf, sprintf('Rede_%d_T_%d.jpg', id_rede, id_treino) );

filename = sprintf('Dados_Rede_%d_T_%d.txt', id_rede, id_treino);

fid = fopen(filename,'wt');
fprintf( fid,'EQM: %f  Epocas: %d\n' , eqm(length(eqm)), epoca );
fprintf( fid,'Saidas da Rede:\n' );
fprintf( fid,'%f\n' , y' );
fprintf( fid,'Media: %f  Variancia: %f\n' , mean(e), var(e) );
fprintf( fid,'Media: %f %%  Variancia: %f %%\n' , mean(e)*100, var(e)*100 );
fclose(fid);



