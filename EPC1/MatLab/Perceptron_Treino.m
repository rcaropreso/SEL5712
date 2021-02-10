function pesos = Perceptron_Treino( eta, entradas, saidas, max_epocas )
%Perceptron_Treino Treinamento de Perceptron 1 camada
%   eta         -> coeficiente de treino
%   entradas    -> matriz com entradas
%   saidas      -> vetor com saidas desejadas
%   max_epocas  -> limite de epocas de treinamento

sizeW = size(entradas);
N_entradas = sizeW(1);
N_amostras = sizeW(2);

pesos = rand(N_entradas, 1); 

disp('Inicialização do Perceptron - Pesos (Pressione uma tecla para continuar)');
pesos
pause

%inicio do treinamento
epoca = 0;
erro = 1;

while( epoca <= max_epocas && erro )
    erro = 0;
    for k=1:N_amostras
        u = pesos' * entradas( :, k );
        y = sign( u );
        
        %verifica erro
        if( y ~= saidas( k ) )
            %corrige peso
%             eta * ( saidas( k ) - y ) * entradas( k )
            pesos = pesos + eta * ( saidas( k ) - y ) * entradas( :, k );
            erro = 1;
        end        
    end;
    epoca = epoca + 1;
end;

epoca = epoca - 1;

disp( sprintf( 'Fim do treinamento. Numero de epocas: %d', epoca) );

