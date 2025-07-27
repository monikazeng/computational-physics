clear
phi(1) = single(1)
phi(2) = (sqrt(5)-1)/2;
for i = 3:20
    phi(i) = phi(i-2) - phi(i-1);
end
plot(phi)


phim(1)=single(1);
phim(2)=(sqrt(5)-1)/2;
for i = 3:20
    phim(i)=phim(i-1) * phim(2);
end
hold on
plot(phim)

figure;


for i = 1:20
    relativediff(i) = abs((phi(i)-phim(i))/phim(i));
end
hold off
% plot(relativediff)
semilogy(relativediff)




