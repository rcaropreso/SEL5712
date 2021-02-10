close all; clear all; clc;

% plot(x,y);
% grid;


% %TESTE
% DB_X1 = 0.3;
% DB_X2 = 0.7;
% 
% N_entradas = 2; %entradas do MLP
% eta = 0.0025; %coeficiente de treinamento
% epson = 1e-06; % margem do erro
% n_camadas = 3;
% size_Camadas = [3 3 2];
% 
% d = [1; 0.5];
% 
% x = [];
% %monta matriz de entradas
% for k=1: length(DB_X1)
%     x(:, k) = [ -1 DB_X1(k) DB_X2(k) ]';
% end;
% 
% max_epocas = 2;
% 
% [W_1, W_2, eqm] = MLP_Treino( eta, epson, x, d, max_epocas, n_camadas, size_Camadas  );
% 
% return;
% 
% % TESTE

%Carrega os dados
Carrega_Tabela_Treino;

%Monta vetores de amostras
N_entradas = 3; %entradas do MLP
eta = 0.1; %coeficiente de treinamento
epson = 1e-06; % margem do erro
n_camadas = 2;
size_Camadas = [10 1];

DB_X1_Norm = DB_X1;
DB_X2_Norm = DB_X2;
DB_X3_Norm = DB_X3;

x = [];
%monta matriz de entradas
for k=1: length(DB_X1_Norm)
    x(:, k) = [ -1 DB_X1_Norm(k) DB_X2_Norm(k) DB_X3_Norm(k) ]';
end;

d =  [DB_D]';
max_epocas = 2000;

[W_1, W_2, eqm] = MLP_Treino( eta, epson, x, d, max_epocas, n_camadas, size_Camadas  );

disp('Pesos do MLP treinado');
W_1
W_2
% pause
% erro
disp('Pressione uma tecla para continuar...');
pause

plot( 1: length(eqm), eqm );
grid;
title( 'Erro Quadratico Medio - MLP');
xlabel( 'Epoca' );
ylabel( 'EQM' );

%TESTE - Roda o conjunto de treinamento para avaliar a precisao da rede
% x = [];
% %monta matriz de entradas
% for k=1: length(DB_X1_Norm)
%     y(k) = Adaline_Executa(pesos, [-1 DB_X1_Norm(k) DB_X2_Norm(k) DB_X3_Norm(k) DB_X4_Norm(k)]' );
%     if(y(k) == d(k))
%         disp( sprintf('ACERTO \n') );
%     else
%         disp( sprintf( 'ERRO \n' ));
%     end;
% end;
% 
% acerto = sum((y' == d)) / length(d);
% disp( sprintf('Acerto: %3.4f %%', acerto*100));
% pause
%FIM - TESTE


%OPERACAO
%Carrega os dados
Carrega_Tabela_Operacao;

%Monta vetores de amostras
DB_X1_Norm    = DB_X1;
DB_X2_Norm    = DB_X2;
DB_X3_Norm    = DB_X3;
DB_Saida_Norm = DB_SAIDA;

x = [];
y = [];
%monta matriz de entradas
for k=1: length(DB_X1_Norm)
    y(k) = MLP_Executa( W_1, W_2, [-1 DB_X1_Norm(k) DB_X2_Norm(k) DB_X3_Norm(k) ]' );
end;

disp 'Saidas MLP - Teorico';

y'
disp('Pressione uma tecla para continuar...');
pause

DB_Saida_Norm



