function [params,V] = fpe(rrt,no_iters)
%	data = csvread(file);
%	s = data(:,1:2);
%	s_next = data(:,3:4);
%	r = data(:,5);
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
    %regression tree from the data
	params = classregtree(s,y,'minparent',30,'qetoler',0.0001);
	
	for k = 1:no_iters
		y = r + 0.9*eval(params,s_next);
		params = classregtree(s,y);
		k;
	end
	V = [];	
%	V = val_viz(params);
%	surf(V','EdgeColor','none');
%	figure,imagesc(V');
end
