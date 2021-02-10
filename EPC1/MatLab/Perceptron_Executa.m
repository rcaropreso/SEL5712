function y = Perceptron_Executa( pesos, entrada )
%Perceptron_Executa Operacao de Perceptron 1 camada
%   entradas    -> vetor com uma entrada
%   pesos       -> matriz de pesos do treinamento
%   max_epocas  -> limite de epocas de treinamento

u = pesos' * entrada;
y = sign( u );

if( y == -1 )
    disp( sprintf( 'Amostra pertence a classe C1 (-1)') );
else
    disp( sprintf( 'Amostra pertence a classe C2 (+1)') );
end;
