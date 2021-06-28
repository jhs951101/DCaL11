clear all; close all;

Rb = 1000;  fs = 100*Rb;
Tb = 1/Rb;  ts = 1/fs;

% -------------------------------------------------------------------------
bit = 1;
bitlen = length(bit);
% -------------------------------------------------------------------------
type = 'polar_nrz';  % unipolar_nrz. unipolar_rz, bipolar_rz
[s, ~, pulse_shape] = Function_Linecode_Gen(bit, type, Rb, fs);
s = [s, 0];

y = Function_Matched_Filter(pulse_shape, s, fs);
% -------------------------------------------------------------------------
Stime = 0:ts:(bitlen)*Tb;
Ytime = 0:ts:(bitlen+1)*Tb;

AXIS_TIME_S = [0, (bitlen+1)*Tb, -1.2 1.2];
AXIS_TIME_Y = [0, (bitlen+1)*Tb, -1.2*Tb, 1.2*Tb];

figure
subplot(211), stairs(Stime, s);
grid on; axis(AXIS_TIME_S);
xlabel('time [sec]'); ylabel('Signal waveform');
subplot(212), plot(Ytime, y);
grid on; axis(AXIS_TIME_Y);
xlabel('time [sec]'); ylabel('Signal waveform');
% =========================================================================
bit = [1, 0, 1, 0, 1, 1];
bitlen = length(bit);
% -------------------------------------------------------------------------
[s, ~, pulse_shape] = Function_Linecode_Gen(bit, type, Rb, fs);
s = [s, 0];

y = Function_Matched_Filter(pulse_shape, s, fs);
% -------------------------------------------------------------------------
Stime = 0:ts:(bitlen)*Tb;
Ytime = 0:ts:(bitlen+1)*Tb;

AXIS_TIME_S = [0, (bitlen+1)*Tb, -1.2 1.2];
AXIS_TIME_Y = [0, (bitlen+1)*Tb, -1.2*Tb, 1.2*Tb];

figure
subplot(211), stairs(Stime, s);
grid on; axis(AXIS_TIME_S);
xlabel('time [sec]'); ylabel('Signal waveform');
subplot(212), plot(Ytime, y);
grid on; axis(AXIS_TIME_Y);
xlabel('time [sec]'); ylabel('Signal waveform');