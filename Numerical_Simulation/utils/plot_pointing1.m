function plot_pointing(num,pos_base,R,B,lead_id,unit_toward_target,target,estimate_target)
% 指向过程中的plotfigure
% **************************************************
% 注意：该画图程序中无刷新图片的功能 无cla 无holdoff
% **************************************************
% 输入变量            定义           维数
% num                 agent个数      1*1
% pos_base            基座位置       2*num
% R                   射线长度       1*1
% B                   航向单位向量   2*num
% lead_id             lead编号       1*n  n由拓扑中leader个数定义
% unit_toward_target  目标相对方位   2*num 
% target              目标坐标       2*1
% estimate_target     目标估计值     2*num
% ***************************************************
%画基座位置
plot(pos_base(1,:),pos_base(2,:),'ob','MarkerSize',10)
hold on
%画目标位置
plot(target(1),target(2),'rp','MarkerSize',20)
%画估计点位置
plot(estimate_target(1,:),estimate_target(2,:),'m*','MarkerSize',5)
%计算射线末端位置
pos_end = pos_base + R*B;
for k = 1:num
    if ismember(k,lead_id)
        color = [0,1,0];
        line([pos_base(1,k),pos_base(1,k)+unit_toward_target(1,k)],[pos_base(2,k),pos_base(2,k)+unit_toward_target(2,k)],'LineWidth',1,'Color',[1,0,0],'LineStyle',':');
    else
        color = [0,0,1];
    end
%     line([pos_base(1,k),pos_end(1,k)],[pos_base(2,k),pos_end(2,k)],'LineWidth',2,'Color',color);
end

%坐标范围 坐标轴
xmin = min(pos_base(1,:))-1;xmax = max(pos_base(1,:))+1;ymin = min(pos_base(2,:))-1;ymax = max(pos_base(2,:))+3;
axis([xmin xmax ymin ymax]);
xlabel('$x(m)$','Interpreter','latex','FontSize',18);
ylabel('$y(m)$','Interpreter','latex','FontSize',18);
h = legend('$p_i$','$q_0$','$\hat{q}_i$','$z_{i0}$');
set(h,'Interpreter','latex','Orientation','horizon','NumColumns',2);
set(gca,'FontSize',16);
end

