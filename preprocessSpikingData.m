function trace = preprocessSpikingData(path)
    %{
    Binarize raw calcium imaging spiking data by a prespecified threshold.
    By observation, a preliminary threshold is chosen to be 0.0003, causing
    71% of all non-zero spiking data to be 1. This threshold is subject to 
    further modification and optimization.
    %}

    load(path);
    method = 'binarization';
    
    if strcmp(method, 'binarization')
        thresh = 0.0003;
        trace = processed.trace > thresh;
    end
    
    if strcmp(method, 'scaling')
        scalingFactor = 1000;
        trace = round(processed.trace .* scalingFactor);
    end
end
    

  