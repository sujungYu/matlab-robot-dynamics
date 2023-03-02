function[]=su_14_2()
l1=1; l2=1; %링크 길이 
T=10; dt=0.01; TT=T/dt; 
q(1,:)=[135 -90];
d_q(1,:)=[0 0];
dd_q(1,:)=[0 0];
for t=1:TT
    %시간에 따른 로봇 말단의 위치
     figure(1)
     p1x(t,1)=l1*cos(q(t,1))
     p1y(t,1)=l1*sin(q(t,1))
     p2x(t,2)=p1x(t,1)+l2*cos(q(t,1)+q(t,2))
     p2y(t,2)=p1y(t,1)+l2*sin(q(t,1)+q(t,2))
     rx=[0,p1x(t,1),p2x(t,2)];
     ry=[0,p1y(t,1),0];
     h1=plot(rx,ry,'color','r');
     hold on
     grid on
     axis([-2 2 -2 2])
     drawnow
     delete(h1)
     %시간에 따른 조인트 각 및 각속도 입력
     dd_q(t+1,:)=0.5;
     d_q(t+1,:)=d_q(t,:)+dd_q(t,:)*dt
     q(t+1,:)=q(t)+d_q(t,:)*dt
end 
    f=1:TT     
    % 시간에 따른 end-effector 위치 변화
    figure(2)
    plot(f,p2x(:,2),'color','b');
    hold on;
    plot(f,p2y(:,2),'color','r');
    hold on;
    xlabel('time')
    ylabel('end-effector pos')
    ff=0:TT
    %시간에 따른 각속도 변화
    figure(3)
    plot(ff,d_q(:,2),'color','b','linewidth',2);
    hold on;
    xlabel('time')
    ylabel('각속도')
end

