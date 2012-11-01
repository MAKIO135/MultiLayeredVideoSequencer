PImage[] thumbnails;
void checkThumbnails(){
	loadThumbnails();
	String[] thumbs=loadStrings("data/thumbnails.txt");
	thumbnails = new PImage[Playlist.length];
	for (int i = 0; i<Playlist.length; i++){
		if(!(Playlist[i].substring(0, Playlist[i].length()-4)).equals(thumbs[i].substring(0, thumbs[i].length()-4))){
			println("creating thumbnails");
			GSMovie tmp=new GSMovie(this,"videos/"+Playlist[i]);
			tmp.play();
			while(tmp.width<10){
				if (tmp.available()) {
					tmp.read();
				}
			}
			tmp.jump(tmp.duration()/2);
			tmp.pause();
			tmp.resize(128,72);
			tmp.save("data/thumbnails/"+Playlist[i].substring(0, Playlist[i].length()-4)+".png");
			tmp.delete();
		}
		thumbnails[i]=loadImage("data/thumbnails/"+Playlist[i].substring(0, Playlist[i].length()-4)+".png");
		thumbnails[i].resize(45,45);
	}
}

void loadThumbnails(){
	// Path
	String path = sketchPath+"\\data\\thumbnails\\";

	// println("Listing all filenames in "+path);
	String[] filenames = listFileNames(path);
	// println(filenames);
	
	if(filenames==null || filenames.length!=Playlist.length){
		filenames = new String[Playlist.length];
		for (int i = 0; i<Playlist.length; i++){
			filenames[i]=".png";
		}
	}
	saveStrings("data/thumbnails.txt", filenames);
}