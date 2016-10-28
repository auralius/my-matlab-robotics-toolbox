# my-matlab-robotics-toolbox

Simple and straight-forward implementation of DH-parameters in MATLAB  
This can be used to execute forward kinematics of the robot to find position and orientation of every link of the robot.  

**cgr** prefix means the code is code-generation ready.    
**ncgr** means the code is **NOT** code-generation ready.

Features:  
* Forward kinematics
* Homogenous transformation of each link of the robot
* Numerical jacobian
* Simple visualization, it can also be animated
* Inverse kinematics with the pseudo-inverse method.

How to use:
* Create the robot structure with **cgr_create**.
* Actuate and update the joint with **cgr_self_update** functions.
* If necessary, plot the robot with **ncgr_plot** by first calling **ncgr_graphic** once at the beginning of the program.

![Screenshot][sshot]

[sshot]: https://raw.githubusercontent.com/auralius/matlab-dh-parameters/master/sshot.png "Screenshot"

Auralius Manurung 
manurung.auralius@gmail.com
