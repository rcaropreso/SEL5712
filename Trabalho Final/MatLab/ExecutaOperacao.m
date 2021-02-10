function acerto_geral = ExecutaOperacao( sPasta, N_Entradas, N_Saidas, threshold, showInfo )

%threshold = para um dado locutor (1a coluna) e quantos acertos deveriam ocorrer (2a coluna - desejado)
clc;

load W_1;
load W_2;

DB_X=[];
DB_Y=[];
x=[];
d=[];

%OPERACAO
N_Locutores = N_Saidas;
N_Frases = 6;

total_acertos = zeros(N_Saidas, 2); %em cada linha tem quantos acertos foram feitos
total_acertos(:, 2) = N_Frases; %segunda coluna contem o total de acertos desejados (6 frases por locutor)

for speaker_id=1:N_Locutores
    for F=1:N_Frases
        %Carrega o arquivo de dados de entrada
        sSource      = sprintf( '%s\\Operacao\\L%d_%d.dat', sPasta, speaker_id, F );
        sDestination = sprintf( 'L%d_%d.dat', speaker_id, F );
        copyfile( sSource, sDestination, 'f' );

        %Carrega os dados
        %         disp 'Carregando dados...'
        [DB_X, DB_Y] = Carrega_Dados_Operacao( sDestination, speaker_id, N_Entradas, N_Saidas );
        %         disp 'Dados carregados!'

        delete (sDestination);

        %EXECUTA MLP
        %Monta vetores de amostras
        N_Amostras = size( DB_X, 1 );

        %monta matriz de entradas
        for k=1: N_Amostras
            x(:, k) = [ -1 DB_X(k, :)]';
        end;

        d =  [DB_Y]';

        y  = []; %saida real
        yp = []; %saida pós processada

        acertos_por_locucao=0;

        for k=1: N_Amostras
            y(:, k) = MLP_Executa( W_1, W_2, x(:, k) );

            %Pos processamento
            [m, winner] = max(y(:,k)); %seleciona neuron vencedor na saida

            if(winner == speaker_id)
                acertos_por_locucao = acertos_por_locucao+1;
            end;
        end; %for k

        %Verifica se a quantidade de acertos é superior ao threshold
        if( ( acertos_por_locucao / N_Amostras ) > threshold)
            total_acertos(speaker_id, 1) = total_acertos(speaker_id, 1) + 1;
        end;
    end; %for F
end; %for L

if( showInfo )
    total_acertos
    N_Amostras

    disp 'Taxa de acerto por locutor:';
    hits = total_acertos(:,1) ./ total_acertos(:,2) * 100

    disp 'Taxa de Acerto Médio e Desvio Padrao da Rede'
    acerto_geral = mean(hits)
    std(hits)
else
    hits = total_acertos(:,1) ./ total_acertos(:,2) * 100;
    acerto_geral = mean(hits);
end;