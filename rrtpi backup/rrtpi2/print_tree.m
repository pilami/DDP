function print_tree(rrt,k,params)
	points = [rrt.state];
	len = 0;
	plot(points(1,:),points(2,:),'r.');
	hold on;
	if(~isempty(params))
		V = eval(params,points');
%		V = basis(points')*params;
		[val,maxi]=max(V);
		optpath = [];
		
		while (~isempty(rrt(maxi).parent))
			optpath = [optpath rrt(maxi).state];
			len = len + norm(rrt(maxi).state - rrt(rrt(maxi).parent).state);
			maxi = rrt(maxi).parent;

		end
		plot(optpath(1,:),optpath(2,:),'b-','LineWidth',4);
	end
	hold off;
	if(k>=0)
		temps = sprintf('i%d_rrtl%f',k,len);
		print('-dpng',temps); 
	end
end
