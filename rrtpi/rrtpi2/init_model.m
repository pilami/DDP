function p = init_model()
	MUs = [0 0; 40 30; 20 60; 65 80; 90 30;95 95];
	[X1,X2] = meshgrid(linspace(0,100,100)', linspace(0,100,100)');
	X = [X1(:) X2(:)];
	Sigma = cat(3,[200 0; 0 200],[100 0; 0 100],[900 0; 0 100],[100 0; 0 100],[100 0; 0 300],[10 0; 0 10]);
	w = 100000*[-1 -1 -1 -1 -1 0.03];
	numgauss = 6;
	p = ones(10000,1);
	for i = 1:numgauss;
		p = p + w(i)*mvnpdf(X,MUs(i,:),Sigma(:,:,i));
	end
	p = reshape(p,100,100);
end
