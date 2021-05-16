# Bayesian-Decoder
A Bayesian decoder written in MATLAB that aims to decode the mouse's spatial position given the spiking activities of its CA1 place cells recorded using in-vivo calcium imaging.


**[logPosterior, trajectory, rateMap] = decodeTrajectory(path, startFrame, decodingLength):**

The wrapper function that estimates and outputs the mouse's log posterior distribution over spatial bins and the maximally likely position at each time step within an extended time period. It does so by sliding a decoding window of 60 frames through the time period defined by [startFrame, startFrame+decodingLength] with a step size of 60 frames. Note that the length of the decoding window and the step size are hyperparameters and can be adjusted.\
-path: the path to the .mat file that contains relevant data from calcium imaging recordings\
-startFrame: which frame you would like to start decoding\
-decodingLength: how many frames you want to decode; the ending frame would be startFrame+decodingLength

**[logPosterior, position] = decodeTimeWindow(tau, spikes, rateMap, spatialProb):**

This function decodes the mouse's log posterior distribution over spatial states and the most likely position within a single time window. It will be called by the function decodeTrajectory(). \
-tau: length of the decoding time window\
-spikes: thresholded spikes of each place cell within this time window\
-rateMap: the firing rate of each place cell at each spatial bin averaged across all time frames except current time window\
-spatialProb: the spatial probability of the mouse estimated by excluding frames from the current time window

**[rateMap, spatialProb] = getRateMap_SpatialProb(path, startFrame, decodingLength):**

This function estimates the rate map and spatial probability after excluding frames from the current decoding window. It will be called by the master function decodeTrajectory().

