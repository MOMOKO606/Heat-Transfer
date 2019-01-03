clear
clc

a=importdata('图3.mat');
y1=a(:,1);
y2=a(:,2);
x=[0:0.01:(length(a)-1)*0.01];
figure,box off

yy1=(y1-min(y1))/(max(y1)-min(y1));
yy2=(y2-min(y2))/(max(y2)-min(y2));

plot(x,yy1,x,yy2,'--'),grid on
set(gca,'YLim',[-0.1,1.1]);
xlabel('时间/ma');
ylabel('归一化温度');