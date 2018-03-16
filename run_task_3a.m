clear all;
close all;
clc;

load('model.mat');
% Create the system thanks to State-space matrices 
SYS = ss(A,B,C,D);
Htot = tf(SYS);     % Compute tranfer functions of the system
G = Htot(1,2);      % Save the tranfer function r/delta_r in H
Kr = -7;

Htot= feedback(Kr*G,1);
figure(1)
rlocus(G);
figure(2)
step(Htot);


signal =[1 1];
sim('task_3', [0 T])

figure(3);
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

%%
signal =[0 0];
sim('task_3', [0 T])

figure(4);
subplot(2,2,1);
plot(chi.Time,chi.Data);
hold on;
plot(chic.Time,chic.Data);
legend('course wanted', 'response of autopilote function');
title('Step smoothing response of autopilote function');
xlabel('time [s]')
ylabel('angle [degree]');
save_chi_3a =chi.Data;
save_chi_3a_time =chi.Time;
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
