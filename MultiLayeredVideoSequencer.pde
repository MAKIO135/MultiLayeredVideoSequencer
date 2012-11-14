/*
 * 	    __  ___      __   _      ________ ______
 * 	   /  |/  /___ _/ /__(_)___ <  /__  // ____/
 * 	  / /|_/ / __ `/ //_/ / __ \/ / /_ </___ \  
 * 	 / /  / / /_/ / ,< / / /_/ / /___/ /___/ /  
 * 	/_/  /_/\__,_/_/|_/_/\____/_//____/_____/   
 * 
 * 	Multi Layered Video Sequencer
 * 	by Lionel Radisson // MAKIO135
 *	http://makio135.com/
 *
 *
 * This file is part of the Multi Layered Video Sequencer application.
 * @author Lionel Radisson // Makio135
 *
 * Copyright (c) 2012 Lionel Radisson // Makio135
 *
 * This source is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This code is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * A copy of the GNU General Public License is available on the World
 * Wide Web at <http://www.gnu.org/copyleft/gpl.html>. You can also
 * obtain it by writing to the Free Software Foundation,
 * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

import processing.opengl.*;
import codeanticode.glgraphics.*;
import codeanticode.gsvideo.*;
import controlP5.*;
import org.json.*;

//////////////////////////////Clips
String[] Playlist;
Clip editClip;

//////////////////////////////Layers
LayerVideo[] layers;
int nbLayers = 8;
int editLayer = 0;

//////////////////////////////Composition
Composition composition;
GLTextureFilter[] BlendModes;

//////////////////////////////GUI
ControlP5 gui;
int[] updateLayerClip = {999,999};
boolean updatingClip = false;

void setup(){
	size(1500, 800, GLConstants.GLGRAPHICS);
	background(20);
	noStroke();

	// load videos and check if you need to load or create thumbnails
	println("loading videos");
	loadVideos();
	println("loading thumbnails");
	checkThumbnails();

	// create a Clip for edition
	println("initializing Clip Editor");
	editClip = new Clip(this);
	editClip.isEditClip = true;

	// create layers
	println("initializing Layers Editor");
	layers = new LayerVideo[nbLayers];
	for (int i = 0; i<nbLayers; i++){
		layers[i] = new LayerVideo(this, i);
	}

	// create composition
	println("initializing Composition Editor");
	composition = new Composition(this);
	initBlendModes();
	
	// init GUI
	println("initializing GUI");
	gui = new ControlP5(this);
	initClipGui();
	initLayerGui();
	initCompositionGui();

	println("setup complete");
}

void draw(){
	editClip.display();
	layers[editLayer].display();
	composition.display();
}


void movieEvent(GSMovie movie) {
	movie.read();
}

void keyPressed(){
	if(key=='l' || key=='L'){
		Composition_ReloadLast();
	}
	else if(key=='s' || key=='S'){
		Composition_Save();
	}
	else if(key=='r' || key=='R'){
		Composition_Reset();
	}
	else if(key=='c' || key=='C'){// reset editClip
		resetEditClip();
	}
	// could use 0-8 to navigate through Layers
}

void stop(){
	Composition_Reset();
	resetEditClip();
}