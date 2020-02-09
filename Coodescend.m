clc,clear
syms f(x,y)
f(x,y) = (sin(y)*(exp(1-cos(x))^2))+(cos(x)*(exp(1-sin(y))^2))+(x-y)^2;
G = jacobian(f, [x, y]);
alpha = 0.005;
eps=1e-6;
ter=0;
iter=0;
X = [-1,-5];
figure
fcontour(f,[-10 0])
hold on
while ter==0
iter=iter+1;
Grad = G(X(1,1),X(1,2));
Gradx = double(Grad(1,1));
Grady = double(Grad(1,2));
Xl = X;
X(1,1) = X(1,1) - alpha*Gradx;
X(1,2) = X(1,2) - alpha*Grady;
if(immse(Xl,X)) < eps
    ter=1;
end
line([X(1,1),Xl(1,1)], [X(1,2), Xl(1,2)],'Color','red');
hold on
end
X
V = double(f(X(1,1),X(1,2)))
iter