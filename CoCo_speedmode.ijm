/*CoCo the colony counter ImageJ macro
 * SPEEDMODE - no checkpoints, minimal clicks!
 * author: Jia Xuan Leong
 */


//global variables
var dir; //directory of image
var prominence = 40;
var areaname = "area name";
var biorep = 1;
//

macro "Process Image [f1]" {
	dir = getDirectory("image");
	img = getTitle();
	//dir = getDirectory(ori);
	setTool("rectangle");
	Dialog.createNonBlocking("");
	Dialog.addMessage("Crop");
	Dialog.show();
	run("Split Channels");
	selectWindow(img + " (red)");
	close();
	selectWindow(img + " (green)");
	close();
	run("Subtract Background...", "rolling=30");
	run("Mean...", "radius=1");
	run("Enhance Contrast...", "saturated=0.3 normalize");
	//run("Multiply...", "value=2");
	run("Select None");
	setTool("rectangle");
}

macro "Count Colonies [f2]" {
	run("Select None");
	/*
	 * Area selection and counting
	 */
	setTool("rectangle");
	Dialog.createNonBlocking("Define area");
	Dialog.addNumber("Find Maxima, Prominence", prominence);
	Dialog.addString("Name area", areaname);
	if (biorep == 7)
		biorep = 1;
	Dialog.addNumber("Biorep", biorep);
	Dialog.show();
	
	prominence = Dialog.getNumber();
	areaname = Dialog.getString();
	biorep = Dialog.getNumber();
	
	run("Find Maxima...", "prominence=" + prominence + " exclude output=[Point Selection]");
	run("Point Tool...", "type=Dot color=Red size=Tiny");
	setTool("multipoint");
	Dialog.createNonBlocking("Cleanup points");
	Dialog.show();
	
	run("Set Measurements...", "  redirect=None decimal=5");
	run("Clear Results");
	run("Measure");
	colonyno = Table.size("Results");
	print(areaname + " " + biorep + ", " + colonyno); 
	biorep += 1;
	close("Results");
	selectWindow("Log");
}
