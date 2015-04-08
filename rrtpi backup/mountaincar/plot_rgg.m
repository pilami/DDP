function plot_rgg(rgg)
	[s,d] = find(rgg.E);
	for i = 1:numel(s);
		line( [rgg.V(1,s(i)) rgg.V(1,d(i))] ,[rgg.V(2,s(i)) rgg.V(2,d(i))] );
	end
end
