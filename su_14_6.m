function[]=su_14_6()
l1=1; l2=0.5;
m1=5; m2=3;
T=20; dt=0.01; TT=T/dt;
q(1,1)=20; q(1,2)=30;
d_q(1,1)=0; d_q(1,2)=0;
dd_q(1,1)=0; dd_q(1,2)=0;

for t=1:TT
      tau1(t)=0;
      tau2(t)=0;
      tau=[tau1(t) tau2(t)];
      tau_t=transpose(tau);
      
      H11(t)=m1*l1^2+m2*l1^2+m2*l2^2+2*m2*l1*l2*cos(q(t,2)*pi/180);
      H12(t)=m2*l2^2+m2*l1*l2*cos(q(t,2)*pi/180);
      H21(t)=H12(t);
      H22(t)=m2*l2^2;
      H=[H11(t) H12(t); H21(t) H22(t)];
      H_inv=inv(H);
  
      C1(t)=-2*m2*l1*l2*sin(q(t,2)*pi/180);
      C2(t)=m2*l1*l2*sin(q(t,2)*pi/180);
      C=[C1(t) C2(t)];
      C_t=transpose(C);
      
      g=9.8;
      G1=m1*g*l1*cos(q(t,1)*pi/180)+m2*g*(l1*cos(q(t,1)*pi/180)+l2*cos(q(t,1)*pi/180+q(t,2)*pi/180));
      G2=m2*g*l2*cos(q(t,1)*pi/180+q(t,2)*pi/180);
      G=[G1 G2];
      G_t=transpose(G);
   
      dd_q(t+1,:)=H_inv*(tau_t-C_t-G_t);
      d_q(t+1,:)=d_q(t)+dd_q(t)*dt;
      q(t+1,:)=q(t)+d_q(t)*dt;
      
      figure(1)
      p1x(t,1)=l1*cos(q(t,1)*pi/180);
      p1y(t,1)=l1*sin(q(t,1)*pi/180);
      p2x(t,2)=p1x(t,1)+l2*cos(q(t,1)*pi/180+q(t,2)*pi/180);
      p2y(t,2)=p1y(t,1)+l2*sin(q(t,1)*pi/180+q(t,2)*pi/180);
      rx=[0,p1x(t,1),p2x(t,2)];
      ry=[0,p1y(t,1),p2y(t,2)];
      h1=plot(p2x(t,2),p2y(t,2),'bo');
      hold on;
      h2=plot(rx,ry,'color','r','linewidth',2);
      hold on
      grid on
      axis([-2 2 -2 1])
      drawnow
      delete(h1)
      delete(h2)
end
end

