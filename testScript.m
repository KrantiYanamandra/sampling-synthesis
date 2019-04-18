%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script to run the code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Specify Audio File
    audioFile = 'sax.wav';
   
    %Load audiofile
    [x, FS] = audioread(audioFile);
    % Set Ratio
    p.ratio = 1.5;
    % Set samplerate
    p.FS = FS;
    % Set f0 minimum threshold
    p.f0min=50;
    % Set f0 and RMS window and hop sizes
    p.wsize = 2048;
    p.hop = round(p.wsize*0.5);

    % Set F0 harmonicity threshold
    p.fDelta = 0;

    % Set the minimum number of f0 periods that is allowed in a segment
    p.minPeriod = 14;
    
    % Sum to mono
    if size(x, 2) ~= 1
        x = sum(x,size(x,2))*0.5;
    end
    x = x';

    % Calculate start and end indexes in samples for loop
    loopIndices = loopPoints(x, p);

    % Apply looping to stretch audio to required duration
    % and write to file
    y = loop(x, length(x) * p.ratio, loopIndices, p);
    audiowrite('loopedSignal.wav', y, p.FS);
    