function delta_saida = GradienteLocalIntermediario( size_camada, size_camada_posterior, delta_posterior, W, Y )
%UNTITLED1 Summary of this function goes here
% Y               -> vetor com a saida de cada neuronio na camada dada por 'camada_L'
% delta_posterior -> gradiente local da camada posterior (ou seja, camada_L + 1)
% W               -> matriz de pesos da camada posterior (ou seja, camada L + 1 )

%a derivada da função de ativação  logistica (chamada g, por exemplo) é:
% g' = alfa * g * (1 - g)
% como g está calculada para o ponto em questão g' = a * y ( 1- y )

for j=1:size_camada
    delta_saida(j) = 0;
    soma = 0;
    for k=1:size_camada_posterior
        soma = soma + delta_posterior(k) * W(k, j);
    end;
    delta_saida(j) = soma * ( Y(j) * ( 1 - Y(j) ) );
end;