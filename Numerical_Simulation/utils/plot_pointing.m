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
A1 = plot(pos_base(1,:),pos_base(2,:),'ob','MarkerSize',10);
hold on
%画目标位置
A2 = plot(target(1),target(2),'rp','MarkerSize',20);
%画估计点位置
A3 = plot(estimate_target(1,:),estimate_target(2,:),'m*','MarkerSize',5);
%计算射线末端位置
pos_end = pos_base + R*B;
for k = 1:num
    if ismember(k,lead_id)
        color =[0,0,1];
        
        B1(k) = line([pos_base(1,k),pos_base(1,k)+unit_toward_target(1,k)],[pos_base(2,k),pos_base(2,k)+unit_toward_target(2,k)],'LineWidth',1,'Color',[1,0,0],'LineStyle',':');
        B2(k) = quiver(pos_base(1,k),pos_base(2,k),B(1,k),B(2,k),'MaxHeadSize',1,'LineWidth',1.5,'Color',color);
    else
        color =  [0,0.8,0.3];
        B3(k) = quiver(pos_base(1,k),pos_base(2,k),B(1,k),B(2,k),'MaxHeadSize',1,'LineWidth',1.5,'Color',color);
    end
    
end

%坐标范围 坐标轴
xmin = min(pos_base(1,:))-1;xmax = max(pos_base(1,:))+1;ymin = min(pos_base(2,:))-1;ymax = max(pos_base(2,:))+3;
axis([xmin xmax ymin ymax]);
xlabel('$x$','Interpreter','latex','FontSize',18);
ylabel('$y$','Interpreter','latex','FontSize',18);
% h = legend([A1,A2,A3,B1,B2,B3],'$p_i$','$q_0$','$\hat{q}_i$','$g_{i0}$','$b_i$','$b_i$');
h = legend('$p_i$','$q_0$','$\hat{q}_i$','$z_{i}$','FontSize',20);
set(h,'Interpreter','latex','Orientation','horizon','NumColumns',2);
set(gca,'FontSize',16);
end

