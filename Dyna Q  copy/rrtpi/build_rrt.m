function [rrt] = build_rrt(start_pt,dim,llimits,ulimits,maxpoints,samplefn,param1,param2)
	k = zeros(dim,maxpoints);
	
	[r,term] = sample_rew(start_pt);
	rrt = struct('state',start_pt,'parent',[],'rew',r);
	k(:,1) = [start_pt];
	
	termset = [];
	
	%sample and add maxpoints	
	term = false;
%	while numel(rrt) < maxpoints
    param = [];
	for z = 1:maxpoints
        if z == maxpoints/100
           figure;
           print_tree(rrt,0,param)
        end
        if z == maxpoints/10
            figure;
            print_tree(rrt,0,param)
        end
        
        if z == maxpoints/2
            figure;
            print_tree(rrt,0,param)
        end

        
		%Uniform distribution
		%sample_pt = llimits+(ulimits-llimits).*rand(dim,1);
		sample_pt = feval(samplefn,dim,llimits,ulimits,param1,param2);
		
		%find nearest pt in tree
		%todo : replace with kdtree
		x = [rrt.state];
		[dist,nearest] = min(sum((x-repmat(sample_pt,1,numel(rrt))).^2));
		if any(termset == nearest)
			continue;
		end
		%extend towards the point
		if(dist < 1.0)
			[r,term] = sample_rew(sample_pt);
			rrt(end+1) = struct('state',sample_pt,'parent',nearest,'rew',r);
			if term
				termset(end+1) = numel(rrt);
				
			end
		else
			new_pt = rrt(nearest).state +  (sample_pt - rrt(nearest).state )/(dist^0.5);
			[r,term] = sample_rew(new_pt);
			rrt(end+1) = struct('state',new_pt,'parent',nearest,'rew',r);
			if term
				termset(end+1) = numel(rrt);
			end
		end		
	end
	
end
