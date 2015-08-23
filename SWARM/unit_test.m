% test SWARM
clear

s = SWARM

N_Agents = 10;
for k = 1: N_Agents
r = UAV
InitialState = r.getNewRandomState;
InitialState(4) = 0.025;
r.Init(InitialState)
s.AddAgent(r)


end
x = s.getNewRandomState
y = s.getNewRandomState

u = s.InverseKinematicsFcn(x, y);

s.UpdateState(u)

s.ControlsShuffle(u)

s.PlotState(x, '*r')
s.PlotState(y, 'ob')

s.PlotStateTransition(x, y)
for k = 1:50
x = s.State;    
y = s.getNewRandomState

u = s.InverseKinematicsFcn(x, y);
s.UpdateState(u)


% s.PlotState(y, '*r')
% s.PlotStateTransition(x, y, 1,'Green', 1);
% drawnow update

%pause(1)
s.PlotStateTransition(x, s.State);
s.PlotState(s.State, 'xk')
drawnow update
end

