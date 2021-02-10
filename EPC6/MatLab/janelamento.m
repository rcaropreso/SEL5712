function saida = Janelamento( p, DB_X )
%Janelamento gera o arquivo de entradas e saidas para a rede
%   de acordo com o valor de p (numero de entradas)

saida = [];

linha =1;
for t=p+1:length(DB_X)
    for j=1:p
        saida(linha,j) = DB_X(t-j);
    end;
    saida(linha, p+1) = DB_X(t); % coluna de saida
    linha = linha + 1;
end;
