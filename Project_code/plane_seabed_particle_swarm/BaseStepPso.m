function [ParSwarm,OptSwarm]=BaseStepPso(ParSwarm,OptSwarm,ParticleScope,MaxW,MinW,LoopCount,CurCount)
%输入参数：ParSwarm:粒子群矩阵，包含粒子的位置，速度与当前的目标函数值
%输入参数：OptSwarm：包含粒子群个体最优解与全局最优解的矩阵
%输入参数：ParticleScope:一个粒子在运算中各维的范围；
%输入参数：AdaptFunc：适应度函数
%输入参数：AdaptFunc：适应度函数
%输入参数：MaxW  MinW：惯性权重(系数)的最大值与最小值
%输入参数：CurCount：当前迭代的次数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%线形递减策略（惯性权值的变化）
w=MaxW-CurCount*((MaxW-MinW)/LoopCount);
%得到粒子群群体大小以及一个粒子维数的信息
[ParRow,ParCol]=size(ParSwarm);
%得到粒子的维数
ParCol=(ParCol-1)/2;
SubTract1=OptSwarm(1:ParRow,:)-ParSwarm(:,1:ParCol);%求解出历史最优值与当前位置的差值
%*****更改下面的代码，可以更改c1,c2的变化*****
c1=2;
c2=2;
%完成一次粒子位置 速度 最优值的更新迭代
for row=1:ParRow
    SubTract2=OptSwarm(ParRow+1,:)-ParSwarm(row,1:ParCol);%计算出全局最优值与当前该粒子位置的差值
    %速度更新公式
TempV=w.*ParSwarm(row,ParCol+1:2*ParCol)+c1*unifrnd(0,1).*SubTract1(row,:)+c2*unifrnd(0,1).*SubTract2;
    %限制速度的代码
    for h=1:ParCol
        if TempV(:,h)>ParticleScope(h,2)
            TempV(:,h)=ParticleScope(h,2);
        end
        if TempV(:,h)<-ParticleScope(h,2)
            TempV(:,h)=-ParticleScope(h,2)+1e-10;%加1e-10防止适应度函数被零除
        end
    end
    %更新该粒子速度值
    ParSwarm(row,ParCol+1:2*ParCol)=TempV;
%*****更改下面的代码，可以更改约束因子的变化*****
a=0.729;%约束因子
%位置更新公式
    TempPos=ParSwarm(row,1:ParCol)+a*TempV;
    %限制位置范围的代码
    for h=1:ParCol
        if TempPos(:,h)>ParticleScope(h,2)
            TempPos(:,h)=ParticleScope(h,2);
        end
        if TempPos(:,h)<=ParticleScope(h,1)
            TempPos(:,h)=ParticleScope(h,1)+1e-10;%加1e-10防止适应度函数被零除
        end
    end
    %更新该粒子位置值
    ParSwarm(row,1:ParCol)=TempPos;
  %计算每个粒子的新的适应度值
    ParSwarm(row,2*ParCol+1)=AdaptFunc(ParSwarm(row,1:ParCol));
    if ParSwarm(row,2*ParCol+1)>AdaptFunc(OptSwarm(row,1:ParCol))
        OptSwarm(row,1:ParCol)=ParSwarm(row,1:ParCol);
    end
end
%寻找适应度函数值最大的解在矩阵中的位置(行数)，进行全局最优值的改变 
[maxValue,row]=max(ParSwarm(:,2*ParCol+1));
if AdaptFunc(ParSwarm(row,1:ParCol))>AdaptFunc(OptSwarm(ParRow+1,:))
    OptSwarm(ParRow+1,:)=ParSwarm(row,1:ParCol);
end