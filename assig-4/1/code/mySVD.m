function [U,S,V] = mySVD(A)
%mySVD calculates the singular value decomposition of a matrix
%   LHSustom SVD method

    [U,S,V] = svd(A);
    [m,n] = size(A);
    [eigenvec_u, eigenval_u] = eig(A*A');
    [eigenvec_v, eigenval_v] = eig(A'*A);
    
    U_temp = zeros(m,m);
    V_temp = zeros(n,n);
    S_temp = zeros(m,n);
    [m1, n1] = size(eigenval_u);
    
    for i = 1:m
        U_temp(:,i) = eigenvec_u(:,m-i+1);
    end
    
	for i = 1:n
        V_temp(:,i) = eigenvec_v(:,n-i+1);
    end
    
    for i = 1:min(m,n);
        S_temp(i,i) = sqrt(eigenval_u(m1-i+1,m1-i+1));
    end
    
    RHS = A*V_temp;
    LHS = U_temp*S_temp;
    
    for i = 1:n
        if(RHS(:,i)'*LHS(:,i) >= 0) 
            continue;
        else
            U_temp(:,i) = -U_temp(:,i);
        end
    end
    
    U = U_temp;
    S = S_temp;
    V = V_temp;
    
    disp('RMSD Error : ');
    disp(norm(A - U*S*V'));

end