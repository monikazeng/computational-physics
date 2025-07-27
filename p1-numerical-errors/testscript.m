phi(1)=single(1);
phi(2)=(sqrt(5)-1)/2;
phim(1)=phi(1);
phim(2)=phi(2);
relerr(1)=(phim(1)-phi(1))/phim(1);
relerr(2)=(phim(2)-phi(2))/phim(2);
for i=3:40
    phi(i)=phi(i-2)-phi(i-1);
    phim(i)=phim(i-1)*phim(2);
    relerr(i)=(phim(i)-phi(i))/phim(i);
end
hold off
semilogy(abs(phi))
hold on
semilogy(abs(phim))
hold off
figure
semilogy(abs(relerr))