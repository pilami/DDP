function print_mcrrt(rrt)
	leaves = [];
	for i = 1:numel(rrt)
		if(isempty(rrt(i).action))
			leaves = [leaves i];
		end
	end
	minleaf = 1;
	minleafcnt = 50000;
	for i = leaves
		path = [];
		head = i;
		leafcount =1;
		while (~isempty(rrt(head).parent))
			path = [path rrt(head).state];
			head = rrt(head).parent;
			leafcount = leafcount +1;
		end
		
		if leafcount < minleafcnt
			minleaf = i;
			minleafcnt = leafcount;
		end
		plot(path(1,:),path(2,:),'b-');
		hold on;
	end

	path = [];
	head = minleaf;
	while (~isempty(rrt(head).parent))
		path = [path rrt(head).state];
		head = rrt(head).parent;
		leafcount = leafcount +1;
	end
	plot(path(1,:),path(2,:),'r-','LineWidth',4);
	hold on;


	
	hold off;
end
