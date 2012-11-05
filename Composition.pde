class Composition{
	PApplet parent;
	GLTexture tex;
	boolean isPlaying = false;
	float startTime = 0.0;
	float playPosition;

	Composition(PApplet applet){
		parent = applet;
		tex = new GLTexture(parent);
	}

	void display(){
		fill(255);
		rect(1005,15,490,280);
		/*
		if(isPlaying){
			playPosition=millis-startTime;// have to take pause in account
			for (int i = nbLayers-1; i>=0; i--){
				if(playPosition>layers[i].delay){
					layers[i].display();
					
				}
			}
		}
		*/
	}

	void start(){
		startTime = millis();
		playPosition = 0.0;
	}

	void export(){
		JSONObject export = new JSONObject();
	}
}