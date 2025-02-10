close all
clear
clc

X = 0:0.01:10;    % Wline
Y = 0:0.01:10;    % Wgap

Nx = length(X);
Ny = length(Y);

OUT = nan(Nx, Ny);
count = 0;
for x=1:Nx
    for y=1:Ny
        Wline = X(x);
        Wgap  = Y(y);

        Y1 = -1*Wline+1.4;
        Y2 = -0.5*Wline+4.5;

        if (Wgap >= Y1) && (Wgap >= 0.4) && (Wline >= 0.3) && (Wgap <= Y2)
            OUT(x,y) = Y(1,y);
            count = count + 1;
        end
    end

end

figure
plot(X, OUT)
xlabel("Wline [mm]")
ylabel("Wgap [mm]")