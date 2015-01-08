function [ U ] = Normalize_U_T( X )
    %Normalize_U_T Retuns Normalization Tranformation Matrix
    %   Detailed explanation goes here

    % Translate the centroid to the origin

    T_origin = [1 0 -mean(X(1,:)); 0 1 -mean(X(2,:));0 0 1];

    X = T_origin * X ;

    % Scale so that average distance from origin is sqrt(2)

    norms = sqrt(sum(X(1:2,:).^2));
    s_f = sqrt(2)/mean(norms);

    Scal = [s_f 0 0; 0 s_f 0; 0 0 1];

    U = Scal * T_origin;

end

