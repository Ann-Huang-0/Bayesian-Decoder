function actual = getActualTrajectory(path, startFrame, decodingLength)
    load(path);
    binSize = 2;
    stepSize = 60;
    steps = startFrame : stepSize : startFrame+decodingLength;
    actual = zeros(2, length(steps));
    for i = 1:length(steps)-1
        actual(:,i) = mean(processed.p(:,steps(i):steps(i+1)),2);
        actual(:,i) = ceil(actual(:,i) ./ binSize);
    end
end