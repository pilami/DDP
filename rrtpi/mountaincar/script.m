for i = 1:10
	i
	rrt = mcrrt(50000);
	[l,~] = prunegraph(rrt);
	l
end
