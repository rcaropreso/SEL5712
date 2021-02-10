function [ v_final ] = HopfieldOperacao( W, ib, x0 )
%HopfieldOperacao Executa a Rede de Hopfield
% W  -> Pesos
% ib -> vetor de limiares
% x0 -> vetor inicial de entradas

v_atual    = x0;
v_anterior = zeros(size(v_atual, 1), size(v_atual, 2) );

beta = 100;
epson = 1e-8;

while( sum( abs( v_anterior - v_atual ) ) > epson )
    v_anterior = v_atual;
    u = W * v_anterior + ib;
    v_atual = sign(u); %alem de ser discreto, tanh com beta muito alto é praticamente a funcao 'sinal'.
%     v_atual = ( 1 - exp( -2 * beta * u ) ) ./ ( 1 + exp( -2 * beta * u ) );
%     v_teste = tanh(u); a expressao acima da os mesmos resultados de tanh
%     quando beta =1 (com diferença uma distante casa decimal)   
end;

v_final = v_atual;