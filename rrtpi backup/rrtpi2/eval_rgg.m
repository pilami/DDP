function [F,del_array] = eval_rgg(rgg)
	E = full(rgg.E);
	R = full(rgg.R);
	F = zeros(size(rgg.V,2),1);
	gamma = 0.9;
	del = 1.0;
	del_array = [];
	%V(s) = pi(s)*(r + gamma*V(s'))
	%We approximate pi(s) to equiprobable policy
	while del > 0.01
		del = 0.0;
		v = F;
		for i=1:size(rgg.V,2)
			s_prime = find(E(i,:));
			
			if ~isempty(s_prime) && ~rgg.term(i)
				F(i) = max( R(i,s_prime) + gamma*v(s_prime)' );
			end
		end
		del = max(del,norm(v-F));
		del_array = [del_array del];
	end
end
