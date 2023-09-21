function dot_unit_vect = update_direct(unit_vect,estimate_target,pos_base,id)
% 航向矢量更新模块 输出是航向矢量的变化率 2*1
% **************************************************
% 输入变量            定义              维数
% unit_vect           单位航向矢量      2*num
% pos_base            基座位置          2*num
% id                  当前处理的个体ID  1*1
% estimate_target     目标估计值        2*num
% ***************************************************
    project_matrix_i = project_matrix(unit_vect(:,id));
    dot_unit_vect = project_matrix_i*(estimate_target(:,id)-pos_base(:,id));
end