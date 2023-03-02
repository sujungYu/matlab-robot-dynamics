function []=su_14_3()
clear all;
close all;
clc;

l1=2; l2=1; %링크 길이 
T=2; dt=0.1; TT=T/dt;
%각속도 변화
for t=1:TT/4
    d_q(t)=0.5;
    d_q(t+5)=1;
    d_q(t+10)=1;
    d_q(t+15)=-0.5;
end
%end-effector 위치
for t=1:TT
    p_l(t,:)=[t 1];
end
% 역기구학 수식
for t=1:TT
    c_l(t,2)=(p_l(t,1)^2+p_l(t,2)^2-l1^2-l2^2)/(2*l1*l2)*pi/180;
    s_l(t,2)=sqrt(c_l(t,2)^2)*pi/180;
    c_l(t,1)=(((l1+l2*c_l(t,2))*p_l(t,1)+l2*s_l(t,2)*p_l(t,2))/(p_l(t,1)^2+p_l(t,2)^2))*pi/180;
    s_l(t,1)=(((l1+l2*c_l(t,2))*p_l(t,2)-l2*s_l(t,2)*p_l(t,1))/(p_l(t,1)^2+p_l(t,2)^2))*pi/180;
end
% theta1 theta2 
for t=1:TT
    q_l(t,2)=atan2(s_l(t,2),c_l(t,2))+d_q(t)*dt
    q_l(t,1)=atan2(s_l(t,1),c_l(t,1))+d_q(t)*dt
end
%end-effector 직선 그래프
 for t=1:TT
     figure(1)
     p1x_l(t,1)=l1*cos(q_l(t,1));
     p1y_l(t,1)=l1*sin(q_l(t,1));
     p2x_l(t,2)=p1x_l(t,1)+l2*cos(q_l(t,1)+q_l(t,2));
     p2y_l(t,2)=p1y_l(t,1)+l2*sin(q_l(t,1)+q_l(t,2));
     rx_l=[0,p1x_l(t,1),p_l(t,1)];
     ry_l=[0,p1y_l(t,1),p_l(t,2)];
     h1=plot(rx_l,ry_l,'color','r');
     line([0,p_l(t,1)],[p_l(t,2),p_l(t,2)],'color','b')
     hold on
     grid on;
      axis([0 20 -0.5 1]);
     drawnow;
%      delete(h1);
 end
end
