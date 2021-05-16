function [logPosterior, trajectory, rateMap] = decodeTrajectory(path, startFrame, decodingLength)
    %{
    Given the spiking activities for a period of time (usually 3000 frames),
    decode the mouse's moving trajectory composed of each individual time
    windows of 60 frames, sliding at 60 frames each step.
    %}

    load(path);
    placeCell = selectPlaceCell(path);
    tau = 60;  % length of time window
    stepSize = 60;
    
    trace = preprocessSpikingData(path); % thresholding the calcium trace
    trace = trace(placeCell, startFrame :startFrame+decodingLength);
    [rateMap, spatialProb] = getRateMap_SpatialProb(path, startFrame, decodingLength); 
    rateMap = rateMap(:,:,placeCell);
    
    steps = 1 : stepSize : decodingLength-tau;
    trajectory = zeros(2, length(steps));
    logPosterior = zeros(size(spatialProb,1),size(spatialProb,2),length(steps));

    for i = 1 : length(steps)
        spikes = sum(trace(:, steps(i):steps(i)+tau), 2);
        [logPosterior(:,:,i), trajectory(:,i)] = decodeTimeWindow(tau, spikes, rateMap, spatialProb);
    end
end
        
        