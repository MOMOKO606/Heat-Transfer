clear
clc
%  Script_Work脚本文件功能：
%  Step1.循环热流边界条件，并循环随温度变化的热导率的a，b系数，以莫霍面温度作为
%        约束，反演符合条件的a,b值；
%  Step2.再对反演出的a，b值作拟合；
%  Step3.将拟合曲线与实验室测得的a，b值拟合曲线作对比，最接近的曲线对应的
%        热流值最接近真实热流；
%  Step4.分别输出实验室拟合曲线，反演拟合曲线，散点图以及相关的信息到一副图件
%        中，并储存；
%  Step5.将反演出的a，b以及相应的热流，温度信息存到mat文件中。

%tic
%  打开输入参数窗口
prompt={'a的循环步长：',...
        'b的循环步长：',...
        '莫霍面热流最小值(W/m^2)：',...
        '莫霍面热流最大值(W/m^2)：',...
        '热流循环步长(W/m^2)：',...
        '约束条件——莫霍面温度下限(degC)：',...
        '约束条件——莫霍面温度上限(degC)：'};
name='请输入程序参数';
answer=inputdlg(prompt,name);
%  载入稳态模型
model = mphload('SWIR.mph');
%  赋值实验室测得各类岩石a，b值
alab=[0.13,0.75,0.64,1.18,0.70];
blab=[1073,705,807,474,770];
%  线性拟合
p=polyfit(alab,blab,1);
%  x为绘图所用的a值
x=[0:0.1:1.5];
%  y为绘图所用的实验室b值
y=polyval(p,x);
%  定义热流边界条件
q0min=str2num(answer{3,1});
q0max=str2num(answer{4,1});
q0step=str2num(answer{5,1});
nq0=((q0max-q0min)/q0step)+1;
q0S=[q0min:q0step:q0max];
%  选取5个地幔边界坐标
list=[0,3308,7500,11235,15000;-12300,-12140,-12050,-11840,-11700];
%  反演约束：地幔温度上下限
Tmen_low=str2num(answer{6,1});
Tmen_high=str2num(answer{7,1});
%  给a，b循环步长赋值
astep=str2num(answer{1,1});
bstep=str2num(answer{2,1});
for i=1:nq0
   output=[];  
   k=1;
   %  修改模型参数——热流边界
   model.physics('ht').feature('hf1').set('q0',q0S(i)); 
   for a=0.1:astep:1.5
       %  修改模型参数——热导率中的a值
       model.param.set('a', a);
       for b=0:bstep:1500
           Tsum=0;
           %  修改模型参数——热导率中的b值
           model.param.set('b', b);
           %  计算模型
           model.sol('sol1').run;    
           %  提取边界坐标上的温度值
           T = mphinterp(model,{'T'},...
                         'coord',list,...
                         't',3.1557E14,...
                         'unit',{'degC'});
           %  平均边界温度值          
           Tsum=mean(T);
           %  以莫霍面温度作为约束，筛选a，b
           if (Tsum <= Tmen_high & Tsum >= Tmen_low)
               output(k,:)=[a,b,Tsum];  
               k=k+1;
           end
       end
   end
   %  保存符合条件的a,b,边界热流，边界温度
   if (~isempty(output))
       %  统计反演的a，b值
       aa=output(:,1);
       bb=output(:,2);
       Tr=output(:,3);
       Tr=mean(Tr);
       %  对反演出的a，b值做拟合
       p=polyfit(aa,bb,1);
       %  y1为绘图所用的拟合b值
       y1=polyval(p,x);
       %  求实验室数据到拟合直线的距离d
       d=abs(blab-p(1)*alab-p(2))/sqrt(1+p(1)^2);
       d=mean(d);
       %  绘图
       h=figure;
       plot(x,y,x,y1,'--',...
            0.73,1293,'o',...
            0.13,1073,'square',...
            0.75,705,'^',...
            0.64,807,'x',...
            1.18,474,'+',...
            0.7,770,'*');
        %  修改坐标范围
        axis([0 1.5 0 1500]);
        xlabel('a','FontSize',12);
        ylabel('b','FontSize',12,'Rotation',0);
        title(['heat flux=',num2str(q0S(i)),' W/m^2'],'FontSize',12);
        text(1.1,1350,['d=',num2str(d)],'FontSize',12);
        text(1.1,1200,['T=',num2str(Tr,6),' ℃'],'FontSize',12);
        hold on
        scatter(aa,bb,3,'filled');
        saveas(gcf,[num2str(q0S(i)),'.fig'],'fig');
        close(h)
        save(['heat flux=',num2str(q0S(i)),'.mat'],'output')
   end
end
%  从服务器中移除稳态模型
ModelUtil.remove('model');  
%toc
