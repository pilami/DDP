function print_valfunc(model,k)
	st = [];
	for i=1:100
		for j=1:100
			st = [st;i j];	
		end
	end
%	covfunc = @covSEiso;
%	meanfunc = {@meanSum, {@meanLinear, @meanConst}};
%	likfunc = @likGauss;

%	[yval,c] = gp(model, @infExact, meanfunc, covfunc, likfunc,[],[],st);
%	yval = m5ppredict(model,st);
	yval = eval(model,st);
%	yval = basis(st)*model;
%	yval = svmpredict(ones(size(st,1),1),st,model);
	V = reshape(yval,100,100);
	surf(V,'EdgeColor','none')
	if(k>0)
		temps = sprintf('i%d_vfunc',k);
		print('-dpng',temps); 
	end

end
