function y = cutpoint(x0,phi,h)
if mod(phi-pi/2,pi) ~= 0%不是pi/2，正常算交点
        y = x0-h*tan(phi);
    elseif mod((phi-pi/2),2)==0
        y = -inf;
    else
        y = inf;
end
end