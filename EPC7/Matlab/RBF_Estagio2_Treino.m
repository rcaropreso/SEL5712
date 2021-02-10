function [W_2, eqm, epoca ] = RBF_Estagio2_Treino( eta, epson, entradas, saidas, max_epocas, n_camadas, size_Camadas )
%RBF_Estagio2 Treinamento de MLP
%   eta          -> coeficiente de treino
%   epson        -> margem de erro
%   entradas     -> matriz com entradas
%   saidas       -> vetor com saidas desejadas
%   max_epocas   -> limite de epocas de treinamento
%   n_camadas    -> numero de camadas neurais da rede MLP
%   size_camadas -> vetor-linha com a quantidade de neuronios em cada
%   camada 

N_Entradas = size(entradas, 1);
N_Amostras = size(entradas, 2);

W_2 = rand(size_Camadas, N_Entradas); %Matriz de pesos da camada 2 - 1 neuron = 1 linha; cada coluna é uma sinapse e tem que incluir o bias da camada anterior (3 colunas)

disp('Inicialização da Rede MLP - Pesos (Pressione uma tecla para continuar)');

%inicio do treinamento
epoca = 1;
eqm(epoca) = 1 + epson;
stop = 0;

%TREINAMENTO MLP 1 camada - BEGIN
difEQM = 1;
EQM_Atual = EQM( entradas, saidas, W_2 );
eqm(epoca) = EQM_Atual;

while (epson < difEQM && epoca < max_epocas)
    EQM_Anterior = EQM_Atual;
    
    %1a Camada: Entrada -> Neurons da camada oculta
    for k=1:N_Amostras
        %FORWARD -INICIO
        X = entradas( :, k );
        d = saidas  ( :, k );
        
        I_2 = W_2 * X;
        Y_2 = I_2; %usando função linear na saida
        %FORWARD - FIM

        %BACKWARD - INICIO
        %Camada 2                     
        delta_2 = GradienteLocalDeSaida( 1, d, Y_2 );
        
        %Atualiza pesos da camada de saida
        sizeW = size(W_2);
        for j=1:sizeW(1) %cada linha é um neuron
            for i=1:sizeW(2) %cada coluna é uma sinapse
                W_2(j,i) = W_2(j,i) + eta * delta_2(j) * X(i);
            end;
        end;          
        %BACKWARD - FIM        
    end;
    
    %Calcula o Erro
    EQM_Atual = EQM( entradas, saidas, W_2 );

    eqm(epoca) = EQM_Atual;
    
    difEQM = abs (EQM_Atual - EQM_Anterior);

    epoca = epoca + 1;       
end;

%TREINAMENTO MLP 1 camada - END

if( epoca < max_epocas )
    disp( sprintf( 'Rede treinada. Numero de epocas: %d', epoca) );
else
    disp( sprintf( 'Limite de epocas atingido (%d), rede nao treinada.', epoca) );
end;