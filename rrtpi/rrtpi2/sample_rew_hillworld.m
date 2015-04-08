function [rew,term] = sample_rew_hillworld(p,prev_state,state)
	term = false;
	rew = -abs(p(ceil(0.00001+state(1)),ceil(0.00001+state(2))) - p(ceil(0.00001+prev_state(1)),ceil(0.00001+prev_state(2))));
	if prev_state(1) > 90 && prev_state(2) > 90
		term = true;
	end
end
