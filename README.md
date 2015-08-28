#Tangible PSO

Particle Swarm Optimization for Formation Flying, written in Matlab, with Agent delegation to classes.

![Example run  of tangible PSO animation](https://raw.githubusercontent.com/clausqr/tangible-PSO/master/sample-PSO-run.gif)

*Sample run, large red circles are the goals, small red circles are global best UAV positions, starting points are green, and particle 1 trajectory is shown.*

## What is PSO?

Particle Swarm Optimization as introduced in [[1]](#cite1) is an optimization method based on the behavior of swarms, where each particle explores the state space adding to the collective knowledge of the solution.

## Why "Tangible"?

Because in the traditional PSO particles are  unidimensional, whereas in Tangible PSO as introduced in [[2]](#cite1) by Saska et al. each particle represents a Swarm of UAVs. So the evolution of each particle in fact represents the trajectories of a group of UAVs.

*NOTE: The use of the word Swarm is somewhat different along this work, because it also refers to the collection of UAVs. So a collection of UAVs is a Swarm, which is a particle of the PSO...*

## What is it used for?

In the current state it is used to determine a feasible path or trajectory for a formation of UAVs from their starting position to a set of predefined goals. But it can be used for any other type of robot or object behaving collectivelly, from choreography to satellites.

## Why did you write this?

I attended the course "Path planning for mobile robots in inspection, surveillance, and exploration missions" by M. Saska at ECI2015 [[3]](#cite3) and wanted to see the method working.

The aim is to experiment with the algorithms, not to optimize them for performance. I consider that performance optimization can be delegated to the actual embedded implementation.

## What is special about this implementation?

1. Implemented using classes.
1. It is very generic in what kind of robot or object constitute the Swarm. It must be defined as an Agent class with a set of standard control properties and methods (current state property, state update method, inverse kinematics, etc.).
1. A sample implementation of this Agent class is the included UAV class. It includes options to saturate controls and velocity.
1. Swarms are classes also, and group Agents. Swarms have the same set of standard control properties and methods.
1. The PSO class takes the Agent (particle class) as a parameter, this allows to reuse it with any other type of particle.
1. The PSO core method is in a separate file ( Iterate.M), for easy experimentation.
1. Cost Function is passed as a parameter to the PSO class, for easy experimentation. 

## Can your formation follow a 5-pointed star shape?

![Example run  of tangible PSO animation](https://raw.githubusercontent.com/clausqr/tangible-PSO/master/sample-PSO-run2.gif)
*You name it, just specify the goals and the cost function will take care.*

## How to run it?

An example script is included, but it's pretty straightforward:  

Create a Swarm:  
```matlab
s = SWARM()
```
Add agents:
```matlab
s.AddAgent(UAV(Path.Start.state))
```

Initialize the PSO:
```matlab
p = PSO(s, N_Particles, Path.Goal, @CostFcn)
```

Iterate:
```matlab
p.Iterate()
```

## Value Tuning

Typically with 20 particles (Swarms of 3 UAVs) the convergence is in less than 50 steps.

## References

<a name="cite1">[1]</a>. J. Kennedy and R. Eberhart, “Particle swarm optimization,” in Pro-
ceedings International Conference on Neural Networks IEEE, vol. 4,
1995, pp. 1942–1948.

<a name="cite2">[2]</a>.	M. Saska, J. Chudoba, L. Precil, J. Thomas, G. Loianno, A. Tresnak, V. Vonasek, and V. Kumar, “Autonomous deployment of swarms of micro-aerial vehicles in cooperative surveillance,” 2014 International Conference on Unmanned Aircraft Systems (ICUAS), pp. 584–595, 2014.

<a name="cite3">[3]</a>. "Path planning for mobile robots in inspection, surveillance, and exploration missions", Prof. Martin Saska. Faculty of Electrical Engineering, Czech Technical University, Czech Republic, [http://www.dc.uba.ar/events/eci/2015/cursos/saska](http://www.dc.uba.ar/events/eci/2015/cursos/saska)
