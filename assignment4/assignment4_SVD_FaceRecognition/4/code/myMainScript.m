%% Assignment 4--4
% CS-663
% Group-163059009, 16305R011
%% SVD using Eigen Function
%% Initialization Input
% Generates matrix of 7x5 with random real values ranging from 1 to 20
A= randi(20,7,5);
A
%% Find SVD
% SVD function takes A matrix as input and returns  U(AA'),S(Singular
% values),V(A'A) as output. S (Singular values) are find out by taking the
% sqrt of the Eigen values of the A'A or AA'. Some the eigen vectors signs (may be inverted) are inverted when we 
% find out the eign values of A'A or AA'. So to resolve that we did eigen vector inversion for 
% specific eigen value(s). Then we are arranging the vectors according the descreasing order of the eigen values.
[U S V]= MySVD(A);
%% Verify the result
U*S*V'