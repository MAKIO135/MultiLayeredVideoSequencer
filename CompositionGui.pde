Slider Composition_Timeline;
Textlabel Composition_Duration;
Button Composition_Save;
Button Composition_Load;
void initCompositionGui(){
	Group compositionGui = gui.addGroup("Composition")
		.setBackgroundColor(color(0))
		.setPosition(1005,310)
		.setWidth(490)
		.setBackgroundHeight(490)
		.disableCollapse()
		;

	Composition_Timeline = gui.addSlider("Composition_Timeline")
		.setPosition(10,10)
		.setSize(470,10)
		.setRange(0,1)
		.moveTo(compositionGui)
		;
		Composition_Timeline.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

	Composition_Duration = gui.addTextlabel("Composition_Duration")
		.setText("DURATION: 0.00")
		.setPosition(380,23)
		.moveTo(compositionGui)
		;

	gui.addToggle("Composition_PlayPause")
		.setPosition(10,40)
		.setSize(80,10)
		.moveTo(compositionGui)
		;

	Composition_Save = gui.addButton("Composition_Save")
		.setPosition(10,100)
		.setSize(80,10)
		.moveTo(compositionGui)
		;
		Composition_Save.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

	Composition_Load = gui.addButton("Composition_Load")
		.setPosition(150,100)
		.setSize(80,10)
		.moveTo(compositionGui)
		;
		Composition_Load.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
}

void Composition_PlayPause(boolean b){
	composition.isPlaying = b;
	for (int i = 0; i<nbLayers; i++){
		layers[i].isPlaying=false;
	}
	composition.timer = millis();
}

void Composition_Save() {
	println("exporting");
	JSONObject JSONExport = new JSONObject();
	for(int i=0;i<nbLayers;i++){
		JSONObject JSONLayer = new JSONObject();
		int nbClips = layers[i].clips.size();
		try{
			JSONLayer.put("duration", layers[i].duration);
			JSONLayer.put("timelineValue", layers[i].timelineValue);
			JSONLayer.put("timer", layers[i].timer);
			JSONLayer.put("posX", layers[i].posX);
			JSONLayer.put("posY", layers[i].posY);
			JSONLayer.put("Scale", layers[i].Scale);
			JSONLayer.put("Opacity", layers[i].Opacity);
			JSONLayer.put("TargetOpacity", layers[i].TargetOpacity);
			JSONLayer.put("Delay", layers[i].Delay);
			JSONLayer.put("fadeInAlpha", layers[i].fadeInAlpha);
			JSONLayer.put("fadeInDuration", layers[i].fadeInDuration);
			JSONLayer.put("fadeOutAlpha", layers[i].fadeOutAlpha);
			JSONLayer.put("fadeOutDuration", layers[i].fadeOutDuration);
			JSONLayer.put("nbClips", nbClips);
		}
		catch(JSONException e) {
			println(e.getCause());
		}

		for(int j=0;j<nbClips;j++){
			JSONObject JSONClip = new JSONObject();
			try{
				JSONClip.put("movieNum", layers[i].clips.get(j).movieNum);
				// println("movieNum: "+layers[i].clips.get(j).movieNum);
				JSONClip.put("duration", layers[i].clips.get(j).duration);
				// println("duration: "+layers[i].clips.get(j).duration);
				JSONClip.put("lectureMode", layers[i].clips.get(j).lectureMode);
				// println("lectureMode: "+layers[i].clips.get(j).lectureMode);
				JSONClip.put("nbRepeat", layers[i].clips.get(j).nbRepeat);
				// println("nbRepeat: "+layers[i].clips.get(j).nbRepeat);
				JSONClip.put("movieSpeed", layers[i].clips.get(j).movieSpeed);
				// println("movieSpeed: "+layers[i].clips.get(j).movieSpeed);
				JSONClip.put("TargetOpacity", layers[i].clips.get(j).TargetOpacity);
				// println("TargetOpacity: "+layers[i].clips.get(j).TargetOpacity);
				JSONClip.put("posX", layers[i].clips.get(j).posX);
				// println("posX: "+layers[i].clips.get(j).posX);
				JSONClip.put("posY", layers[i].clips.get(j).posY);
				// println("posY: "+layers[i].clips.get(j).posY);
				JSONClip.put("Scale", layers[i].clips.get(j).Scale);
				// println("Scale: "+layers[i].clips.get(j).Scale);
				JSONClip.put("fadeInAlpha", layers[i].clips.get(j).fadeInAlpha);
				// println("fadeInAlpha: "+layers[i].clips.get(j).fadeInAlpha);
				JSONClip.put("fadeInDuration", layers[i].clips.get(j).fadeInDuration);
				// println("fadeInDuration: "+layers[i].clips.get(j).fadeInDuration);
				JSONClip.put("fadeOutAlpha", layers[i].clips.get(j).fadeOutAlpha);
				// println("fadeOutAlpha: "+layers[i].clips.get(j).fadeOutAlpha);
				JSONClip.put("fadeOutDuration", layers[i].clips.get(j).fadeOutDuration);
				// println("fadeOutDuration: "+layers[i].clips.get(j).fadeOutDuration);
				JSONClip.put("blendMode", layers[i].clips.get(j).blendMode);
				// println("blendMode: "+layers[i].clips.get(j).blendMode);
				JSONLayer.put("Clip"+j, JSONClip);
				// println("Clip"+j+": "+JSONClip);
			}
			catch(JSONException e) {
				println(e.getCause());
			}
		}

		try{
			JSONExport.put("Layer"+i, JSONLayer);
		}
		catch(JSONException e) {
			println(e.getCause());
		}
	}

	String[] tmp = new String[1];
	tmp[0]=JSONExport.toString();
	String timestamp = year() + nf(month(),2) + nf(day(),2) + "-" + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
	saveStrings("data/Compositions/Composition_"+timestamp+".json",tmp);
	println("export OK");
}

void Composition_Load(){
	String loadPath = selectInput();// Opens file chooser
	if (loadPath == null) {
		// If a file was not selected
		println("No file was selected...");
	} else {
		// If a file was selected, print path to file
		println(loadPath);
		String[] JSONString = loadStrings(loadPath);
		JSONObject myJsonObject = new JSONObject();
		try {
			myJsonObject = new JSONObject(JSONString[0]);
		}
		catch(JSONException e) {
			e.getCause();
		}
		println(myJsonObject);
	}
}
/*
try{

}
catch(JSONException e) {
	e.getCause();
}
*/