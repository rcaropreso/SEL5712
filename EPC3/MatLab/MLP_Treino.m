function [W_1, W_2, eqm] = MLP_Treino( eta, epson, entradas, saidas, max_epocas, n_camadas, size_Camadas  )
%MLP_Treino Treinamento de MLP
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

W_1 = rand(10, 4); %10 neurons = 10 linhas; 4 entradas (3 entradas + 1 bias) = 4 colunas 
W_2 = rand(1, 10); %Matriz de pesos da camada 2 - 1 neuron = 1 linha; 

% entradas'
% pause


% W_1 = [
%     0.4115    0.7742    0.0232    0.9574
%     0.5270    0.1478    0.2313    0.1970
%     0.9202    0.1482    0.8453    0.5293
%     0.3791    0.6391    0.7264    0.5042
%     0.6389    0.0934    0.6947    0.4834
%     0.1737    0.9288    0.3831    0.3776
%     0.7858    0.4851    0.4798    0.5197
%     0.3656    0.1632    0.9671    0.8158
%     0.7769    0.2763    0.7835    0.2086
%     0.3421    0.1310    0.4097    0.3888
%     ];
% 
% W_2 = [0.0461    0.3048    0.8138    0.6821    0.8824    0.0818    0.4948    0.4303    0.3455    0.9137];

%mossim palluci
wCamada1 = W_1;
wCamada2 = W_2';

amostrasTreinamento = [ entradas; saidas]';

% 11 entradas (10 neurons da camada anterior + 1 bias) = 11 colunas

% I_1 -> vetor que possui, em cada posição, a entrada ponderada em relação
% ao j-esimo neuronio da camada 1 (entrada) -> soma ponderada das entradas no
% neuronio 'j'

disp('Inicialização da Rede MLP - Pesos (Pressione uma tecla para continuar)');

%inicio do treinamento
epoca = 1;
eqm(epoca) = 1 + epson;
stop = 0;

nCamadaOculta = size_Camadas(1);
nCamadaSaida  = size_Camadas(2);


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
%         sizeY = size(Y_1);
%         Y_1 = [ (-1) * ones( 1, sizeY(2) ); Y_1 ]; %adiciona uma linha de -1 à matriz Y_1

        %2a Camada: Neurons Camada Oculta -> Neurons de Saida
        I_2 = W_2 * Y_1;
%         Y_2 = logsig(I_2);
        
         Y_2 = I_2; %usnado função linear na saida
        %TESTE - FORWARD - FIM

%         %Remove a 1a linha de Y_1 (bias nao entra no bakcpropag)
%         Y_1( 1, : ) = [];
        
        %TESTE - BACKWARD
        %Camada 2                     
        delta_2 = GradienteLocalDeSaida( 1, d, Y_2 );
        
        %Atualiza pesos da camada de saida
        sizeW = size(W_2);
        for j=1:sizeW(1) %cada linha é um neuron
            for i=1:sizeW(2) %cada coluna é uma sinapse
                W_2(j,i) = W_2(j,i) + eta * delta_2(j) * Y_1(i);
            end;
        end;
          
        %Camada 1
        delta_1 = GradienteLocalIntermediario( 10, 1, delta_2, W_2, Y_1 );
       
        %Atualiza pesos de uma camada de entrada
        sizeW = size(W_1);
        for j=1:sizeW(1) %cada linha é um neuron
            for i=1:sizeW(2) %cada coluna é uma sinapse
                W_1(j,i) = W_1(j,i) + eta * delta_1(j) * X(i);
            end;
        end;
        %TESTE - BACKWARD - FIM   
        
        %%%%%%%%%%%%%%%%%%%%%%%%% codigo mossim pallucii
%         
%         i = k;
%         % Passo Forward
%         I1(:,i)=wCamada1*amostrasTreinamento(i,1:4)'; %dimensao 10 x 200
%         for k=1:10
%             y1(k,i)= logsig(I1(k,i));
%         end
% 
%         % Neuronio da Camada de saida
%         I2(1,i)=wCamada2'*y1(:,i);
%         y2(1,i)=logsig(I2(1,i));
% 
%         % Passo Backward
%         deri2=y2(1,i)*(1-y2(1,i)); %Calculo da derivada de g'(I2)
%         delta2=(amostrasTreinamento(i,5)-y2(1,i))*deri2; %Calculo de delta2 para o ajuste de wCamada2
% 
%         wCamada2=wCamada2+eta*delta2*y1(:,i); %ajuste
% 
%         % Neuronios da primeira Camada
%         %determinando delta1
%         deri1=y1(:,i).*(1-y1(:,i)); %Calculo da derivada de g'(I1)
% 
%         delta1=deri1.*(delta2*wCamada2); %Calculo de delta1 para o ajuste de wCamada1
% 
%         wCamada1=wCamada1+eta*delta1*amostrasTreinamento(i,1:4);%ajuste
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
    end;

% %     disp 'Fim de uma epoca'
%      WW1 = (W_1 == wCamada1);
%      if( isempty(find( WW1 == 0 ) ) == 0 )
%          disp 'Diferença em W1';
%      end;
%      
%      WW2 = (W_2' == wCamada2);
%      if( isempty(find( WW2 == 0 ) )== 0 )
%          disp 'Diferença em W2';
%      end;
         
%     EQM_Atual_Mossim = EQM_Mossim(200, (4+1), amostrasTreinamento, wCamada1, wCamada2);
       
    %Calcula o Erro
    EQM_Atual = EQM( entradas, saidas, W_1, W_2 );

%     if( EQM_Atual ~= EQM_Atual_Mossim )
%         disp 'Erro EQM'
%     end;
    
    eqm(epoca) = EQM_Atual;
    
    difEQM = abs (EQM_Atual - EQM_Anterior);

    epoca = epoca + 1;       
end;

%TESTE GERAL - FIM

if( epoca < max_epocas )
    disp( sprintf( 'Rede treinada. Numero de epocas: %d', epoca) );
else
    disp( sprintf( 'Limite de epocas atingido (%d), rede nao treinada.', epoca) );
end;


