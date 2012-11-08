class LayerVideo{
	PApplet parent;
	int id;

	ArrayList<Clip> clips;
	int currentClip = 0;

	boolean isEditLayer = false;
	boolean isPlaying = false;
	float duration = 0.0;
	float timelineValue = 0.0;
	float timer = 0.0;
	float posX=0, posY=0;
	float Scale=1.0;
	float Opacity=0.0;
	float TargetOpacity=1.0;
	float Delay=0.0;
	float fadeInAlpha=1.0;
	float fadeInDuration=0.1;
	float fadeOutAlpha=1.0;
	float fadeOutDuration=0.1;

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
						timelineValueUp += ((clips.get(i)).duration*(clips.get(i)).nbRepeat)/(clips.get(i)).movieSpeed;
					}
					timelineValue = timelineValueUp;
				}

				currentClip++;
				if(currentClip<clips.size()){
					println("Layer"+id+".currentClip: "+currentClip);
					(clips.get(currentClip)).movie.play();
				}
				else{
					// gui.getController("Layer_PlayPause"+id).setValue(0.0);// problem with controlp5
					println("Layer"+id+" ended");
					isPlaying = false;

					// restart clips
					currentClip = 0;
					for(int i = 0; i<clips.size(); i++){
						clips.get(i).ended = false;
					}
				}
			}
		}
	}

	void updateLayerGui(){
		timelineValue += (millis()-timer)/1000;
		if(timelineValue>duration) timelineValue=0.0;
		timer = millis();
		Layer_Timeline[id].setRange(0.0, duration);
		Layer_Timeline[id].setValue(timelineValue);
		Layer_Timeline[id].getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
	}

	void updateGLSLParams(){
		LayerFilter.setParameterValue("posXY", new float[] {posX, posY});
		LayerFilter.setParameterValue("Scale", Scale);
		if(timelineValue<fadeInDuration){
			Opacity = fadeInAlpha+timelineValue*((TargetOpacity-fadeInAlpha)/fadeInDuration);
			// println(Opacity);
		}
		else if(duration-timelineValue<fadeOutDuration){
			Opacity = fadeOutAlpha+(duration-timelineValue)*((TargetOpacity-fadeOutAlpha)/fadeOutDuration);
			// println(Opacity);
		}
		else Opacity = TargetOpacity;
		LayerFilter.setParameterValue("Opacity", Opacity);
	}

	void resetLayer(){
		isPlaying = false;
		Layer_PlayPause[id].setValue(0.0);
		isEditLayer = false;
		currentClip = 0;
		duration = 0.0;
		Layer_Duration[id].setText("DURATION: 0.0");
		timelineValue = 0.0;
		Layer_Timeline[id].setValue(0.0);
		timer = 0.0;
		posX=0;
		posY=0;
		Layer_XY[id].setArrayValue(new float[]{100,100});
		Scale=1.0;
		Layer_Scale[id].setValue(1.0);
		Opacity=0.0;
		TargetOpacity=1.0;
		Layer_Opacity[id].setValue(1.0);
		Delay=0.0;
		Layer_Delay[id].setValue(0.0);
		fadeInAlpha=1.0;
		Layer_fadeInAlpha[id].setValue(1.0);
		fadeInDuration=0.1;
		Layer_fadeInDuration[id].setValue(0.1);
		fadeOutAlpha=1.0;
		Layer_fadeOutAlpha[id].setValue(1.0);
		fadeOutDuration=0.1;
		Layer_fadeOutDuration[id].setValue(0.1);
		for(int i = clips.size()-1; i>=0; i--){
			clips.get(i).movie.stop();
			clips.get(i).texFiltered.delete();
			clips.get(i).tex.delete();
			clips.get(i).ClipFilter.delete();
			clips.remove(i);
			gui.remove("Layer"+id+"Clip"+i);
		}
		fill(20);
		rect(505,15,490,280);
	}
}