function [rew,term] = sample_rew(prev_state,state)
	rew = -1;
	term = false;
	if prev_state(1) > 90 && prev_state(2) > 90
		rew = 100;
		term = true;
	end
	
	if prev_state(1) > 50 && prev_state(1) < 70 && prev_state(2) > 30 && prev_state(1) < 60
		rew = -30;
		term = true;
	end
end
