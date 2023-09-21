function dot_estimate = update_location(pos_base,estimate_pos,topology,id,num)
% 定位更新模块 输出是定位估计值的变化率 2*1
% **************************************************
% 输入变量            定义              维数
% topology            拓扑矩阵          num*num
% pos_base            基座位置          2*num
% id                  当前处理的个体ID  1*1
% estimate_pos        定位估计值        2*num
% ***************************************************
    dot_estimate_p = [0;0];
    for j = 1:num
        if id ~= j
            unit_vector_realneigh = unit_vector(pos_base(:,id), pos_base(:,j));
            unit_vector_estimateneigh = unit_vector(estimate_pos(:,id), estimate_pos(:,j));
            project_matrix_estimateneigh = project_matrix(unit_vector_estimateneigh);
            dot_estimate_p = dot_estimate_p - topology(id,j) * project_matrix_estimateneigh * unit_vector_realneigh;
        end
    end
    dot_estimate = dot_estimate_p;
end