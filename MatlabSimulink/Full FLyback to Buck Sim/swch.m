function sw = swch(t,D,T)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Desription: 
%
%    function (swch) that accepts the duty cycle D, and
% a single instant of time as an input, and outputs the 
% state of the transistor at that time instant as an output.
% A Fourier series-based triangle wave that is an even function
% of time. Within this function the Even traingle wave is compared
% with the duty cycle D to determine the state of the transistor.
% The output of the function is a 1 if the transistor is to be
% turned on. A value of 0 if it is turned off.
%
%% Inputs:
% 
% t - a signle value of time in seconds 
% D - the duty cycle of the frequancy
% f - the frequancy of the switch
%
%% Outputs: 
%
% sw - the state of the first switch (either 1 or 0)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Costants/Convertions 
H = 30; % the amount of Harmonics in the FS of the Triangle Wave


%% The FS of the Traigle wave with time the input 
x = [];
for k = 1:H
    ak = (1/(k*pi))*sin(k*pi) + (2/(k^2*pi^2))*(cos(k*pi)-1);
    x(k) = ak*cos(k*2*pi*t/T);
end
tri = sum(x) + .5; 

%% Comparator of the Traigle wave value with Duty Cycle for 
if (tri < D)
    sw = 1; % Set the switch high
else
    sw = 0; % Set the switch low
end

end