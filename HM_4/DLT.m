function [ finalH ] = DLT( X, Xw )
    %Direct Linear Transformation 
    %   Detailed explanation goes here

    % Normalize X and Xw
    Ux = Normalize_U_T(X);
    T = Normalize_U_T(Xw);

    X = Ux * X;
    Xw = T * Xw;


    % number of points
    n = size(X,2);

    % Compute Matrix A 

    A = []; 

    for p = 1 : n

        xwp = Xw(1,p);
        ywp = Xw(2,p);
        wwp = Xw(3,p);

        xp = X(:,p);
        % Using the equation 4.1 in Mult. view Geometry  
        Ap = [ 0, 0, 0 , -wwp*xp', ywp*xp'  ;  wwp*xp', 0, 0, 0 , -xwp*xp'];

        A = [A; Ap];

    end

    % computing singular value decomposition

    [U, S, V] = svd(A);

    % Picking up the smalled singular vector from V

    H = reshape(V(:,9),[3 3])';

    H = H / H(3,3);

    finalH = T\H * Ux;

    finalH = finalH / H(3,3); 


end

