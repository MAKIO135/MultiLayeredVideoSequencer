Slider Composition_Timeline;
Textlabel Composition_Duration;
Button Composition_Save;
Button Composition_Load;
Button Composition_Reset;

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

	Composition_Reset = gui.addButton("Composition_Reset")
		.setPosition(400,40)
		.setSize(80,10)
		.moveTo(compositionGui)
		;
		Composition_Reset.getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

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

// quick access 's' || 'S'
void Composition_Save() {
	println("exporting");
	JSONObject JSONExport = new JSONObject();
	for(int i=0;i<nbLayers;i++){
		JSONObject JSONLayer = new JSONObject();
		int nbClips = layers[i].clips.size();
		try{
			JSONLayer.put("duration", layers[i].duration);
			JSONLayer.put("posX", layers[i].posX);
			JSONLayer.put("posY", layers[i].posY);
			JSONLayer.put("Scale", layers[i].Scale);
			// JSONLayer.put("Opacity", layers[i].Opacity);
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
	if (loadPath != null && loadPath.substring(loadPath.length()-4).equals("json")) {

		String[] JSONString = loadStrings(loadPath);
		JSONObject JSONComposition = new JSONObject();
		JSONObject JSONLayer = new JSONObject();
		JSONObject JSONClip = new JSONObject();
		try {
			JSONComposition = new JSONObject(JSONString[0]);
			// println(JSONComposition);
			for(int i=0; i<nbLayers; i++){
				// reset Layer
				layers[i].resetLayer();

				// load JSON
				JSONLayer = JSONComposition.getJSONObject("Layer"+i);
				// println("JSONLayer"+i+": "+JSONLayer);

				// set loaded values
				layers[i].duration = (float)JSONLayer.getDouble("duration");
				Layer_Duration[i].setText("DURATION: "+layers[i].duration);
				layers[i].posX = (float)JSONLayer.getDouble("posX");
				layers[i].posY = (float)JSONLayer.getDouble("posY");
				Layer_XY[i].setArrayValue(new float[]{100,100});
				layers[i].Scale = (float)JSONLayer.getDouble("Scale");
				Layer_Scale[i].setValue(layers[i].Scale);
				layers[i].TargetOpacity = (float)JSONLayer.getDouble("TargetOpacity");
				Layer_Opacity[i].setValue(layers[i].TargetOpacity);
				layers[i].Delay = (float)JSONLayer.getDouble("Delay");
				Layer_Delay[i].setValue(layers[i].Delay);
				layers[i].fadeInAlpha = (float)JSONLayer.getDouble("fadeInAlpha");
				Layer_fadeInAlpha[i].setValue(layers[i].fadeInAlpha);
				layers[i].fadeInDuration = (float)JSONLayer.getDouble("fadeInDuration");
				Layer_fadeInDuration[i].setValue(layers[i].fadeInDuration);
				layers[i].fadeOutAlpha = (float)JSONLayer.getDouble("fadeOutAlpha");
				Layer_fadeOutAlpha[i].setValue(layers[i].fadeOutAlpha);
				layers[i].fadeOutDuration = (float)JSONLayer.getDouble("fadeOutDuration");
				Layer_fadeOutDuration[i].setValue(layers[i].fadeOutDuration);

				int nbClips = JSONLayer.getInt("nbClips");
				// println("layers["+i+"].nbClips: "+nbClips);
				for(int j=0; j<nbClips; j++){
					JSONClip = JSONLayer.getJSONObject("Clip"+j);
					// println("JSONClip"+j+": "+JSONClip);
					layers[i].clips.add(new Clip(this));
					layers[i].clips.get(j).movieNum = JSONClip.getInt("movieNum");
					layers[i].clips.get(j).duration = (float)JSONClip.getDouble("duration");
					layers[i].clips.get(j).lectureMode = JSONClip.getInt("lectureMode");
					layers[i].clips.get(j).nbRepeat = JSONClip.getInt("nbRepeat");
					layers[i].clips.get(j).movieSpeed = (float)JSONClip.getDouble("movieSpeed");
					layers[i].clips.get(j).TargetOpacity = (float)JSONClip.getDouble("TargetOpacity");
					layers[i].clips.get(j).posX = (float)JSONClip.getDouble("posX");
					layers[i].clips.get(j).posY = (float)JSONClip.getDouble("posY");
					layers[i].clips.get(j).Scale = (float)JSONClip.getDouble("Scale");
					layers[i].clips.get(j).fadeInAlpha = (float)JSONClip.getDouble("fadeInAlpha");
					layers[i].clips.get(j).fadeInDuration = (float)JSONClip.getDouble("fadeInDuration");
					layers[i].clips.get(j).fadeOutAlpha = (float)JSONClip.getDouble("fadeOutAlpha");
					layers[i].clips.get(j).fadeOutDuration = (float)JSONClip.getDouble("fadeOutDuration");
					layers[i].clips.get(j).blendMode = JSONClip.getInt("blendMode");
					gui.addButton("Layer"+i+"Clip"+j)
						.setPosition(10+46*j, 75)
						.setSize(45,45)
						.setImage(thumbnails[layers[i].clips.get(j).movieNum])
						.setView(new ImageButton())
						.moveTo(layerG[i])
						;
					layers[i].clips.get(j).setVideo();
				}
			}
		}
		catch(JSONException e) {
			e.getCause();
		}

		for(int i=0; i<nbLayers; i++){
			if(layers[i].duration>composition.duration) composition.duration = layers[i].duration;
		}
		Composition_Duration.setText("DURATION: "+composition.duration);
		Composition_Timeline.setRange(0.0, composition.duration);
		Composition_Timeline.setValue(0.0);
		Composition_Timeline.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
	}
}

// quick access 'r' || 'R'
void Composition_Reset(){
	composition.isPlaying=false;
	for (int i = 0; i<nbLayers; i++){
		layers[i].resetLayer();
	}
}

// a quick loading method for debug :: access by press 'l' || 'L'
// specify json file path in KeyPressed method
void loadComp(String loadPath){
	String[] JSONString = loadStrings(loadPath);
	JSONObject JSONComposition = new JSONObject();
	JSONObject JSONLayer = new JSONObject();
	JSONObject JSONClip = new JSONObject();
	try {
		JSONComposition = new JSONObject(JSONString[0]);
		// println(JSONComposition);
		for(int i=0; i<nbLayers; i++){
			// reset Layer
			layers[i].resetLayer();

			// load JSON
			JSONLayer = JSONComposition.getJSONObject("Layer"+i);
			// println("JSONLayer"+i+": "+JSONLayer);

			// set loaded values
			layers[i].duration = (float)JSONLayer.getDouble("duration");
			Layer_Duration[i].setText("DURATION: "+layers[i].duration);
			layers[i].posX = (float)JSONLayer.getDouble("posX");
			layers[i].posY = (float)JSONLayer.getDouble("posY");
			Layer_XY[i].setArrayValue(new float[]{100,100});
			layers[i].Scale = (float)JSONLayer.getDouble("Scale");
			Layer_Scale[i].setValue(layers[i].Scale);
			layers[i].TargetOpacity = (float)JSONLayer.getDouble("TargetOpacity");
			Layer_Opacity[i].setValue(layers[i].TargetOpacity);
			layers[i].Delay = (float)JSONLayer.getDouble("Delay");
			Layer_Delay[i].setValue(layers[i].Delay);
			layers[i].fadeInAlpha = (float)JSONLayer.getDouble("fadeInAlpha");
			Layer_fadeInAlpha[i].setValue(layers[i].fadeInAlpha);
			layers[i].fadeInDuration = (float)JSONLayer.getDouble("fadeInDuration");
			Layer_fadeInDuration[i].setValue(layers[i].fadeInDuration);
			layers[i].fadeOutAlpha = (float)JSONLayer.getDouble("fadeOutAlpha");
			Layer_fadeOutAlpha[i].setValue(layers[i].fadeOutAlpha);
			layers[i].fadeOutDuration = (float)JSONLayer.getDouble("fadeOutDuration");
			Layer_fadeOutDuration[i].setValue(layers[i].fadeOutDuration);

			int nbClips = JSONLayer.getInt("nbClips");
			// println("layers["+i+"].nbClips: "+nbClips);
			for(int j=0; j<nbClips; j++){
				JSONClip = JSONLayer.getJSONObject("Clip"+j);
				// println("JSONClip"+j+": "+JSONClip);
				layers[i].clips.add(new Clip(this));
				layers[i].clips.get(j).movieNum = JSONClip.getInt("movieNum");
				layers[i].clips.get(j).duration = (float)JSONClip.getDouble("duration");
				layers[i].clips.get(j).lectureMode = JSONClip.getInt("lectureMode");
				layers[i].clips.get(j).nbRepeat = JSONClip.getInt("nbRepeat");
				layers[i].clips.get(j).movieSpeed = (float)JSONClip.getDouble("movieSpeed");
				layers[i].clips.get(j).TargetOpacity = (float)JSONClip.getDouble("TargetOpacity");
				layers[i].clips.get(j).posX = (float)JSONClip.getDouble("posX");
				layers[i].clips.get(j).posY = (float)JSONClip.getDouble("posY");
				layers[i].clips.get(j).Scale = (float)JSONClip.getDouble("Scale");
				layers[i].clips.get(j).fadeInAlpha = (float)JSONClip.getDouble("fadeInAlpha");
				layers[i].clips.get(j).fadeInDuration = (float)JSONClip.getDouble("fadeInDuration");
				layers[i].clips.get(j).fadeOutAlpha = (float)JSONClip.getDouble("fadeOutAlpha");
				layers[i].clips.get(j).fadeOutDuration = (float)JSONClip.getDouble("fadeOutDuration");
				layers[i].clips.get(j).blendMode = JSONClip.getInt("blendMode");
				gui.addButton("Layer"+i+"Clip"+j)
					.setPosition(10+46*j, 75)
					.setSize(45,45)
					.setImage(thumbnails[layers[i].clips.get(j).movieNum])
					.setView(new ImageButton())
					.moveTo(layerG[i])
					;
				layers[i].clips.get(j).setVideo();
			}
		}
	}
	catch(JSONException e) {
		e.getCause();
	}

	for(int i=0; i<nbLayers; i++){
		if(layers[i].duration>composition.duration) composition.duration = layers[i].duration;
	}
	Composition_Duration.setText("DURATION: "+composition.duration);
	Composition_Timeline.setRange(0.0, composition.duration);
	Composition_Timeline.setValue(0.0);
	Composition_Timeline.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
}