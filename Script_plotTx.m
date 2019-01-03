clear
clc

a=importdata('test.dat');
[m,n]=size(a);
y1=a(:,2);
y2=a(:,11);
y3=a(:,21);
y4=a(:,51);
y5=a(:,101);
y6=a(:,601);



x=[0:15/(m-1):15];
figure
plot(x,y1,x,y2,x,y3,x,y4,x,y5,x,y6)
set(gca,'YLim',[min(min(a)),max(max(a))]);
%set(gca,'YLim',[349,395.5]);
%y=a(:,101);
%plot(x,y)
xlabel('æ‡¿Î/km');
ylabel('Œ¬∂»/\circC');