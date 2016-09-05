function [ParSwarm,OptSwarm]=InitSwarm(SwarmSize,ParticleSize,ParticleScope)
%��ʼ������Ⱥ����ȫ����Ϊ[0-1]�����
%rand('state',0);
ParSwarm=rand(SwarmSize,2*ParticleSize+1);%��ʼ��λ�� �ٶ� ��ʷ�Ż�ֵ
%������Ⱥ��λ��,�ٶȵķ�Χ���е���
for k=1:ParticleSize
    ParSwarm(:,k)=ParSwarm(:,k)*(ParticleScope(k,2)-ParticleScope(k,1))+ParticleScope(k,1);%�����ٶȣ�ʹ�ٶ���λ�õķ�Χһ��
    ParSwarm(:,ParticleSize+k)=ParSwarm(:,ParticleSize+k)*(ParticleScope(k,2)-ParticleScope(k,1))+ParticleScope(k,1);
end
%��ÿһ�����Ӽ�������Ӧ�Ⱥ�����ֵ
for k=1:SwarmSize
    ParSwarm(k,2*ParticleSize+1)=AdaptFunc(ParSwarm(k,1:ParticleSize));%����ÿ�����ӵ���Ӧ��ֵ
end
%��ʼ������Ⱥ���Ž����
OptSwarm=zeros(SwarmSize+1,ParticleSize);
%����Ⱥ���Ž����ȫ����Ϊ��
[maxValue,row]=max(ParSwarm(:,2*ParticleSize+1));
%Ѱ����Ӧ�Ⱥ���ֵ���Ľ��ھ����е�λ��(����)
OptSwarm=ParSwarm(1:SwarmSize,1:ParticleSize);
OptSwarm(SwarmSize+1,:)=ParSwarm(row,1:ParticleSize);%����Ӧ��ֵ�������ӵ�λ����Ϊȫ�����ӵ�����ֵ