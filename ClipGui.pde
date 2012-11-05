int currentButton=0;
Slider Clip_Timeline;
Textlabel Clip_Duration;
DropdownList Clip_LectureMode;
Slider Clip_nbRepeat;
Slider Clip_Speed;
Slider2D Clip_XY;
Slider Clip_Scale;
Slider Clip_fadeInAlpha;
Slider Clip_fadeInDuration;
Slider Clip_fadeOutAlpha;
Slider Clip_fadeOutDuration;
Slider Clip_Opacity;
DropdownList Clip_Effect;
DropdownList Add_to_Layer;
int addTo=0;

class ImageButton implements ControllerView<Button> {
	PImage img = thumbnails[currentButton];
	public void display(PApplet theApplet, Button theButton) {
		theApplet.pushMatrix();
		image(img,0,0);
		if (theButton.isInside()) {
			if (theButton.isPressed()) { // button is pressed
				theApplet.fill(0,0);
			}	else { // mouse hovers the button
				theApplet.fill(0, 0);
			}
		} else { // the mouse is located outside the button area
			theApplet.fill(0, 120);
		}
		
		theApplet.rect(0, 0, 45, 45);

		theApplet.popMatrix();
	}
}

void initClipGui() {
	Group clipList = gui.addGroup("clipList")
		.setBackgroundColor(color(0))
		.setPosition(5,10)
		.setWidth(490)
		.setBackgroundHeight(280)
		.activateEvent(true)
		;
		for(int i=0; i<Playlist.length; i++){
			currentButton=i;
			gui.addButton("Clip"+i)
				.setPosition(15+46*(i%10), 15+46*int(i/10))
				.setSize(45,45)
				.setImage(thumbnails[i])
				.setView(new ImageButton())
				.moveTo(clipList)
				;
		}

	Group clipGui = gui.addGroup("Clip")
		.setBackgroundColor(color(0))
		.setPosition(5,310)
		.setWidth(490)
		.setBackgroundHeight(490)
		.disableCollapse()
		;

		Clip_Timeline = gui.addSlider("Clip_Timeline")
			.setPosition(10,10)
			.setSize(470,10)
			.setMin(0.0)
			.setMax(1.0)
			.moveTo(clipGui)
			;
			Clip_Timeline.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

		Clip_Duration = gui.addTextlabel("Clip_Duration")
			.setText("DURATION: 0.00")
			.setPosition(380,23)
			.moveTo(clipGui)
			;

		gui.addToggle("Clip_PlayPause")
			.setPosition(10,40)
			.setSize(60,10)
			.moveTo(clipGui)
			;

		Clip_LectureMode = gui.addDropdownList("Clip_LectureMode")
			.setPosition(90,50)
			.setSize(85,40)
			.setItemHeight(15)
			.moveTo(clipGui)
			;

			Clip_LectureMode.addItem("Lecture",0);
			Clip_LectureMode.addItem("Aller Retour",1);

			Clip_LectureMode.setIndex(0);

		Clip_nbRepeat = gui.addSlider("Clip_nbRepeat")
			.setPosition(185,40)
			.setSize(85,10)
			.setMin(1)
			.setMax(20)
			.setValue(1)
			.moveTo(clipGui)
			;
			Clip_nbRepeat.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

		Clip_Speed = gui.addSlider("Clip_Speed")
			.setPosition(295,40)
			.setSize(185,10)
			.setMin(0.1)
			.setMax(6.0)
			.setValue(1)
			.moveTo(clipGui)
			;
			Clip_Speed.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

		Clip_XY = gui.addSlider2D("Clip_XY")
			.setPosition(10,90)
			.setSize(260,140)
			.setMinX(-100)
			.setMaxX(100)
			.setMinY(-100)
			.setMaxY(100)
			.setArrayValue(new float[] {100,100})
			.moveTo(clipGui)
			;

		Clip_Scale = gui.addSlider("Clip_Scale")
			.setPosition(295,90)
			.setSize(185,10)
			.setMin(0.1)
			.setMax(10)
			.setValue(1)
			.moveTo(clipGui)
			;
			Clip_Scale.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

		Clip_Opacity = gui.addSlider("Clip_Opacity")
			.setPosition(295,140)
			.setSize(185,10)
			.setMin(0.0)
			.setMax(1.0)
			.setValue(1.0)
			.moveTo(clipGui)
			;
			Clip_Opacity.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

		Clip_Effect = gui.addDropdownList("Clip_Effect")
			.setPosition(295,200)
			.setSize(180,200)
			.setItemHeight(15)
			.moveTo(clipGui)
			;

			Clip_Effect.addItem( "Normal (Unpremultiplied, Photo Mask)", 0 );
			Clip_Effect.addItem( "Normal (Premultiplied, CG Alpha)", 1 );
			Clip_Effect.addItem( "Color", 2 );
			Clip_Effect.addItem( "Luminance", 3 );
			Clip_Effect.addItem( "Multiply", 4 );
			Clip_Effect.addItem( "Subtract", 5 );
			Clip_Effect.addItem( "Linear Dodge (Add)", 6 );
			Clip_Effect.addItem( "ColorDodge", 7 );
			Clip_Effect.addItem( "ColorBurn", 8 );
			Clip_Effect.addItem( "Darken", 9 );
			Clip_Effect.addItem( "Lighten", 10 );
			Clip_Effect.addItem( "Difference", 11 );
			Clip_Effect.addItem( "InverseDifference", 12 );
			Clip_Effect.addItem( "Exclusion", 13 );
			Clip_Effect.addItem( "Screen", 14 );
			Clip_Effect.addItem( "SoftLight", 15 );
			Clip_Effect.addItem( "Overlay", 16 );
			Clip_Effect.addItem( "HardLight", 17 );

			Clip_Effect.setIndex(0);

		Clip_fadeInAlpha = gui.addSlider("Clip_fadeInAlpha")
			.setPosition(10,260)
			.setSize(185,10)
			.setMin(0.0)
			.setMax(1.0)
			.setValue(1.0)
			.moveTo(clipGui)
			;
			Clip_fadeInAlpha.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

		Clip_fadeInDuration = gui.addSlider("Clip_fadeInDuration")
			.setPosition(10,290)
			.setSize(185,10)
			.setMin(0.0)
			.setMax(5.0)
			.setValue(0.0)
			.moveTo(clipGui)
			;
			Clip_fadeInDuration.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

		Clip_fadeOutAlpha = gui.addSlider("Clip_fadeOutAlpha")
			.setPosition(10,350)
			.setSize(185,10)
			.setMin(0.0)
			.setMax(1.0)
			.setValue(1.0)
			.moveTo(clipGui)
			;
			Clip_fadeOutAlpha.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

		Clip_fadeOutDuration = gui.addSlider("Clip_fadeOutDuration")
			.setPosition(10,380)
			.setSize(185,10)
			.setMin(0.0)
			.setMax(5.0)
			.setValue(0.0)
			.moveTo(clipGui)
			;
			Clip_fadeOutDuration.getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);

		Add_to_Layer = gui.addDropdownList("Add_to_Layer")
			.setPosition(295,440)
			.setSize(120,50)
			.setItemHeight(15)
			.moveTo(clipGui)
			;

			for (int i = 0; i<8; i++){
				Add_to_Layer.addItem("Layer"+i,i);
			}

		gui.addButton("Add_Clip")
			.setPosition(425,430)
			.setSize(50,10)
			.moveTo(clipGui)
			;
}

void Clip_Timeline(float f){
/*	if(editClip.movie!=null){
		float t = f;
		if (0.1 < abs(t - editClip.movie.time())) {
			boolean b = editClip.movie.isPlaying();
			if (!b) editClip.movie.play();
			editClip.movie.jump(t);
			if (!b) editClip.movie.pause();
		}
	}*/
}

void Clip_PlayPause(boolean b){
	if (editClip.movie!=null){
		if(b)editClip.movie.play();
		else editClip.movie.pause();
	}
}

void Clip_nbRepeat(int f){
	editClip.nbRepeat=f;
}

void Clip_Speed(float f){
	editClip.movieSpeed = f;
	if (editClip.movie!=null){
		editClip.movie.goToBeginning();
		editClip.movie.speed(f);
		editClip.movie.play();
	}
	// println("setSpeed: "+editClip.movieSpeed);
}

void Clip_Scale(float f){
	editClip.Scale=f;
}

void Clip_fadeInAlpha(float f){
	editClip.fadeInAlpha=f;
}

void Clip_fadeInDuration(float f){
	editClip.fadeInDuration=f;
}

void Clip_fadeOutAlpha(float f){
	editClip.fadeOutAlpha=f;
}

void Clip_fadeOutDuration(float f){
	editClip.fadeOutDuration=f;
}

void Clip_Opacity(float f){
	editClip.TargetOpacity=f;
}

void Add_Clip(){
	if(editClip.movie != null){
		// Create a new Video Clip, copying calculated infos from editClip
		Clip c = new Clip(this);
		c.movieNum = editClip.movieNum;
		c.duration = editClip.duration;
		c.lectureMode = editClip.lectureMode;
		c.nbRepeat = editClip.nbRepeat;
		c.movieSpeed = editClip.movieSpeed;
		c.TargetOpacity = editClip.TargetOpacity;
		c.posX = editClip.posX;
		c.posY = editClip.posY;
		c.Scale = editClip.Scale;
		c.fadeInAlpha = editClip.fadeInAlpha;
		c.fadeInAlphaStep = editClip.fadeInAlphaStep;
		c.fadeInDuration = editClip.fadeInDuration;
		c.fadeOutAlpha = editClip.fadeOutAlpha;
		c.fadeOutAlphaStep = editClip.fadeOutAlphaStep;
		c.fadeOutDuration = editClip.fadeOutDuration;
		c.blendMode = editClip.blendMode;

		c.setVideo();

		layers[addTo].clips.add(c);

		gui.addButton("Layer"+addTo+"Clip"+layers[addTo].clips.size())
			.setPosition(10+46*(layers[addTo].clips.size()-1), 75)
			.setSize(45,45)
			.setImage(thumbnails[c.movieNum])
			.setView(new ImageButton())
			.moveTo(layerG[addTo])
			;

		println("Clip added to Layer "+addTo);
		println("layers[addTo].clips.size(): "+layers[addTo].clips.size());
		layers[addTo].layerDuration += (c.duration*c.nbRepeat)/c.movieSpeed;
		Layer_Duration[addTo].setText("DURATION: "+layers[addTo].layerDuration);
		
		// check if layer duration superior to composition duration
		if(layers[addTo].layerDuration>composition.duration){
			composition.duration = layers[addTo].layerDuration;
			Composition_Duration.setText("DURATION: "+composition.duration);
		}
	}
}