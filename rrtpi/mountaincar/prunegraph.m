function [minlen,minindex,minpath] = prunegraph(rrt)
	E =rrt.E;
	minlen = 30000;
	minindex = 0;
	for i = find(rrt.term)
		index = i;
		l = 1;
		while index ~=1
			index = find(E(:,index));
			l = l+1;
		end
		if l < minlen
			minlen = l;
			minindex = i;
		end
	end
	index = minindex;
	minpath = [index];
	while index ~=1
		index = find(E(:,index));
		minpath = [minpath index];
	end
	
end
