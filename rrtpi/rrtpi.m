function [rrt,param] = rrtpi(num_iters)
	llimits = [0;0];
	ulimits = [100;100];
	dim = 2;
	startpt = [50;50];
    maxpoints = 3000;
	rrt = build_rrt(startpt,dim,llimits,ulimits,maxpoints,@uniform_sample,0,0);
    display('Howdy');
    
	J = zeros(maxpoints,3);
    
    param = [];
    num_iters = 100;
	print_tree(rrt,0,param);
	for z = 1:num_iters
        display('entered iteration'); z
		temps = sprintf('Iter no %d',z);
		
		disp(temps);
		disp('Evaluating Policy');
		%[param] = fpemodeltree(rrt,50);
		%[param] = polevaltest(rrt,10);
		%[param] = polyfpe(rrt,1000);
        
        %DO TD(0) Update on rrt and generate the J values
        
		if(z == 1)
			[param] = fpe(rrt,500);
		else
			[param] = fpe(rrt,200);
            
		%[param] = svmfpe(rrt,100);
		print_valfunc(param,z);
		[B,index] =  resample_set(param,2,llimits,ulimits,20000);
        size(B)
        size(index)
        
		disp('Building RRT');
		rrt = build_rrt(startpt,dim,llimits,ulimits,1750,@bias_sample,B,index);
		
		
		print_tree(rrt,z,param);
	end
end
