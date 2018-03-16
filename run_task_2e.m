clear all;
close all;
clc;
load('model.mat');
% State-model
A=[ -0.3220 0.0640 0.0364 -0.9917 0.0003 0.0008; 0 0 1 -0.0037 0 0; -30.6492 0 -3.6784 0.6646 -0.7333 0.1315; 8.5396 0 -0.0254 -0.4764 -0.0319 -0.0620; 0 0 0 0 -20.2 0 ; 0 0 0 0 0 -20.2];
B = [ 0 0; 0 0; 0 0; 0 0; 20.2 0; 0 20.2] ;
C = [0 0 0 1 0 0;  0 0 1 0 0 0; 1 0 0 0 0 0; 0 1 0 0 0 0];
D = zeros(4, 2);



T = 1000;

%% Simulation with steps signals
signal =[1 1];
sim('task_2e', [0 T])

figure(1);
subplot(2,2,1);
plot(chi.Time,chi.Data);
hold on;
plot(chic.Time,chic.Data);
legend('course wanted', 'response of autopilote function');
title('Step response of autopilote function');
xlabel('time [s]')
ylabel('angle [degree]');

subplot(2,2,2);
plot(delta_a.Time,delta_a.Data);
title('evolution of \deltaa');
xlabel('time [s]')
ylabel('angle [degree]');

subplot(2,2,3);
plot(e.Time,e.Data);
title('error of \phi');
xlabel('time [s]')
ylabel('angle [degree]');

subplot(2,2,4);
plot(y.Time,y.Data);
legend('\beta', '\phi', 'p', 'r');
title('Evolution of y')
xlabel('time [s]')
ylabel('angle [degree]');

%% Simulation with steps smoothing signals

signal =[0 0];
sim('task_2e', [0 T])

figure(2);

subplot(2,2,1);
plot(chi.Time,chi.Data);
hold on;
plot(chic.Time,chic.Data);
legend('course wanted', 'response of autopilote function');
title('Step smoothing response of autopilote function');
xlabel('time [s]')
ylabel('angle [degree]');
save_chi_2e =chi.Data;
save_chi_2e_time =chi.Time;
subplot(2,2,2);
plot(delta_a.Time,delta_a.Data);
title('Evolution of \deltaa')
xlabel('time [s]')
ylabel('angle [degree]');

subplot(2,2,3);
plot(e.Time,e.Data);
title('error of \phi');
xlabel('time [s]')
ylabel('angle [degree]');

subplot(2,2,4);
plot(y.Time,y.Data);
legend('\beta', '\phi', 'p', 'r');
title('Evolution of y')
xlabel('time [s]')
ylabel('angle [degree]');

save('model.mat');