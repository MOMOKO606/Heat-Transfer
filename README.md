# Heat-Transfer
Numerical thermal modeling of a magma chamber in the Southwest Indian Ridge (SWIR)，using MATLAB and COMSOL.

## About COMSOL with MATLAB


1. **如何启动？**

开始菜单/桌面双击“COMSOL with MATLAB”，没有图标说明没装上。

解决方法：重新下载双击安装程序，选修复，在选项里要把live……..MATLAB后的路径写上，

例D：/Program files/MATLAB/R2010b

之后桌面会出现COMSOL with MATLAB图标，双击即可。初次使用需要给server一个用户名和密码，例username：BianLong  password：ssvvggk
     
  
**2.COMSOL的菜单“另存为m文件”，此m文件可以记录模型，是一个function，可以自行修改。**

但注意只能通过COMSOL with MATLAB打开。



**3.特别注意：使用中文COMSOL建的模型会出错！！**

|       英文"建模"导出m文件        |   成功   |
| :------------------------------: | :------: |
| **中文"建模"换成英文"导出m文件** | **失败** |

 

**4.有两种方式通过MATLAB对COMSOL模型进行操作：**

方法①. 对COMSOL生成的m function文件进行修改，再通过循环调用该function。

方法②. 使用COMSOL提供的函数直接对模型进行各种操作。

经测试，方法②运行速度比①快的多，建议使用方法②。



**5.常用的函数记录**

```matlab
mphmodellibrary  %open the model library

model = mphload('Stationary_model.mph');  %载入名为Stationary_model.mph的模型

mphgeom(model , 'geom1')  %显示几何模型

mphmesh(model , 'mesh')  %显示划分网格

mphplot(model , 'pg1')  %显示最终结果

model.physics('ht').feature('hf1').set('q0', 1, q0S(i));  %修改模型边界条件q0

model.param.set('a', a);  %修改模型变量a

model.sol('sol1').run;  % 计算模型

%提取坐标为list上的温度值，单位为摄氏度，list一列为一组坐标

 T = mphinterp(model,{'T'},...

​             'coord',list,...

​             'unit',{'degC'});

ModelUtil.remove('model');  % 从服务器中移除模型
```


## The main function in this repository
**<u>STEP1.</u>** 循环热流边界条件，并循环随温度变化的热导率的a，b系数，以莫霍面温度作为约束，反演符合条件的a,b值；

**<u>STEP2.</u>** 再对反演出的a，b值作拟合；

**<u>STEP3.</u>** 将拟合曲线与实验室测得的a，b值拟合曲线作对比，最接近的曲线对应的热流值最接近真实热流；

**<u>STEP4.</u>** 分别输出实验室拟合曲线，反演拟合曲线，散点图以及相关的信息到一副图中，并储存；

**<u>STEP5.</u>** 将反演出的a，b以及相应的热流，温度信息存到mat文件中。
