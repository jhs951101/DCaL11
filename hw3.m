clear all; close all;

Rb = 1000;  fs = 100*Rb;
Tb = 1/Rb;  ts = 1/fs;

% -------------------------------------------------------------------------
% Tx;
bit = [1, 0, 1, 0, 1, 1, 0, 0, 0, 1];
bitlen = length(bit);
type = 'unipolar_rz';  % unipolar_nrz, unipolar_rz, polar_rz, manchester
[x, ~, pulse_shape] = Function_Linecode_Gen(bit, type, Rb, fs);
x = [x, 0];
% -------------------------------------------------------------------------
% Channel;

noise_power = [2, 4];
BW = 25;

y1 = Function_Channel_Filter(x, 1, noise_power(1), BW*Rb, fs);
y2 = Function_Channel_Filter(x, 1, noise_power(2), BW*Rb, fs);
% -------------------------------------------------------------------------
Ttime = 0:ts:(bitlen)*Tb;

AXIS_TIME1 = [0, bitlen*Tb, -1.5 1.5];
AXIS_TIME2 = [0, bitlen*Tb, -5 5];
AXIS_TIME3 = [0, bitlen*Tb, -10 10];

figure
subplot(211), plot(Ttime, x); grid on; axis(AXIS_TIME1);
xlabel('time [sec]'); ylabel('Signal waveform');
title(['Tx & Rx signal waveforms, Noise power = ',num2str(noise_power(1)),...
    ' W, Channel BW = ',num2str(BW),' KHz']);
subplot(212), plot(Ttime, y1); grid on; axis(AXIS_TIME2);
xlabel('time [sec]'); ylabel('Signal waveform');

figure
subplot(211), plot(Ttime, x); grid on; axis(AXIS_TIME1);
xlabel('time [sec]'); ylabel('Signal waveform');
title(['Tx & Rx signal waveforms, Noise power = ',num2str(noise_power(2)),...
    ' W, Channel BW = ',num2str(BW),' KHz']);
subplot(212), plot(Ttime, y2); grid on; axis(AXIS_TIME3);
xlabel('time [sec]'); ylabel('Signal waveform');
% -------------------------------------------------------------------------
% Rx;

z1 = Function_Matched_Filter(pulse_shape, y1, fs);
z2 = Function_Matched_Filter(pulse_shape, y2, fs);

% -------------------------------------------------------------------------
Ztime = 0:ts:(bitlen+1)*Tb;

AXIS_TIME_Z = [0, (bitlen+1)*Tb, -1.5*Tb, 1.5*Tb];

figure
subplot(211), plot(Ttime, x); grid on; axis(AXIS_TIME1);
xlabel('time [sec]'); ylabel('Signal waveform');
title(['Tx & Rx signal waveforms, Noise power = ',num2str(noise_power(1)),...
    ' W, Channel BW = ',num2str(BW),' KHz']);
subplot(212), plot(Ztime, z1); grid on; axis(AXIS_TIME_Z);
xlabel('time [sec]'); ylabel('Signal waveform');


figure
subplot(211), plot(Ttime, x); grid on; axis(AXIS_TIME1);
xlabel('time [sec]'); ylabel('Signal waveform');
title(['Tx & Rx signal waveforms, Noise power = ',num2str(noise_power(2)),...
    ' W, Channel BW = ',num2str(BW),' KHz']);
subplot(212), plot(Ztime, z2); grid on; axis(AXIS_TIME_Z);
xlabel('time [sec]'); ylabel('Signal waveform');
% -------------------------------------------------------------------------