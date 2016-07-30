#include "ofApp.h"
ofVideoGrabber movie;
ofImage img;
ofPlanePrimitive plane;
ofShader shader;

float touchX,touchY;
//--------------------------------------------------------------
void ofApp::setup(){
    
    shader.load("shaders/shader");
    
    ///img.allocate(80, 60, OF_IMAGE_GRAYSCALE);
    
    plane.set(ofGetWidth(), ofGetHeight(), 100, 100);
    
    movie.setup(ofGetWidth()*2, ofGetHeight()*2);
    
    img.allocate(movie.getWidth(), movie.getHeight(), OF_IMAGE_COLOR);
    
    plane.mapTexCoordsFromTexture(img.getTextureReference());
    
    touchX = touchY =0;
    
    
    for(int i = 0; i < plane.getMesh().getNumVertices(); i++)
    {
        ofVec3f center;
        center.set(0,0,0);
        float radius = 100;
        ofVec3f v = plane.getMesh().getVertex(i);
        //v +=ofVec3f(ofGetWidth()/2,ofGetHeight()/2);
        
        if(v.distance(center) < 200 ){
            float dist = v.distance(center);
            float height = ofMap(dist, 0, 200, 200, 0);
            float sin = ofMap(dist, 0, 200, PI, 0);
            plane.getMesh().setVertex(i, v+ofVec3f(0,0,100*sin));
        }else {
            
            plane.getMesh().setVertex(i, v);
        }
        
        
        
        //plane.getMesh().setTexCoord(i, plane.getMesh().getVertex(i));
        
    }
}

//--------------------------------------------------------------
void ofApp::update(){
    
    movie.update();
    float noiseScale = ofMap(mouseX, 0, ofGetWidth(), 0, 0.1);
    float noiseVel = ofGetElapsedTimef();
    
    //    unsigned char * pixels = img.getPixels();
    //    int w = img.getWidth();
    //    int h = img.getHeight();
    //    for(int y=0; y<h; y++) {
    //        for(int x=0; x<w; x++) {
    //            int i = y * w + x;
    //            float noiseVelue = ofNoise(x * noiseScale, y * noiseScale, noiseVel);
    //            pixels[i] = 255 * noiseVelue;
    //        }
    //    }
    //    img.update();
    
    if(movie.isFrameNew() && movie.getPixels().getData() != NULL){
        img.setFromPixels(movie.getPixels().getData(), movie.getWidth(), movie.getHeight(), OF_IMAGE_COLOR);
    }
    img.update();
    
    
    float cx = ofGetWidth() / 2.0;
    float cy = ofGetHeight() / 2.0;
    
    // the plane is being position in the middle of the screen,
    // so we have to apply the same offset to the mouse coordinates before passing into the shader.
    float mx = touchX - cx;
    float my = touchY - cy;
    
    // we can pass in a single value into the shader by using the setUniform1 function.
    // if you want to pass in a float value, use setUniform1f.
    // if you want to pass in a integer value, use setUniform1i.
    shader.setUniform1f("mouseRange", 150);
    
    // we can pass in two values into the shader at the same time by using the setUniform2 function.
    // inside the shader these two values are set inside a vec2 object.
    shader.setUniform2f("mousePos", mx, my);
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    // bind our texture. in our shader this will now be tex0 by default
    // so we can just go ahead and access it there.
    img.getTextureReference().bind();
    
    shader.begin();
    
    ofPushMatrix();
    
    // translate plane into center screen.
    float tx = ofGetWidth() / 2;
    float ty = ofGetHeight() / 2;
    ofTranslate(tx, ty);
    
    // the mouse/touch Y position changes the rotation of the plane.
//    float percentY = mouseY / (float)ofGetHeight();
//    float rotation = ofMap(percentY, 0, 1, -60, 60, true) + 60;
//    ofRotate(rotation, 1, 0, 0);
    
    plane.draw();
    
    ofPopMatrix();
    
    shader.end();
    
    ofSetColor(ofColor::white);
    //img.draw(0, 0);
}

//--------------------------------------------------------------
void ofApp::exit(){
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    //doShader = !doShader;
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    
    touchX = touch.x;
    touchY = touch.y;
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    
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
