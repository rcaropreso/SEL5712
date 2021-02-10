clear;
close all;
clc;


%Numero de padroes usados: p (4)
%Numero de dados usados: n (45)

[Z1, Z2, Z3, Z4] = CarregaDadosDeEntrada();

p = 4;
n = length(Z1); %45'
NivelDeRuido = 0.2; %no caso, 20%
SimulacoresPorAmostra = 3;

%Gera matriz de pesos da Rede
Z = [Z1 Z2 Z3 Z4];
W = ProdutoExterno(p, n, Z);

%Gera vetor de limiares
ib = zeros(45, 1);

%Execucao
for k=1:p % vai pegar 1 amostra por vez
    for i=1:SimulacoresPorAmostra %3 ruidos por amostra
        %Gera ruido para uma amostra
        x0 = GeraRuido( Z(:, k), NivelDeRuido );

        %Executa a Rede
        v_final = HopfieldOperacao( W, ib, x0 );

        % v_final
        % sum(v_final == Z1)

        %Monta Figura com dados: original, ruidoso e obtido pela rede
        figure
        title( sprintf( 'Amostra: %d - Simulação: %d', k, i ));
        original = AjeitaVetor(Z(:, k)');
        ruido    = AjeitaVetor(x0');
        obtido   = AjeitaVetor(v_final');
              
        subplot( 1,3,1 ), imshow( original ), title( 'Original' );
        subplot( 1,3,2 ), imshow( ruido ), title( 'Ruido' );
        subplot( 1,3,3 ), imshow( obtido ), title( 'Obtido pela Rede' );
        saveas( gcf, sprintf('%d_%d.jpg', k, i) );
    end;
end;