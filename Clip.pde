class Clip{
	PApplet parent;

	boolean isEditClip = false;
	boolean isLoaded = false;// clip is loaded
	boolean ended = false;// clip ended

	int movieNum=999;
	GSMovie movie;
	float duration;// duration of the movie
	float timelineValue = 0.0;
	float timer = 0.0;
	int lectureMode=0;// 0:loop - 1:play/playback
	int nbRepeat=1;// number of repetition
	int nbLecture=1;// current number of reads
	boolean addLectureSwitch=false;// utility boolean to count nbLecture

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

		movie.play();
		while(movie.width<1){
			movie.volume(0.0);
		}
		movie.goToBeginning();

		if(isEditClip){
			gui.getController("Clip_PlayPause").setValue(1.0);
			Clip_Timeline.setValue(0);

			// calculs for fadeIn & fadeOut
			Opacity = fadeInAlpha;
			fadeInAlphaStep = (TargetOpacity - fadeInAlpha)/(fadeInDuration*movie.getSourceFrameRate());
			// println(fadeInAlphaStep);
			fadeOutAlphaStep = (TargetOpacity - fadeOutAlpha)/(fadeOutDuration*movie.getSourceFrameRate());
			// println(fadeOutAlphaStep);
		}
		else{
			movie.pause();
		}

		movie.speed(movieSpeed);
		duration = movie.duration();
		isLoaded=true;
	}

	void display(){
		if(isLoaded && movie.ready()){
			if(lectureMode == 0) movie.speed(movieSpeed);
			if (tex.putPixelsIntoTexture()) {
				updateGLSLParams();
				// apply GLSL Filter
				tex.filter(ClipFilter, texFiltered);

				// display editClip in editor
				if(isEditClip){
					// due to Clip alpha, we need to "erase" previous frame
					fill(20);
					rect(5,15,490,280);

					image(texFiltered,5,15,490,280);
					updateClipGui();
				}
			}

			// check loop/playback/stop
			checkLoop();
		}
	}
	
	void checkLoop() {
		// check at Beginning
		if(addLectureSwitch && movie.frame()<=2*max(1,movieSpeed)){
			movie.speed(movieSpeed);
			nbLecture++;
			addLectureSwitch=false;
		}
		// check at end
		else if(movie.length()-movie.frame()<=2*max(1,movieSpeed)){
			// lectureMode: loop
			if(lectureMode==0){
				movie.goToBeginning();
				movie.pause();
				movie.speed(movieSpeed);
				movie.play();
				nbLecture++;
			}

			// lectureMode: play/playback
			else if(lectureMode==1 && !addLectureSwitch) {
				nbLecture++;
				addLectureSwitch=true;
				movie.speed(-movieSpeed);
			}
		}// end check loop/playback/stop

		if(nbLecture > nbRepeat && !isEditClip){
			println("nbLecture: "+nbLecture);
			println("nbRepeat: "+nbRepeat);
			ended = true;
			nbLecture = 1;
			movie.goToBeginning();
			movie.pause();
			addLectureSwitch=false;
		}
	}

	void updateGLSLParams(){
		ClipFilter.setParameterValue("posXY", new float[] {posX, posY});
		ClipFilter.setParameterValue("Scale", Scale);
		if(nbLecture==1 && TargetOpacity-Opacity>.1 && movie.time()<fadeInDuration) Opacity += fadeInAlphaStep;
		else if(nbLecture==nbRepeat && movie.duration()-movie.time()<fadeOutDuration) Opacity -= fadeOutAlphaStep;// depends on playMode
		else Opacity = TargetOpacity;
		ClipFilter.setParameterValue("Opacity", Opacity);
	}

	void updateClipGui(){
		Clip_Timeline.setRange(0.0, duration);
		Clip_Timeline.setValue(movie.time());
		Clip_Timeline.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
		Clip_Duration.setText("DURATION: "+duration*nbRepeat/movieSpeed);
	}
}