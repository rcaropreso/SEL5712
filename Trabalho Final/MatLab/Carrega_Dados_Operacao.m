function [ x, y ] = Carrega_Dados_Operacao( sFileNM, speaker_id, n_in, n_out )
%Carrega_Dados_Treino Carrega o arquivo de dados
%   Detailed explanation goes here

ffile = fopen( sFileNM, 'r' );
aux=[];
[aux, count] = fscanf( ffile, '%f');
fclose(ffile);

nRows = size(aux,1) / n_in; %numero de linhas do arquivo, cada linha contem um conjunto completo de dados de entrada

index = 1;
for k=1:nRows
    %entradas primeiro e saidas no final
    for i=1:n_in
        x(k,i) = aux(index);
        index = index + 1;
    end;
end;

%Monta vetor de valores desejados (targets)
y = zeros(1, n_out);
y( speaker_id ) = 1;