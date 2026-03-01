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
Vs = 400;
f = 300e3;
SamplePerT = 800; % the number of samples in each period T
tstart = 0;
tend = 15e-3;

% Flyback Inputs
FL = .6e-3;
FC = 8e-4;
FD = .05;
NptoNs = 9;
VFout = 2.34;

% Buck Inputs 

BL = 600e-6;
BC = 5.82e-6;
BR = 100;
BD = .05;
VBout = .1;

% Flyback R Calc
PBout =  VBout^2  * BR;
FR = VFout ^ 2 / PBout;

%% Intiization of varaibls and Arrays 
T = 1 / f;
delta_t = T/SamplePerT;

Vs_i = [];
t = [];

% Flyback
iFL = []; 
vFL = []; 
iFC = [];
vFC = [];
iFR = [];
vFR = [];
iFsw1 = [];
vFsw1 = [];
iFsw2 = [];
vFsw2 = [];

% Buck
iBL = []; 
vBL = []; 
iBC = [];
vBC = [];
iBR = [];
vBR = [];
iBsw1 = [];
vBsw1 = [];
iBsw2 = [];
vBsw2 = [];

% Initial Values 
% (only Capacitor Voltage and Inuctor current matters)
Vs_i(1) = 0;
t(1) = tstart;

% FLyback
iFL(1) = 0; 
vFL(1) = 0; 
iFC(1) = 0;
vFC(1) = 0;
iFR(1) = 0;
vFR(1) = 0;
iFsw1(1) = 0;
vFsw1(1) = 0;
iFsw2(1) = 0;
vFsw2(1) = 0;

% Buck
iBL(1) = 0; 
vBL(1) = 0; 
iBC(1) = 0;
vBC(1) = 0;
iBR(1) = 0;
vBR(1) = 0;
iBsw1(1) = 0;
vBsw1(1) = 0;
iBsw2(1) = 0;
vBsw2(1) = 0;

%% Involking the Calculation Sript
bck

%% Plots 
avg_start = k - 4*SamplePerT;
avg_end = avg_start + SamplePerT;

% The Full Response
figure ()
plot(t,vFC)
xlabel("time (sec)")
ylabel("Output Voltage (V)")
title("Output Voltage Vs Time")

% figure ()
% plot(t,iFL)
% xlabel("time (sec)")
% ylabel("Inductor Current (A)")
% title("Inductor Current Vs Time")

% The Full Response
figure ()
plot(t,vBR)
xlabel("time (sec)")
ylabel("Output Voltage (V)")
title("Output Voltage Vs Time")

figure ()
plot(t,iBL)
xlabel("time (sec)")
ylabel("Inductor Current (A)")
title("Inductor Current Vs Time")