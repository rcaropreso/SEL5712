function y = Plota_Cluster( DB_X1, DB_X2, DB_D, W_1, sigma )
%UNTITLED1 Summary of this function goes here
%   Detailed explanation goes here

I1 = 1;
I2 = 1;
for i=1:length(DB_X1)
    if( DB_D(i) == 1 )
        C_1(I1, :) = [ DB_X1(i) DB_X2(i) ];
        I1 = I1 + 1;
    end;
    if( DB_D(i) == -1 )
        C_2(I2, :) = [ DB_X1(i) DB_X2(i) ];
        I2 = I2 + 1;
    end;    
end;

figure;
hold on;
plot( C_1(:,1), C_1(:,2), 'bx' );
plot( C_2(:,1), C_2(:,2), 'ro' );

title('Cluster de dados');
xlabel('X1');
ylabel('X2');


%Plota os centroides
plot( W_1(:, 1), W_1(:, 2), 'k+');


%Desenha os circulos
ang=0:0.01:2*pi; 
for i=1:size(W_1,1)
    r = sigma(i);
    x = W_1(i,1);
    y = W_1(i,2);
    xp=r*cos(ang);
    yp=r*sin(ang);

    plot(x+xp,y+yp, 'k');
end;

hold off;
