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

clear

%rwh
%rng default 
isoctave = (exist('OCTAVE_VERSION')~=0); % Checks if octave running
if ~isoctave
    rng('default');
else
    rand ('state', 'reset');
end

global t_max
birth_rate = 0.05;
%t_max = 15/birth_rate; % 15 times characteristic time scale 
t_max = 1/birth_rate; % 15 times characteristic time scale 

homogeneous_cells
heterogeneous_cells 

figure(2)
cmap = [0 0 1]; 

bar( bins_times , [N_DT_hom/sum(N_DT_hom)]' )
colormap(cmap); 
axis( [0 max(bins_times) 0 .7] );
axis square 

% h = legend( 'homogeneous', 'heterogeneous' ); 
% set(h , 'fontsize', 14 ); 
xlabel( 'division time (hour)' , 'fontsize', 16 ); 
ylabel( 'probability density', 'fontsize', 16 ); 
title( 'Division Time Distributions', 'fontsize', 18) ; 

figure(4)
cmap = [1 0 0]; 

bar( bins_times , [N_DT_het/sum(N_DT_het)]' )
colormap(cmap); 
axis( [0 max(bins_times) 0 .7] );
axis square 

% h = legend( 'homogeneous', 'heterogeneous' ); 
% set(h , 'fontsize', 14 ); 
xlabel( 'division time (hour)' , 'fontsize', 16 ); 
ylabel( 'probability density', 'fontsize', 16 ); 
title( 'Division Time Distributions', 'fontsize', 18) ; 



figure(3)
cmap = [0 0 1; 1 0 0]; 

bar( bins_times , [N_DT_hom/sum(N_DT_hom); N_DT_het/sum(N_DT_het)]' )
colormap(cmap); 
axis( [0 max(bins_times) 0 .7] );
axis square 

h = legend( 'homogeneous', 'heterogeneous' ); 
set(h , 'fontsize', 14 ); 
xlabel( 'division time (hour)' , 'fontsize', 16 ); 
ylabel( 'probability density', 'fontsize', 16 ); 
title( 'Division Time Distributions', 'fontsize', 18) ; 

figure(1); 
fig = gcf; 
%fig.PaperPositionMode = 'auto'
set(fig, 'PaperPositionMode', 'auto')

%fig_pos = fig.PaperPosition;
%fig.PaperSize = [fig_pos(3) fig_pos(4)];
fig_pos = get(fig,'PaperPosition')
set(fig, 'PaperSize', [fig_pos(3) fig_pos(4)]);
disp( sprintf('fig_pos(3,4) = %d %d', fig_pos(3),fig_pos(4) ));

set( gca, 'fontsize' , 14 )

print( '-dpng', 'birth_rates.png' );
print( '-dpdf', 'birth_rates.pdf' );
print( '-deps2c', 'birth_rates.eps' );

figure(2); 
fig = gcf; 
%fig.PaperPositionMode = 'auto'
%fig_pos = fig.PaperPosition;
set(fig, 'PaperPositionMode', 'auto')
fig_pos = get(fig,'PaperPosition')

%fig.PaperSize = [fig_pos(3) fig_pos(4)];
set(fig, 'PaperSize', [fig_pos(3) fig_pos(4)]);
set( gca, 'fontsize' , 14 )

print( '-dpng', 'division_times(homogeneous).png' );
print( '-dpdf', 'division_times(homogeneous).pdf' );
print( '-deps2c', 'division_times(homogeneous).eps' );


figure(3); 
fig = gcf; 
%fig.PaperPositionMode = 'auto'
%fig_pos = fig.PaperPosition;
set(fig, 'PaperPositionMode', 'auto')
fig_pos = get(fig,'PaperPosition')

%fig.PaperSize = [fig_pos(3) fig_pos(4)];
set(fig, 'PaperSize', [fig_pos(3) fig_pos(4)]);
set( gca, 'fontsize' , 14 )

print( '-dpng', 'division_times.png' );
print( '-dpdf', 'division_times.pdf' );
print( '-deps2c', 'division_times.eps' );

figure(4); 
fig = gcf; 
%fig.PaperPositionMode = 'auto'
%fig_pos = fig.PaperPosition;
set(fig, 'PaperPositionMode', 'auto')
fig_pos = get(fig,'PaperPosition')
disp( sprintf('fig_pos(3,4) = %d %d', fig_pos(3),fig_pos(4) ));
%fig.PaperSize = [fig_pos(3) fig_pos(4)];
set(fig, 'PaperSize', [fig_pos(3) fig_pos(4)]);
set( gca, 'fontsize' , 14 )

print( '-dpng', 'division_times(heterogeneous).png' );
print( '-dpdf', 'division_times(heterogeneous).pdf' );
print( '-deps2c', 'division_times(heterogeneous).eps' );


