% Using Aurelio to measure free vibration using Laser 
%
% clear all
close all
clc
%%
%%
ita_aurelio_control('channel',[1 2],'inputrange',6,'input','XLR',...
    'AmpAC',0,'inputCouplingAC',0);
%%
N = 17.5 ; 
my_ramp = ita_generate('emptydat',44100,N);
NN = my_ramp.nSamples;
DutyCycle_fade_in = 0.85 ;
DutyCycle_hold = 0.10 ;
DutyCycle_fade_out = 0.05 ;
Amplitude = -1 ;
%
tmp = linspace(0,pi/2,DutyCycle_fade_in*NN);
fade_in = sin(tmp).^2;
hold_on = ones(1,round(DutyCycle_hold*NN));
tmp = linspace(0,pi/2,DutyCycle_fade_out*NN);
fade_out = 1.2*(cos(tmp).^2)-.2;

timeData = Amplitude*[fade_in hold_on fade_out].';

my_ramp.timeData = timeData;
my_new_ramp = ita_extend_dat(my_ramp,N+3);

%%
my_new_ramp.pt



%%

MS = itaMSPlaybackRecord('useMeasurementChain',0,'samplingRate',[44100],...
    'fftDegree',[ceil(my_new_ramp.fftDegree+1)],'freqRange',[0.1  1000],'inputChannels',[ 1 2],...
'precision','single','averages',1,'repeats',1,'pause',0,...
    'applyBandpass',0,'outputamplification','-1dBFS','latencysamples',0,...
    'outputEqualization',0,'outputChannels',[ 2]);

%%
MS.excitation = my_new_ramp;
%%
data = MS.run;
return
save ramp01_outputAmplification_m1dB MS my_ramp my_new_ramp data
%%
b = ita_resample(data,100);
c = ita_envelope(b);
d = ita_merge(b,c);

%%
b.pf
xlim([.2 15])