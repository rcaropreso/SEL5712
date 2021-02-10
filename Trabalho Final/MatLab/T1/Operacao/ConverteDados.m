%Converte os dados, colocando tudo num arquivo só
%Carrega os dados
clear;
clc;
nEntradas  = 69;
nLocucoes  = 6;
nLocutores = 10;

disp 'Carregando dados...'
x=[];
DB_X = [];
for i=1:nLocucoes %locuções
    for j=1:nLocutores %locutores
        sFileName = sprintf( 'L%d_%d.dat', j, i);

        ffile = fopen( sFileName, 'r' );
       
        %le dados da rede
        aux=[];
        [aux, count] = fscanf( ffile, '%f');
        fclose(ffile);

        nAmostras = length(aux)/nEntradas;

        index = 1;
        for k=1:nAmostras
            for m=1:nEntradas
                DB_X(k,m) = aux(index);
                index = index+1;
            end;

            %Cria array de saidas adiciona ao vetor
            d = zeros(1,nLocutores);
            d(j) = 1;

            for m=nEntradas+1:nEntradas+nLocutores
                DB_X(k,m) = d(m-nEntradas);
            end;
        end;
        
        if( isempty(x) )
            x = DB_X;
        else
            x = [x; DB_X];
        end;        
    end;
end;

disp 'Dados convertidos!'

ffile = fopen( 'Dados_Operacao.dat', 'w' );

nRows = size(x,1);
nCols = size(x,2);

fprintf( ffile, '%d %d %d\n', nRows, nEntradas, nLocutores);


for i=1:nRows
    for j  = 1: nCols
        fprintf( ffile, '%9.6f ', x(i,j));
    end;
    fprintf( ffile, '\n' );
end

fclose(ffile);