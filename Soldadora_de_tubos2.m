k=50; % Cantidad de valores a considerar
R=linspace(1,8,k);
r=linspace(1,8,k);
theta=pi/2; %Cambiar antes de ejecutar según el ángulo deseado

dx= @(t,r0) r0^2*sin(t).^2;
dy= @(t,r0,R0) (r0^4*cos(t).^2.*sin(t).^2)./(R0^2-r0^2*cos(t).^2);

l=@(t,r0,R0,theta0) cos(theta0)/sin(theta0)*(r0^2*cos(t).*sin(t))./(sqrt(R0^2-r0^2*cos(t).^2))-r0/cos(theta0)*cos(t);
dz=@(t,r0,R0,theta0) l(t,r0,R0,theta0).^2;

cnorm=@(t,r0,R0,theta0) sqrt(dx(t,r0)+dy(t,r0,R0)+dz(t,r0,R0,theta0));

M=zeros(k);

for i = 1:k
    for j = 1:k
        if i >= j
            M(i,j)=integral(@(t) cnorm(t,r(j)/2,R(i)/2,theta),0,2*pi);
        end
    end
end

s=surf(r,R,M);
title('Longitud de soldadura segun los radios (angulo='+string(theta)+' radianes)')
xlabel('Radio Menor (cm)')
ylabel('Radio Mayor (cm)')
zlabel('Longitud de la soldadura (cm)')
s.EdgeColor="none";