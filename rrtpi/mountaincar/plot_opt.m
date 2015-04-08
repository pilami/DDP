function plot_opt(rgg,optpath)	
	for i = 2:numel(optpath)
		line( [rgg.V(1,optpath(i-1)) rgg.V(1,optpath(i))] ,[rgg.V(2,optpath(i-1)) rgg.V(2,optpath(i))] );
	end
end
