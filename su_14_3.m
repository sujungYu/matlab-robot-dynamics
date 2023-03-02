function []=su_14_3()
clear all;
close all;
clc;

l1=0.5; l2=0.5; %링크 길이 
r=0.2;
T=2; dt=0.1; TT=T/dt;
%각속도 변화
for t=1:TT/4
    d_q(t)=0.5*t;
    d_q(t+5)=1;
    d_q(t+10)=1;
    d_q(t+15)=-0.5*t;
end
%end-effector 위치
for t=1:TT
    th(t)=2*pi*(t)/TT;
    p_c(t,:)=[0.5+r*cos(th(t)) 0.2+r*sin(th(t))]; %원
end
% 역기구학 수식
for t=1:TT
    c_c(t,2)=(p_c(t,1)^2+p_c(t,2)^2-l1^2-l2^2)/(2*l1*l2);
    s_c(t,2)=sqrt(c_c(t,2)^2);
    c_c(t,1)=(((l1+l2*c_c(t,2))*p_c(t,1)+l2*s_c(t,2)*p_c(t,2))/(p_c(t,1)^2+p_c(t,2)^2));
    s_c(t,1)=(((l1+l2*c_c(t,2))*p_c(t,2)-l2*s_c(t,2)*p_c(t,1))/(p_c(t,1)^2+p_c(t,2)^2));
end
% theta1 theta2 
for t=1:TT
    q_c(t,2)=atan2(s_c(t,2)*pi/180,c_c(t,2)*pi/180)+d_q(t)*dt;
    q_c(t,1)=atan2(s_c(t,1)*pi/180,c_c(t,1)*pi/180)+d_q(t)*dt;
end
%end-effector 원 그래프
for t=1:TT
     figure(1)
     p1x_c(t,1)=l1*cos(q_c(t,1));
     p1y_c(t,1)=l1*sin(q_c(t,1));
     p2x_c(t,2)=p1x_c(t,1)+l2*cos(q_c(t,1)+q_c(t,2));
     p2y_c(t,2)=p1y_c(t,1)+l2*sin(q_c(t,1)+q_c(t,2));
     rx1_c=[0,p1x_c(t,1),p_c(t,1)];
     ry1_c=[0,p1y_c(t,1),p_c(t,2)];
     viscircles([0.5,0.2],0.2,'color','b')
     h2=plot(rx1_c,ry1_c,'color','r');
     hold on
     grid on;
     axis([-0.5 1 -0.5 0.5]);
     drawnow;
%      delete(h2);
end
end
     