<h1>Multi Layered Video Sequencer</h1>
Made with Processing 1.5.1, GSVideo 1.0.0, GLGraphics 1.0.0 and ControlP5 0.7.6<br />
This project is under developpement.<br />
<br />
![Alt Video Sequencer](http://makio.free.fr/divers/Github/VideoSequencer.jpg)
First, add your videos inside /data/videos folder. It will automatically create playlist and check if thumbnails exist or need to be created.<br />
<br />
The Sequencer works in 3 steps/parts: 
<li>
	<ul>Clips: choose a video, modify its settings and add the created clip to a chosen Layer.</ul>
	<ul>Layers: a succession of clips playing one after another, you can modify each layer settings and choose a delay before playing Layer.</ul>
	<ul>Composition: all the Layers playing at the same time (after their launch delay is met) with the blendMode chosen for the current clip of each Layer.</ul>
</li>
<h4>Due to some bug on the first part, only the first part is released at this time.<br />Help would be welcome.</h4>
<br />
<h2>Part 1: Clip Editor</h2>
![Alt Video Sequencer Part 1](http://makio.free.fr/divers/Github/VideoSequencerPart1.png)<br />
This allows you to edit Clip settings like:
<li>
<ul>play mode: loop or play-playback</ul>
<ul>number of repetition (loop 1 = play once, you need 2 for play-playback)</ul>
<ul>how fast/slow the movie should be run</ul>
<ul>position XY</ul>
<ul>scale</ul>
<ul>opacity</ul>
<ul>blendmode</ul>
<ul>custom fade in and fade out</ul>
<ul>(choice of VideoLayer to add the clip to)</ul>
</li>
<br />
<h3>Needing fixes:</h3>
<li>
<ul>Timeline: Not updating correctly</ul>
<ul>readPosition: Define time of the reading on totalDuration (duration*nbRepeat) of the clip</ul>
<ul>Play mode: Sometimes loop when it should playback</ul>
<ul>Gstreamer: Crashing randomly</ul>
</li>

<br />
<br />
<h2>Part 2: VideoLayers</h2>
<br />
<br />
<h2>Part 3: Composition</h2>