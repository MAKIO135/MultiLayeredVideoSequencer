import processing.opengl.*;
import codeanticode.glgraphics.*;
import codeanticode.gsvideo.*;
import controlP5.*;

//////////////////////////////Clips
String[] Playlist;
Clip editClip;

//////////////////////////////GUI
ControlP5 gui;


void setup(){
	size(500, 800, GLConstants.GLGRAPHICS);
	background(20);
	noStroke();

	// load videos and check if you need to load or create thumbnails
	loadVideos();
	Playlist = loadStrings("data/playlist.txt");
	checkThumbnails();

	// create a Clip for edition
	editClip = new Clip(this);
	editClip.isEditClip = true;

	// init GUI
	gui = new ControlP5(this);
	initClipGui();
}

void draw(){
	if(editClip.isLoaded){
		editClip.display(5,15,490,280);
		editClip.updateClipGui();
	}
}

void movieEvent(GSMovie movie) {
	movie.read();
}