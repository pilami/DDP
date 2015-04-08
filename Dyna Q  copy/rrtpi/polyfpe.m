function [params] = polyfpe(rrt,no_iters)
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
	params = regress(y,basis(s));
	
	for k = 1:no_iters
		y = r + 0.99*(basis(s_next)*params);
		params = regress(y,basis(s));
		k;
	end
	
end
