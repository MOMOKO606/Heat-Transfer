clear
clc

a=load('�ȵ��ʻ�ͼ����.dat');
h=a(:,1);
h=h./1000;
p1=a(:,2);
p2=a(:,3);
p3=a(:,4);
p4=a(:,5);

figure
plot(p1,h,'b',p2,h,'b',p3,h,'g',p4,h,'g')
grid on
xlabel('�¶� / ��C');
ylabel('��� / km');