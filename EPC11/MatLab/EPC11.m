clc;
clear;

Carrega_Tabela_Treino;

eta = 0.05;
x0 = [DB_X1 DB_X2 DB_X3 DB_X4 DB_X5 DB_X6]';
d  = [DB_D]'; %saidas para treinamento supervisionado
N1 = 4; %neuronios (na LVQ o numero de neurons == quantidade de classes)
N  = 6; %entradas
epson = 1e-4;
max_epocas = 500;
N_Amostras = length(DB_X1);

%Normaliza o vetor de entrada
for k=1:N_Amostras
    x( :, k ) = x0( :, k ) / norm(x0( :, k ));
end;

%Inicializacao da matriz de pesos (cada vetor ou neuron deve ser associado
%a uma classe de dados)
w( :, 1 ) = x( :, 1 );
w( :, 2 ) = x( :, 5 );
w( :, 3 ) = x( :, 9 );
w( :, 4 ) = x( :, 13 );

%Treinamento
epoca = 0;
stop = 0;

w_anterior = w;
maior_mudanca_anterior = 0;

while(~stop)
    for k=1:N_Amostras
        for j = 1: N1
            D(j, k) = sqrt( sum( ( x( :, k ) - w( :, j ) ).^2 ) );
        end;

        [value, winner] = min(D(:, k)); %menor distancia, determina o vencedor

        %Atualiza pesos do vencedor
        if( winner == d(k) ) %vencedor pertence a classe do treinamento -> aproxima ele do cluster
            w( :, winner ) = w( :, winner ) + eta * ( x( :, k ) -  w( :, winner ) );
        else %vencedor NAO pertence a classe do treinamento -> afasta ele do cluster
            w( :, winner ) = w( :, winner ) - eta * ( x( :, k ) -  w( :, winner ) );
        end;
            
        %Normaliza
         w( :, winner ) = w( :, winner ) / norm( w( :, winner ) );
    end;
    epoca = epoca + 1;

    %Criterio de parada      
%     maior_mudanca_atual = max(max(abs(w-w_anterior)));

    w_change = w-w_anterior;    
    for hh=1:size(w_change,2)
        norma(hh) = norm( w_change( :, hh ) ); %calcula a norma de cada coluna
    end;

     maior_mudanca_atual = max( norma );  %norm(max(abs((w-w_anterior)), [],2));
     maior_mudanca_atual
     if( maior_mudanca_atual < epson ) %|| ( maior_mudanca_atual - maior_mudanca_anterior ) < epson )
         stop = 1;
     end;
% 
%     maior_mudanca_anterior = maior_mudanca_atual;
    
    w_anterior = w;
    
end;


disp 'Fim do Treinamento: Numero de Epocas'
epoca
pause

%OPERACAO
Carrega_Tabela_Operacao;
xOp = [DB_X1 DB_X2 DB_X3 DB_X4 DB_X5 DB_X6]';

N_Amostras = length(DB_X1);

%Normaliza o vetor de entrada
for k=1:N_Amostras
    x( :, k ) = xOp( :, k ) / norm(xOp( :, k ));
end;

%Verificação
for k=1:N_Amostras
    for j = 1: N1
        D(j, k) = sqrt( sum( ( x( :, k ) - w( :, j ) ).^2 ) );
    end;

    [value, winner] = min(D(:, k)); %menor distancia, determina o vencedor

    disp( sprintf( 'Neuronio vencedor (classe): %d', winner ) );    
end;