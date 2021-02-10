/*CoCo the colony counter ImageJ macro
 * author: Jia Xuan Leong
 */


//global variables
var dir; //directory of image
var prominence = 40;
var areaname = "area name";
//

macro "Process Image [f1]" {
	dir = getDirectory("image");
	img = getTitle();
	//dir = getDirectory(ori);
	setTool("rectangle");
	Dialog.createNonBlocking("");
	Dialog.addMessage("Crop image if needed. Include only the agar plate and its edges, for optimal image processing later.");
	Dialog.addCheckbox("Image has been cropped and/or is ready for processing.", 0);
	Dialog.show();
	idiotproofcheckpoint = Dialog.getCheckbox();
	while (!idiotproofcheckpoint) {
		Dialog.createNonBlocking("");
		Dialog.addMessage("Crop image if needed. Include only the agar plate and its edges, for optimal image processing later.");
		Dialog.addCheckbox("Image has been cropped and/or is ready for processing.", 0);
		Dialog.show();
		idiotproofcheckpoint = Dialog.getCheckbox();
	}
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
	Dialog.addMessage("Using area selection tools eg. rectangle, define and name the area for colony counting.");
	Dialog.addNumber("Find Maxima, Prominence", prominence);
	Dialog.addCheckbox("Area selection and labelling done", 0);
	Dialog.addString("Name area", areaname);
	Dialog.show();

	idiotproofcheckpoint = Dialog.getCheckbox();
	while (!idiotproofcheckpoint) {
		Dialog.createNonBlocking("Define area");
		Dialog.addMessage("Using area selection tools eg. rectangle, define and name the area for colony counting.");
		Dialog.addNumber("Find Maxima, Prominence", prominence);
		Dialog.addCheckbox("Area selection and labelling done", 0);
		Dialog.addString("Name area", areaname);
		Dialog.show();
		idiotproofcheckpoint = Dialog.getCheckbox();
	}
	
	prominence = Dialog.getNumber();
	areaname = Dialog.getString();

	run("Find Maxima...", "prominence=" + prominence + " exclude output=[Point Selection]");
	run("Point Tool...", "type=Dot color=Red size=Tiny");
	setTool("multipoint");
	Dialog.createNonBlocking("Cleanup points");
	Dialog.addMessage("Click to add points, or Ctrl + click to delete points");
	Dialog.addCheckbox("Cleanup done", 0);
	Dialog.show();
	idiotproofcheckpoint = Dialog.getCheckbox();
	while (!idiotproofcheckpoint) {
		Dialog.createNonBlocking("Cleanup points");
		Dialog.addMessage("Click to add points, or Ctrl + click to delete points");
		Dialog.addCheckbox("Cleanup done", 0);
		Dialog.show();
		idiotproofcheckpoint = Dialog.getCheckbox();
	}
	
	run("Set Measurements...", "  redirect=None decimal=5");
	run("Clear Results");
	run("Measure");
	colonyno = Table.size("Results");
	print(areaname + ", " + colonyno); 
	close("Results");
	selectWindow("Log");
}
