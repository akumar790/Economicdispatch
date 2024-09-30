%Economic dispatch with quadratic costs 
%Quadprog needs min0.5*x'*H*x + f'x
clear all
B=[
    13.3    -5       0      -5     -3.3      0;
    -5     27.3    -4      -10    -3.3     -5;
    0      -4     17.84     0     -3.84    -10;
    -5     -10      0     17.5    -2.5      0;
    -3.3   -3.3   -3.84   -2.5     16.24  -3.3; 
    0      -5     -10       0     -3.3     18.3
    ];

H= [106.6 0 0 0 0 0 0 0 0 0 0 0;
    0 177.8 0 0 0 0 0 0 0 0 0 0;
    0 0 148.2 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0];

f=[1166.9;1033.3;1083.3;0;0;0;0;0;0;0;0;0];
MinAMatrix=diag([-1, -1, -1 ]);
ZeroMat=zeros(3);

xx=[-1 0 0 0 0 0;
      0 -1 0 0 0 0;
      0 0 -1 0 0 0;
      0 0 0 0 0 0;
      0 0 0 0 0 0;
      0 0 0 0 0 0];
Aeq=[xx B;0 0 0 0 0 0 1 0 0 0 0 0];
beq=[0;0;0;-1;-1;-1;0];

%use lower and upper bounds 
lb=[0.5 0.375 0.45 -inf -inf -inf -inf -inf -inf -inf -inf -inf]';
ub=[2.0 1.500 1.80 inf inf inf inf inf inf inf inf inf]';
Azz=[0 0 0 -5 0 0;
    0 0 0 5 0 0;
    0 10 0 -10 0 0;
    0 -10 0 10 0 0;
    0 0 -10 0 0 10;
     0 0 10 0 0 -10;
     0 0 0 2.5 -2.5 0;
     0 0 0 -2.5 2.5 0];
A=[zeros(8,6) Azz];
b=[1;1;0.6;0.6;0.6;0.6;0.7;0.7];

[x, fvalx, existflag, output, lambda] = quadprog(H, f, A, b, Aeq, beq, lb, ub);% for q2
%[x, fvalx, existflag, output, lambda] =quadprog(H, f, [], [], Aeq, beq, lb, ub);%q1
x
lambda.eqlin
