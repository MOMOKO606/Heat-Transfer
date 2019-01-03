clear
clc
%  Script_Work�ű��ļ����ܣ�
%  Step1.ѭ�������߽���������ѭ�����¶ȱ仯���ȵ��ʵ�a��bϵ������Ī�����¶���Ϊ
%        Լ�������ݷ���������a,bֵ��
%  Step2.�ٶԷ��ݳ���a��bֵ����ϣ�
%  Step3.�����������ʵ���Ҳ�õ�a��bֵ����������Աȣ���ӽ������߶�Ӧ��
%        ����ֵ��ӽ���ʵ������
%  Step4.�ֱ����ʵ����������ߣ�����������ߣ�ɢ��ͼ�Լ���ص���Ϣ��һ��ͼ��
%        �У������棻
%  Step5.�����ݳ���a��b�Լ���Ӧ���������¶���Ϣ�浽mat�ļ��С�

%tic
%  �������������
prompt={'a��ѭ��������',...
        'b��ѭ��������',...
        'Ī����������Сֵ(W/m^2)��',...
        'Ī�����������ֵ(W/m^2)��',...
        '����ѭ������(W/m^2)��',...
        'Լ����������Ī�����¶�����(degC)��',...
        'Լ����������Ī�����¶�����(degC)��'};
name='������������';
answer=inputdlg(prompt,name);
%  ������̬ģ��
model = mphload('SWIR.mph');
%  ��ֵʵ���Ҳ�ø�����ʯa��bֵ
alab=[0.13,0.75,0.64,1.18,0.70];
blab=[1073,705,807,474,770];
%  �������
p=polyfit(alab,blab,1);
%  xΪ��ͼ���õ�aֵ
x=[0:0.1:1.5];
%  yΪ��ͼ���õ�ʵ����bֵ
y=polyval(p,x);
%  ���������߽�����
q0min=str2num(answer{3,1});
q0max=str2num(answer{4,1});
q0step=str2num(answer{5,1});
nq0=((q0max-q0min)/q0step)+1;
q0S=[q0min:q0step:q0max];
%  ѡȡ5����ᣱ߽�����
list=[0,3308,7500,11235,15000;-12300,-12140,-12050,-11840,-11700];
%  ����Լ��������¶�������
Tmen_low=str2num(answer{6,1});
Tmen_high=str2num(answer{7,1});
%  ��a��bѭ��������ֵ
astep=str2num(answer{1,1});
bstep=str2num(answer{2,1});
for i=1:nq0
   output=[];  
   k=1;
   %  �޸�ģ�Ͳ������������߽�
   model.physics('ht').feature('hf1').set('q0',q0S(i)); 
   for a=0.1:astep:1.5
       %  �޸�ģ�Ͳ��������ȵ����е�aֵ
       model.param.set('a', a);
       for b=0:bstep:1500
           Tsum=0;
           %  �޸�ģ�Ͳ��������ȵ����е�bֵ
           model.param.set('b', b);
           %  ����ģ��
           model.sol('sol1').run;    
           %  ��ȡ�߽������ϵ��¶�ֵ
           T = mphinterp(model,{'T'},...
                         'coord',list,...
                         't',3.1557E14,...
                         'unit',{'degC'});
           %  ƽ���߽��¶�ֵ          
           Tsum=mean(T);
           %  ��Ī�����¶���ΪԼ����ɸѡa��b
           if (Tsum <= Tmen_high & Tsum >= Tmen_low)
               output(k,:)=[a,b,Tsum];  
               k=k+1;
           end
       end
   end
   %  �������������a,b,�߽��������߽��¶�
   if (~isempty(output))
       %  ͳ�Ʒ��ݵ�a��bֵ
       aa=output(:,1);
       bb=output(:,2);
       Tr=output(:,3);
       Tr=mean(Tr);
       %  �Է��ݳ���a��bֵ�����
       p=polyfit(aa,bb,1);
       %  y1Ϊ��ͼ���õ����bֵ
       y1=polyval(p,x);
       %  ��ʵ�������ݵ����ֱ�ߵľ���d
       d=abs(blab-p(1)*alab-p(2))/sqrt(1+p(1)^2);
       d=mean(d);
       %  ��ͼ
       h=figure;
       plot(x,y,x,y1,'--',...
            0.73,1293,'o',...
            0.13,1073,'square',...
            0.75,705,'^',...
            0.64,807,'x',...
            1.18,474,'+',...
            0.7,770,'*');
        %  �޸����귶Χ
        axis([0 1.5 0 1500]);
        xlabel('a','FontSize',12);
        ylabel('b','FontSize',12,'Rotation',0);
        title(['heat flux=',num2str(q0S(i)),' W/m^2'],'FontSize',12);
        text(1.1,1350,['d=',num2str(d)],'FontSize',12);
        text(1.1,1200,['T=',num2str(Tr,6),' ��'],'FontSize',12);
        hold on
        scatter(aa,bb,3,'filled');
        saveas(gcf,[num2str(q0S(i)),'.fig'],'fig');
        close(h)
        save(['heat flux=',num2str(q0S(i)),'.mat'],'output')
   end
end
%  �ӷ��������Ƴ���̬ģ��
ModelUtil.remove('model');  
%toc
