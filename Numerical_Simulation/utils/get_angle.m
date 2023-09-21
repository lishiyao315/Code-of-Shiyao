function angle = get_angle(point1,point2)
%计算平面上两点组成的矢量(从1指向2) 与 x轴正方向的夹角
%   angle  范围-pi~+pi 在x轴上方为正；若angle为[] 即两点重合
%   point1 矢量起点
%   point2 矢量终点
vector = point2-point1;
vector = vector';
vect0 = [1;0];
distance = sqrt(vector(1)^2+vector(2)^2);
if distance == 0
    angle = [];
elseif vector(2)>=0%x轴上方
    angle = acos(vector*vect0/distance);
else
    angle = -acos(vector*vect0/distance);
end

