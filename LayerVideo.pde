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
		if(!isPlaying){
			fill(255);
			rect(505,15,490,280);
		}
		if(clips.size()>0){
			/*if(isPlaying){
				if((clips.get(currentClip)).texFiltered.putPixelsIntoTexture()){
					tex = (clips.get(currentClip)).texFiltered;
					tex.filter(LayerFilter, texFiltered);
				}
				clips.get(currentClip).display(505,15,490,280);

				
				if(clips.get(currentClip).duration - clips.get(currentClip).movie.time()<1){
					clips.get(currentClip).movie.stop();
					if(currentClip < clips.size()-1){
						currentClip++;
						clips.get(currentClip).movie.play();
					}
				}
			}*/
		}
	}

	void updateLayerGui(){
		Layer_Timeline[id].setRange(0.0, layerDuration);
		Layer_Timeline[id].setValue(0.0);
		Layer_Timeline[id].getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
		Layer_Duration[id].setText("DURATION: "+layerDuration);
	}
}