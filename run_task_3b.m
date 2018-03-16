clear all;
close all;
clc;

load('model.mat');
kr=-10;
signal =[1 1];
sim('task_3b', [0 T])

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
sim('task_3b', [0 T])

figure(2);
subplot(2,2,1);
plot(chi.Time,chi.Data);
hold on;
plot(chic.Time,chic.Data);
legend('course wanted', 'response of autopilote function');
title('Step smoothing response of autopilote function');
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

figure(3);
hold on;
plot(chi.Time,chi.Data);
plot(save_chi_2d_time,save_chi_2d );
plot(save_chi_2e_time,save_chi_2e );
plot(save_chi_3a_time,save_chi_3a );
plot(chic.Time,chic.Data);
legend('course wanted','response 2d', 'response 2e', 'response 3a', 'response 3b');
title('Comparaison of all step smoothing response of autopilote function');

