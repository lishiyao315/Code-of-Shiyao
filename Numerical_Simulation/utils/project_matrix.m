function Pb = project_matrix(vector)
%正交投影矩阵
%vector 输入的单位向量 N*1
%Pb     输出的投影矩阵 N*N
%unit        输出的单位向量 2*1
size_v = size(vector,1);
Pb = eye(size_v) - vector*vector';
end

