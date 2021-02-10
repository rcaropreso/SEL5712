%Carrega os dados
disp 'Carregando dados...'
[DB_X, DB_Y] = Carrega_Dados_Treino;
disp 'Dados carregados!'

%Monta vetores de amostras
N_entradas = 69; %entradas do MLP
eta = 0.015; %coeficiente de treinamento
epson = 1e-05; % margem do erro
n_camadas = 2;
size_Camadas = [nHidden 10];
N_Saidas = size_Camadas(2);
N_Amostras = size(DB_X,1);

x = [];
%monta matriz de entradas
for k=1: N_Amostras
    x(:, k) = [ -1 DB_X(k, :)]';
end;

d =  [DB_Y]';

max_epocas = 10000;

%TREINAMENTO
tic
[W_1, W_2, eqm, epoca] = MLP_Treino( eta, epson, x, d, max_epocas, n_camadas, size_Camadas  );
toc

%Grafico do EQM
figure;
plot( 1: length(eqm), eqm );
grid;
title( 'Erro Quadratico Medio - MLP');
xlabel( 'Epoca' );
ylabel( 'EQM' );

%salva vetores de pesos
save W_1.mat W_1;
save W_2.mat W_2;
save eqm.mat eqm;
save epoca.mat epoca;
saveas(gcf, 'EQM_Treino', 'jpg');
