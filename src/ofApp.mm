#include "ofApp.h"
ofVideoGrabber movie;
ofPlanePrimitive plane;
ofShader shader;

//--------------------------------------------------------------
void ofApp::setup(){
    
    plane.set(ofGetWidth(), ofGetHeight(), 100, 100);
    
    movie.setup(ofGetWidth()*2, ofGetHeight()*2);
    
    
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
    }
}

//--------------------------------------------------------------
void ofApp::update(){
    
    movie.update();

    if(movie.isFrameNew() && movie.getPixels().getData() != NULL){
        plane.mapTexCoordsFromTexture(movie.getTextureReference());
    }
    
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    movie.getTextureReference().bind();
    
    
    ofPushMatrix();
    
    float tx = ofGetWidth() / 2;
    float ty = ofGetHeight() / 2;
    ofTranslate(tx, ty);
    
    plane.draw();
    
    ofPopMatrix();
    movie.getTextureReference().unbind();
    
    ofSetColor(ofColor::white);
    
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
