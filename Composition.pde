class Composition{
	PApplet parent;
	GLTexture[] tex;
	boolean isPlaying = false;
	float duration = 0.0;
	float timelineValue = 0.0;
	float timer = 0.0;
	int top=999, bottom=999;
	boolean firstBlend = true;
	boolean initialize=true;

	Composition(PApplet applet){
		parent = applet;
		tex = new GLTexture[nbLayers-1];
		for (int i = 0; i<nbLayers-1; i++){
			tex[i] = new GLTexture(parent);
		}
	}

	void display(){
		if(isPlaying){
			if(initialize){
				println("Start composition");
				for (int i = 0; i<nbLayers; i++){
					// re init layers
					layers[i].timelineValue=0.0;
					layers[i].currentClip=0;
					// re init layers clips
					for(int j = 0; j<layers[i].clips.size(); j++){
						(layers[i].clips).get(i).ended = false;
					}
				}
				initialize=false;
			}

			fill(20);
			rect(1005,15,490,280);
			for (int i = nbLayers-1; i>=0; i--){
				if(timelineValue>layers[i].Delay && timelineValue<layers[i].Delay+layers[i].duration && layers[i].clips.size()>0 && layers[i].currentClip<layers[i].clips.size()){
					layers[i].isPlaying=true;
					layers[i].timelineValue=timelineValue-layers[i].Delay;
					(layers[i].clips).get(layers[i].currentClip).movie.play();
					layers[i].display();

					if(top==999){
						top = i;
					}
					else{
						bottom = i;
						if(firstBlend){
							firstBlend = false;
							println("top: "+top);
							println("layers[top].currentClip: "+layers[top].currentClip);
							println("bottom: "+bottom);
							println("layers[bottom].currentClip: "+layers[bottom].currentClip);
							println("blendMode: "+layers[top].clips.get(layers[top].currentClip).blendMode);
							BlendModes[layers[top].clips.get(layers[top].currentClip).blendMode].apply(new GLTexture[]{layers[top].tex, layers[bottom].tex}, tex[bottom]);
						}
						else{
							BlendModes[layers[top].clips.get(layers[top].currentClip).blendMode].apply(new GLTexture[]{tex[top], layers[bottom].tex}, tex[bottom]);
						}
						top = bottom;
					}
				}
				else{
					layers[i].isPlaying=false;
					layers[i].timelineValue=0;
				}
			}
			if(top!=999 && bottom!=999){
				image(tex[bottom],1005,15,490,280);
			}
			else if(top!=999) image(layers[top].tex,1005,15,490,280);
			top=999;
			bottom=999;

			updateCompositionGui();
		}
	}

	void export(){
		JSONObject export = new JSONObject();
	}

	void updateCompositionGui(){
		timelineValue += (millis()-timer)/1000;
		timer = millis();

		if(timelineValue>duration){// stop composition
			isPlaying=false;
			initialize = true;
			timelineValue=0.0;
		
			// stop layers
			for(int i=0; i<nbLayers; i++){
				layers[i].isPlaying=false;
			}
		}

		Composition_Timeline.setRange(0.0, duration);
		Composition_Timeline.setValue(timelineValue);
		Composition_Timeline.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
	}
}