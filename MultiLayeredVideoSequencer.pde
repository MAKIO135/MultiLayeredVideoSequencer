import processing.opengl.*;
import codeanticode.glgraphics.*;
import codeanticode.gsvideo.*;
import controlP5.*;
import org.json.*;//used for export

//////////////////////////////Clips
String[] Playlist;
Clip editClip;

//////////////////////////////Layers
LayerVideo[] layers;
int nbLayers = 8;
int editLayer = 0;

//////////////////////////////Composition
Composition composition;
GLTextureFilter[] BlendModes;

//////////////////////////////GUI
ControlP5 gui;
int[] updateLayerClip = {999,999};

void setup(){
	size(1500, 800, GLConstants.GLGRAPHICS);
	background(20);
	noStroke();

	// load videos and check if you need to load or create thumbnails
	loadVideos();
	checkThumbnails();

	// create a Clip for edition
	editClip = new Clip(this);
	editClip.isEditClip = true;

	// create layers
	layers = new LayerVideo[nbLayers];
	for (int i = 0; i<nbLayers; i++){
		layers[i] = new LayerVideo(this, i);
	}

	// create composition
	composition = new Composition(this);
	initBlendModes();
	
	// init GUI
	gui = new ControlP5(this);
	initClipGui();
	initLayerGui();
	initCompositionGui();
}

void draw(){
	editClip.display();
	layers[editLayer].display();
	composition.display();
}


void movieEvent(GSMovie movie) {
	movie.read();
}

// used for debug
void keyPressed(){
	if(key=='r' || key=='R'){
		composition.isPlaying=false;
		for (int i = 0; i<nbLayers; i++){
			layers[i].resetLayer();
		}
	}
}