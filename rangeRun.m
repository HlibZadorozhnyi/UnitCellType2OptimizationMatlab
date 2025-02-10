function [out] = rangeRun(in)

 x0=in(:,1:end-1);
 x1=in(:,2:end);

 out = zeros(length(x0),1);
 for i=1:length(x0)
     X = [x0(i,1) x1(i,1)];
     out(i,1) = singleRun(X);
 end

end