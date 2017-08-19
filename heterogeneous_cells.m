% GPL v3 License (see https://opensource.org/licenses/GPL-3.0)
%
% Computational Thought Experiment for the 2017 Cell Systems preview
% Copyright (C) 2017 Paul Macklin
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.


% key parameters 
birth_rate = 0.05; 
dt = 0.05; 
heterogeneity = .25; 
number_of_initial_agents = 10000; 
%t_max = 15/birth_rate; % 15 times characteristic time scale 
global t_max

% create the prototype Agent 
Agent = [];
Agent.birth_rate = birth_rate; % the cell's "gene" 
Agent.division_probability = 0; 
Agent.time_units = 'hr'; 
Agent.active = true; 

Agents(1) = Agent; 

division_times = zeros( 1,  length(Agents)); 

% now create a distribution of agents 

% get the distribution of rates; 
rates = randn( 1, number_of_initial_agents ); 
% shift to the correct mean and standard deviation 
rates = rates - mean(rates); 
rates = Agent.birth_rate + heterogeneity*birth_rate*rates; 

mean( rates )
std( rates ) 

% create the agents with the distribution of properties 
for i=1:number_of_initial_agents
   Agents(i) = Agent;
   Agents(i).birth_rate = rates(i); 
   Agents(i).division_probability  = Agents(i).birth_rate * dt; 
end

t = 0.0; 
T = 0:dt:t_max; 

n = 1; 

tic
while( t < t_max + 0.01 * dt && length(Agents) < 25000 )   
    
    % for efficiency, sample PRNG all at once. 
    N = length(Agents); 
    random_numbers = rand(1 , N); 

    if( mod(n,100) == 0 || n == 1 )
        disp( sprintf('t = %3.2f %s (max = %3.2f %s)', t, Agent.time_units, t_max , Agent.time_units)); 
    end
    
    % This could be parallelized, if MATLAB were written better. 
    % parfor is slower than serial!!
    for i=1:N
        % Is there a division between now (t) and t+dt? If so, let's call
        % that time t + dt/2. 
        if( random_numbers(i) < Agents(i).division_probability && Agents(i).active == true )
            Agents(i).active = false; 
            division_times(i) = t + dt/2; 
        end
    end
    
    n = n+1;
    t = t+dt; 
end
toc 


figure(1)
bins = 0 : 0.1*birth_rate : 2*birth_rate; 
[N,temp] = hist( rates , bins ); 
hold on 
plot( bins , N/sum(N) , 'r', 'linewidth',  3 ); 
hold off 
axis( [0 2*birth_rate 0 1] ); 
axis square

% h = legend( 'homogeneous', 'heterogeneous' ); 
% set(h , 'fontsize', 12.5 ); 

xlabel( 'birth rate (1/hour)' , 'fontsize', 16 ); 
ylabel( 'probability density', 'fontsize', 16 ); 
title( 'Birth Rate Distributions', 'fontsize', 18   ) ; 


figure(2)
r = mean( rates ); 
X = bins_times; 
ind = find( division_times > 1e-16 ); 
DT = division_times(ind); 

[N,temp] = hist( DT , bins_times ); 
hold on
plot( bins_times , N/sum(N), 'r' , 'linewidth', 2 ); 
N_theor = exp( -r*X ); 
plot( X , N_theor/sum(N_theor) ,'r:', 'linewidth', 3 ); 
hold off 

mean( division_times )
std( division_times )

rates_het = rates; 
division_times_het = division_times; 
N_DT_het = N; 

bins_times = X; 
