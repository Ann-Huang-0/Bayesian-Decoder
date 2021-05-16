function [logPosterior, position] = decodeTimeWindow_1(tau, spikes, rateMap, spatialProb)
    %{
    Given a vector containing the spike counts of each cell within 
    a particular time window, compute the probability distribution of the
    animal's position at this time window. Return the position probability
    distribution as well as the most likely position.
    %}
     
    logPnx = zeros(size(spatialProb)); 
    logPnx(isnan(spatialProb)) = NaN;
    
    for x = 1:size(rateMap, 2)
        for y = 1:size(rateMap, 1)
            if ~isnan(spatialProb(x,y)) && spatialProb(x,y)~=0 % using only active pixels
                meanFR = squeeze(tau .* rateMap(x,y,:));                
                nonZero = meanFR > 0; % using only active cells                                                              
                logPnx(x,y) = log(prod(meanFR(nonZero).^spikes(nonZero) ./ factorial(spikes(nonZero))...
                    .* exp(-meanFR(nonZero)), 'all'));
            end
        end
    end
                
    logPosterior = log(spatialProb) + logPnx;
    [row, col] = find(logPosterior == nanmax(logPosterior,[],'all'));
    position = [row col].';
  
    %{
    logPosterior = zeros(size(spatialProb)); % log probability of being at location X
    logPosterior(isnan(spatialProb)) = NaN;
    
    for x = 1:size(rateMap, 2)
        for y = 1:size(rateMap, 1)
            if ~isnan(spatialProb(x,y)) && spatialProb(x,y)~=0 % using only active pixels
               meanFR = squeeze(tau .* rateMap(x,y,:)); 
               logPosterior(x,y) = log(prod(meanFR .^ spikes ./ factorial(spikes)...
                    .* exp(-meanFR), 'all'));
            end
        end
    end

    [row, col] = find(logPosterior == nanmax(logPosterior(logPosterior~=0))); 
    position = [row col].';
    %}
end
  