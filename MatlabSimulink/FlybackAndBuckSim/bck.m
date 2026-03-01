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
    
    a = ((delta_t * (~Fsw) * NptoNs) / FL );
    b = (1 );
    c = (1 + delta_t / (FR * FC));
    d = (-(delta_t * Fsw * NptoNs) / FC);

    A = [a , b ; c , d];
    B = [iFL(k) + Fsw * Vs * delta_t / FL ; vFC(k)];
    E = A\B;
    
    % Values Gotten from Differational Equation Approximation
    vFC(k+1) = E(1); 
    iFL(k+1) = E(2);

    a = (delta_t / BL );
    b = (1);
    c = (1 + delta_t / (BR * BC));
    d = (-delta_t / BC);

    A = [a , b ; c , d];
    B = [iBL(k) + Bsw * vFC(k) * delta_t / BL ; vBC(k)];
    E = A\B;
    
    % Values Gotten from Differational Equation Approximation
    vBC(k+1) = E(1); 
    iBL(k+1) = E(2);

    if (iFL(k+1) < 0) 
        iFL(k+1) = 0;
    end
    if (iBL(k+1) < 0) 
        iBL(k+1) = 0;
    end

    vBR(k+1) = vBC(k+1);
    iBR(k+1) = vBR(k+1) / BR;

    t(k+1) = t(k) + delta_t;

    k = k+1; 

end




