function [Y] = Logistica(I, beta )

[Y] = 1./( 1 + exp( (-1) * (beta)*I)) ;

