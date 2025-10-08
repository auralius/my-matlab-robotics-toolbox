# my-matlab-robotics-toolbox

A simple and straightforward implementation of the DH-parameters in MATLAB  

There are two different conventions on the implementation of the DH-parameters. This one uses the standard DH-parameters which can as well be found in this book: https://www.cs.duke.edu/brd/Teaching/Bio/asmb/current/Papers/chap3-forward-kinematics.pdf. The results have been validated with Peter Corke's RVC toolbox (https://github.com/petercorke/robotics-toolbox-matlab).

**cgr** prefix means the code is code-generation ready.    
**ncgr** means the code is **NOT** code-generation ready.

Features:  
* Forward kinematics
* Homogenous transformation of each link of the robot
* Numerical Jacobian
* Simple visualization, it can also be animated
* Inverse kinematics with the pseudo-inverse method and damped least square method.
* Code generation ready.

How to use:
* Create the robot structure with **cgr_create**.
* Actuate and update the joint with **cgr_self_update** functions.
* If necessary, plot the robot with **ncgr_plot** by first calling **ncgr_graphic** once at the beginning of the program.
* To create the compiled MEX or DLL files, two examples of MATLAB Coder project files  are provided. 

[Here are some kinematics problems for us to try!](https://docs.google.com/presentation/d/1IwAoLZMTFeWiz0YZUyCvjQ4Hp7PpCqGMhgCqimQRPWs/edit?usp=sharing)

**Screenshot Gallery:**

![Screenshot][sshot]

[sshot]: https://raw.githubusercontent.com/auralius/my-matlab-robotics-toolbox/master/sshot.png "Screenshot"

![Screenshot][sshot3]

[sshot3]: https://raw.githubusercontent.com/auralius/my-matlab-robotics-toolbox/master/sshot3.png "Screenshot3"

![Screenshot][sshot2]

[sshot2]: https://raw.githubusercontent.com/auralius/my-matlab-robotics-toolbox/master/sshot2.png "Screenshot2"

Auralius Manurung 
auralius.manurung@ieee.org
