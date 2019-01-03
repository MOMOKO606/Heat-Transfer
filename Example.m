clear
clc

A=[1.486,3.059,0.1;2.121,4.041,0.1;2.570,3.959,0.1;3.439,4.396,0.1; 4.505,3.012,0.1;3.402,1.604,0.1;2.570,2.065,0.1;2.150,1.970,0.1; 1.794,3.059,0.2;2.121,3.615,0.2;2.570,3.473,0.2;3.421,4.160,0.2; 4.271,3.036,0.2;3.411,1.876,0.2;2.561,2.562,0.2;2.179,2.420,0.2; 2.757,3.024,0.3;3.439,3.970,0.3;4.084,3.036,0.3;3.402,2.077,0.3; 2.879,3.036,0.4;3.421,3.793,0.4;3.953,3.036,0.4;3.402,2.219,0.4; 3.000,3.047,0.5;3.430,3.639,0.5;3.822,3.012,0.5;3.411,2.385,0.5; 3.103,3.012,0.6;3.430,3.462,0.6;3.710,3.036,0.6;3.402,2.562,0.6; 3.224,3.047,0.7;3.411,3.260,0.7;3.542,3.024,0.7;3.393,2.763,0.7];
x=A(:,1);
y=A(:,2);
z=A(:,3);

xi=linspace(min(x),max(x),50);
yi=linspace(min(y),max(y),50);

%scatter(x,y,5,z)%散点图
%[X,Y,Z]=griddata(x,y,z,linspace(1.486,4.271)',linspace(1.604,4.276),'v4');%插值
%figure,pcolor(X,Y,Z);shading interp%伪彩色图
%figure,contourf(X,Y,Z) %等高线图
%figure,surf(X,Y,Z)%三维曲面