function delta_saida = GradienteLocalIntermediario( size_camada, size_camada_posterior, delta_posterior, W, Y )
%UNTITLED1 Summary of this function goes here
% Y               -> vetor com a saida de cada neuronio na camada dada por 'camada_L'
% delta_posterior -> gradiente local da camada posterior (ou seja, camada_L + 1)
% W               -> matriz de pesos da camada posterior (ou seja, camada L + 1 )

%a derivada da fun��o de ativa��o  logistica (chamada g, por exemplo) �:
% g' = alfa * g * (1 - g)
% como g est� calculada para o ponto em quest�o g' = a * y ( 1- y )

%a primeira coluna da matriz de pesos contem as sinapses do bias, que nao devem ser levadas em
%conta na corre��o do erro (portanto, usa-se W( k, j+1 )

%a primeira linha da matriz Y cont�m o bias, que nao deve ser usado na
%corre��o (portanto, usa-se Y(j+1) )

soma = delta_posterior * W; %o 1o elemento conter� resultado do bias, nao levar em conta

for j=1:size_camada
    delta_saida(j) = 0;
%     soma = 0;
%     for k=1:size_camada_posterior
%         soma = soma + delta_posterior(k) * W(k, j+1);
%     end;
    delta_saida(j) = soma(j+1) * ( Y(j+1) * ( 1 - Y(j+1) ) );
end;