#include "ofApp.h"

float w,h;
ofVboMesh mesh;
ofEasyCam cam;
ofImage img;
ofTexture tex;
ofPlanePrimitive plane;

ofMesh tri;
ofVideoGrabber movie;
//--------------------------------------------------------------
void ofApp::setup(){
    
    
    plane.set(ofGetWidth(), ofGetHeight(), 100, 100);
    cout << plane.getMesh().getVertex(0) << endl;
    mesh = plane.getMesh();
    
    for(int i = 0; i < plane.getMesh().getNumVertices(); i++)
    {
        ofVec3f center;center.set(ofGetWidth()/2,ofGetHeight()/2,0);
        float radius = 100;
        ofVec3f v = plane.getMesh().getVertex(i);
        v +=ofVec3f(ofGetWidth()/2,ofGetHeight()/2);
        
        if(v.distance(center) < 100 ){
            float dist = v.distance(center);
            float height = ofMap(dist, 0, 100, 100, 0);
            float sin = ofMap(dist, 0, 100, PI, 0);
            plane.getMesh().setVertex(i, v+ofVec3f(0,0,100*sin));
        }else {
            
            plane.getMesh().setVertex(i, v);
        }
        
        
        
        plane.getMesh().setTexCoord(i, plane.getMesh().getVertex(i));
        
    }
    
    
    ofVec3f point0 = ofVec3f(0,0,0);
    
    ofVec3f point1 = ofVec3f(0,100,0);
    ofVec3f point2 = ofVec3f(100,0,0);
    tri.addVertex( point0 ); tri.addVertex( point1 ); tri.addVertex( point2 );
    tri.addTexCoord(point0);
    tri.addTexCoord(point1);
    tri.addTexCoord(point2);
    
    movie.setup(ofGetWidth(), ofGetHeight());
    //tex.allocate(movie.getWidth(),movie.getHeight(),GL_RGB);
    img.allocate(movie.getWidth(), movie.getHeight(), OF_IMAGE_COLOR);
    
    
}

//--------------------------------------------------------------
void ofApp::update(){
    
    movie.update();
    img.setFromPixels(movie.getPixels().getData(), movie.getWidth(), movie.getHeight(), OF_IMAGE_COLOR);
   
}

//--------------------------------------------------------------
void ofApp::draw(){

    img.bind();
    //
    plane.draw();
    img.unbind();
    
    //movie.draw(0, 0, ofGetWidth(), ofGetHeight());
    
}


//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
   
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

