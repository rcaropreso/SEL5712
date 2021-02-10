%Executa treinamento em lote das Redes Neurais do Artigo
%O programa começa aqui
clear;
clc;

%TREINAMENTO: INICIO
% %TESTE DE CAMADA OCULTA
% MLP_Inputs = 69;
% MLP_Outputs = 10;
% sTag = 'T1';
% sFolder = sTag;
%
% sFileNM = sprintf('%s\\Treino\\DADOS_TREINO_%s.dat', sFolder, sTag);
%
% copyfile(sFileNM, 'DADOS_TREINO.DAT', 'f');

% Executa Treinamentos
% nHidden = 25;
% for z=1:5
%     nHidden = nHidden + 10;
%
%     if( nHidden == 35 )
%         continue;
%     end;
%
%     if( nHidden ~= 45 )
%         ExecutaTreinamento;
%     end;
%
%
%     %OPERACAO: TESTE DE CAMADA OCULTA
%     threshold = 0.1:0.1:1
%     showInfo = 0;
%     for i=1:length(threshold)
%         acerto(i) = ExecutaOperacao( sFolder, MLP_Inputs, MLP_Outputs, threshold(i), showInfo );
%     end;
%
%     [xx,yy] = smoothLine(threshold,acerto);
%     figure;
%     plot(xx, yy);
%     title('Taxa de Acerto em função do Threshold');
%     grid;
%     xlabel( 'Threshold');
%     ylabel( 'Taxa de Acerto');
%
%     sFileNM = sprintf('%s\\Resultados\\Acerto_%s_%d.jpg', sFolder, sTag, nHidden);
%     saveas(gcf, sFileNM, 'jpg');
%
%     sFileNM = sprintf('%s\\Resultados\\Acerto_%s_%d.mat', sFolder, sTag, nHidden);
%     save sFileNM acerto; %vetor (1a coluna = acertos do locutor N; 2a coluna = acertos desejados - cada linha corresponde a 1 locutos)
%
%     %Salva Resultados
%     sFileNM = sprintf('%s\\Resultados\\W_1_%s_%d.mat', sFolder, sTag, nHidden);
%     movefile('W_1.mat', sFileNM, 'f');
%
%     sFileNM = sprintf('%s\\Resultados\\W_2_%s_%d.mat', sFolder, sTag, nHidden);
%     movefile('W_2.mat', sFileNM, 'f');
%
%     sFileNM = sprintf('%s\\Resultados\\epoca_%s_%d.mat', sFolder, sTag, nHidden);
%     movefile('epoca.mat', sFileNM, 'f');
%
%     sFileNM = sprintf('%s\\Resultados\\eqm_%s_%d.mat', sFolder, sTag, nHidden);
%     movefile('eqm.mat', sFileNM, 'f');
%
%     sFileNM = sprintf('%s\\Resultados\\EQM_Treino_%s_%d.jpg', sFolder, sTag, nHidden);
%     movefile('EQM_Treino.jpg', sFileNM, 'f');
% end
%
% delete( 'DADOS_TREINO.DAT' );
%
% disp 'Treinamento inicial terminado. Escolha o melhor valor de nHidden e execute o codigo abaixo'
% return;

%TREINAMENTO: INICIO
nHidden = 55; %melhor valor
MLP_Inputs = 69;
MLP_Outputs = 10;

for I=2:4 %nao precisa do treinamento 1 porque ele ja foi feito acima.
    sTag = sprintf('T%d', I);
    sFolder = sTag;

    sFileNM = sprintf('%s\\Treino\\DADOS_TREINO_%s.dat', sFolder, sTag);

    copyfile(sFileNM, 'DADOS_TREINO.DAT', 'f');

    % Executa Treino e Operação
    ExecutaTreinamento;

    delete( 'DADOS_TREINO.DAT' );

    %OPERACAO: TESTE DE CAMADA OCULTA
    threshold = 0.1:0.1:1
    showInfo = 0;
    for i=1:length(threshold)
        acerto(i) = ExecutaOperacao( sFolder, MLP_Inputs, MLP_Outputs, threshold(i), showInfo );
    end;

    [xx,yy] = smoothLine(threshold,acerto);
    plot(xx, yy);
    title('Taxa de Acerto em função do Threshold');
    grid;
    xlabel( 'Threshold');
    ylabel( 'Taxa de Acerto');

    sFileNM = sprintf('%s\\Resultados\\Acerto_%s_%d.jpg', sFolder, sTag, nHidden);
    saveas(gcf, sFileNM, 'jpg');

    sFileNM = sprintf('%s\\Resultados\\Acerto_%s_%d.mat', sFolder, sTag, nHidden);
    save sFileNM acerto; %vetor (1a coluna = acertos do locutor N; 2a coluna = acertos desejados - cada linha corresponde a 1 locutos)

    %Salva Resultados
    sFileNM = sprintf('%s\\Resultados\\W_1_%s.mat', sFolder, sTag);
    movefile('W_1.mat', sFileNM, 'f');

    sFileNM = sprintf('%s\\Resultados\\W_2_%s.mat', sFolder, sTag);
    movefile('W_2.mat', sFileNM, 'f');

    sFileNM = sprintf('%s\\Resultados\\epoca_%s.mat', sFolder, sTag);
    movefile('epoca.mat', sFileNM, 'f');

    sFileNM = sprintf('%s\\Resultados\\eqm_%s.mat', sFolder, sTag);
    movefile('eqm.mat', sFileNM, 'f');

    sFileNM = sprintf('%s\\Resultados\\EQM_Treino_%s.jpg', sFolder, sTag);
    movefile('EQM_Treino.jpg', sFileNM, 'f');
end;