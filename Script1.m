clear
clc

A=importdata('��̬�¶Ƚ��.dat');
n=length(A);
x=A(:,1);
y=A(:,2);
z=A(:,3);
%xi=linspace(min(x),max(x),n/2);
%yi=linspace(min(y),max(y),n/2);
%[xi,yi]=meshgrid(xi,yi);
%[X,Y,Z]=griddata(x,y,z,xi',yi,'v4');




%mesh(xi,yi,zi);
figure,scatter(x,y,5,z);   %  ɢ��ͼ    
%pcolor(X,Y,Z);shading interp%α��ɫͼ
%figure,contourf(X,Y,Z) %�ȸ���ͼ
%figure,surf(X,Y,Z)%��ά����

%for k=1:4
%    i=a(k,1);
%    j=a(k,2);
%    t(i,j)=a(k,3);
%end


%a=importdata('��̬�¶Ƚ��.dat');
%for k=1:length(a)
%    i=a(k,1);
%    j=a(k,2);
%    T(i,j)=a(k,3);
%end