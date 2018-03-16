clear all;
close all;
clc;

% Constant values
Vg = 552/3.6;       % Speed
g = 9.81;       % Gravity

% Roll Attitude Loop Design
a_phi1 = 3.6784;
a_phi2 = -0.7333;
delta_max_a = 21.5;   %Given in the assignment
e_max_phi = 15;       %Given in the assignment
eta_phi = 0.707;      %Given in the assignment

w_n_phi = sqrt((abs(a_phi2)*delta_max_a)/e_max_phi);  % Given in the book
Kp_phi = (delta_max_a*sign(a_phi2))/e_max_phi;        % Given in the book   
Kd_phi = (2*eta_phi*w_n_phi - a_phi1)/a_phi2;         % Given in the book
Ki_phi = -0.01;        % To compute here

% Transfert function (closed-loop poles) used to find k_i_phi
n_rlocus = [-a_phi2];
d_rlocus = [1 a_phi1+a_phi2*Kd_phi a_phi2*Kp_phi 0];
H_rlocus = tf(n_rlocus,d_rlocus);
figure(1);
rlocus(H_rlocus)    % root locus method

% Transfert function phi/phi_c
n_phi_phic = a_phi2*Kp_phi*[1 Ki_phi/Kp_phi];
d_phi_phic = [1 a_phi1+a_phi2*Kd_phi a_phi2*Kp_phi a_phi2*Ki_phi];
H_phi_phic = tf(n_phi_phic,d_phi_phic);

figure(2);
step(H_phi_phic);
title('step response for close loop of H\phi/\phic');

%% If natural frequency are equals (W_chi = 1)

% Course Hold
zeta_chi = 1.2;      % To compute here
W_chi = 1;           % To compute here

Wn_chi = w_n_phi/W_chi;            % Given in the book
Ki_chi = Wn_chi*Wn_chi*Vg/g;     % Given in the book
Kp_chi = 2*zeta_chi*Wn_chi*Vg/g;  % Given in the book

% Transfert fonction autopilot
H_chi = tf([Kp_chi Ki_chi],[1 0]);
H_end = tf([g/Vg],[1 0]);
H_open = H_chi*H_phi_phic*H_end;     % open-loop
H_chi_chic = feedback(H_open,1);   % close-loop

figure(3);
subplot(1, 2, 1);
margin(H_phi_phic);  % Trace Bode plot.
hold on;
margin(H_chi_chic);
legend('H\phi/\phic', 'H\chi/\chic');
title('Bode of inner and global system with the same natural frequency'); 

%% Final result

% Course Hold
zeta_chi = 1.2;      % Compute in the previous exercise 
W_chi = 9;           % Compute in the previous exercise 

Wn_chi = w_n_phi/W_chi;            % Given in the book
Ki_chi = Wn_chi*Wn_chi*Vg/g;     % Given in the book
Kp_chi = 2*zeta_chi*Wn_chi*Vg/g;  % Given in the book

% Transfert fonction autopilot
H_chi = tf([Kp_chi Ki_chi],[1 0]);
H_end = tf([g/Vg],[1 0]);
H_open = H_chi*H_phi_phic*H_end;     % open-loop
H_chi_chic = feedback(H_open,1);   % close-loop

% Bode plot (open-loop and close-loop)
subplot(1, 2, 2);
margin(H_phi_phic);  % Trace Bode plot.
hold on;
margin(H_chi_chic);
legend('H\phi/\phic', 'H\chi/\chic');
title('Bode of inner and global system'); 


%% Simulation with steps signals
T = 1000;
signal =[1 1];
sim('task_2d', [0 T])

figure(4);
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
title('\deltaa');
xlabel('time [s]')
ylabel('angle [degree]');

subplot(2,2,3);
plot(e.Time,e.Data);
title('error of \phi');
xlabel('time [s]')
ylabel('angle [degree]');

%% Simulation with steps smoothing signals
signal =[0 0];
sim('task_2d', [0 T])
figure(5)

subplot(2,2,1);
plot(chi.Time,chi.Data);
hold on;
plot(chic.Time,chic.Data);
legend('course wanted', 'response of autopilote function');
title('step smoothing response of autopilote function');
xlabel('time [s]')
ylabel('angle [degree]');
save_chi_2d =chi.Data;
save_chi_2d_time =chi.Time;
subplot(2,2,2);
plot(delta_a.Time,delta_a.Data);
title('changement of \deltaa')
xlabel('time [s]')
ylabel('angle [degree]');

subplot(2,2,3);
plot(e.Time,e.Data);
title('error of \phi');
xlabel('time [s]')
ylabel('angle [degree]');


save('model.mat');
