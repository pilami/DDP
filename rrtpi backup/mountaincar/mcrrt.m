%Mountain car solving using rrt. 'Under constrained' system.
%Manimaran S S IITM 2012
% 2 D domain - [p,v]
% range -1.2 < p < 0.5
% 		-0.07<v<0.07

function rrt = mcrrt(maxpts)
	start_pt = [-0.5;0];
	llimits = [-1.2;-0.07];
	ulimits = [0.6;0.07];
	dim = 2;

	V = zeros(dim,maxpts);
	E = sparse(zeros(maxpts,maxpts));
	R = sparse(zeros(maxpts,maxpts));
	
	rrt = struct('state',start_pt,'parent',[],'action',[]);
	x = zeros(2,maxpts);
	x(:,1) = [start_pt];
	rrtsize = 1;
	V(:,1) = start_pt;
	terminate = false;
	termset = zeros(1,maxpts);
	while (rrtsize < maxpts)
%	for z = 1:maxpoints
		%Uniform distribution
		sample_pt = llimits+(ulimits-llimits).*rand(dim,1);
		%sample_pt = feval(samplefn,dim,llimits,ulimits,param1,param2);
		
		%find nearest pt in tree
		%todo : replace with kdtree
		%x = [rrt.state];
		[~,nearest] = min(sum((V(:,1:rrtsize)-repmat(sample_pt,1,rrtsize)).^2));
		
		%extend towards the point
		s = V(:,nearest);
		for a = [-1, 0, 1]
			rew = -1;
			v = s(2) + 0.001*a -0.0025*cos(3*s(1));
			if (v < llimits(2)) || (v > ulimits(2))
				v = s(2);
			end
			p = s(1) + v;
			if (p > 0.5)
				rew = 100000;
				if (~terminate)
					fprintf(1,'Solved');
				end
				terminate = true;

				rrtsize = rrtsize + 1;
				V(:,rrtsize) = [p;v];
				E(nearest,rrtsize) = 1;
				R(nearest,rrtsize) = rew;
				termset(rrtsize) = 1;				
								
			end
			if  (p < llimits(1))
				p = llimits(1);
				v = 0;
			end
			if  (p > ulimits(1))
				p = ulimits(1);
				v = 0;
			end
			if((a+2)/3 > rand)
				rrtsize = rrtsize + 1;
				V(:,rrtsize) = [p;v];
				E(nearest,rrtsize) = 1;
				R(nearest,rrtsize) = rew;
			end
			
		end
		%greedy choice
		%[closeval,closea] = min(sum((sn-repmat(sample_pt,1,3)).^2));

	end
	rrt = struct('V',V,'E',E,'R',R,'size',rrtsize,'term',termset);
end
