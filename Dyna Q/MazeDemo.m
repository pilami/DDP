function  MazeDemo( maxepisodes )
%MazeDemo, the main function of the demo
%maxepisodes: maximum number of episodes to run the demo

% Maze Problem  
% Programmed in Matlab 
% by:
%  Jose Antonio Martin H. <jamartinh@fdi.ucm.es>
% 

clc
start       = [0 3];
goal        = [80 50];
[maze N M]  = CreateMaze();


statelist   = BuildStateList(N,M);  % the list of states
actionlist  = BuildActionList(); % the list of actions


nstates     = size(statelist,1);
nactions    = size(actionlist,1);

%Generate initial Population
Q           = BuildQTable(nstates,nactions ); % the Qtable  
Model       = BuildModel(nstates,nactions ); % the Qtable  

% planning steps
p_steps     = 50;

maxsteps    = 2000;  % maximum number of steps per episode
alpha       = 0.1;   % learning rate
gamma       = 0.95;  % discount factor
epsilon     = 0.1;   % probability of a random action selection


grafica     = false; % indicates if display the graphical interface
grafica     = true;
xpoints=[];
ypoints=[];
maxepisodes = 10
for i=1:maxepisodes    
    
    if i == 2
        maze(7,2:5) =0 ;
    end
    [total_reward,steps,Q,Model ] =  Episode( maxsteps, Q, Model , alpha, gamma,epsilon,statelist,actionlist,grafica,maze,start,goal,p_steps ) ;  
    disp(['Espisode: ',int2str(i),'  Steps:',int2str(steps),'  Reward:',num2str(total_reward),' epsilon: ',num2str(epsilon)])
    
    %epsilon = epsilon*0.999;
    
    xpoints(i)=i-1;
    ypoints(i)=steps;
    %subplot(2,1,2);    
    %plot(xpoints,ypoints)      
    %title(['Episode: ',int2str(i),' epsilon: ',num2str(epsilon)])    
      
    
    
    
    if (i>2000000)
        grafica=true;
    end
end






