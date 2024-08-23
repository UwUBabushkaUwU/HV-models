% Assign values to the parameters
C_eq = 190;      % Equivalent heat capacity (J/K)
m = 0.4;         % Mass (kg)
C = 880;         % Specific heat capacity (J/kg*K)
h = 5;           % Heat transfer coefficient (W/m^2*K)
breadth = 0.015;
length = 0.164;
A = breadth * length * 2;          % Surface area (m^2)
T_in = 25;                     % Input temperature (C)
I = 100;                       % Current (A)
% conductivity = ;
% Area_cu = ;
% thickness_cu;
area_busbar = 0.0002;
length_busbar = 0.0035;
rho_cu = 0.00000001724;
number_busbar = 1/2;
R = rho_cu * area_busbar * number_busbar / rho_cu;         % Resistance (ohms)
T_initial_kelvin = T_in+273.15;  % Initial temperature (K)
t_final = 100000;  % Final time for simulation (s)

% Define the differential equation as a function handle
dTdt = @(t, T) (h * A * (T - T_initial_kelvin) - I^2 * R) / (C_eq - m * C);

% Solve the differential equation using ode45
[t, T] = ode45(dTdt, [0 t_final], T_initial_kelvin);

% Plot T vs t
figure;
plot(t, T-273.15, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Temperature (C)');
title('Temperature vs Time');
grid on;