phi(1,1)=single(1);
phi(2,1)=(sqrt(5)-1)/2;
phi(1,2)=phi(1,1);
phi(2,2)=phi(2,1);
phi(3,1)=0;
phi(3,2)=0;
phi(1,4)=phi(1,1);
phi(2,4)=-(sqrt(5)+1)/2;
phi(1,5)=phi(1,1)/phi(1,4);
phi(2,5)=phi(2,1)/phi(2,4);
for i=3:50
    phi(i,1)=phi(i-2,1)-phi(i-1,1);
    phi(i,2)=phi(i-1,2)*phi(2,2);
    phi(i,3)=(phi(i,2)-phi(i,1))/phi(i,2);
    phi(i,4)=phi(i-2,4)-phi(i-1,4);
    phi(i,5)=phi(i,1)/phi(i,4);
end
%
figure(1)
hold off
semilogy(abs(phi(:,1)))
hold on
semilogy(phi(:,2))
title('|\phi_r| and \phi_m')
xlabel('n')
ylabel('\phi^n')
%
figure(2)
hold off
semilogy(abs(phi(:,4)))
title('$\tilde\phi$','Interpreter','latex')
xlabel('n')
ylabel('|\phi^n|')
%
figure(3)
hold off
semilogy(abs(phi(:,5)))
title('$\phi_r/\tilde\phi$','Interpreter','latex','FontSize',16)
xlabel('n')
