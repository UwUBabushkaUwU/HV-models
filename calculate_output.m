% Load the data
data = csvread('graph_data.csv');
t_data = data(:, 1); % Time values
T_data = data(:, 2); % Temperature values

% Convert temperatures from Celsius to Kelvin
T_data_Kelvin = T_data + 273.15;

% Function to calculate temperature with parameters C_1, C_2
function T_calc = temp_function(params, t, i, T_initial, T_surroundings)
    if(t< 0)
        T_calc = T_surrounds;
        return;
    end
    C_1 = params(1);
    C_2 = params(2);
    T_prev = temp_function(params,t-100)
    % Calculate temperature
    T_calc = C_1 * i^2 * t + C_2 * (T_prev^4 - T_surroundings^4);
    
    % Check for NaN or Inf values
    if any(isnan(T_calc)) || any(isinf(T_calc))
        error('Temperature calculation resulted in NaN or Inf.');
    end
end

% Initial guesses for the parameters
initial_guess = [0.0003, 0.1]; % Adjust as needed

% Given values (replace these with your actual values)
C_rate = 1; % Example C rate
battery_capacity = 21; % Example battery capacity in Ah

% Calculate current (i)
i = C_rate * battery_capacity;

% Convert temperatures from Celsius to Kelvin for fitting
T_surroundings = T_data(1); % First y-value from the CSV
T_surroundings_Kelvin = T_surroundings + 273.15; % Convert to Kelvin

% Fit the function to the data
options = optimset('Display', 'iter'); % Show iteration information
params_fitted = lsqcurvefit(@(params, t) temp_function(params, t, i, T_surroundings_Kelvin, T_surroundings_Kelvin), initial_guess, t_data, T_data_Kelvin, [], [], options);

% Display the fitted parameters
disp('Fitted parameters:');
disp(params_fitted);

% Generate a range of time values for plotting
t_plot = linspace(0, 4000, 100); % From 0 to 4000 with 100 points

% Calculate the fitted temperature values
T_fitted_Kelvin = temp_function(params_fitted, t_plot, i, T_surroundings_Kelvin, T_surroundings_Kelvin);

% Convert the fitted temperature values back to Celsius for plotting
T_fitted_Celsius = T_fitted_Kelvin - 273.15;

% Plot the original data points and the fitted curve
figure;
plot(t_data, T_data, 'ro', 'DisplayName', 'Original Data'); % Original data in red circles
hold on;
plot(t_plot, T_fitted_Celsius, 'b-', 'LineWidth', 2, 'DisplayName', 'Fitted Curve'); % Fitted curve in blue
xlabel('Time');
ylabel('Temperature (°C)');
title('Temperature vs. Time');
xlim([0 4000]); % Set x-axis limits
ylim([20 40]); % Set y-axis limits
xticks(0:1000:4000); % Set x-axis ticks
yticks(20:5:40); % Set y-axis ticks
legend;
grid on;
hold off;
