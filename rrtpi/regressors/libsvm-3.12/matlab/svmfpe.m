function [params] = svmfpe(rrt,no_iters)
	s_next = [];
	s = [];
	r = [];
	for i = 1:numel(rrt)
		if(~isempty(rrt(i).parent))
			s_next(i,:) = rrt(i).state;
			s(i,:) = rrt(rrt(i).parent).state;
			r(i) = rrt(i).rew;
		end
	end	
	r = r';
	y = r;
	params = svmtrain(y,s,['-s 4 -t 2 -h 0 -q']);
	
	for k = 1:no_iters
		val = svmpredict(y,s_next,params);
		y = r + 0.99*val;
		params = svmtrain(y,s,['-s 4 -t 2 -h 0 -q']);
		k;
	end
	
end
