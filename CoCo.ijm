/*CoCo the colony counter ImageJ macro
 * author: Jia Xuan Leong
 */


//global variables
var dir; //directory of image
var prominence = 20;
var areaname = "area name";
//

macro "Process Image" {
	dir = getDirectory("image");
	img = getTitle();
	//dir = getDirectory(ori);
	waitForUser("Crop image if needed");
	run("Split Channels");
	selectWindow(img + " (red)");
	close();
	selectWindow(img + " (green)");
	close();
	run("Subtract Background...", "rolling=30");
	run("Mean...", "radius=1");
	run("Enhance Contrast...", "saturated=0.3 normalize");
	run("Multiply...", "value=2");
	run("Select None");
	setTool("rectangle");
}

macro "Count Colonies" {
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
	prominence = Dialog.getNumber();
	areaname = Dialog.getString();
	done = Dialog.getCheckbox();
	while (!done) {
		Dialog.addMessage("Using area selection tools eg. rectangle, circle etc., define the area for colony counting, then give a name for the label.");
		Dialog.addCheckbox("Done", 0);
		Dialog.addString("Name area", "Xcv control no.1");
		Dialog.show();
		areaname = Dialog.getString();
		done = Dialog.getCheckbox();
	}
	run("Find Maxima...", prominence + " exclude output=[Point Selection]");
	run("Point Tool...", "type=Dot color=Red size=Tiny");
	setTool("multipoint");
	Dialog.createNonBlocking("Cleanup points");
	Dialog.addMessage("Click to add points, or Ctrl + click to delete points");
	Dialog.addCheckbox("Cleanup done", 0);
	Dialog.show();
	run("Set Measurements...", "  redirect=None decimal=5");
	run("Clear Results");
	run("Measure");
	colonyno = Table.size("Results");
	print(areaname + ", " + colonyno); 
	selectWindow("Log");
}