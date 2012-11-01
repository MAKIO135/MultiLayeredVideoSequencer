class Clip{
	PApplet parent;

	boolean isEditClip = false;
	boolean isLoaded = false;// clip is loaded
	boolean ended = false;// clip finished reading

	int movieNum=999;
	GSMovie movie;
	float duration;// duration of the movie
	float readPosition;// time of the reading on totalDuration
	int lectureMode=0;// play/
	int nbRepeat=1;// number of repetition
	int nbLecture=0;// current number of reads
	float totalDuration;// duration of the movie multiplied by number of repetition

	float movieSpeed=1.0;
	float TargetOpacity=1.0;
	float Opacity;// current Opacity
	float posX=0, posY=0;
	float Scale=1.0;
	float fadeInAlpha=1.0;
	float fadeInAlphaStep;
	float fadeInDuration=0.1;
	float fadeOutAlpha=1.0;
	float fadeOutAlphaStep;
	float fadeOutDuration=0.1;
	int blendMode=0;	

	GLTexture tex;
	GLTexture texFiltered;
	GLTextureFilter ClipFilter;

	Clip(PApplet applet){
		parent = applet;
		ClipFilter = new GLTextureFilter(parent, "ClipFilter.xml");
	}

	void setVideo(){
		isLoaded = false;
		// check if a movie is loaded and delete it
		if(movie != null){
			movie.stop();
			movie.delete();
			tex.delete();
			texFiltered.delete();
			println("Movie deleted");
		}

		// load movie and set Texture
		movie = new GSMovie(parent,"videos/"+Playlist[movieNum]);
		tex = new GLTexture(parent);
		texFiltered = new GLTexture(parent);
		movie.setPixelDest(tex);
		tex.setPixelBufferSize(10);
		tex.delPixelsWhenBufferFull(false);

		if(isEditClip){
			gui.getController("Clip_PlayPause").setValue(1.0);
			movie.play();
			while(movie.width<10){
				movie.volume(0.0);
			}

			// calculs for fadeIn & fadeOut
			Opacity = fadeInAlpha;
			fadeInAlphaStep = (TargetOpacity - fadeInAlpha)/(fadeInDuration*movie.getSourceFrameRate());
			fadeOutAlphaStep = (TargetOpacity - fadeOutAlpha)/(fadeOutDuration*movie.getSourceFrameRate());
			// println(fadeInAlphaStep);
			// println(fadeOutAlphaStep);
			Clip_Timeline.setValue(0);
			movie.goToBeginning();
		}
		isLoaded=true;
	}

	void launch(){
		movie.play();
		movie.volume(0.0);
		movie.goToBeginning();
	}

	void display(int x, int y, int w, int h){
		if(movie.ready()){
			if (tex.putPixelsIntoTexture()) {	
				// apply GLSL Filter		
				ClipFilter.setParameterValue("posXY", new float[] {posX, posY});
				ClipFilter.setParameterValue("Scale", Scale);
				if(TargetOpacity-Opacity>.1) Opacity += fadeInAlphaStep;
				ClipFilter.setParameterValue("Opacity", Opacity);
				tex.filter(ClipFilter, texFiltered);
				if(isEditClip){
					fill(20);
					rect(x,y,w,h);
					image(texFiltered,x,y,w,h);
				}
			}

			// check loop/playback/stop
			
			if(movie.time()<=.1){
				movie.speed(movieSpeed);
			}
			else if(movie.duration()-movie.time()<=.1){
				if(lectureMode==0){
					nbLecture++;
					if(nbLecture<nbRepeat || isEditClip){
						movie.jump(0);
					}
					else{
						ended = true;
						movie.stop();
					}
				}
				else if(lectureMode==1) {
					movie.speed(-movieSpeed);
				}
			}
		}
	}

	void updateClipGui(){
		duration = movie.duration();
		totalDuration = duration * nbRepeat;
		Clip_Timeline.setRange(0.0, duration);
		Clip_Timeline.setValue(movie.time());
		Clip_Timeline.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
		Clip_Duration.setText("DURATION: "+duration);
	}
}