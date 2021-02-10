function delta_saida = GradienteLocalIntermediario( size_camada, size_camada_posterior, delta_posterior, W, Y )
%UNTITLED1 Summary of this function goes here
% Y               -> vetor com a saida de cada neuronio na camada dada por 'camada_L'
% delta_posterior -> gradiente local da camada posterior (ou seja, camada_L + 1)
% W               -> matriz de pesos da camada posterior (ou seja, camada L + 1 )

%a derivada da função de ativação  logistica (chamada g, por exemplo) é:
% g' = alfa * g * (1 - g)
% como g está calculada para o ponto em questão g' = a * y ( 1- y )

%a primeira coluna da matriz de pesos contem as sinapses do bias, que nao devem ser levadas em
%conta na correção do erro (portanto, usa-se W( k, j+1 )

%a primeira linha da matriz Y contém o bias, que nao deve ser usado na
%correção (portanto, usa-se Y(j+1) )

for j=1:size_camada
    delta_saida(j) = 0;
    soma = 0;
    for k=1:size_camada_posterior
        soma = soma + delta_posterior(k) * W(k, j+1);
    end;
    delta_saida(j) = soma * ( Y(j+1) * ( 1 - Y(j+1) ) );
end;