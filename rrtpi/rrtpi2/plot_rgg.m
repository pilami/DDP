function plot_rgg(rgg,c)
	[s,d] = find(rgg.E);
	for i = 1:numel(s);
		line( [rgg.V(1,s(i)) rgg.V(1,d(i))] ,[rgg.V(2,s(i)) rgg.V(2,d(i))],'Color',c,'LineWidth',2);
	end
end
