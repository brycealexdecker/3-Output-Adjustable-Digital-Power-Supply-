%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Desription: 
%
%    A matlab script Uses backward euler integration algorithm 
% within a while loop to solve all to solve for all circuit voltages 
% and currents of your Fflyback to buck converter. This includes all votlages and
% currents of the power source, inductor, capicator, both swtiches and
% the load resistance. 
%
%% Inputs:
% 
% Vs - Voltage Source 
% L - Inductor Value
% C - Capacitor Value
% R - Load Resistance
% D - Duty Cycle 
% f - Frequency
% SamplePerT - the samples taken per period
% iFL(1) - Initial value of flyback inductor current
% vFC(1) - Intiial value of  flyabck capacitor voltage 
% iBL(1) - Initial value of Buck inductor current
% vBC(1) - Intiial value of  Buck capacitor voltage 
% NptoNs - The turn ratio of the transformer Primary/Secondary turns 
% delta_t - the change of interval of time
% tstart - the starting time
% tend - the ending time
%
% note - these values are not inputs but are stored in a different fucntion
%% Outputs: 
%
% Vs_i - the current from the voltage source 
% iFL - the Flyback inductor current 
% vFL - the Flyback inductor voltage 
% iFC - the Flyback capacitor current 
% vFC - the Flyback capacitor voltage 
% iBL - the Buck inductor current 
% vBL - the Buck inductor voltage 
% iBC - the Buck capacitor current 
% vBC - the Buck capacitor voltage 
% iR - the load current 
% vR - the load voltage 
% iFsw1 - Flyback switch one current 
% vFsw1 - Flyback switch one voltage 
% iFsw2 - Flyback switch two current 
% vFsw2 - Flyback switch two voltage
% iBsw1 - Buck switch one current 
% vBsw1 - Buck switch one voltage 
% iBsw2 - Buck switch two current 
% vBsw2 - Buck switch two voltage 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Calculation 

k = 1;

while (t(k) < tend)
    Fsw1 = swch(t(k),FD,T);

    Bsw1 = swch(t(k),BD,T);
    Bsw2 = swch(t(k),BD,T);
    

  % Key 
    % a = iLF
    % b = iLB1
    % c = iLB2
    % d = vCF1
    % e = vCF2
    % f = vCB1 
    % g = vCB2
    % h = i2
    % m = i3

    % y = what it is equal to 

    % equation 1
    a1 = 1 + delta_t * Fr_on * Fsw1 / FL;
    b1 = 0;
    c1 = 0;
    d1 = delta_t * NptoNs * (~Fsw1) / FL;
    e1 = 0;
    f1 = 0; 
    g1 = 0;
    h1 = 0;
    m1 = 0;

    y1 = iFL(k) + delta_t * (Vs * Fsw1 - NptoNs * FVd_on * (~Fsw1)) / FL;

    % equation 2
    a2 = 0;
    b2 = 1 + delta_t * Br_on * Bsw1 / BL;
    c2 = 0;
    d2 = - delta_t * Bsw1 / BL;
    e2 = 0;
    f2 = delta_t / BL; 
    g2 = 0;
    h2 = 0;
    m2 = 0;

    y2 = iBL1(k) - delta_t * BVd_on * (~Bsw1);

    % equation 3
    a3 = 0;
    b3 = 0;
    c3 = 1 + delta_t * Br_on * Bsw2 / BL;
    d3 = 0;
    e3 = - delta_t * Bsw2 / BL;
    f3 = 0; 
    g3 = delta_t / BL;
    h3 = 0;
    m3 = 0;

    y3 = iBL2(k) - delta_t * BVd_on * (~Bsw2);

    % equation 4
    a4 = 0;
    b4 = delta_t * Bsw1 / FC;
    c4 = 0;
    d4 = 1 + delta_t / (FC * RT1);
    e4 = 0;
    f4 = 0; 
    g4 = 0;
    h4 = delta_t * (~Fsw1) / FC;
    m4 = 0;

    y4 = vFC1(k);

    % equation 5
    a5 = 0;
    b5 = 0;
    c5 = delta_t * Bsw2 / FC;
    d5 = 0;
    e5 = 1 + delta_t / (FC * RT2);
    f5 = 0; 
    g5 = 0;
    h5 = 0;
    m5 = delta_t * (~Fsw1) / FC;

    y5 = vFC2(k);

    % equation 6
    a6 = 0;
    b6 =  - delta_t / BC;
    c6 = 0;
    d6 = 0;
    e6 = 0;
    f6 = 1 + delta_t * (1/RT3 + 1/BR1) / BC; 
    g6 = 0;
    h6 = 0;
    m6 = 0;

    y6 = vBC1(k);

    % equation 7
    a7 = 0;
    b7 = 0;
    c7 = - delta_t / BC;
    d7 = 0;
    e7 = 0;
    f7 = 0; 
    g7 = 1 + delta_t * (1/RT4 + 1/BR2) / BC;
    h7 = 0;
    m7 = 0;

    y7 = vBC2(k);

    % equation 8
    a8 = 1;
    b8 = 0;
    c8 = 0;
    d8 = 0;
    e8 = 0;
    f8 = 0; 
    g8 = 0;
    h8 = 1 / NptoNs;
    m8 = 1 / NptoNs;

    % equation 9
    a9 = 0;
    b9 = 0;
    c9 = 0;
    d9 = 1;
    e9 = -1;
    f9 = 0; 
    g9 = 0;
    h9 = 0;
    m9 = 0;

    y9 = 0;



    A = [a1 , b1 , c1 , d1, e1, f1, g1, h1, m1;
        a2 , b2 , c2 , d2, e2, f2, g2, h2, m2 ;
        a3 , b3 , c3 , d3, e3, f3, g3, h3, m3 ;
        a4 , b4 , c4 , d4, e4, f4, g4, h4, m4 ;
        a5 , b5 , c5 , d5, e5, f5, g5, h5, m5 ;
        a6 , b6 , c6 , d6, e6, f6, g6, h6, m6 ;
        a7 , b7 , c7 , d7, e7, f7, g7, h7, m7 ;
        a8 , b8 , c8 , d8, e8, f8, g8, h8, m8 ;
        a9 , b9 , c9 , d9, e9, f9, g9, h9, m9 ];
    B = [y1 ; y2 ; y3 ; y4 ; y5 ; y6 ; y7 ; y8 ; y9];
    E = A\B;
    
    % Values Gotten from Differational Equation Approximation
    iFL(k+1) = E(1);
    iBL1(k+1) = E(2);
    iBL2(k+1) = E(3);
    vFC1(k+1) = E(4); 
    vFC2(k+1) = E(5); 
    vBC1(k+1) = E(6);
    vBC2(k+1) = E(7); 
    i2(k+1) = E(8);
    i3(k+1) = E(9);

    if (i2(k+1) > 0)
        i2(k+1) = 0;
    end
    if (i3(k+1) > 0)
        i3(k+1) = 0;
    end
    if ( iBL1(k+1) < 0)
        iBL1(k+1) = 0;
    end
    if ( iBL2(k+1) < 0)
        iBL2(k+1) = 0;
    end

    t(k+1) = t(k) + delta_t;

    k = k+1; 

end




