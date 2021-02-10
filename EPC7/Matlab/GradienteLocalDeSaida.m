function delta_saida = GradienteLocalDeSaida( size_camada, d, Y )
%UNTITLED1 Summary of this function goes here
%  saidas_desejadas -> vetor com amostras de saida para a epoca atual
%  saidas_MLP        -> vetor com a saida de cada neuronio 
%  entradas          -> vetor com o valor de entrada em cada neuron, antes
%  da fun��o de ativa��o


%a derivada da fun��o de ativa��o  logistica (chamada g, por exemplo) �:
% g' = g * (1 - g)
for j=1:size_camada    
%     delta_saida(j) = ( d(j) - Y(j) ) * ( Y(j) * ( 1 - Y(j) ) );
    delta_saida(j) = ( d(j) - Y(j) ); %usando fun��o linear (aproximador de fun��es)
end;
