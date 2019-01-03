clear
clc

a=importdata('test.dat');
a=a';
x=[0:0.01:(length(a)-1)*0.01];
figure,box off
plot(x,a),grid on
%set(gca,'YLim',[min(a),max(a)]);
xlabel('Ê±¼ä/ma');
ylabel('ÎÂ¶È/¡ãC');