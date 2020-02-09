clc,clear
syms f(x,y)
f(x,y) = (sin(y)*(exp(1-cos(x))^2))+(cos(x)*(exp(1-sin(y))^2))+(x-y)^2;
eps = 1e-6; %termination
alpha = 1; %reflection
gamma = 0.5; %contraction
beta = 2; %expansion
segma = 0.5; %shrink
n = 3;
% inetialization
X = [-1,-5,0;-4,-1,0;-1,-6,0];
ter=0;
iter = 0;
figure
fcontour(f,[-10 0])
hold on
for i = 1:n
X(i,3) = double(f(X(i,1),X(i,2)));
end
while ter==0
iter = iter+1;
if ((X(1,1)+5)^2)+((X(1,2)+5)^2) > 25
    X(1,1) = -X(1,1)
    X(1,2) = -X(1,2)
end
% sorting
X = sortrows(X,3);
% calculationg centroid
line([X(1,1),X(2,1)], [X(1,2), X(2,2)],'Color','blue');
hold on
line([X(2,1),X(3,1)], [X(2,2), X(3,2)],'Color','blue');
hold on
line([X(3,1),X(1,1)], [X(3,2), X(1,2)],'Color','blue');
hold on
Xcen(1,1) = sum(X(1:2,1))/(n-1);
Xcen(1,2) = sum(X(1:2,2))/(n-1);
Xcen(1,n) = double(f(Xcen(1,1),Xcen(1,2)));

%reflection
Xr(1,1) = Xcen(1,1)+alpha*(Xcen(1,1)-X(3,1));
Xr(1,2) = Xcen(1,2)+alpha*(Xcen(1,2)-X(3,2));
Xr(1,3) = double(f(Xr(1,1),Xr(1,2)));

Xcomp = X;
Xcomp(4,1) =  Xr(1,1);
Xcomp(4,2) =  Xr(1,2);
Xcomp(4,3) =  Xr(1,3);
Xcomp = sortrows(Xcomp,3);

if Xcomp(2,1) == Xr(1,1) && Xcomp(2,2) == Xr(1,2)
    X(3,:) = Xr(1,:);
    continue
end

if Xcomp(1,1) == Xr(1,1) && Xcomp(1,2) == Xr(1,2)
%expansion
Xe(1,1) = Xcen(1,1)+beta*(Xr(1,1)-Xcen(1,1));
Xe(1,2) = Xcen(1,2)+beta*(Xr(1,2)-Xcen(1,2));
Xe(1,3) = double(f(Xe(1,1),Xe(1,2)));
if Xe(1,3) < Xr(1,3)
    X(3,:) = Xe(1,:);
    continue
else
    X(3,:) = Xr(1,:);
    continue
end
end

%contraction
Xc(1,1) = Xcen(1,1)+gamma*(X(3,1)-Xcen(1,1));
Xc(1,2) = Xcen(1,2)+gamma*(X(3,2)-Xcen(1,2));
Xc(1,3) = double(f(Xc(1,1),Xc(1,2)));
if Xc(1,3) < X(3,3)
    X(3,:) = Xc(1,:);
    continue
end



X = sortrows(X,3);
%shrink
for i=2:n
    Xs(i,1) = X(1,1) + segma*(X(i,1) - X(1,1));
end
for i=2:n
    Xs(i,2) = X(1,2) + segma*(X(i,2) - X(1,2));
end
for i=2:n
    Xs(i,3) = double(f(Xs(i,1),Xs(i,2)));
end

Xs = sortrows(Xs,3);
X = Xs;


if abs(X(1,3)-X(2,3)) < eps
    ter =1;
end

end
X(1,:)
iter