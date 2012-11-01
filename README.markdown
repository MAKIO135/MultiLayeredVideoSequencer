<h1>Multi Layered Video Sequencer</h1>
Made with:<br>
<li>
	<ul>Processing 1.5.1: <a href="http://processing.org/download/">http://processing.org/download/</a><br>
	GSVideo 1.0.0: <a href="http://sourceforge.net/projects/gsvideo/files/gsvideo/1.0/">http://sourceforge.net/projects/gsvideo/files/gsvideo/1.0/</a><br>
	GLGraphics 1.0.0: <a href="http://sourceforge.net/projects/glgraphics/files/glgraphics/1.0/">http://sourceforge.net/projects/glgraphics/files/glgraphics/1.0/</a><br>
	ControlP5 1.5.2: <a href="http://code.google.com/p/controlp5/downloads/list">http://code.google.com/p/controlp5/downloads/list</a></ul>
</li>

<p>Videos used in the demo are from <a href="http://www.beeple-crap.com/vjclips.php">Beeple</a></p>

<h3>This project is under developpement.<br>Help welcome.</h3>
<img src="http://makio.free.fr/divers/Github/VideoSequencer.jpg">
<br>
<p>First, add your videos inside /data/videos folder. It will automatically create playlist and check if thumbnails exist or need to be created.</p>
<p>The Sequencer works in 3 steps/parts:</p>
<li>
	<ul>- Clips: choose a video, modify its settings and add the created clip to a chosen Layer.<br>
	- Layers: a succession of clips playing one after another, you can modify each layer settings and choose a delay before playing Layer.<br>
	- Composition: all the Layers playing at the same time (after their launch delay is met) with the blendMode chosen for the current clip of each Layer.</ul>
</li>
<h4>Due to some bug on the first part, only the first part is released at this time.</h4>
<br>
<h2>Part 1: Clip Editor</h2>
<img src="http://makio.free.fr/divers/Github/VideoSequencerPart1.png" alt="Video Sequencer Part 1"><br>
<p>This allows you to edit Clip settings like:</p>
<li>
	<ul>- play mode: loop or play-playback<br>
	- number of repetition (loop 1 = play once, you need 2 for play-playback)<br>
	- how fast/slow the movie should be run<br>
	- position XY<br>
	- scale<br>
	- opacity<br>
	- blendmode<br>
	- custom fade in and fade out<br>
	(- choice of VideoLayer to add the clip to)</ul>
</li>
<br>
<h3>Needing fixes:</h3>
<li>
	<ul>- Timeline: Not updating correctly<br>
	- Opacity: modfying opacity slider have the clip disappear<br>
	- readPosition: Define current position of the reading on totalDuration (duration*nbRepeat) of the clip<br>
	- Play mode: Sometimes loop when it should playback<br>
	- Gstreamer: Crashing randomly</ul>
</li>

<br>
<br>
<h2>Part 2: VideoLayers</h2>
<p>Part 2 will be released as soon as Part 1 will be fixed.</p>
<br>
<br>
<h2>Part 3: Composition</h2>
<p>Part 3 will be released as soon as Part 2 will be fixed.</p>
<br>
<br>