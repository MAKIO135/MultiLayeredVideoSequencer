Group[] layerG;
Slider[] Layer_Timeline;
Textlabel[] Layer_Duration;
Slider2D[] Layer_XY;
Slider[] Layer_Scale;
Slider[] Layer_Opacity;
Slider[] Layer_Delay;
Slider[] Layer_fadeInAlpha;
Slider[] Layer_fadeInDuration;
Slider[] Layer_fadeOutAlpha;
Slider[] Layer_fadeOutDuration;

void initLayerGui(){
	layerG = new Group[nbLayers];
	Layer_Timeline = new Slider[nbLayers];
	Layer_Duration = new Textlabel[nbLayers];
	Layer_XY = new Slider2D[nbLayers];
	Layer_Scale = new Slider[nbLayers];
	Layer_Opacity = new Slider[nbLayers];
	Layer_Delay = new Slider[nbLayers];
	Layer_fadeInAlpha = new Slider[nbLayers];
	Layer_fadeInDuration = new Slider[nbLayers];
	Layer_fadeOutAlpha = new Slider[nbLayers];
	Layer_fadeOutDuration = new Slider[nbLayers];
	
	Group layerGui = gui.addGroup("Layer")
		.setBackgroundColor(color(0))
		.setPosition(505,310)
		.setWidth(490)
		.setBackgroundHeight(490)
		.disableCollapse()
		;

	Accordion LayersGui = gui.addAccordion("LayersGui")
		.setPosition(0,40)
		.setWidth(490)
		.moveTo(layerGui)
		;

	DropdownList Layer_List = gui.addDropdownList("Layer_List")
		.setPosition(10,20)
		.moveTo(layerGui)
		;

		for (int n = nbLayers-1; n>=0; n--){
			layerG[n] = gui.addGroup("Layer"+n)
				.setWidth(490)
				.setBackgroundHeight(370)
				;

			Layer_Timeline[n] = gui.addSlider("Layer"+n+"_Timeline")
				.setPosition(10,10)
				.setSize(470,10)
				.setRange(0,1)
				.moveTo(layerG[n])
				;
				Layer_Timeline[n].getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

			Layer_Duration[n] = gui.addTextlabel("Layer"+n+"_Duration")
				.setText("DURATION: 0.00")
				.setPosition(380,23)
				.moveTo(layerG[n])
				;

			gui.addToggle("Layer"+n+"_PlayPause")
				.setPosition(10,40)
				.setSize(80,10)
				.moveTo(layerG[n])
				;


			Layer_XY[n] = gui.addSlider2D("Layer"+n+"_XY")
				.setPosition(10,130)
				.setSize(260,140)
				.setMinX(-130)
				.setMaxX(130)
				.setMinY(-70)
				.setMaxY(70)
				.setArrayValue(new float[] {130,70})
				.moveTo(layerG[n])
				;

			Layer_Scale[n] = gui.addSlider("Layer"+n+"_Scale")
				.setPosition(295,130)
				.setSize(185,10)
				.setMin(0.1)
				.setMax(10)
				.setValue(1)
				.moveTo(layerG[n])
				;
				Layer_Scale[n].getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

			Layer_Opacity[n] = gui.addSlider("Layer"+n+"_Opacity")
				.setPosition(295,180)
				.setSize(185,10)
				.setMin(0.0)
				.setMax(1.0)
				.setValue(1.0)
				.moveTo(layerG[n])
				;
				Layer_Opacity[n].getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

			Layer_Delay[n] = gui.addSlider("Layer"+n+"_Delay")
				.setPosition(295,220)
				.setSize(185,10)
				.setMin(0.0)
				.setMax(360.0)
				.setValue(0.0)
				.moveTo(layerG[n])
				;
				Layer_Delay[n].getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

			Layer_fadeInAlpha[n] = gui.addSlider("Layer"+n+"_fadeInAlpha")
				.setPosition(10,300)
				.setSize(185,10)
				.setMin(0.0)
				.setMax(1.0)
				.setValue(1.0)
				.moveTo(layerG[n])
				;
				Layer_fadeInAlpha[n].getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

			Layer_fadeInDuration[n] = gui.addSlider("Layer"+n+"_fadeInDuration")
				.setPosition(10,330)
				.setSize(185,10)
				.setMin(0.0)
				.setMax(5.0)
				.setValue(0.0)
				.moveTo(layerG[n])
				;
				Layer_fadeInDuration[n].getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

			Layer_fadeOutAlpha[n] = gui.addSlider("Layer"+n+"_fadeOutAlpha")
				.setPosition(240,300)
				.setSize(185,10)
				.setMin(0.0)
				.setMax(1.0)
				.setValue(1.0)
				.moveTo(layerG[n])
				;
				Layer_fadeOutAlpha[n].getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

			Layer_fadeOutDuration[n] = gui.addSlider("Layer"+n+"_fadeOutDuration")
				.setPosition(240,330)
				.setSize(185,10)
				.setMin(0.0)
				.setMax(5.0)
				.setValue(0.0)
				.moveTo(layerG[n])
				;
				Layer_fadeOutDuration[n].getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

			// add to accordion
			LayersGui.addItem(layerG[n]);
			Layer_List.addItem("Layer"+n, n);
		}

	Layer_List.setIndex(7);
	LayersGui.open(7);
}


/*
void Layer0_Timeline(float f){
	float t = f;
	if(Layer1.clips.size() > 0){
		// if(0.1 < abs(t - Layer1.clips.get(Layer1.currentLayer).movie.time())){
			for (int i = 0; i<Layer1.clips.size(); i++){
				if(t > 0){
					if(t <= Layer1.clips.get(i).duration){
						if(Layer1.currentLayer != i){
							Layer1.clips.get(Layer1.currentLayer).movie.pause();
							Layer1.currentLayer = i;
							println("Layer1.currentLayer: "+Layer1.currentLayer);
						}
						if(!Layer1.isPlaying) Layer1.clips.get(i).movie.play();
						Layer1.clips.get(i).movie.jump(t);
						if(!Layer1.isPlaying) Layer1.clips.get(i).movie.pause();
					}
					else{
						t -= Layer1.clips.get(i).duration;
						println(t);
					}
				}
			}
		// }
	}
}
*/

//use id to avoid repetition
void Layer0_PlayPause(boolean b){
	layers[0].isPlaying = b;
	if(layers[0].clips.size()>0) layers[0].clips.get(layers[0].currentClip).movie.play();
}

void Layer1_PlayPause(boolean b){
	layers[1].isPlaying = b;
	if(layers[1].clips.size()>0) layers[1].clips.get(layers[1].currentClip).movie.play();
}

void Layer2_PlayPause(boolean b){
	layers[2].isPlaying = b;
	if(layers[2].clips.size()>0) layers[2].clips.get(layers[2].currentClip).movie.play();
}

void Layer3_PlayPause(boolean b){
	layers[3].isPlaying = b;
	if(layers[3].clips.size()>0) layers[3].clips.get(layers[3].currentClip).movie.play();
}

void Layer4_PlayPause(boolean b){
	layers[4].isPlaying = b;
	if(layers[4].clips.size()>0) layers[4].clips.get(layers[4].currentClip).movie.play();
}

void Layer5_PlayPause(boolean b){
	layers[5].isPlaying = b;
	if(layers[5].clips.size()>0) layers[5].clips.get(layers[5].currentClip).movie.play();
}

void Layer6_PlayPause(boolean b){
	layers[6].isPlaying = b;
	if(layers[6].clips.size()>0) layers[6].clips.get(layers[6].currentClip).movie.play();
}

void Layer7_PlayPause(boolean b){
	layers[7].isPlaying = b;
	if(layers[7].clips.size()>0) layers[7].clips.get(layers[7].currentClip).movie.play();
}