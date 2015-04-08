for i = 1:10
	i
	rrt = mcrrt(50000);
	[l,~] = prunegraph(rrt);
    'done ' 
    plot_rgg(rrt)
    
	l
end
