function [opt_pts] = find_opt_path(F,E)
	index = 1;
	opt_pts = [1];
	sprime = find(E(index,:));
	while ~isempty(sprime)
		sprime = find(E(index,:));
		[maxf,maxind] = max(F(sprime));
		opt_pts = [opt_pts sprime(maxind)];
		index = sprime(maxind);	
	end
end
