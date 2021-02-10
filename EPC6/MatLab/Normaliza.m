function NormArray = Normaliza( max_scale, min_scale, Vetor_Amostras )
%Normaliza Faz a normalizacao do vetor de amostras
% max_scale -> valor maximo da escala (para funcao sgn = 1)
% min_scale -> valor minimo da escala (para funcao sgn = -1)
% Vetor_Amostras -> vetor com amostras

max_amostras = max(Vetor_Amostras);
min_amostras = min(Vetor_Amostras);

for k=1:length(Vetor_Amostras)
    NormArray(k) = (max_scale - min_scale) * ( Vetor_Amostras(k) - min_amostras ) / (max_amostras - min_amostras) + min_scale;
end;


