# CoCo
Bacterial colony counter written in ImageJ macro language

This macro enables easy counting of bacterial colonies on Petri plates. 
Images are first processed in using standard ImageJ commands such as Subtract Background, Enhance Contrast etc.
Then the user is prompted to select area of interest, and the Find Maxima command is used to automatically count colonies.
The user can modify the detected colonies to enable more accurate colony counting.

# **CoCo User Guide**
## Experimental Setup

This is an example of a standard bacterial growth experiment which CoCo was optimized for. CoCo can also be used as a standard counter of colonies on agar plates.
At least 40 ml of media should be poured into a standard square Petri plate, to make up a depth of 5 mm. If you are using standard round Petri plates this will be around 15(?) ml of media. This is to enable better contrast between colonies and background when the plates are scanned later. Ensure the surface of the agar is thoroughly dry, to facilitate the “flow” of bacterial suspension droplets down the agar later (see image below).
An example bacterial growth experiment that CoCo was optimized for is as follows:
1.	Make dilutions of bacteria suspension and technical replicates using a multi-channel pipette and a 96-well plate.
2.	Using a multi-channel pipette, take up 10 ul of bacteria from each well.
3.	Tilt the plate towards you at a 45 degree angle, and gently pipette the bacteria on to the plate. The bacterial suspension should flow downwards and create lanes. Tilt the plate so that the lanes do not merge. 
4.	Once the lanes dry on to the agar, place the lid back onto the plate and allow bacteria to grow.


![plate_scanned](https://user-images.githubusercontent.com/50719253/110786017-ed57d500-826b-11eb-8589-fe0c3d44900b.png)



## Image acquisition

A scanner is recommended for imaging. Plates should be placed without their lids, and with the top of the agar facing the scanner. A BLACK background must be used behind the plate to enable sufficient contrast between the colonies and the background. See the example scanned image available in the GitHub Repository.
Resolution of 300dpi was found to be sufficient, however 720dpi is recommended especially for small colonies. Please save all image files as TIFF.


## Install the macro

**Option 1:**

This permanently installs the macros to your ImageJ toolbar so you do not have to re-install it every time FIJI starts up.
1.	Find your ImageJ directory, under the macros folder, open StartupMacros.ijm in Notepad (or your word editor of choice)
2.	Open CoCo.ijm in Notepad (or your word editor of choice)
3.	Copy the contents of CoCo.ijm to the end of StartupMacros.ijm.
 ![install_option1](https://user-images.githubusercontent.com/50719253/110786032-f183f280-826b-11eb-9ca8-99f24a4f4537.png)

**Option 2:**
This is quicker, but needs to be repeated every time FIJI is started up.

In the ImageJ toolbar, Plugins > Macros > Install > Select CoCo.ijm

![install_option2](https://user-images.githubusercontent.com/50719253/110786095-03fe2c00-826c-11eb-89b6-cd4439b1b823.png)



## Run the macro

*This macro was written for FIJI is just ImageJ (FIJI).
Please ensure that your FIJI is up to date before proceeding. *

1.	Open your image containing colonies to be counted.
2.	Locate and select the Process Image command.
Alternatively, the macro has been assigned the keyboard shortcut F1, simply press this key with the ImageJ toolbar in focus and the macro will run.
3.	You will be given the chance to crop your image if needed	
	To crop, select relevant area then press Ctrl + Shift + X
5.	Your image will now be processed to facilitate colony counting.
6.	Locate and select the Count Colonies command, then run it. 
Alternatively, use shortcut F2.
6.	Select and name the area of interest when prompted. Input a value for prominence.
This the parameter that ImageJ’s “Find Maxima” function uses to define bright spots. Typical values range from 10 – 35 for densely packed colonies, up to 100 - 120 for colonies spaced further apart. These values can be approximated to mean “how much brighter should a region of pixels be compared to its surroundings, before it is recognized as a bright spot”

To reduce background noise, increase prominence. To increase detection of small/faint colonies, decrease prominence.

![img_processed](https://user-images.githubusercontent.com/50719253/110786153-12e4de80-826c-11eb-98b8-9f91f15790ed.png) &nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://user-images.githubusercontent.com/50719253/110786164-14aea200-826c-11eb-93c7-8c6b7988d146.png" height="620">


7.	Automatically detected colonies will be marked by a red dot. 
8.	You can now manually correct the detected colonies. Use the left mouse click to select more colonies, and 
Ctrl +Click to remove colonies. Tick the checkbox when you are done.
9.	The counted colonies will be printed into your Log window. **Do not close this window until you are done!!!**
10.	Run the Count Colonies command as many times as needed. 
11.	When colony counting is complete, save the Log file.
12.	Import into excel as a CSV (comma-separated values) file.

## **CoCo_speedmode**

For experienced users, a quicker version of the original macro has been included. This version has less descriptive instructions in the dialog boxes that appear during run of the macro, and requires less clicks from the user.

## Tips and tricks:

If image segmentation (processing of image so that objects of interest appear white, and background appears black) needs to be fined-tuned, some additional processing steps can be used. These functions are all included in FIJI, and can be found on the toolbar.
* Remove Outliers: This is useful for removing background noise present as spots smaller/darker than colonies. 
* Subtract Background: This is useful for removing background noise present as larger areas darker than colonies.
* Enhance Contrast: This is useful for making colonies brighter, however may increase background noise.

These commands can be used in combination with each other. Happy experimenting!
