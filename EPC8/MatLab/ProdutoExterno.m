function [ W ] = ProdutoExterno( p, n, amostras )
%ProdutoExterno Realiza o PE das amostras
%   Detailed explanation goes here

soma = zeros(n,n);

for k=1:p
    soma = soma + amostras(:, k) * amostras(:, k)';
end;

W = soma / n - (p/n)*eye(n);
