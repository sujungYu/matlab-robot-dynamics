function []=su_14_3_3()
clear all;
close all;
clc;

l1=1.5; l2=0.5; %링크 길이 
T=2; dt=0.1; TT=T/dt;

for t=1:TT/4
    d_q(t)=0.5;
    d_q(t+5)=1;
    d_q(t+10)=1;
    d_q(t+15)=-0.5;
end
for t=1:TT/4
    %사각형
    p_s(t,:)=[t+1,1];
    p_s(t+5,:)=[1,t+1];
    p_s(t+10,:)=[-t+6,6];
    p_s(t+15,:)=[1,-t+6];
end
for t=1:TT
    c_s(t,2)=(p_s(t,1)^2+p_s(t,2)^2-l1^2-l2^2)/(2*l1*l2);
    s_s(t,2)=sqrt(c_s(t,2)^2);
    c_s(t,1)=(((l1+l2*c_s(t,2))*p_s(t,1)+l2*s_s(t,2)*p_s(t,2))/(p_s(t,1)^2+p_s(t,2)^2));
    s_s(t,1)=(((l1+l2*c_s(t,2))*p_s(t,2)-l2*s_s(t,2)*p_s(t,1))/(p_s(t,1)^2+p_s(t,2)^2));
end
for t=1:TT
    q_s(t,2)=atan2(s_s(t,2)*pi/180,c_s(t,2)*pi/180)+d_q(t)*dt;
    q_s(t,1)=atan2(s_s(t,1)*pi/180,c_s(t,1)*pi/180)+d_q(t)*dt;
end
for t=1:TT
     p1x_s(t,1)=l1*cos(q_s(t,1));
     p1y_s(t,1)=l1*sin(q_s(t,1));
     p2x_s(t,2)=p1x_s(t,1)+l2*cos(q_s(t,1)+q_s(t,2));
     p2y_c(t,2)=p1y_s(t,1)+l2*sin(q_s(t,1)+q_s(t,2));
     rx1_s=[0,p1x_s(t,1),p_s(t,1)];
     ry1_s=[0,p1y_s(t,1),p_s(t,2)];
     line([1,6],[1,1],'color','b');
     line([6,6], [1,6],'color','b');
     line([1,6],[6,6],'color','b');
     line([1,1],[6,1],'color','b')
     h2=plot(rx1_s,ry1_s,'color','r');
     hold on
     grid on;
     axis([0 7 -1 7]);
     drawnow;
%      delete(h2);
end
end