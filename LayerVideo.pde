class LayerVideo{
	PApplet parent;
	int id;

	ArrayList<Clip> clips;
	int currentClip = 0;

	boolean isSelected = false;
	boolean isPlaying = false;
	float layerDuration = 0.0;
	float timelineValue = 0.0;
	float posX=0, posY=0;
	float Scale=1.0;
	float Opacity=1.0;
	float Delay=0.0;
	float fadeInAlpha;
	float fadeInDuration;
	float fadeOutAlpha;
	float fadeOutDuration;

	GLTexture tex;
	boolean setTexture = true;
	GLTexture texFiltered;
	GLTextureFilter LayerFilter;

	LayerVideo(PApplet applet, int _id){
		parent = applet;
		id = _id;
		clips = new ArrayList<Clip>();
		tex = new GLTexture(parent);
		texFiltered = new GLTexture(parent);
		LayerFilter = new GLTextureFilter(parent, "LayerFilter.xml");
	}

	void display(){
		if(clips.size()>0 && currentClip<clips.size() && isPlaying){
			// println("Layer"+id+" playing");
			(clips.get(currentClip)).display();
			(clips.get(currentClip)).texFiltered.filter(LayerFilter, texFiltered);
			image(texFiltered,505,15,490,280);
			
			if((clips.get(currentClip)).ended){
				currentClip++;
				println("Layer"+id+".currentClip: "+currentClip);
				if(currentClip<clips.size()) (clips.get(currentClip)).movie.play();
			}
		}
	}

	void updateLayerGui(){
		Layer_Timeline[id].setRange(0.0, layerDuration);
		Layer_Timeline[id].setValue(0.0);
		Layer_Timeline[id].getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
		Layer_Duration[id].setText("DURATION: "+layerDuration);
	}
}