% Rayleigh-Taylor Instability Simulation
clear; clc;

% Parameters
Lx = 100;        % Length of the domain in x-direction
Ly = 50;         % Length of the domain in y-direction
Nx = 256;        % Number of grid points in x-direction
Ny = 256;        % Number of grid points in y-direction
dx = Lx / (Nx - 1);
dy = Ly / (Ny - 1);
g = 9.81;        % Acceleration due to gravity
rho1 = 1;       % Density of the lighter fluid
rho2 = 2;       % Density of the heavier fluid
dt = 0.01;      % Time step
nt = 500;       % Number of time steps

% Initialize grid
[x, y] = meshgrid(0:dx:Lx, 0:dy:Ly);
h = Ly / 2 + 5 * sin(2 * pi * x / Lx); % Initial interface
u = zeros(Ny, Nx); % Horizontal velocity
v = zeros(Ny, Nx); % Vertical velocity
rho = rho2 * ones(Ny, Nx); % Density field

% Set initial density
for j = 1:Ny
    for i = 1:Nx
        if y(j, i) < h(j, i)
            rho(j, i) = rho1;
        end
    end
end

% Time evolution
for t = 1:nt
    % Calculate pressure gradient (simplified)
    dp_dx = gradient(rho, dx, 2); % Pressure gradient in x-direction
    dp_dy = gradient(rho, dy, 1); % Pressure gradient in y-direction
    
    % Update velocities (simple form)
    u = u - dt * dp_dx / rho; % Update horizontal velocity
    v = v - dt * (g + dp_dy ./ rho); % Update vertical velocity
    
    % Update interface
    h = h + dt * v(round(Ny/2), :); % Move interface with vertical velocity
    
    % Visualization
    if mod(t, 10) == 0
        figure(1); clf;
        imagesc(x(1, :), y(:, 1), rho);
        colorbar;
        title(['Rayleigh-Taylor Instability - Time: ', num2str(t * dt)]);
        xlabel('x');
        ylabel('y');
        pause(0.1);
    end
end