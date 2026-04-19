%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Desription: 
%
%    A main matlab script that simulates an ideal flyback to buck 
% converter. The scirpt contains all initial conditions and preforms 
% all post-processing calculations and plotting voltage and current 
% values of the flyback to buck converter with respect to time. 
%
%% Scripts and Functins Needed
%
% swch.m - (function) Calculation of the on state of switch one based off time
% averg.m - (function) takes averages based of period
% bck.m - (script) Calculation of all current and voltage values of the components 
% with respect to time 
%
%% Inputs:
% 
% Vs - Voltage Source 
% FL - Flyback Inductor Value
% FC - Flyback Capacitor Value
% BL - Buck Inductor Value
% BC - Buck Capacitor Value
% R - Load Resistance
% FD - Flyback Duty Cycle 
% BD - Buck Duty Cycle 
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

%% General Inputs 
Vs = 380;
f = 300e3;
SamplePerT = 800; % the number of samples in each period T
tstart = 0;
tend = 2e-3;

% The flyback with two outputs have the same components for both outputs

% Flyback Inputs
FL = 600e-6;
FC = 100e-6;
FD = .2;
NptoNs = 9;
Fr_on = 0; 
FVd_on = 0;

% Buck Inputs 

BL = 60e-6;
BC = 5.82e-6;
BD = .5;
Br_on = 0;
BVd_on = 0;

% Load Currents 

BR1 = .5;
BR2 = .25;

% Transitor on resitsance

RT1 = 10000000;
RT2 = 10000000; 
RT3 = 10000000;
RT4 = 10000000; 

% Vref 
Vref = 15; 

%[FD,BD] = DutyCycleSetter(Vs, NptoNs, Vref);


%% Intiization of varaibls and Arrays 
T = 1 / f;
delta_t = T/SamplePerT;

Vs_i = [];
t = [];

% Flyback
iFL = []; 
vFL = []; 

iFC1 = [];
vFC1 = [];
iFR1 = [];
vFR1 = [];
iFsw1 = [];
vFsw1 = [];
iFsw3 = [];
vFsw3 = [];

iFC2 = [];
vFC2 = [];
iFR2 = [];
vFR2 = [];
iFsw2 = [];
vFsw2 = [];
iFsw4 = [];
vFsw4 = [];

i2 = [];
i3 = [];

% Buck
iBL1 = []; 
vBL1 = []; 
iBC1 = [];
vBC1 = [];
iBR1 = [];
vBR1 = [];
iBsw1 = [];
vBsw1 = [];
iBsw3 = [];
vBsw3 = [];

iBL2 = []; 
vBL2 = []; 
iBC2 = [];
vBC2 = [];
iBR2 = [];
vBR2 = [];
iBsw2 = [];
vBsw2 = [];
iBsw4 = [];
vBsw4 = [];

% Initial Values 
% (only Capacitor Voltage and Inuctor current matters)
Vs_i(1) = 0;
t(1) = tstart;

% FLyback
iFL(1) = 0; 
vFL(1) = 0; 

iFC1(1) = 0;
vFC1(1) = 0;
iFR1(1) = 0;
vFR1(1) = 0;
iFsw1(1) = 0;
vFsw1(1) = 0;
iFsw3(1) = 0;
vFsw3(1) = 0;

iFC2(1) = 0;
vFC2(1) = 0;
iFR2(1) = 0;
vFR2(1) = 0;
iFsw2(1) = 0;
vFsw2(1) = 0;
iFsw4(1) = 0;
vFsw4(1) = 0;

i2(1) = 0;
i3(1) = 0;

% Buck
iBL1(1) = 0; 
vBL1(1) = 0; 
iBC1(1) = 0;
vBC1(1) = 1;
iBR1(1) = 0;
vBR1(1) = 0;
iBsw1(1) = 0;
vBsw1(1) = 0;
iBsw3(1) = 0;
vBsw3(1) = 0;

iBL2(1) = 0; 
vBL2(1) = 0; 
iBC2(1) = 0;
vBC2(1) = 1;
iBR2(1) = 0;
vBR2(1) = 0;
iBsw2(1) = 0;
vBsw2(1) = 0;
iBsw4(1) = 0;
vBsw4(1) = 0;

%% Involking the Calculation Sript
bck2O

%% Plots 
% avg_start = k - 4*SamplePerT;
% avg_end = avg_start + SamplePerT;
% 

figure ()
plot(t,vBC1)

figure ()
plot(t,vBC2)



% Calculate the average values for the output voltage and inductor current
