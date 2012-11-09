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
	float fadeInDuration=0.0;
	float fadeOutAlpha=1.0;
	float fadeOutDuration=0.0;
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
		// check if a movie was already loaded and delete it
		if(movie != null){
			movie.stop();
			movie.delete();
			tex.delete();
			texFiltered.delete();
			// println("Movie deleted");
		}

		// load movie and set Texture
		movie = new GSMovie(parent,"videos/"+Playlist[movieNum]);
		tex = new GLTexture(parent);
		texFiltered = new GLTexture(parent);
		movie.setPixelDest(tex);
		tex.setPixelBufferSize(10);
		tex.delPixelsWhenBufferFull(false);

		if(lectureMode == 0) movie.loop();
		else movie.play();
		while(movie.width<1){
			movie.volume(0.0);
		}

		movie.goToBeginning();
		if(isEditClip){
			gui.getController("Clip_PlayPause").setValue(1.0);
			Clip_Timeline.setValue(0);
		}
		else{
			movie.pause();
		}

		Opacity = fadeInAlpha;
		movie.speed(movieSpeed);
		duration = movie.duration()*nbRepeat/movieSpeed;
		isLoaded=true;
	}

	void display(){
		if(isLoaded && movie.isPlaying()){
			if(lectureMode == 0) movie.speed(movieSpeed);
			if (tex.putPixelsIntoTexture()) {
				updateGLSLParams();
				// apply GLSL Filter
				tex.filter(ClipFilter, texFiltered);

				// display editClip in editor
				if(isEditClip){
					duration = movie.duration()*nbRepeat/movieSpeed;
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
		timelineValue += (millis()-timer)/1000;
		timer = millis();

		// check at Beginning
		if(addLectureSwitch && movie.time()<.05*max(1,movieSpeed)){
			if(lectureMode==1){
				nbLecture++;
				movie.speed(movieSpeed);
			}
			addLectureSwitch=false;
		}
		// check at end
		else if(movie.duration()-movie.time()<.05*max(1,movieSpeed)){
			// lectureMode: loop
			if(lectureMode==0){
				if(!addLectureSwitch){
					nbLecture++;
					addLectureSwitch=true;
					movie.speed(movieSpeed+1);
					movie.goToBeginning();
					movie.speed(movieSpeed);
				}
			}

			// lectureMode: play/playback
			else if(lectureMode==1 && !addLectureSwitch) {
				nbLecture++;
				addLectureSwitch=true;
				movie.speed(-movieSpeed);
			}
		}

		if(nbLecture > nbRepeat || timelineValue>duration){
			// println("Clip end");
			nbLecture = 1;
			addLectureSwitch=false;
			Opacity = fadeInAlpha;
			movie.speed(movieSpeed+1);
			movie.goToBeginning();
			movie.speed(movieSpeed);
			timelineValue=0.0;
			addLectureSwitch=false;
			if(!isEditClip){
				// println("nbLecture: "+nbLecture+"  nbRepeat: "+nbRepeat);
				ended = true;
				movie.pause();
			}
		}
	}

	void updateGLSLParams(){
		Opacity = TargetOpacity;
		if(timelineValue<fadeInDuration){
			// println("fadeIn");
			Opacity = fadeInAlpha+timelineValue*((TargetOpacity-fadeInAlpha)/fadeInDuration);
		}
		else if( timelineValue>duration-fadeOutDuration){
			// println("fadeOut");
			Opacity = fadeOutAlpha+(duration-timelineValue)*((TargetOpacity-fadeOutAlpha)/fadeOutDuration);
		}
		ClipFilter.setParameterValue("Opacity", Opacity);
		ClipFilter.setParameterValue("posXY", new float[] {posX, posY});
		ClipFilter.setParameterValue("Scale", Scale);
	}

	void updateClipGui(){
		Clip_Timeline.setRange(0.0, duration);
		Clip_Timeline.setValue(timelineValue);
		Clip_Timeline.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
		Clip_Duration.setText("DURATION: "+duration);
	}
}