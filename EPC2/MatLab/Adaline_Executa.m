function y = Adaline_Executa( pesos, entrada )
%Perceptron_Executa Operacao de Adaline 1 camada
%   entradas    -> vetor com uma entrada
%   pesos       -> matriz de pesos do treinamento
%   max_epocas  -> limite de epocas de treinamento

u = pesos' * entrada;
y = sign( u );

if( y == -1 )
    disp( sprintf( 'Amostra pertence a Valvula A (-1)') );
else
    disp( sprintf( 'Amostra pertence a Valvula B (+1)') );
end;
