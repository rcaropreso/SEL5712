function [pesos, eqm] = Adaline_Treino( eta, epson, entradas, saidas, max_epocas )
%Adaline_Treino Treinamento de Adaline 1 camada
%   eta         -> coeficiente de treino
%   epson       -> margem de erro
%   entradas    -> matriz com entradas
%   saidas      -> vetor com saidas desejadas
%   max_epocas  -> limite de epocas de treinamento

sizeW = size(entradas);
N_entradas = sizeW(1);
N_amostras = sizeW(2);

pesos = rand(N_entradas, 1);

disp('Inicialização da Rede Adaline - Pesos (Pressione uma tecla para continuar)');
pesos
pause

%inicio do treinamento
epoca = 1;
eqm(epoca) = 1 + epson;
stop = 0;

while( epoca <= max_epocas && ~stop )
    erro_parcial = 0;

    for k=1:N_amostras
        u = pesos' * entradas( :, k );
        
        erro_parcial = erro_parcial + ( saidas(k) - u )^2;
        
        pesos = pesos + eta * ( saidas(k) - u ) * entradas( :, k );        
    end;
    
    %Calcula erro Quadratico Medio   
    eqm( epoca ) = erro_parcial / N_amostras;
    
    if( epoca > 1 ) %precisamos de 2 epocas para poder comparar
        
%         abs(eqm(epoca) - eqm(epoca-1))
        
        if( abs(eqm(epoca) - eqm(epoca-1)) < epson )
            stop = 1;
        end;
    end;
    epoca = epoca + 1;
end;

epoca = epoca - 1;

if( stop == 1 )
    disp( sprintf( 'Rede treinada. Numero de epocas: %d', epoca) );
else
    disp( sprintf( 'Limite de epocas atingido (%d), rede nao treinada.', epoca) );
end;


