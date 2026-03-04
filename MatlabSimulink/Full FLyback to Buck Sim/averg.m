function avg = averg(t,x,T)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Desription: 
%
%   This fucntion takes in the period, the time interval in that period
% and any interval of values in that period that needs to be average. 
% Using a riemann sum approximation to calculate the average over the 
% period.
%
%% Inputs:
% 
% t - time interval over a Period + 1 indentation (should be an array/vector)
% x - the values that is being average over a period (should be an
% array/vector)
% T - the period in seconds
%
%% Outputs: 
%
% avg - the averaged value of the input x
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Checking System
if (size(x) ~= size(t) - 1) %Check the size of both input x and t to see fi they are compatible
   fprintf("The input x and t are not the right lengths to complete this operation")
   avg = -1;
    return
end

%% Average Calculations
avg = 0;
for i = 1:length(x)

    avg = avg + x(i) * (t(i+1) - t(i));
 
end

avg = avg / T;

end