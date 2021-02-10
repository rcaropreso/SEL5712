%funcao que le informacoes de qualquer arquivo
function dados = lerArquivo( nomeArquivo, linhas, colunas)
% Importando informações de arquivos
pFile = fopen(nomeArquivo,'r');
AmostraDoArquivo = fscanf(pFile,'%f',[linhas*colunas,inf]);  
fclose(pFile);
% Organizando dados do arquivo txt numa matriz Amostras
for i=1:linhas
    for j=1:colunas
        Amostras(i,j) = AmostraDoArquivo((i-1)*colunas+j);
    end
end
dados = Amostras;