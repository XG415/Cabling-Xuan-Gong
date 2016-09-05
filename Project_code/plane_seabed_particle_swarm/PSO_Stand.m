function [XResult,YResult]=PSO_Stand(SwarmSize,ParticleSize,ParticleScope,IsStep,IsDraw,LoopCount,IsPlot)
%输入参数：SwarmSize:种群大小的个数
%输入参数：ParticleSize：一个粒子的维数
%输入参数：ParticleScope:一个粒子在运算中各维的范围；
%　　　　　　　　 ParticleScope格式:
%　　　　　　　　　　 3维粒子的ParticleScope格式:
%　　　　　　　　　　　　　　　　　　　　　　　　　　[x1Min,x1Max
%　　　　　　　　　　　　　　　　　　　　　　　　　　 x2Min,x2Max
%　　　　　　　　　　　　　　　　　　　　　　　　　　 x3Min,x3Max]
%输入参数:InitFunc:初始化粒子群函数
%输入参数:StepFindFunc:单步更新速度，位置函数
%输入参数：AdaptFunc：适应度函数
%输入参数：IsStep：是否每次迭代暂停；IsStep＝0，不暂停，否则暂停。缺省不暂停
%输入参数：IsDraw：是否图形化迭代过程；IsDraw＝0，不图形化迭代过程，否则，图形化表示。缺省不图形化表示
%输入参数：LoopCount：迭代的次数；缺省迭代100次
%输入参数：IsPlot：控制是否绘制在线性能与离线性能的图形表示;IsPlot=0,不显示；
%　　　　　　　　　　　　　　　　                          IsPlot=1；显示图形结果。缺省IsPlot=1
%返回值：Result为经过迭代后得到的最优解
%返回值：OnLine为在线性能的数据
%返回值：OffLine为离线性能的数据
%返回值：MinMaxMeanAdapt为本次完整迭代得到的最小与最大的平均适应度

[ParSwarm,OptSwarm]=InitSwarm(SwarmSize,ParticleSize,ParticleScope);%初始化粒子群
if IsStep~=0
    disp('Start to iterate and press any key:')
    pause
end
%开始更新算法的调用%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:LoopCount
    %显示迭代的次数：
    disp('----------------------------------------------------------')
    TempStr=sprintf('The No.%g iteration',k);
    disp(TempStr);
    disp('----------------------------------------------------------')
    
%调用一步迭代的算法
[ParSwarm,OptSwarm]=BaseStepPso(ParSwarm,OptSwarm,ParticleScope,0.95,0.4,LoopCount,k);
    figure(1);
plot(ParSwarm(:,1),ParSwarm(:,2),'g*','markersize',8);grid on;
    XResult=OptSwarm(SwarmSize+1,1:ParticleSize);%存取本次迭代得到的全局最优值
    YResult=AdaptFunc(XResult);                  %计算全局最优值对应的粒子的适应度值
    if IsStep~=0
        %XResult=OptSwarm(SwarmSize+1,1:ParticleSize);
        %YResult=AdaptFunc(XResult);
        str=sprintf('The optimal objective function value is %g after No.%g iteration',YResult,k);
        disp(str);
        disp('Press any key to start next iteration');
        pause
    end    
    %记录每一步的平均适应度
    MeanAdapt(1,k)=mean(ParSwarm(:,2*ParticleSize+1));%mean函数为取有效值函数
end