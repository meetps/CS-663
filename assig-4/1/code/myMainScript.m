%% MyMainScript

% We run it for 3 examples of varying matrix sizes here

tic;

% row < col
A = rand(4,5);
mySVD(A);

% row > col
A = rand(7,5);
mySVD(A);

% row == col
A = rand(5,5);
mySVD(A);

toc;
