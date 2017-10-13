# my-matlab-robotics-toolbox

Simple and straight-forward implementation of DH-parameters in MATLAB  
This can be used to execute forward kinematics of the robot to find position and orientation of every link of the robot.  

There are two different conventions on the implementation of the DH-parameters. This one uses the standard DH-parameters which can as well be found in this book: https://www.cs.duke.edu/brd/Teaching/Bio/asmb/current/Papers/chap3-forward-kinematics.pdf. The results have been validated with Peter Corke's RVC toolbox (https://github.com/petercorke/robotics-toolbox-matlab).

**cgr** prefix means the code is code-generation ready.    
**ncgr** means the code is **NOT** code-generation ready.

Features:  
* Forward kinematics
* Homogenous transformation of each link of the robot
* Numerical jacobian
* Simple visualization, it can also be animated
* Inverse kinematics with the pseudo-inverse method and damped least square method.
* Code generation ready.

How to use:
* Create a global variable N_DOFS and define the number of degree-of-freedom of the robot in it. The reason why global variable is used is because I keep having problems in using the dynamic memory allocation for MATLAB coder. Therefore, I use global variable to define the dimension of the necessary static arrays.
* Create the robot structure with **cgr_create**.
* Actuate and update the joint with **cgr_self_update** functions.
* If necessary, plot the robot with **ncgr_plot** by first calling **ncgr_graphic** once at the beginning of the program.
* To create the compiled MEX or DLL files, two examples of MATLAB Coder project files  are provided. This is where the global variable is used.

![Screenshot][sshot]

[sshot]: https://raw.githubusercontent.com/auralius/my-matlab-robotics-toolbox/master/sshot.png "Screenshot"

![Screenshot][sshot2]

[sshot2]: https://raw.githubusercontent.com/auralius/my-matlab-robotics-toolbox/master/sshot2.png "Screenshot2"

Auralius Manurung 
manurunga@yandex.com