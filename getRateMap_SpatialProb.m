function [rateMap, spatialProb] = getRateMap_SpatialProb(path, startFrame, decodingLength)
    load(path);
    bin_size = 2;
    p = processed.p;
    p(:,startFrame:startFrame+decodingLength) = [];
    trace = preprocessSpikingData(path);
    trace(:, startFrame:startFrame+decodingLength) = [];
    
    % bin the environment by the specified bin_size
    steps = ceil(environment.size(1)/ bin_size);
    numN = size(trace, 1);
    numTFrame = size(trace, 2);
    % array initiation
    rateMap = zeros(steps, steps, numN); 
    spatialProb = zeros(steps, steps); 
    
    % sampling and get the average firing rate in each position bin
    for x = 1 : steps   
        x_range = bin_size * [x-1 x];
        x_inRange = (p(1,:)>= x_range(1) & p(1,:)<= x_range(2));
        for y = 1 : steps
            y_range = bin_size * [y-1 y];
            y_inRange = (p(2,:)>= y_range(1) & p(2,:)<= y_range(2));
            idx = x_inRange & y_inRange; % 1 at time frames when the mice is at position (x,y)
            spatialProb(x,y) = sum(idx) / numTFrame; % get the probability of mouse being in that pixel
            if sum(idx) == 0  % unaccessible pixels or unvisited pixels
                rateMap(x,y,:) = 0;
            else 
                rateMap(x,y,:) = mean(trace(:,idx),2);
            end
        end
    end
    
    % smooth the rate map
    for idx = 1 : numN
        rateMap(:,:,idx) = imfilter(rateMap(:,:,idx),fspecial('gauss',round([4.*5 4.*5]./bin_size),4./bin_size),'same');
    end
    
    % reassign unaccesible pixels caused by environmental boundaries to NaN
    numMorphPixel = ceil(findMorphSize(path) / bin_size);
    rateMap(1:numMorphPixel, steps-numMorphPixel:steps, :) = NaN;
    rateMap(steps-numMorphPixel:steps, 1:numMorphPixel, :) = NaN;
    spatialProb(1:numMorphPixel, steps-numMorphPixel:steps) = NaN;
    spatialProb(steps-numMorphPixel:steps, 1:numMorphPixel) = NaN;
    
end

