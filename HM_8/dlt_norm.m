function H = dlt_norm( x, xp )

  T = normalize_transform( x );
  Tp = normalize_transform( xp );

  Htilde = dlt( T * x, Tp * xp );
  H = inv( Tp ) * Htilde * T;
  H = H / H(3,3);
