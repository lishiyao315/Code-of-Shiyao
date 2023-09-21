function dot_estimate = update_estimate(estimate_target,lead_id,unit_toward_target,topology,pos_base,id,num,K_A,K_B)
% 目标估计值更新模块 输出是目标估计值的变化率 2*1
% **************************************************
% 输入变量            定义              维数
% num                 agent个数         1*1
% pos_base            基座位置          2*num
% id                  当前处理的个体ID  1*1
% lead_id             lead编号          1*n  n由拓扑中leader个数定义
% unit_toward_target  目标相对方位      2*num 
% target              目标坐标          2*1
% estimate_target     目标估计值        2*num
% topology            拓扑矩阵          num*num
% K_A                 拓扑增益          1*1
% K_B                 正交投影项增益    1*1
% ***************************************************
    %matrix_copy_state = [estimate_target(1,id)*ones(1,num);estimate_target(2,id)*ones(1,num)];
    %判断是否为可感知目标的个体
    if ismember(id,lead_id)
        %目标真实方位向量的正交投影矩阵
        project_matrix_targ = project_matrix(unit_toward_target(:,id));
        %leader更新方式
        dot_estimate = K_A*estimate_target*topology(id,:)'- K_B*project_matrix_targ*(estimate_target(:,id)-pos_base(:,id));
    else
        %follower更新方式
        dot_estimate = K_A*estimate_target*topology(id,:)';
    end
end

