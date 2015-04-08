function [pt] = bias_sample(dim,llimits,ulimits,param1,param2)	
	pt = param1(:,param2(randi(numel(param2))));
end
