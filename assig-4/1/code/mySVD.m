function [] = mySVD(A)
%mySVD calculates the singular value decomposition of a matrix
%   Custom SVD method
 
[ eigenvec_u, eigenval_u ] = eig(A*A');
[ eigenvec_v, eigenval_v ] = eig(A'*A);

eigenvec_v = fliplr(eigenvec_v)
eigenvec_u = fliplr(eigenvec_u)

eigenval_v = flipud(eigenval_v);
eigenval_u = flipud(eigenval_u);

S = sqrt(eigenval_v);

end

