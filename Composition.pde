class Composition{
	PApplet parent;
	GLTexture tex;
	boolean isPlaying = false;

	Composition(PApplet applet){
		parent = applet;
		tex = new GLTexture(parent);
	}

	void display(){
		fill(255);
		rect(1005,15,490,280);
	}

	void export(){
		JSONObject export = new JSONObject();
	}
}