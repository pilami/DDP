function phi = basis(x)
	x1 = x(:,1);
	x2 = x(:,2);
	phi = [x1.^2 x2.^2 x1.*x2 x1 x2 ones(numel(x1),1)];
	phi = phi ./ repmat([10000 10000 10000 100 100 1],size(phi,1),1);
end
