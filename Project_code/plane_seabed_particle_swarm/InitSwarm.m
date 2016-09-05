function [ParSwarm,OptSwarm]=InitSwarm(SwarmSize,ParticleSize,ParticleScope)
%初始化粒子群矩阵，全部设为[0-1]随机数
%rand('state',0);
ParSwarm=rand(SwarmSize,2*ParticleSize+1);%初始化位置 速度 历史优化值
%对粒子群中位置,速度的范围进行调节
for k=1:ParticleSize
    ParSwarm(:,k)=ParSwarm(:,k)*(ParticleScope(k,2)-ParticleScope(k,1))+ParticleScope(k,1);%调节速度，使速度与位置的范围一致
    ParSwarm(:,ParticleSize+k)=ParSwarm(:,ParticleSize+k)*(ParticleScope(k,2)-ParticleScope(k,1))+ParticleScope(k,1);
end
%对每一个粒子计算其适应度函数的值
for k=1:SwarmSize
    ParSwarm(k,2*ParticleSize+1)=AdaptFunc(ParSwarm(k,1:ParticleSize));%计算每个粒子的适应度值
end
%初始化粒子群最优解矩阵
OptSwarm=zeros(SwarmSize+1,ParticleSize);
%粒子群最优解矩阵全部设为零
[maxValue,row]=max(ParSwarm(:,2*ParticleSize+1));
%寻找适应度函数值最大的解在矩阵中的位置(行数)
OptSwarm=ParSwarm(1:SwarmSize,1:ParticleSize);
OptSwarm(SwarmSize+1,:)=ParSwarm(row,1:ParticleSize);%将适应度值最大的粒子的位置最为全局粒子的最优值