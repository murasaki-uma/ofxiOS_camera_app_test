#pragma once

#include "ofxiOS.h"

class ofApp : public ofxiOSApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);
	
        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);

        ofShader shader;
    ofShader shader00;
        bool bUseShader;
		ofTrueTypeFont font;
        ofPoint mousePoint;
    
    ofVideoGrabber movie;
    
    
    ofEasyCam cam;
    ofLight directional;
    ofImage colormap;
    
    
    int target;
    bool bShowHelp;
    
    
    ofPlanePrimitive plane;
    ofImage img;
};

