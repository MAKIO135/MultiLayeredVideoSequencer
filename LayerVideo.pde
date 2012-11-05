class LayerVideo{
	PApplet parent;
	int id;

	ArrayList<Clip> clips;
	int currentClip = 0;

	boolean isEditLayer = false;
	boolean isPlaying = false;
	float layerDuration = 0.0;
	float timelineValue = 0.0;
	float timer = 0.0;
	float posX=0, posY=0;
	float Scale=1.0;
	float Opacity=0.0;
	float TargetOpacity=1.0;
	float Delay=0.0;
	float fadeInAlpha;
	float fadeInDuration;
	float fadeOutAlpha;
	float fadeOutDuration;

	boolean setTexture = true;
	GLTexture tex;
	GLTextureFilter LayerFilter;

	LayerVideo(PApplet applet, int _id){
		parent = applet;
		id = _id;
		clips = new ArrayList<Clip>();
		tex = new GLTexture(parent);
		LayerFilter = new GLTextureFilter(parent, "LayerFilter.xml");
	}

	void display(){
		if(clips.size()>0 && currentClip<clips.size() && isPlaying){
			// println("Layer"+id+" playing");
			(clips.get(currentClip)).display();
			updateGLSLParams();
			(clips.get(currentClip)).texFiltered.filter(LayerFilter, tex);

			// display editLayer in editor
			if(isEditLayer){
				// due to Layer alpha, we need to "erase" previous frame
				fill(20);
				rect(505,15,490,280);

				image(tex,505,15,490,280);
				updateLayerGui();
			}
			
			if((clips.get(currentClip)).ended){
				println("Layer"+id+".currentClip: "+currentClip+" ended");
				if(isEditLayer){
					float timelineValueUp=0.0;
					for (int i = 0; i<= currentClip; i++){
						timelineValueUp += ((clips.get(currentClip)).duration*(clips.get(currentClip)).nbRepeat)/(clips.get(currentClip)).movieSpeed;
					}
					timelineValue = timelineValueUp;
				}

				currentClip++;
				if(currentClip<clips.size()){
					println("Layer"+id+".currentClip: "+currentClip);
					(clips.get(currentClip)).movie.play();
				}
				else{
					// gui.getController("Layer_PlayPause"+id).setValue(0.0);
					println("Layer"+id+" ended");
					isPlaying = false;
				}
			}
		}
	}

	void updateLayerGui(){
		timelineValue += (millis()-timer)/1000;
		if(timelineValue>layerDuration) timelineValue=0.0;
		timer = millis();
		Layer_Timeline[id].setRange(0.0, layerDuration);
		Layer_Timeline[id].setValue(timelineValue);
		Layer_Timeline[id].getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
	}

	void updateGLSLParams(){
		LayerFilter.setParameterValue("posXY", new float[] {posX, posY});
		LayerFilter.setParameterValue("Scale", Scale);
		if(timelineValue<fadeInDuration){
			Opacity = fadeInAlpha+timelineValue*((TargetOpacity-fadeInAlpha)/fadeInDuration);
			println(Opacity);
		}
		else if(layerDuration-timelineValue<fadeOutDuration){
			Opacity = fadeOutAlpha+(layerDuration-timelineValue)*((TargetOpacity-fadeOutAlpha)/fadeOutDuration);
			println(Opacity);
		}
		else Opacity = TargetOpacity;
		LayerFilter.setParameterValue("Opacity", Opacity);
	}
}