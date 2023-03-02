function[]=su_14_4()
l1=1; l2=0.5;
m1=3; m2=2;
T=5; dt=0.01; TT=T/dt;
q(1,1)=135; q(1,2)=-90;
d_q(1,1)=0; d_q(1,2)=0;
dd_q(1,1)=0; dd_q(1,2)=0;
for t=1:TT/4
    %2.5초에 한번씩 외란발생
    d(t)=0;
    d(t+125)=1;
    d(t+250)=0;
    d(t+375)=1;
end

for t=1:TT
     %토크 입력 변화
      tau1(t)=1*sin(t);
      tau2(t)=2*sin(t);
      %입력값 
      tau=[tau1(t)+d(t) tau2(t)+d(t)];
      tau_t=transpose(tau);
      
      %시간 변화에 따른 관성력 변화
      H11(t)=m1*l1^2+m2*l1^2+m2*l2^2+2*m2*l1*l2*cos(q(t,2)*pi/180);
      H12(t)=m2*l2^2+m2*l1*l2*cos(q(t,2)*pi/180);
      H21(t)=H12(t);
      H22(t)=m2*l2^2;
      H=[H11(t) H12(t); H21(t) H22(t)];
      H_inv=inv(H);
  
      %시간 변화에 따른 코리올리, 원심력 변화
      C1(t)=-2*m2*l1*l2*sin(q(t,2)*pi/180);
      C2(t)=m2*l1*l2*sin(q(t,2)*pi/180);
      C=[C1(t) C2(t)];
      C_t=transpose(C);
      
      %시간 변화에 따른 중력 변화
      g=9.8;
      G1=m1*g*l1*cos(q(t,1))+m2*g*(l1*cos(q(t,1))+l2*cos(q(t,1)+q(t,2)));
      G2=m2*g*l2*cos(q(t,1)+q(t,2));
      G=[G1 G2];
      G_t=transpose(G);
      
      %시간변화에 따른 각가속도, 각속도, 속도 변화
      dd_q(t+1,:)=H_inv*(tau_t-C_t-G_t);
      d_q(t+1,:)=d_q(t)+dd_q(t)*dt;
      q(t+1,:)=q(t)+d_q(t)*dt;
      
      %그래프 출력
      figure(2)
      p1x(t,1)=l1*cos(q(t,1));
      p1y(t,1)=l1*sin(q(t,1));
      p2x(t,2)=p1x(t,1)+l2*cos(q(t,1)+q(t,2));
      p2y(t,2)=p1y(t,1)+l2*sin(q(t,1)+q(t,2));
      rx=[0,p1x(t,1),p2x(t,2)];
      ry=[0,p1y(t,1),p2y(t,2)];
      h1=plot(p2x(t,2),p2y(t,2),'bo');
      hold on;
      h2=plot(rx,ry,'color','r','linewidth',2);
      hold on
      grid on
      axis([-2 2 -2 1]);
      drawnow
       delete(h1);
       delete(h2);
end
end
    