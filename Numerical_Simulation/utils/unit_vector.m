function unit = unit_vector(start_point,end_point)
%给出向量的起点和终点 计算单位矢量
%start_point 向量起点       2*1
%end_point   向量终点       2*1
%unit        输出的单位向量 2*1
vector = end_point - start_point;
dist = sqrt(vector(1)^2+vector(2)^2);
if dist == 0
    unit = [0;0];
else
    unit = vector/dist;
end

