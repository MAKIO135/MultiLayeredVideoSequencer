class Composition{
	PApplet parent;
	GLTexture tex;
	boolean isPlaying = false;
	float duration = 0.0;
	float timelineValue = 0.0;
	float timer = 0.0;

	Composition(PApplet applet){
		parent = applet;
		tex = new GLTexture(parent);
	}

	void display(){
		fill(255);
		rect(1005,15,490,280);
		if(isPlaying){
			updateCompositionGui();
		/*
			for (int i = nbLayers-1; i>=0; i--){
				if(playPosition>layers[i].delay){
					layers[i].display();
					
				}
			}
		*/
		}
	}

	void export(){
		JSONObject export = new JSONObject();
	}

	void updateCompositionGui(){
		timelineValue += (millis()-timer)/1000;
		if(timelineValue>duration) timelineValue=0.0;
		timer = millis();
		Composition_Timeline.setRange(0.0, duration);
		Composition_Timeline.setValue(timelineValue);
		Composition_Timeline.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
	}
}