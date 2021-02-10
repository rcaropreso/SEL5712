%Carrega os dados
Carrega_Tabela_Treino;

%Monta vetores de amostras
N_entradas = 3; %entradas do perceptron
eta = 0.1; %coeficiente de treinamento

%Normaliza dados (pre-processamento)
DB_X1_Norm = Normaliza( 1, -1, DB_X1 );
DB_X2_Norm = Normaliza( 1, -1, DB_X2 );
DB_X3_Norm = Normaliza( 1, -1, DB_X3 );

x = [];
%monta matriz de entradas
for k=1: length(DB_X1_Norm)
    x(:, k) = [ -1 DB_X1_Norm(k) DB_X2_Norm(k) DB_X3_Norm(k) ]';
end;

d =  [DB_D];
max_epocas = 1000;

pesos = Perceptron_Treino(eta, x, d, max_epocas);

disp('Pesos do Perceptron treinado');
pesos
pause

%OPERACAO
%Carrega os dados
Carrega_Tabela_Operacao;

%Monta vetores de amostras
%Normaliza dados (pre-processamento)
DB_X1_Norm = Normaliza( 1, -1, DB_X1 );
DB_X2_Norm = Normaliza( 1, -1, DB_X2 );
DB_X3_Norm = Normaliza( 1, -1, DB_X3 );

x = [];
%monta matriz de entradas
for k=1: length(DB_X1_Norm)
    y = Perceptron_Executa(pesos, [-1 DB_X1_Norm(k) DB_X2_Norm(k) DB_X3_Norm(k)]' );
end;

