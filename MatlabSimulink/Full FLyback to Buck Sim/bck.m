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
    Fsw = swch(t(k),FD,T);
    Bsw = swch(t(k),BD,T);
    


    a = 1 + delta_t * Fsw * Fr_on / FL;
    b = 0;
    c = delta_t * (~Fsw) * NptoNs / FL;
    d = 0;

    e = 0;
    g = 1 + delta_t * Bsw * Br_on / BL;
    h = -delta_t * Bsw / BL;
    l = delta_t / BL;

    m = - delta_t * (~Fsw) * NptoNs / FC;
    n = (Bsw) * delta_t * Bsw / FC;
    o = 1 + delta_t / (FC * RT1);
    p = 0;

    q = 0;
    r = - delta_t / BC;
    s = 0;
    u = 1  + (delta_t / (BC * BR)) + (delta_t / (BC * RT2));

    z = iFL(k) + Fsw * delta_t * Vs / FL - (~Fsw) * delta_t * FVd_on * NptoNs /FL;
    y = iBL(k) - delta_t * (~Bsw) * BVd_on / BL;
    w = vFC(k);
    x = vBC(k);

    A = [a , b , c , d; e , g , h, l; m , n , o , p; q , r , s , u];
    B = [z ; y ; w ; x];
    E = A\B;
    
    % Values Gotten from Differational Equation Approximation
    iFL(k+1) = E(1);
    iBL(k+1) = E(2);
    vFC(k+1) = E(3); 
    vBC(k+1) = E(4); 
    

    if (iFL(k+1) < 0) 
        iFL(k+1) = 0;
    end
    if (iBL(k+1) < 0) 
        iBL(k+1) = 0;
    end

    vBR(k+1) = vBC(k+1);
    iBR(k+1) = vBR(k+1) / BR;


    vBL(k+1) = vFC(k+1) *Bsw + -vBC(k+1);
    vFL(k+1) = (Fsw * Vs - (~Fsw) * vFC(k+1) * NptoNs);
    iFC(k+1) = -(((~Fsw) * -iFL(k+1) * NptoNs) + (-iBL(k+1) * Bsw));

    




    t(k+1) = t(k) + delta_t;

    k = k+1; 

end




