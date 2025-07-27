%v0i = 1;
nu = 1;
k = 2;
eps = 1.e-5;
omega = 1.0;

global Nx
global Ny
global dx
global dy
global npl
global npr
global npt
global v0i

v0 = 6;
v0i = 1;
WT = 2; % height to width ratio of half plate
UW = 5; % Ratio of upstream distance to plate width
DW = 6; % Ratio of downstream distance to plate width
HT = 5; % Ratio of domain height to plate height

% Base discretization scale
Nc = int16(2); % Zones in plate width
Ne = int16(Nc*UW); % Zones in upstring segment
Na = int16(Nc*DW); % Zones in downstream segment
Ng = Ne + Nc + Na; % Zones in the x direction
Nb = int16(Nc*WT); % Zones in plate height
Nf = int16(Nb*HT); % zones in y direction

%Computational Domain
Nx = k*Ng + 1;
Ny = k*Nf + 1;
% discretization lengths
dx = 1.0/double(k);
dy = 1.0/double(k);
% Grid boundaries and vertex locations
Xmin = double(0.0);
Xmax = double(Nx-1)*dx;
Ymin = double(0.0);
Ymax = double(Ny-1)*dy;
x = Xmin:dx:Xmax;
y = Ymin:dy:Ymax;
[yg,xg]=meshgrid(y,x);
% Plate boundary indices
npl = k*Ne+1; %index of left plate face
npr = npl+k*Nc; %index of right plate face
npt = k*Nb+1; %index of top plate face
% Initialize solution grids
v = zeros(Nx,Ny,2); %v(i,j,1) is the stream function, v(i,j,2) is the vorticity

%Set the initial value for psi = v*y inside the grid
for i=2:npl-1
    for j=2:npt
        v(i,j,1)=v0i*y(j);
    end
end
for i=npr+1:Nx-1
    for j=2:npt
        v(i,j,1)=v0i*y(j);
    end
end
for i=2:Nx-1
    for j=npt+1:Ny-1
        v(i,j,1)=v0i*y(j);
    end
end
%The initial value for Xi is just zero.
%Set the initial value on the boundary.
v = Dirichlet(v);
rho = source(v);
res1 = residual1(v);
res2 = residual2(v,rho,nu);
figure(4)
surface(xg,yg,res1)
view(-35,45)
figure(5)
surface(xg,yg,res2)
view(-35,45)

for n = 1:((v0-1)*10+1)
    v0i = 1+(n-1)*0.1;
for l = 1:10000
    v(:,:,1) = SOR1(v,2,npl-1,2,npt,omega);
    v(:,:,1) = SOR1(v,npr+1,Nx-1,2,npt,omega);
    v(:,:,1) = SOR1(v,2,Nx-1,npt+1,Ny-1,omega);
    v = Dirichlet(v);
    %rho = source(v);
    v(:,:,2)=SOR2(v,2,npl-1,2,npt,nu,omega);
    v(:,:,2)=SOR2(v,npr+1,Nx-1,2,npt,nu,omega);
    v(:,:,2)=SOR2(v,2,Nx-1,npt+1,Ny-1,nu,omega);
    v = Dirichlet(v);
    res1 = residual1(v);
    rho = source(v);
    res2 = residual2(v,rho,nu);
    resnorm1 = norm(res1)/sqrt(dx*dy);
    resnorm2 = norm(res2)/sqrt(dx*dy);
    if mod(l,100) == 0
        fprintf('|res1| = %g\n',resnorm1);
        fprintf('|res2| = %g\n',resnorm2);
        fprintf('v = %g\n',v0i);
        
        figure(1)
        %         dc = (psimax+3.0)/20;
        %         cl = log10(-3.0:dc:psimax);
        %         cl2 = -psimax:dc:3.0;
        %         c = cat(2,cl2,0,cl);
        %         c = 10.0*c;
        psimax = max(v(:,Ny,1));
        cl = logspace(0,1,10);
        cl = (cl - 1)*psimax/10;
        c = cat(2,-cl,0,cl);
        contour(xg,yg,v(:,:,1),c)
        rectangle('Position',[k*Ne*dx 0 k*Nc*dx k*Nb*dy],'FaceColor',[0.9 .9 .9]);
        title("Contour of Psi")
        figure(2)
        ximax = max(max(abs(v(:,:,2))));
        cl2 = logspace(0,1,20);
        cl2 = (cl2 - 1)*ximax/10;
        c2 = cat(2,-cl2,0,cl2);
        contour(xg,yg,v(:,:,2),c2)
        rectangle('Position',[k*Ne*dx 0 k*Nc*dx k*Nb*dy],'FaceColor',[0.9 .9 .9]);
        title("Contour of Xi")
        [Ey,Ex] = gradient(v(:,:,1),dx,dy);
        %Ex = - Ex;Ey = -Ey;
        figure(3)
        quiver(xg,yg,Ey,-Ex)
        title("Velocity of fluid")
    end
    if resnorm1 < eps && resnorm2 < eps
        fprintf('Stopped at l=%d, |res1| = %g\n, |res2| = %g\n',l,resnorm1,resnorm2)
        break
    end
end
end

%


%Boundary values
function v = Dirichlet(v)
global Nx
global Ny
global dx
global dy
global npl
global npr
global npt
global v0i
% left plane
v(1,:,1) = v(2,:,1);
v(1,:,2) = 0;
% right plane
v(Nx,:,1) = v(Nx-1,:,1);
v(Nx,:,2) = v(Nx-1,:,2);
% top plane
v(:,Ny,1) = v0i*dy + v(:,Ny-1,1);
v(:,Ny,2) = 0;
% bottom plane
v(:,1,1) = 0;
v(:,1,2) = 0;
% left plate surface
for i = 2:npt
    v(npl,i,1) = 0;
    v(npl,i,2) = -2*v(npl-1,i,1)/(dx^2);
end
% top of plate
for i = npl:npr
    v(i,npt,1) = 0;
    v(i,npt,2) = -2*v(i,npt+1,1)/(dy^2);
end
% right side of plate
for i = 2:npt
    v(npr,i,1) = 0;
    v(npr,i,2) = -2*v(npr+1,i,1)/(dx^2);
end
end

%source function
function rho = source(v)
% initialize rho
global Nx
global Ny
rho = zeros(Nx, Ny);
for i = 2:Nx-1
    for j = 2:Ny-1
        rho(i,j) = (v(i,j+1,1)-v(i,j-1,1))*(v(i+1,j,2)-v(i-1,j,2)) - (v(i+1,j,1)-v(i-1,j,1))*(v(i,j+1,2)-v(i,j-1,2));
    end
end
end

%loop for SOR

function v = SOR1(v,xs,xf,ys,yf,omega)
global dx
global dy
%xs is the starting index for x, and xf is the ending index for x.
%ys is the starting index for y, and yf is the ending index for y.
vol = dx*dy;
rx = dy/dx;
ry = dx/dy;
for i=xs:xf
    for j=ys:yf
        delta = rx*(v(i+1,j,1)-2.0*v(i,j,1) + v(i-1,j,1)) + ry*(v(i,j+1,1)-2.0*v(i,j,1) +v(i,j-1,1)) + vol*v(i,j,2);
        v(i,j,1) = v(i,j,1) - omega*delta/(-2.0*(rx+ry));
    end
end
v = v(:,:,1);
end

function v = SOR2(v,xs,xf,ys,yf,nu,omega)
global dx
global dy
%xs is the starting index for x, and xf is the ending index for x.
%ys is the starting index for y, and yf is the ending index for y.
rx = dy/dx;
ry = dx/dy;
for i=xs:xf
    for j=ys:yf
        delta = rx*(v(i+1,j,2)-2.0*v(i,j,2) + v(i-1,j,2)) + ry*(v(i,j+1,2)-2.0*v(i,j,2)+v(i,j-1,2))...
            -(1/(4*nu))*((v(i,j+1,1)-v(i,j-1,1))*(v(i+1,j,2)-v(i-1,j,2)) - (v(i+1,j,1)-v(i-1,j,1))*(v(i,j+1,2)-v(i,j-1,2)));
        v(i,j,2) = v(i,j,2) - omega*delta/(-2.0*(rx+ry));
    end
end
v = v(:,:,2);
end

%Residual for the first equation
function res = residual1(v)
global Nx
global Ny
global dx
global dy
global npl
global npr
global npt
vol = dx*dy;
rx = dy/dx;
ry = dx/dy;
res = - 2.0*(rx+ry)*v(:,:,1) + vol*v(:,:,2);
%Set the residual on the outer boundary to be zero
res(:,1) = 0.0; res(:,Ny)=0.0;res(1,:)=0.0;res(Nx,:)=0.0;

%Calculate the residual inside
for i=2:Nx-1
    for j=2:Ny-1
        res(i,j) = res(i,j) + rx*(v(i+1,j,1)+v(i-1,j,1)) + ry*(v(i,j+1,1)+v(i,j-1,1));
    end
end

%Set the residual on the plate region (including the boundary) to be zero
for i=npl:npr
    for j=1:npt
        res(i,j)=0;
    end
end
end

%Residual for the second equation
function res = residual2(v,rho,nu)
global Nx
global Ny
global dx
global dy
global npl
global npr
global npt
rx = dy/dx;
ry = dx/dy;
res = - 2.0*(rx+ry)*v(:,:,2)-(1/(4*nu))*rho;
%Set the residual on the outer boundary to be zero
res(:,1) = 0.0; res(:,Ny)=0.0;res(1,:)=0.0;res(Nx,:)=0.0;

%Calculate the residual inside
for i=2:Nx-1
    for j=2:Ny-1
        res(i,j) = res(i,j) + rx*(v(i+1,j,2)+v(i-1,j,2)) + ry*(v(i,j+1,2)+v(i,j-1,2));
    end
end

%Set the residual on the plate region (including the boundary) to be zero
for i=npl:npr
    for j=1:npt
        res(i,j)=0;
    end
end
end