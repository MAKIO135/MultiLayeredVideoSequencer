void controlEvent(ControlEvent event){
	if(event.isGroup()){
		/////////////////////////////////////////////////Clip Events
		if((event.getGroup().getName()).equals("clipList")){
			if(!event.getGroup().isOpen()) background(20);
		}
	
		if((event.getGroup().getName()).equals("Clip_LectureMode")){
			editClip.lectureMode = (int)event.getGroup().getValue();
			// println("editClip.lectureMode: "+editClip.lectureMode);
		}
	
		if((event.getGroup().getName()).equals("Clip_Effect")){
			editClip.blendMode = (int)event.getGroup().getValue();
			// println("editClip.blendMode: "+editClip.blendMode);
		}
	
		if((event.getGroup().getName()).equals("Add_to_Layer")){
			addTo = (int)event.getGroup().getValue();
			// println("editClip.blendMode: "+editClip.blendMode);
		}
	}

	else if (event.isController()){
		/////////////////////////////////////////////////Clip Events
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
	}
}