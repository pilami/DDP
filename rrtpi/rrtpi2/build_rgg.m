function [rgg] = build_rgg(start_pt,dim,llimits,ulimits,maxpoints,samplefn,param1,param2)
	V = zeros(dim,maxpoints);
	E = zeros(maxpoints,maxpoints);
	R = zeros(maxpoints,maxpoints);
	ModelP = init_model();
	rstar = 150;
	rrtsize = 1;
	V(:,1) = start_pt;
	termset = zeros(1,maxpoints);
	while rrtsize < maxpoints
		sample_pt = feval(samplefn,dim,llimits,ulimits,param1,param2);
		distvect = sqrt(sum((V(:,1:rrtsize)-repmat(sample_pt,1,rrtsize)).^2));
		[dist,nearest] = min(distvect);
		if(termset(nearest))
			continue;
		end
		
		%node to be added to Vertex is ext_pt		
		ext_pt = sample_pt;
		if(dist >= 1.0)
			ext_pt = V(:,nearest) + (sample_pt - V(:,nearest) )/(dist);
			distvect = sqrt(sum((V(:,1:rrtsize)-repmat(ext_pt,1,rrtsize)).^2));
		end
		
		if param1==1
			dv = sqrt(sum((param2.S-repmat(ext_pt,1,maxpoints)).^2));
			[D,neark] = min(dv);
			val = param2.F(neark);
			if val <= (min(param2.F)+rand*range(param2.F))
				%disp('rejected');
				continue;
			end
		end


		ballrad = rstar*(log(1+rrtsize)/rrtsize)^(1/dim);
		closeset = find(distvect<ballrad);
		
		%uncomment to make it back to tree
		closeset = [];
		
		%add ext_pt to vertex set, index of ext_pt is rrtsize
		rrtsize = rrtsize + 1;			
		V(:,rrtsize) = ext_pt;
		%try to add all points in close set
		if(isempty(closeset)) %just connect nearest
			closeset(1) = nearest;
		end
		
		for ptind = closeset
			%[r,term] = sample_rew_hillworld(ModelP,V(:,ptind),ext_pt);
			[r,term] = sample_rew(V(:,ptind),ext_pt);
			termset(rrtsize) = term;
			E(ptind,rrtsize) = 1;
			R(ptind,rrtsize) = r;
		end

	end
	rgg = struct('V',V,'E',E,'R',R,'term',termset);	
end
