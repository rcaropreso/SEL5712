function y = RBF_Estagio2_Operacao( W_2, X )
%RBF_Estagio2_Operacao 
%   X     -> matriz com entradas
%   y     -> vetor com saidas produzidas pela rede
%   W_2   -> matriz de pesos da rede treinada

I_2 = W_2 * X;
y = I_2; %usando função linear na saida
