function [rgg,vf] = rrtpi(num_iters)
	llimits = [0;0];
	ulimits = [100;100];
	dim = 2;
	startpt = [20;20];
	disp('Building RGG');
	rgg(1) = build_rgg(startpt,dim,llimits,ulimits,5000,@uniform_sample,0,0);
	
	for z = 1:num_iters
		temps = sprintf('Iter no %d',z);
		disp(temps);
		disp('Evaluating Policy');
		F = eval_rgg(rgg(z));
		opt = find_opt_path(F,rgg(z).E);
		vf(z) = struct('F',F,'S',rgg(z).V,'opt',opt);
		disp('Building RGG');
		rgg(z+1) =build_rgg(startpt,dim,llimits,ulimits,5000,@uniform_sample,1,vf(z));
	end
	disp('Evaluating Policy');
	F = eval_rgg(rgg(num_iters+1));
	opt = find_opt_path(F,rgg(num_iters+1).E);
	vf(num_iters+1) = struct('F',F,'S',rgg(num_iters+1).V,'opt',opt);
end
