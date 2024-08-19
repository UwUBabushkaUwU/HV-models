function output = calculate_output(i, t, T_initial, T_surroundings)
    % Constants
    C_1 = 1; % You can change these constants to your specific values
    C_2 = 1; % You can change these constants to your specific values
    C_3 = 1; % You can change these constants to your specific values

    % Calculate the output
    output = C_1 * i^2 * t + C_2 * T_initial^4 - C_3 * T_surroundings^4;
end

