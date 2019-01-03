clc
clear

a=importdata('1.dat');
x=a(:,1);
y=a(:,2);
p1=polyfit(x,y,5);
y1=polyval(p1,x);

%p5=polyfit(x,y,5);
%y5=polyval(p5,x);

plot(x,y,x,y1,'r');