void controlEvent(ControlEvent event){
	if(event.isGroup()){
		// println(event.getGroup().getName()+" is Group");
		/////////////////////////////////////////////////Clip Events
		if((event.getGroup().getName()).equals("clipList")){
			if(!event.getGroup().isOpen()) background(20);
		}
	
		else if((event.getGroup().getName()).equals("Clip_LectureMode")){
			editClip.lectureMode = (int)event.getGroup().getValue();
			if(editClip.lectureMode == 0 && editClip.movie != null) editClip.movie.loop();
			// println("editClip.lectureMode: "+editClip.lectureMode);
		}
	
		else if((event.getGroup().getName()).equals("Clip_Effect")){
			editClip.blendMode = (int)event.getGroup().getValue();
			// println("editClip.blendMode: "+editClip.blendMode);
		}
	
		else if((event.getGroup().getName()).equals("Add_to_Layer")){
			addTo = (int)event.getGroup().getValue();
			// println("editClip.blendMode: "+editClip.blendMode);
		}

		/////////////////////////////////////////////////Edit Layer choice
		else if((event.getGroup().getName().substring(0,5)).equals("Layer")){
			String s = event.getGroup().getName();
			// println(s);
			editLayer = int(Character.toString(s.charAt(s.length()-1)));
			println(editLayer);
			for (int i = 0; i<nbLayers; i++){
				if(i==editLayer){
					layers[i].isEditLayer = true;
				}
				else{
					layers[i].isEditLayer = false;
					layers[i].isPlaying = false;
				}
			}
		}
	}

	else if (event.isController()){
		// println(event.getController().getName()+" is Controller");
		/////////////////////////////////////////////////Clips Events
		if((event.getController().getName()).equals("Clip_XY")){
			if(editClip != null){
				editClip.posX = map(event.getController().arrayValue()[0],-100,100,-1,1);
				editClip.posY = map(event.getController().arrayValue()[1],-100,100,-1,1);
			}
		}

		// choice of the clip to edit
		else if((event.getController().getName().substring(0,4)).equals("Clip")){
			for(int i=0; i<Playlist.length; i++){
				if((event.getController().getName()).equals("Clip"+i)){
					gui.getGroup("clipList").close();
					editClip.movieNum=i;
					editClip.isLoaded=false;
					editClip.setVideo();
				}
			}
		}

		/////////////////////////////////////////////////Layers Events
		else if((event.getController().getName().substring(0,5)).equals("Layer")){

			String s = event.getController().getName();
			// println(s);

			if(s.length()>10 && (s.substring(6,10)).equals("Clip")){
				// get number of the Layer
				int n = int(s.substring(5,6));
				// println("Layer: "+n);
				layers[n].isEditLayer = true;
				updateLayerClip = new int[]{n, int(Character.toString(s.charAt(s.length()-1)))};
				// println(updateLayerClip);
				setEditClip(updateLayerClip);
			}
			else{
				// get number of the Layer
				int n = int(Character.toString(s.charAt(s.length()-1)));
				// println("Layer: "+n);
				layers[n].isEditLayer = true;

				switch(event.controller().id()){
					case(0): // Layer_Timeline
						// layers[n].Timeline = event.controller().value();
						break;
					case(1): // Layer_Duration
						// layers[n].Duration = event.controller().value();
						break;
					case(2): // Layer_PlayPause
						if(layers[n].clips.size()>0 && !composition.isPlaying){
							layers[n].isPlaying = boolean(int(event.controller().value()));
							println("//////////////////////////////");
							if(layers[n].isPlaying){
								if(!(layers[n].clips).get(layers[n].currentClip).movie.isPlaying()){// if layer.currentClip is not playing -> play
									if((layers[n].clips).get(layers[n].currentClip).lectureMode==0){
										(layers[n].clips).get(layers[n].currentClip).movie.play();
									}
									else if((layers[n].clips).get(layers[n].currentClip).lectureMode==1){
										(layers[n].clips).get(layers[n].currentClip).movie.loop();
									}
								}
								layers[n].timer = millis();
							}
							else{
								if((layers[n].clips).get(layers[n].currentClip).movie.isPlaying()){// if layer.currentClip is playing -> pause
									(layers[n].clips).get(layers[n].currentClip).movie.pause();
								}
							}
						}
						// println("layers["+n+"].isPlaying: "+layers[n].isPlaying);
						break;
					case(3): // Layer_XY
						layers[n].posX = map(event.getController().arrayValue()[0],-100,100,-1,1);
						// println("layers["+n+"].posX: "+layers[n].posX);
						layers[n].posY = map(event.getController().arrayValue()[1],-100,100,-1,1);
						// println("layers["+n+"].posY: "+layers[n].posY);
						break;
					case(4): // Layer_Scale
						layers[n].Scale = event.controller().value();
						// println("layers["+n+"].Scale: "+layers[n].Scale);
						break;
					case(5): // Layer_Opacity
						layers[n].TargetOpacity = event.controller().value();
						// println("layers["+n+"].Opacity: "+layers[n].Opacity);
						break;
					case(6): // Layer_Delay
						layers[n].Delay = event.controller().value();
						// println("layers["+n+"].Delay: "+layers[n].Delay);
						
						float MaxLayerDuration=0.0;
						for(int i=0; i<nbLayers; i++){
							if(layers[n].Delay+layers[n].duration>MaxLayerDuration){
								MaxLayerDuration = layers[n].Delay+layers[n].duration;
							}
						}
						composition.duration = MaxLayerDuration;
						Composition_Duration.setText("DURATION: "+composition.duration);
						break;
					case(7): // Layer_fadeInAlpha
						layers[n].fadeInAlpha = event.controller().value();
						// println("layers["+n+"].fadeInAlpha: "+layers[n].fadeInAlpha);
						break;
					case(8): // Layer_fadeInDuration
						layers[n].fadeInDuration = event.controller().value();
						// println("layers["+n+"].fadeInDuration: "+layers[n].fadeInDuration);
						break;
					case(9): // Layer_fadeOutAlpha
						layers[n].fadeOutAlpha = event.controller().value();
						// println("layers["+n+"].fadeOutAlpha: "+layers[n].fadeOutAlpha);
						break;
					case(10):// Layer_fadeOutDuration
						layers[n].fadeOutDuration = event.controller().value();
						// println("layers["+n+"].fadeOutDuration: "+layers[n].fadeOutDuration);
						break;
				}
			}
		}
	}
}

void setEditClip(int[] n) {
	// stop editClip
	editClip.movie.stop();
	editClip.isEditClip = false;

	editClip.movieNum = layers[n[0]].clips.get(n[1]).movieNum;
	editClip.duration = layers[n[0]].clips.get(n[1]).duration;
	editClip.lectureMode = layers[n[0]].clips.get(n[1]).lectureMode;
	editClip.nbRepeat = layers[n[0]].clips.get(n[1]).nbRepeat;
	editClip.movieSpeed = layers[n[0]].clips.get(n[1]).movieSpeed;
	editClip.TargetOpacity = layers[n[0]].clips.get(n[1]).TargetOpacity;
	editClip.posX = layers[n[0]].clips.get(n[1]).posX;
	editClip.posY = layers[n[0]].clips.get(n[1]).posY;
	editClip.Scale = layers[n[0]].clips.get(n[1]).Scale;
	editClip.fadeInAlpha = layers[n[0]].clips.get(n[1]).fadeInAlpha;
	editClip.fadeInDuration = layers[n[0]].clips.get(n[1]).fadeInDuration;
	editClip.fadeOutAlpha = layers[n[0]].clips.get(n[1]).fadeOutAlpha;
	editClip.fadeOutDuration = layers[n[0]].clips.get(n[1]).fadeOutDuration;
	editClip.blendMode = layers[n[0]].clips.get(n[1]).blendMode;

	editClip.isEditClip = true;
	editClip.setVideo();

	Clip_Duration.setText("DURATION: "+editClip.duration*editClip.nbRepeat/editClip.movieSpeed);
	Clip_LectureMode.setIndex(editClip.lectureMode);
	Clip_nbRepeat.setValue(editClip.nbRepeat);
	Clip_Speed.setValue(editClip.movieSpeed);

	Clip_XY.setArrayValue(new float[]{map(editClip.posX,-1,1,0,200), map(editClip.posY,-1,1,0,200)});
	Clip_Scale.setValue(editClip.Scale);
	Clip_fadeInAlpha.setValue(editClip.fadeInAlpha);
	Clip_fadeInDuration.setValue(editClip.fadeInDuration);
	Clip_fadeOutAlpha.setValue(editClip.fadeOutAlpha);
	Clip_fadeOutDuration.setValue(editClip.fadeOutDuration);
	Clip_Opacity.setValue(editClip.TargetOpacity);
	Clip_Effect.setValue(editClip.blendMode);
	Update_ClipId.setText("LAYER"+n[0]+" CLIP"+n[1]);
}