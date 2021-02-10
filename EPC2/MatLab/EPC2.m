clear;
clc;

%Carrega os dados
Carrega_Tabela_Treino;

%Monta vetores de amostras
N_entradas = 4; %entradas da adaline
eta = 0.0025; %coeficiente de treinamento
epson = 1e-06; % margem do erro

%Normaliza dados (pre-processamento)
% DB_X1_Norm = Normaliza( 1, -1, DB_X1 );
% DB_X2_Norm = Normaliza( 1, -1, DB_X2 );
% DB_X3_Norm = Normaliza( 1, -1, DB_X3 );
% DB_X4_Norm = Normaliza( 1, -1, DB_X4 );

DB_X1_Norm = DB_X1;
DB_X2_Norm = DB_X2;
DB_X3_Norm = DB_X3;
DB_X4_Norm = DB_X4;


x = [];
%monta matriz de entradas
for k=1: length(DB_X1_Norm)
    x(:, k) = [ -1 DB_X1_Norm(k) DB_X2_Norm(k) DB_X3_Norm(k) DB_X4_Norm(k)]';
end;

d =  [DB_D];
max_epocas = 20000;

[pesos, erro] = Adaline_Treino(eta, epson, x, d, max_epocas);

disp('Pesos da Rede Adaline treinada');
pesos
% pause
% erro
pause

plot( 1: length(erro), erro );
grid;
title( 'Erro Quadratico Medio - Rede Adaline');
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
%Normaliza dados (pre-processamento)
% DB_X1_Norm = Normaliza( 1, -1, DB_X1 );
% DB_X2_Norm = Normaliza( 1, -1, DB_X2 );
% DB_X3_Norm = Normaliza( 1, -1, DB_X3 );
% DB_X4_Norm = Normaliza( 1, -1, DB_X4 );

DB_X1_Norm = DB_X1;
DB_X2_Norm = DB_X2;
DB_X3_Norm = DB_X3;
DB_X4_Norm = DB_X4;

x = [];
%monta matriz de entradas
for k=1: length(DB_X1_Norm)
    y = Adaline_Executa(pesos, [-1 DB_X1_Norm(k) DB_X2_Norm(k) DB_X3_Norm(k) DB_X4_Norm(k)]' );
end;

