% Load and display the image
graphImage = imread('graph_image.png'); % replace with your image file
figure;
imshow(graphImage);
title('Click the origin, (4000, 20) on the x-axis, and (0, 30) on the y-axis in that order');

% Capture the origin and reference points
[x_ref, y_ref] = ginput(3); % Click the origin, a point on the x-axis, and a point on the y-axis

% Define the actual coordinates of these reference points
x_actual = [0, 4000, 0]; % Origin, (4000, 20), (0, 30)
y_actual = [20, 20, 30]; % Origin at y=20, (1000, 20), (0, 30)

% Calculate the scale factors
x_scale = (x_actual(2) - x_actual(1)) / (x_ref(2) - x_ref(1));
y_scale = (y_actual(3) - y_actual(1)) / (y_ref(3) - y_ref(1));

% Get the number of points you want to capture
numPoints = input('Enter the number of points you want to capture: ');

% Calculate the spacing between lines
x_spacing = (x_ref(2) - x_ref(1)) / (numPoints + 1);

% Display the image again with parallel lines added
figure;
imshow(graphImage);
title('Click on the points on the graph');
hold on;

% Add lines parallel to the y-axis
for i = 1:numPoints
    x_line = x_ref(1) + i * x_spacing;
    line([x_line x_line], ylim, 'Color', 'r', 'LineStyle', '--');
end

% Capture points on the graph
[x, y] = ginput(numPoints);

% Transform the captured points to the actual coordinates
x_transformed = (x - x_ref(1)) * x_scale;
y_transformed = (y - y_ref(1)) * y_scale + 20; % Adding 20 to adjust for the y-axis starting point

% Store the transformed points in an ordered pair matrix
data = [x_transformed, y_transformed];

% Save the data to a file
save('graph_data.mat', 'data'); % Save to .mat file
csvwrite('graph_data.csv', data); % Save to .csv file

% Display the captured and transformed data
disp('Captured and transformed (x, y) pairs:');
disp(data);

hold off;
