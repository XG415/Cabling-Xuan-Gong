function [ParSwarm,OptSwarm]=BaseStepPso(ParSwarm,OptSwarm,ParticleScope,MaxW,MinW,LoopCount,CurCount)
%���������ParSwarm:����Ⱥ���󣬰������ӵ�λ�ã��ٶ��뵱ǰ��Ŀ�꺯��ֵ
%���������OptSwarm����������Ⱥ�������Ž���ȫ�����Ž�ľ���
%���������ParticleScope:һ�������������и�ά�ķ�Χ��
%���������AdaptFunc����Ӧ�Ⱥ���
%���������AdaptFunc����Ӧ�Ⱥ���
%���������MaxW  MinW������Ȩ��(ϵ��)�����ֵ����Сֵ
%���������CurCount����ǰ�����Ĵ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���εݼ����ԣ�����Ȩֵ�ı仯��
w=MaxW-CurCount*((MaxW-MinW)/LoopCount);
%�õ�����ȺȺ���С�Լ�һ������ά������Ϣ
[ParRow,ParCol]=size(ParSwarm);
%�õ����ӵ�ά��
ParCol=(ParCol-1)/2;
SubTract1=OptSwarm(1:ParRow,:)-ParSwarm(:,1:ParCol);%������ʷ����ֵ�뵱ǰλ�õĲ�ֵ
%*****��������Ĵ��룬���Ը���c1,c2�ı仯*****
c1=2;
c2=2;
%���һ������λ�� �ٶ� ����ֵ�ĸ��µ���
for row=1:ParRow
    SubTract2=OptSwarm(ParRow+1,:)-ParSwarm(row,1:ParCol);%�����ȫ������ֵ�뵱ǰ������λ�õĲ�ֵ
    %�ٶȸ��¹�ʽ
TempV=w.*ParSwarm(row,ParCol+1:2*ParCol)+c1*unifrnd(0,1).*SubTract1(row,:)+c2*unifrnd(0,1).*SubTract2;
    %�����ٶȵĴ���
    for h=1:ParCol
        if TempV(:,h)>ParticleScope(h,2)
            TempV(:,h)=ParticleScope(h,2);
        end
        if TempV(:,h)<-ParticleScope(h,2)
            TempV(:,h)=-ParticleScope(h,2)+1e-10;%��1e-10��ֹ��Ӧ�Ⱥ��������
        end
    end
    %���¸������ٶ�ֵ
    ParSwarm(row,ParCol+1:2*ParCol)=TempV;
%*****��������Ĵ��룬���Ը���Լ�����ӵı仯*****
a=0.729;%Լ������
%λ�ø��¹�ʽ
    TempPos=ParSwarm(row,1:ParCol)+a*TempV;
    %����λ�÷�Χ�Ĵ���
    for h=1:ParCol
        if TempPos(:,h)>ParticleScope(h,2)
            TempPos(:,h)=ParticleScope(h,2);
        end
        if TempPos(:,h)<=ParticleScope(h,1)
            TempPos(:,h)=ParticleScope(h,1)+1e-10;%��1e-10��ֹ��Ӧ�Ⱥ��������
        end
    end
    %���¸�����λ��ֵ
    ParSwarm(row,1:ParCol)=TempPos;
  %����ÿ�����ӵ��µ���Ӧ��ֵ
    ParSwarm(row,2*ParCol+1)=AdaptFunc(ParSwarm(row,1:ParCol));
    if ParSwarm(row,2*ParCol+1)>AdaptFunc(OptSwarm(row,1:ParCol))
        OptSwarm(row,1:ParCol)=ParSwarm(row,1:ParCol);
    end
end
%Ѱ����Ӧ�Ⱥ���ֵ���Ľ��ھ����е�λ��(����)������ȫ������ֵ�ĸı� 
[maxValue,row]=max(ParSwarm(:,2*ParCol+1));
if AdaptFunc(ParSwarm(row,1:ParCol))>AdaptFunc(OptSwarm(ParRow+1,:))
    OptSwarm(ParRow+1,:)=ParSwarm(row,1:ParCol);
end