%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to calculate the RMS value of the audio signal.
% 
% Input: Audio signal and the structure containing the attributes of the
% signal
%
% Output: Vector containing RMS values of the signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function r = RMSValue(signal, p)

    if ~isfield(p, 'maxprd'); p.maxprd=100; end
    if ~isfield(p, 'wsize'); p.wsize=p.maxprd; end
    if ~isfield(p, 'hop'); p.hop=p.wsize; end
    if ~isfield(p, 'FS'); error('Sample rate not provided to RMS function'); end

    if min(size(signal)) ~= 1; error('data should be 1 dimensional'); end
    x=signal(:)/max(signal(:));
    nsamples=numel(x);

    nframes=floor((nsamples-p.wsize)/p.hop);
    r=zeros(1,nframes);

    for k=1:nframes
        % Get current frame of audio
        start=(k-1)*p.hop; % offset of frame
        xx=x(start+1:start+p.wsize,:);

        % Calculate RMS value
        r(k) = rms(xx);
        
    end