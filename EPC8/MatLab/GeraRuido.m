function Zout = GeraRuido( Zin, NivelDeRuido )
%GeraRuido Gera um Ruido em 20% dos pixels da amostra
%   Detailed explanation goes here

%Quantidade de pixels que sofrera interferencia
n = NivelDeRuido * length(Zin);

Zout = Zin;
vpositions = [];
for i=1:n
    %Sorteia um pixel para sofrer 'ruido'
    b_newposition = false;
    while( ~b_newposition ) %este while garante que uma posicao ainda nao alterada pelo ruido (inedita) sera de fato sorteada
        position = ceil(rand * length(Zin)); %ceil arredonda pra cima, garantindo que a menor posiçao seja 1 e a maior 45
        if( isempty(find( vpositions == position )) )
            %esta posicao é inetida ou seja, nao foi alterada ainda pelo
            %ruido
            vpositions(i) = position;
            b_newposition = true;
        end;
    end;
    Zout(position) = Zout(position) * (-1); %inverte o pixel = ruido
end;
