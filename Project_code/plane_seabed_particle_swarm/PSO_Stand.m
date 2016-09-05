function [XResult,YResult]=PSO_Stand(SwarmSize,ParticleSize,ParticleScope,IsStep,IsDraw,LoopCount,IsPlot)
%���������SwarmSize:��Ⱥ��С�ĸ���
%���������ParticleSize��һ�����ӵ�ά��
%���������ParticleScope:һ�������������и�ά�ķ�Χ��
%���������������� ParticleScope��ʽ:
%�������������������� 3ά���ӵ�ParticleScope��ʽ:
%����������������������������������������������������[x1Min,x1Max
%���������������������������������������������������� x2Min,x2Max
%���������������������������������������������������� x3Min,x3Max]
%�������:InitFunc:��ʼ������Ⱥ����
%�������:StepFindFunc:���������ٶȣ�λ�ú���
%���������AdaptFunc����Ӧ�Ⱥ���
%���������IsStep���Ƿ�ÿ�ε�����ͣ��IsStep��0������ͣ��������ͣ��ȱʡ����ͣ
%���������IsDraw���Ƿ�ͼ�λ��������̣�IsDraw��0����ͼ�λ��������̣�����ͼ�λ���ʾ��ȱʡ��ͼ�λ���ʾ
%���������LoopCount�������Ĵ�����ȱʡ����100��
%���������IsPlot�������Ƿ���������������������ܵ�ͼ�α�ʾ;IsPlot=0,����ʾ��
%��������������������������������                          IsPlot=1����ʾͼ�ν����ȱʡIsPlot=1
%����ֵ��ResultΪ����������õ������Ž�
%����ֵ��OnLineΪ�������ܵ�����
%����ֵ��OffLineΪ�������ܵ�����
%����ֵ��MinMaxMeanAdaptΪ�������������õ�����С������ƽ����Ӧ��

[ParSwarm,OptSwarm]=InitSwarm(SwarmSize,ParticleSize,ParticleScope);%��ʼ������Ⱥ
if IsStep~=0
    disp('Start to iterate and press any key:')
    pause
end
%��ʼ�����㷨�ĵ���%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:LoopCount
    %��ʾ�����Ĵ�����
    disp('----------------------------------------------------------')
    TempStr=sprintf('The No.%g iteration',k);
    disp(TempStr);
    disp('----------------------------------------------------------')
    
%����һ���������㷨
[ParSwarm,OptSwarm]=BaseStepPso(ParSwarm,OptSwarm,ParticleScope,0.95,0.4,LoopCount,k);
    figure(1);
plot(ParSwarm(:,1),ParSwarm(:,2),'g*','markersize',8);grid on;
    XResult=OptSwarm(SwarmSize+1,1:ParticleSize);%��ȡ���ε����õ���ȫ������ֵ
    YResult=AdaptFunc(XResult);                  %����ȫ������ֵ��Ӧ�����ӵ���Ӧ��ֵ
    if IsStep~=0
        %XResult=OptSwarm(SwarmSize+1,1:ParticleSize);
        %YResult=AdaptFunc(XResult);
        str=sprintf('The optimal objective function value is %g after No.%g iteration',YResult,k);
        disp(str);
        disp('Press any key to start next iteration');
        pause
    end    
    %��¼ÿһ����ƽ����Ӧ��
    MeanAdapt(1,k)=mean(ParSwarm(:,2*ParticleSize+1));%mean����Ϊȡ��Чֵ����
end