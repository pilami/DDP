function [B,index] = resample_set(param,dim,llimits,ulimits,NS)
	B=repmat(llimits,1,NS)+diag(ulimits-llimits)*rand(dim,NS);
%	V = svmpredict(ones(size(B',1),1),B',param);
	V = eval(param,B');
%	V = basis(B')*param;
%	V = m5ppredict(param,B');
%	covfunc = @covSEiso;
%	meanfunc = {@meanSum, {@meanLinear, @meanConst}};
%	likfunc = @likGauss;
%	[V,c] = gp(model, @infExact, meanfunc, covfunc, likfunc,[],[],B');
	V = V - min(V); 
	V = V/sum(V);

	Q = cumsum(V);
	t = rand(NS+1);
	T=sort(t);
	T(NS+1)=1;
	i=1;j=1;
	index=[];
	while(i<=NS&&j<=NS)
		if T(i) < Q(j)
			index(i)=j;
			i = i+1;
		else
			j = j+1;
		end
	end
	
end
