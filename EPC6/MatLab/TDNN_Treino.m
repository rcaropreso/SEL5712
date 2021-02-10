function [W_1, W_2, eqm, epoca] = TDNN_Treino( alfa, eta, epson, entradas, saidas, max_epocas, n_camadas, size_Camadas  )
%TDNN_Treino Treinamento de TDNN
%   alfa         -> taxa de momentum
%   eta          -> coeficiente de treino
%   epson        -> margem de erro
%   entradas     -> matriz com entradas
%   saidas       -> vetor com saidas desejadas
%   max_epocas   -> limite de epocas de treinamento
%   n_camadas    -> numero de camadas neurais da rede MLP
%   size_camadas -> vetor-linha com a quantidade de neuronios em cada
%   camada 

sizeW = size(entradas);
N_entradas = sizeW(1);
N_amostras = sizeW(2);

% pesos = rand(N_entradas, n_camadas);

% Wji = j-esimo neuron de uma cada ao i-esimo sinal da camada de entrada (na primeira matriz de pesos)
%assim, todos os sinais de entrada de um neuronio ficam na linha, cada
%linha contem 1 neuronio

nCamadaOculta = size_Camadas(1);
nCamadaSaida  = size_Camadas(2);

W_1 = rand(nCamadaOculta, N_entradas);   %1 neuron por linha; a quantidade de colunas corresponde ao tamanho do vetor de entrada que já inclui o bias
W_2 = rand(nCamadaSaida, nCamadaOculta+1); %Matriz de pesos da camada 2 - 1 neuron = 1 linha; cada coluna é uma sinapse e tem que incluir o bias da camada anterior N_Camada_Oculta + 1

%Matrizes de peso da iteração anterior (para calculo de momentum)
W_1_Anterior = W_1;%zeros(nCamadaOculta, N_entradas);
W_2_Anterior = W_2;%zeros(nCamadaSaida, nCamadaOculta+1);

disp('Inicialização da Rede TDNN - Pesos (Pressione uma tecla para continuar)');

%inicio do treinamento
epoca = 1;
eqm(epoca) = 1 + epson;
stop = 0;

%TESTE GERAL
difEQM = 1;
EQM_Atual = EQM( entradas, saidas, W_1, W_2 );
eqm(epoca) = EQM_Atual;

while (epson < difEQM && epoca < max_epocas)
    EQM_Anterior = EQM_Atual;
    
    %1a Camada: Entrada -> Neurons da camada oculta
    for k=1:N_amostras
        %TESTE - FORWARD
        X = entradas( :, k );
        d = saidas  ( :, k );
        
        I_1 = W_1 * X;
        Y_1 = logsig( I_1 );
        
        %Ajeita o vetor de saida, adicionando o bias
         Y_1 = [ -1; Y_1 ];

        %2a Camada: Neurons Camada Oculta -> Neurons de Saida
        I_2 = W_2 * Y_1;
        Y_2 = logsig(I_2);
                
        %TESTE - BACKWARD
        %Camada 2
        delta_2 = GradienteLocalDeSaida( nCamadaSaida, d, Y_2 );
        
        %Atualiza pesos da camada de saida
        sizeW = size(W_2);
        for j=1:sizeW(1) %cada linha é um neuron
            for i=1:sizeW(2) %cada coluna é uma sinapse
                W_2(j,i) = W_2(j,i) + alfa * ( W_2(j,i) - W_2_Anterior(j,i) ) + eta * delta_2(j) * Y_1(i); %correção com momentum
            end;
        end;
        
        %Ja atualizou os pesos, armazena na matriz para a proxima iteração,
        %com uso de momentum
        W_2_Anterior = W_2;
          
        %Camada 1
        delta_1 = GradienteLocalIntermediario( nCamadaOculta, nCamadaSaida, delta_2, W_2, Y_1 );
       
        %Atualiza pesos de uma camada de entrada
        sizeW = size(W_1);
        for j=1:sizeW(1) %cada linha é um neuron
            for i=1:sizeW(2) %cada coluna é uma sinapse
                W_1(j,i) = W_1(j,i) + alfa * ( W_1(j,i) - W_1_Anterior(j,i) ) + eta * delta_1(j) * X(i); %correção com momentum
            end;
        end;
        
        %Ja atualizou os pesos, armazena na matriz para a proxima iteração,
        %com uso de momentum
        W_1_Anterior = W_1;
        
        %TESTE - BACKWARD - FIM        
    end;
                
    %Calcula o Erro
    EQM_Atual = EQM( entradas, saidas, W_1, W_2 );
    EQM_Atual
    
    eqm(epoca) = EQM_Atual;
    
    difEQM = abs (EQM_Atual - EQM_Anterior);

    epoca = epoca + 1;       
end;

if( epoca < max_epocas )
    disp( sprintf( 'Rede treinada. Numero de epocas: %d', epoca) );
else
    disp( sprintf( 'Limite de epocas atingido (%d), rede nao treinada.', epoca) );
end;


