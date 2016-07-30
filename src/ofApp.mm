#include "ofApp.h"

ofPlanePrimitive plane;

ofBoxPrimitive box;
ofSpherePrimitive sp;
ofMaterial material;
int w,h;

int touchX,touchY;
float rotation;
//--------------------------------------------------------------
void ofApp::setup(){
	ofBackground(40);
	ofSetVerticalSync(false);
	ofEnableAlphaBlending();
    ofSetLogLevel(OF_LOG_VERBOSE);
    
    //shader.load("shaders/noise.vert", "shaders/noise.frag");
    bUseShader = false;
    
	//we load a font and tell OF to make outlines so we can draw it as GL shapes rather than textures
    int fontSize = ofGetWidth() / 10;
	font.load("type/verdana.ttf", fontSize, true, false, true, 0.4, 72);
    sp.set(200, 10);
    sp.setPosition(ofGetWidth()/2, ofGetHeight()/2, 0);
    plane.set(ofGetWidth()*1.5, ofGetHeight()*1.5, 50, 50);
    plane.setPosition(0, 0, 0);
    
    material.setColors(ofColor(255), ofColor(255), ofColor(255), ofColor(255));
    
    box.set(50, 50, 50, 100, 100, 100);
    box.setPosition(100, 100, 0);
    box.setResolution(10);
    w = ofGetWidth();
    h = ofGetHeight();
    movie.setup(w, h);
    
    w = movie.getWidth();
    h = movie.getHeight();
    
//#ifdef TARGET_OPENGLES
    shader.load("shadersES2/shader");
    shader00.load("00/shader");
//#else
//    if(ofIsGLProgrammableRenderer()){
//    shader.load("shadersGL3/shader");
//    }else{
        //shader.load("shadersGL2/shader");
//    }
//#endif
    
    img.allocate(80, 60, OF_IMAGE_GRAYSCALE);
    
    plane.set(800, 600, 80, 60);
    plane.mapTexCoordsFromTexture(img.getTextureReference());
    
}

//--------------------------------------------------------------
void ofApp::update(){
    movie.update();
    
    plane.rotate(0.1, ofVec3f(0,1,0));
    
    
    
    
    float noiseScale = ofMap(mouseX, 0, ofGetWidth(), 0, 0.1);
    float noiseVel = ofGetElapsedTimef();
    
    unsigned char * pixels = img.getPixels();
    int w = img.getWidth();
    int h = img.getHeight();
    for(int y=0; y<h; y++) {
        for(int x=0; x<w; x++) {
            int i = y * w + x;
            float noiseVelue = ofNoise(x * noiseScale, y * noiseScale, noiseVel);
            pixels[i] = 255 * noiseVelue;
        }
    }
    img.update();
}

//--------------------------------------------------------------
void ofApp::draw(){
//    ofPushStyle();
//	//ofSetColor(245, 58, 135);
//	//ofFill();
//    
//    if(bUseShader) {
//        shader.begin();
//        shader.setUniform1f("timeValX", ofGetElapsedTimef() * 0.1 );     // we want to pass in some varrying values to animate our type / color
//        shader.setUniform1f("timeValY", -ofGetElapsedTimef() * 0.18 );
//        shader.setUniform2f("mouse", mousePoint.x, mousePoint.y);
//        // we also pass in the mouse position
//        //shader.setUniformTexture(<#const string &name#>, <#int textureTarget#>, <#GLint textureID#>, <#int textureLocation#>)
//    }
//    
//    
//    //material.begin();
//    //plane.drawWireframe();
//    //material.end();
//    
////    cam.getTexture().bind();
////    plane.draw(OF_MESH_WIREFRAME);
////    cam.getTexture().unbind();
//    //ofDrawPlane(0, 0, ofGetWidth()*2, ofGetHeight()*2);
//    //cam.draw(0,0, ofGetWidth(),ofGetHeight());
//    
//    //ofDrawPlane(0, 0,ofGetWidth(), ofGetHeight());
//    
//    ofRectangle rect = font.getStringBoundingBox("openFrameworks", 0, 0);   // size of text.
//    int x = (ofGetWidth() - rect.width) * 0.5;                              // position in center screen.
//    int padding = rect.height + 50;                                         // draw the text multiple times.
//    for(int y=rect.height; y<ofGetHeight(); y+=padding) {
//        font.drawStringAsShapes("openFrameworks", x, y);
//    }
//    //cam.draw(0, 0, ofGetWidth(), ofGetHeight());
//   // ofRect(0, 0, ofGetWidth()*2, ofGetHeight()*2);
//    
//
//    if(bUseShader) {
//        shader.end();
//    }
//    
//    ofPopStyle();
    
    
    //plane.drawWireframe();
    
//    sp.drawWireframe();
//    box.drawWireframe();
    ofRotateX(80);
    img.getTextureReference().bind();
    
    shader.begin();
    
    //ofPushMatrix();
    
    // translate plane into center screen.
//    float tx = ofGetWidth() / 2;
//    float ty = ofGetHeight() / 2;
//    ofTranslate(tx, ty);
//    
//    // the mouse/touch Y position changes the rotation of the plane.
//    float percentY = mouseY / (float)ofGetHeight();
//    float rotation = ofMap(percentY, 0, 1, -60, 60, true) + 60;
//    ofRotate(rotation, 1, 0, 0);
    
    plane.drawWireframe();
    
    //ofPopMatrix();
    
    shader.end();
    
    ofSetColor(ofColor::white);
    img.draw(0, 0);
    
    
    ofSetColor(255);
    
    shader.begin();
    
    ofRect(0, 0, ofGetWidth(), ofGetHeight());
    
    shader.end();
    
}


//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    bUseShader = true;
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    // we have to transform the coords to what the shader is expecting which is 0,0 in the center and y axis flipped.
    mousePoint.x = touch.x * 2 - ofGetWidth();
    mousePoint.y = ofGetHeight() * 0.5 - touch.y;
    
    touchX = touch.x;
    touchY = touch.y;
    
    float percentY = touch.y / (float)ofGetHeight()*2;
    rotation = ofMap(percentY, 0, 1, -60, 60, true) + 60;
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    bUseShader = false;
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}

