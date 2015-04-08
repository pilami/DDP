function [ maze,nrows,ncols ] = CreateMaze()
%CREATEMAZE Summary of this function goes here
%   Detailed explanation goes here
nrows = 100;
ncols = 100;

% Maze base
maze = zeros(nrows,ncols);


%Add some obstacles as ones in the maze
% Sutton and Barto Dyna-Q example maze.
maze(30,3:50) =1;
maze(6,20)   =1;
%maze(8,4:6) =1;
maze(5,20:50) =1 ;
maze(70,1:14) =1 ;
end

