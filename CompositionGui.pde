Slider Composition_Timeline;
Textlabel Composition_Duration;

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

	gui.addBang("Composition_Save")
		.setPosition(10,100)
		.setSize(80,10)
		.moveTo(compositionGui)
		;

	gui.addBang("Composition_Load")
		.setPosition(150,100)
		.setSize(80,10)
		.moveTo(compositionGui)
		;
}

void Composition_PlayPause(boolean b){
	composition.isPlaying = b;
	composition.timer = millis();
}

void Composition_Save() {
	composition.export();
}