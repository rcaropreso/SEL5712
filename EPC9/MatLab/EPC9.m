clc;
clear;

Carrega_Tabela_Treino;

eta = 0.001;
x0 = [DB_X1 DB_X2 DB_X3]';
N1 = 16; %neuronios
N  = 3; %entradas
epson = 1e-4;
max_epocas = 500;
N_Amostras = length(DB_X1);

%Mapa dos vizinhos
omega = {};
omega{1}  =[2 5];
omega{2}  =[1 3 6];
omega{3}  =[2 4 7];
omega{4}  =[3 8];
omega{5}  =[1 6 9];
omega{6}  =[2 5 7 10];
omega{7}  =[3 6 8 11];
omega{8}  =[4 7 12];
omega{9}  =[5 10 13];
omega{10} =[6 9 11 14];
omega{11} =[7 10 12 15];
omega{12} =[8 11 16];
omega{13} =[9 14];
omega{14} =[10 13 15];
omega{15} =[11 14 16];
omega{16} =[12 15];

%Normaliza o vetor de entrada
for k=1:N_Amostras
    x( :, k ) = x0( :, k ) / norm(x0( :, k ));
end;

%Inicializacao
for i=1:N1
    w( :, i ) = x( :, i );
end;

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
        w( :, winner ) = w( :, winner ) + eta * ( x( :, k ) -  w( :, winner ) );

        %Normaliza
         w( :, winner ) = w( :, winner ) / norm( w( :, winner ) );

        %Atualiza vizinhos do vencedor
        vizinhos = omega{winner};
        for j=1: length(vizinhos)
            index = vizinhos(j);
            w( :, index ) = w( :, index ) + (eta/2) * ( x( :, k ) -  w( :, index ) );

            %Normaliza
             w( :, index ) = w( :, index ) / norm( w( :, index ) );
        end;
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


disp 'Fim do Mapeamento: Numero de Epocas'
epoca
pause

%Identifica as classes
A = [];
B = [];
C = [];
for k=1:N_Amostras
    for j = 1: N1
        D(j, k) = sqrt( sum( ( x( :, k ) - w( :, j ) ).^2 ) );
    end;

    [value, winner] = min(D(:, k)); %menor distancia, determina o vencedor

    %Define a classe
    if(k <= 20)
%         if( isempty(find(A==winner)) )
            A = [A winner];
%         end;
    end;

    if(k >= 21 && k <= 60 )
%         if( isempty(find(B==winner)) )
            B = [B winner];
%         end;
    end;

    if(k >= 61 && k <= 120 )
%         if( isempty(find(C==winner)) )
            C = [C winner];
%         end;
    end;

    %     disp(sprintf( 'Amostra: %3d - Neuron:%d', k, winner ));
end;

for i=1:16
    disp(sprintf('A - %d = %d', i, length(find(A==i))));
    disp(sprintf('B - %d = %d', i, length(find(B==i))));
    disp(sprintf('C - %d = %d\n', i, length(find(C==i))));
end;

disp 'Classes'
A
B
C
pause

%OPERACAO

%Define as classes
A = [1 6 14 15 16];
B = [5 9 10 13];
C = [2 3 4 7 8 11 12];

Carrega_Tabela_Operacao;
xOp = [DB_X1 DB_X2 DB_X3]';

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

    disp( sprintf( 'Neuronio vencedor: %d', winner ) );
    
    %Decide a classe
    if( ~isempty(find(A==winner)) )
        disp(sprintf( 'Amostra: %2d - Classe: A', k));
    end;
    if( ~isempty(find(B==winner)) )
        disp(sprintf( 'Amostra: %2d - Classe: B', k));
    end;
    if( ~isempty(find(C==winner)) )
        disp(sprintf( 'Amostra: %2d - Classe: C', k));
    end;
end;