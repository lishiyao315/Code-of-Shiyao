%%  指向参数
%仿真步长 单位：s  /  终止时间 单位：s
step = 0.1;
endt = 15;
%拓扑矩阵
   A = [-1,1,0,0,0,0
     1,-1,0,0,0,0
     1,0,-2,1,0,0
     1,1,1,-3,0,0
     0,0,0,1,-2,1
     0,0,1,1,1,-3];
%增益参数
K_A = 30; 
K_B = 300;
%控制律
Kd  =10;
%UE4基座初始位置 
x0 = [4,16,22,16,4,-2];  
y0 = [0,-1,-10,-15,-15,-10]; 
target=[10;33];
pos_base = [x0;y0];% 基座位置
%agent数量
num = size(x0,2);
lead_id = [1,2];
%%初始条件
% psi_initial=[pi*3/4;pi/4;pi/4;pi/4;pi*5/6;pi*4/5];
psi_initial=[pi*3/4,pi/4,pi/4,pi/4,pi*5/6,pi*4/5];
%%  Aero辨识参数
L_body = 6.5*0.0254; % length of horizontal body (metal tube)
m_body = 0.094; % mass of horizontal body (metal tube) 
J_body = m_body * L_body^2 / 12; % horizontal cylinder rotating about CM
m_yoke = 0.526; % mass of entire yoke assembly (kg)
r_fork = 0.04/2; % radius of each fork (approximated as cylinder)
J_yoke = 0.5*m_yoke*r_fork^2;
m_prop = 0.43; % mass of dc motor + shield + propeller shiel
r_prop = 6.25*0.0254; % distance from CM to center of pitch axis
J_prop = m_prop * r_prop^2; % using parallel axis theorem

Jy = J_body + 2*J_prop + J_yoke; % yaw: body, 2 props, and yoke

Dy = 0.0085;