clear;
clc;

amostrasTreinamento = lerArquivo( 'amostras.txt', 200, 5 );

Carrega_Tabela_Treino;
% Carrega_Tabela_Operacao;
sizeY = size(DB_X1);
Dados_RCA = [(-1) * ones( sizeY(1), 1 ) DB_X1 DB_X2 DB_X3 DB_D];

amostrasTreinamento == Dados_RCA