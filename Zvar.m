function Z = Zvar(f, V)

Cj0     = 2.1e-12;
Vj      = 3;
M       = 1.2;
Cp      = 0.075e-12;
Rs      = 5.4;
Lp      = 0.45e-9;

Cj = Cj0/( ((V/Vj)+1)^M );

w = 2*pi*f;

Z_Lp = 1i*w*Lp;
Z_Cp = 1/(1i*w*Cp);
Z_Cj = 1/(1i*w*Cj);

Za = Rs + Z_Cj;
Zb = 1/ ((1/Za) + (1/Z_Cp));
Z = Z_Lp + Zb;

end