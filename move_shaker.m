% clear all
close all
clc
%%
ita_robocontrol('0dB','Norm','20dBu');

MS = itaMSTF('useMeasurementChain',0,'samplingRate',[44100],'fftDegree',[20],...
'freqRange',[2  100],'inputChannels',1,'precision','single','averages',1,...
    'repeats',1,'pause',0,'applyBandpass',0,'freqRange'...
    ,[2  15],'outputamplification','0dBFS','latencysamples',0,...
    'outputEqualization',0,'outputChannels',1,'type','exp',...
    'stopMargin',[0.1],'lineardeconvolution',0);


%%
a = MS.run ;

%% Plot
a.plot_freq
xlim(MS.freqRange.*[.9 1.1])
