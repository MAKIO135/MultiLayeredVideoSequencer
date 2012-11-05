void initBlendModes(){
	println("BlendModes Initializing");
	BlendModes = new GLTextureFilter[18];
	BlendModes[0] = new GLTextureFilter(this, "data/BlendModes/BlendUnmultiplied.xml");
	BlendModes[1] = new GLTextureFilter(this, "data/BlendModes/BlendPremultiplied.xml");
	BlendModes[2] = new GLTextureFilter(this, "data/BlendModes/BlendColor.xml");
	BlendModes[3] = new GLTextureFilter(this, "data/BlendModes/BlendLuminance.xml");
	BlendModes[4] = new GLTextureFilter(this, "data/BlendModes/BlendMultiply.xml");
	BlendModes[5] = new GLTextureFilter(this, "data/BlendModes/BlendSubtract.xml");
	BlendModes[6] = new GLTextureFilter(this, "data/BlendModes/BlendAdd.xml");
	BlendModes[7] = new GLTextureFilter(this, "data/BlendModes/BlendColorDodge.xml");
	BlendModes[8] = new GLTextureFilter(this, "data/BlendModes/BlendColorBurn.xml");
	BlendModes[9] = new GLTextureFilter(this, "data/BlendModes/BlendDarken.xml");
	BlendModes[10] = new GLTextureFilter(this, "data/BlendModes/BlendLighten.xml");
	BlendModes[11] = new GLTextureFilter(this, "data/BlendModes/BlendDifference.xml");
	BlendModes[12] = new GLTextureFilter(this, "data/BlendModes/BlendInverseDifference.xml");
	BlendModes[13] = new GLTextureFilter(this, "data/BlendModes/BlendExclusion.xml");
	BlendModes[14] = new GLTextureFilter(this, "data/BlendModes/BlendScreen.xml");
	BlendModes[15] = new GLTextureFilter(this, "data/BlendModes/BlendSoftLight.xml");
	BlendModes[16] = new GLTextureFilter(this, "data/BlendModes/BlendOverlay.xml");
	BlendModes[17] = new GLTextureFilter(this, "data/BlendModes/BlendHardLight.xml");
	println("BlendModes Initialized\n");
}