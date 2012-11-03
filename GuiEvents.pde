void controlEvent(ControlEvent event){
	if(event.isGroup()){
		/////////////////////////////////////////////////Clip Events
		if((event.getGroup().getName()).equals("clipList")){
			if(!event.getGroup().isOpen()) background(20);
		}
	
		else if((event.getGroup().getName()).equals("Clip_LectureMode")){
			editClip.lectureMode = (int)event.getGroup().getValue();
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
		else if((event.getGroup().getName()).equals("Layer_List")){
			editLayer = (int)event.getGroup().getValue();
		}
	}

	else if (event.isController()){
		/////////////////////////////////////////////////Clips Events
		if((event.getController().getName()).equals("Clip_XY")){
			if(editClip != null){
				editClip.posX = map(event.getController().arrayValue()[0],-100,100,-1,1);
				editClip.posY = map(event.getController().arrayValue()[1],-100,100,-1,1);
			}
		}

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
			int n = int(Character.toString(s.charAt(s.length()-1)));// get number of the Layer
			// println(n);

			switch(event.controller().id()){
				case(0): // Layer_Timeline
					// layers[n].Timeline = event.controller().value();
					break;
				case(1): // Layer_Duration
					// layers[n].Duration = event.controller().value();
					break;
				case(2): // Layer_PlayPause
					layers[n].isPlaying = boolean(int(event.controller().value()));
					println("layers["+n+"].isPlaying: "+layers[n].isPlaying);
					break;
				case(3): // Layer_XY
					layers[n].posX = map(event.getController().arrayValue()[0],-100,100,-1,1);
					println("layers["+n+"].posX: "+layers[n].posX);
					layers[n].posY = map(event.getController().arrayValue()[1],-100,100,-1,1);
					println("layers["+n+"].posY: "+layers[n].posY);
					break;
				case(4): // Layer_Scale
					layers[n].Scale = event.controller().value();
					println("layers["+n+"].Scale: "+layers[n].Scale);
					break;
				case(5): // Layer_Opacity
					layers[n].Opacity = event.controller().value();
					println("layers["+n+"].Opacity: "+layers[n].Opacity);
					break;
				case(6): // Layer_Delay
					layers[n].Delay = event.controller().value();
					println("layers["+n+"].Delay: "+layers[n].Delay);
					break;
				case(7): // Layer_fadeInAlpha
					layers[n].fadeInAlpha = event.controller().value();
					println("layers["+n+"].fadeInAlpha: "+layers[n].fadeInAlpha);
					break;
				case(8): // Layer_fadeInDuration
					layers[n].fadeInDuration = event.controller().value();
					println("layers["+n+"].fadeInDuration: "+layers[n].fadeInDuration);
					break;
				case(9): // Layer_fadeOutAlpha
					layers[n].fadeOutAlpha = event.controller().value();
					println("layers["+n+"].fadeOutAlpha: "+layers[n].fadeOutAlpha);
					break;
				case(10):// Layer_fadeOutDuration
					layers[n].fadeOutDuration = event.controller().value();
					println("layers["+n+"].fadeOutDuration: "+layers[n].fadeOutDuration);
					break;
			}
		}
	}
}