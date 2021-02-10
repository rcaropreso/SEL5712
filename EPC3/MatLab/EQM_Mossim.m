function eqm = EQM_Mossim(p, colunaSaidaDesejada, amostras, w1, w2)
% Essa funcao retorna o Erro Quadratico Medio
eqm = 0;
em = 0;
N = colunaSaidaDesejada -1;

% calculando o EM
for i=1:p
    I1=w1*amostras(i,1:N)'; 
    y1=logsig(I1);     
    I2=w2'*y1; 
    y2=logsig(I2);

    erro =(amostras(i,colunaSaidaDesejada)-y2)^2; 
    erro = erro/2;

    em = em + erro;
end

eqm = em/p;


