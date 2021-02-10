function [ x, y ] = Carrega_Dados_Treino( input_args )
%Carrega_Dados_Treino Carrega o arquivo de dados
%   Detailed explanation goes here

ffile = fopen( 'DADOS_TREINO.DAT', 'r' );

%le dados da rede
header = fscanf(ffile, '%d', 3);
n_amostras = header(1,1);
n_in = header(2,1);
n_out = header(3,1);

for k=1:n_amostras
    for o=1:n_out
        aux = fscanf( ffile, '%f', 1 );
        %ajusta dados de saida (esta vindo 0.8 para a saida escolhida e -0.8 para
        %as demais - vamos trocar para 1 e 0)
        if( aux > 0 )
            y(k,o) = 1;
        else
            y(k,o) = 0;
        end;
    end;

    for i=1:n_in
        x(k,i) = fscanf( ffile, '%f', 1 );
    end;
end;

fclose(ffile);
