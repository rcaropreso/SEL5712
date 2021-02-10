function [ c, sigma ] = Caminhos( X, N_Camada_Oculta )
%UNTITLED1 Algoritmo K-Means
%   Detailed explanation goes here

c=[];
sigma = [];

%Inicializacao
for i=1:N_Camada_Oculta
    for j=1:size(X,2) %quantidade de entradas (sinapses)
        c( i, j ) = X( i, j );
    end;
end;

% c(1,:) = X(1,:);
% c(2,:) = X(3,:);

%inicializa vetores de amostras
omega_anterior=[];
stop = 0;

omega_1_Anterior=[];
omega_2_Anterior=[];

while( stop == 0 )
    omega_1=[];
    omega_2=[];
    I_1 = 1;
    I_2 = 1;

    for k=1:size(X,1)               %quantidade de amostras
        for j=1:N_Camada_Oculta     %neurons
            soma = 0;
            for i=1:size(X,2)       %sinapses
                soma = soma + (X(k,i)-c(j,i))^2;
            end;
            d(k, j) = sqrt(soma); %distancia euclidiana
        end;

        %Selecionar o neuronio com a menor distancia
        [value, index] = min(d(k,:));

        if( index == 1 )
            omega_1( I_1 ) = k;
            I_1 = I_1 + 1;
        end;

        if( index == 2 )
            omega_2( I_2 ) = k;
            I_2 = I_2 + 1;
        end;
    end;

    %Ajusta os novos centroides
    %C_1
    soma = [0 0];
    m = length(omega_1);
    for k=1:m %quantidade de amostras em omega_1
        soma = soma + X(omega_1(k), :);
    end;

    c(1, :) = soma/m;

    %C_2
    soma = [0 0];
    m = length(omega_2);
    for k=1:m %quantidade de amostras em omega_2
        soma = soma + X(omega_2(k), :);
    end;

    c(2, :) = soma/m;
    
    %Verifica condicao de parada
    if( length(omega_1_Anterior) ~= length(omega_1) || length(omega_2_Anterior) ~= length(omega_2) )
        stop =0;
    else
        %os vetores tem o mesmo comprimento, vamos ver se sao iguais
        if( sum(omega_1_Anterior==omega_1) == length(omega_1) && sum(omega_2_Anterior==omega_2) == length(omega_2) )
            stop =1;
        end;
    end;
    
    omega_1_Anterior = omega_1;
    omega_2_Anterior = omega_2;    
end;

%calcula sigma
%S_1
soma = 0;
m = length(omega_1);
for k=1:m %quantidade de amostras em omega_1
    soma = soma + (X(omega_1(k), 1) - c(1,1))^2 + (X(omega_1(k), 2) - c(1,2))^2;
end;

sigma(1) = sqrt(soma/m);

%S_2
soma = 0;
m = length(omega_2);
for k=1:m %quantidade de amostras em omega_1
    soma = soma + (X(omega_2(k), 1) - c(2,1))^2 + (X(omega_2(k), 2) - c(2,2))^2;
end;

sigma(2) = sqrt(soma/m);