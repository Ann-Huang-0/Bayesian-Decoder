function showTrajectory(path)
    load(path);
    startFrame = 1;
    decodingLength = 3000;

    actual = getActualTrajectory(path, startFrame, decodingLength);
    [~, decoded] = decodeTrajectory(path, startFrame, decodingLength);

    %{
    scatter plot with time-varying color. Note: The axis labels only indicate 
    how the distance from the bottom-left corner. It does not indicate the XY
    positional index used when binning the environment.
    %}
    sz = 25;
    subplot(1,2,1);
    scatter(actual(1,:), actual(2,:), sz, linspace(1, 10, size(actual,2)), 'filled'); 
    title('Actual Trajectory');
    subplot(1,2,2);
    scatter(decoded(1,:), decoded(2,:), sz, linspace(1, 10, size(decoded,2)), 'filled');
    title('Bayesian Decoded Trajectory');
 
end    
    
    
    
    