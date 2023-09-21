clc
clear
close all
clf
addpath(genpath('utils'))
%% 初始化参数
fprintf('inital parameter...\n');
%仿真步长 单位：s  /  终止时间 单位：s
step = 0.1;
endt = 10;
%基座初始位置 单位：m  / 初始偏航角，以从x轴向y轴旋转为正方向,左偏为正 单位：rad 角度的定义：逆时针为正
x0 = [2,4,5,4,2,1];
y0 = [4,4,2,1,1,2];
phi0 = [pi*3/4,0,pi/2,pi,pi/3,pi];
pos_base = [x0;y0];
phi = phi0;
%目标位置 单位：m  /  定义可感知目标的个体
target = [3;6];
% speed = [0.1;0];
speed = [0;0];
lead_id = [1,2];
%拓扑矩阵 每行代表第i个个体是否与第j个体通信
% A = [-3,1,0,1,1
%      1,-3,1,0,1
%      0,1,-3,1,1
%      1,0,1,-3,1
%      1,1,1,1,-4];
   A = [-1,1,0,0,0,0
     1,-1,0,0,0,0
     1,0,-2,1,0,0
     1,1,1,-3,0,0
     0,0,0,1,-2,1
     0,0,1,1,1,-3];
 %估计律 / 控制律增益 K_A拓扑增益 / K_B正交投影项增益
 K_A = 2;
 K_B = 12;
%agent数量
num = size(x0,2)
%% 与相对定位、目标估计相关的算法变量 初始化 
%B当前航向单位向量2*num  /  dot_B单位向量变化率2*num
%estimate_target目标估计值2*num /  dot_estimate 估计值变化率 2*num
B = [cos(phi);sin(phi)]; 
dot_B = zeros(2,num);
estimate_target = pos_base;
dot_estimate = zeros(2,num);
%航迹序列初始化
estimate_logx = estimate_target(1,:);
estimate_logy = estimate_target(2,:);
target_log = target;
error_log =[];
error_target_log=[];
%目标的相对方位
unit_toward_target = zeros(2,num);
for i = 1:num
     unit_toward_target(:,i) = unit_vector(pos_base(:,i), target);
end
fprintf('initalize finished...\n');
%% 画图 初始状态
fprintf('inital figure...\n');
figure(1)
%射线长度
R = 1;
plot_pointing(num,pos_base,R,B,lead_id,unit_toward_target,target,estimate_target)
% title('t=0');

%% 算法运行
iter = 1;
%保存帧，为后面做视频
F(iter) = getframe(gcf); 
for t = 0:step:endt
    iter = iter+1;
    disp(['time = ',num2str(t)]); 
    %目标位置更新
    target = target+speed*step;
    %目标的相对方位
    unit_toward_target = zeros(2,num);
    for i = 1:num
         unit_toward_target(:,i) = unit_vector(pos_base(:,i), target);
    end
    %更新目标估计点
    for i = 1:num
        dot_estimate(:,i) = update_estimate(estimate_target,lead_id,unit_toward_target,A,pos_base,i,num,K_A,K_B); 
    end
    %离散增量式更新
    estimate_target = estimate_target + dot_estimate*step;
    
    %更新指向
    for i = 1:num
        dot_B(:,i) = update_direct(B,estimate_target,pos_base,i);
    end
    %离散增量式更新
    B = B + dot_B*step;

    % 与期望方向的偏离
    error = unit_toward_target - B;
    
    q_error=estimate_target
    error_ =sqrt(error(1,:).^2 + error(2,:).^2);
    
    error_target=estimate_target-target
    error_target_=sqrt(error_target(1,:).^2 + error_target(2,:).^2);
    %记录航迹
    estimate_logx = [estimate_logx;estimate_target(1,:)];
    estimate_logy = [estimate_logy;estimate_target(2,:)];
    
    error_log = [error_log;error_];
%     target_log = [target_log,target];
    error_target_log=[error_target_log;error_target_]
    %画图
    figure(2)
    cla;
    plot_pointing(num,pos_base,R,B,lead_id,unit_toward_target,target,estimate_target)
%     title(['t=',int2str(t)]);
    drawnow
    %保存视频帧
    F(iter) = getframe(gcf);
end

%% 画航迹
figure
for w = 1:num
    plot(0:step:endt+step,estimate_logx(:,w),'LineWidth',2.5);
    hold on
end
grid on
xlabel('t /s');
ylabel('x /m');
title('目标估计值收敛--x方向');
legend('agt1','agt2','agt3','agt4','agt5');
set(gca,'FontSize',14,'Fontname', 'Times New Roman');

figure
for w = 1:num
    plot(0:step:endt+step,estimate_logy(:,w),'LineWidth',2.5);
    hold on
end
grid on
xlabel('t /s');
ylabel('y /m');
title('目标估计值收敛--y方向');
legend('agt1','agt2','agt3','agt4','agt5');
set(gca,'FontSize',14,'Fontname', 'Times New Roman');

figure
for w = 1:num
    plot(0:step:endt,error_log(:,w),'LineWidth',2.5);
    hold on
end
grid on
xlabel('$t(s)$','Interpreter','latex','FontSize',20);
ylabel('$\left\| {{h_i} - {h_{i0}}} \right\|$','Interpreter','latex','FontSize',20);
% xlabel('$t(s)$','Interpreter','latex','FontSize',18);
legend('$i=1$','$i=2$','$i=3$','$i=4$','$i=5$','$i=6$','Interpreter','latex','FontSize',20);
set(gca,'FontSize',18,'Fontname', 'Times New Roman');

figure
for w = 1:num
    plot(0:step:endt,error_target_log(:,w),'LineWidth',2.5);
    hold on
end
grid on
xlabel('$t(s)$','Interpreter','latex','FontSize',20);
ylabel('$\left\| {{\hat q_i} - {q_0}} \right\|$','Interpreter','latex','FontSize',20);
% xlabel('$t(s)$','Interpreter','latex','FontSize',18);
legend('$i=1$','$i=2$','$i=3$','$i=4$','$i=5$','$i=6$','Interpreter','latex','FontSize',20);
set(gca,'FontSize',18,'Fontname', 'Times New Roman');
%% 视频
v = VideoWriter('targeting.avi');
v.FrameRate = 10;
open(v)
writeVideo(v,F)
close(v)


