import React, { Component } from 'react';
import './App.scss';
import WaterWave from 'react-water-wave';

import ReactPlayer from 'react-player';
import huck from './misc/huck.jpg';

import headline from './misc/huckbanned1.png';
import headline2 from './misc/huckbanned2.png';

import mockingbird from './misc/mockingbirdbanned.png';

import newsHeadline from './misc/headline.png';

import tweet1 from './misc/tweet1.png';
import tweet2 from './misc/tweet2.png';
import tweet3 from './misc/tweet3.png';
import tweet4 from './misc/tweet4.png';
import tweet5 from './misc/tweet5.png';
import tweet6 from './misc/tweet6.png';

import tweet7 from './misc/tweet7.png';

import tweet8 from './misc/tweet8.png';

import tweet9 from './misc/tweet9.png';

import Gallery from 'react-photo-gallery';

const photos = [
  {
    src: tweet1,
    width: 1,
    height: 1
  },
  {
    src: tweet2,
    width: 2,
    height: 1
  },
  {
    src: tweet3,
    width: 1,
    height: 1
  },
  {
    src: tweet4,
    width: 3, 
    height: 1
  },
  {
    src: tweet5,
    width: 5, 
    height: 1
  },
  {
    src: tweet6,
    width: 2, 
    height: 1
  },
  {
    src: tweet7,
    width: 1,
    height: 1
  },
  {
    src: tweet8,
    width: 5, 
    height: 1
  },
  {
    src: tweet9,
    width: 4, 
    height: 1
  },

]

class App extends Component {

  render() {
    return (
      <div>
        <div className="fullSection centeredSection columnDisplay introColor">
            <h1 style={{ fontFamily: "Lato" }}> ECHOING VOICES </h1>
            <p id="credits"> By Aaron Chen  </p>
        </div>
        <div className="fullSection colorOne">
          
            <WaterWave className="rippleBody">
            {methods => (
                <div className="centeredSection rowDisplay">
                  <img className="item vertical" src={huck} style={{opacity: .8}} ></img>
                  <span className="filler"></span>
                  <div className="flex columnDisplay">
                    <p style={{ opacity: 0.8 }} className="item"> "Picking up noise as it travels across time, a text also picks up controversy, annoying and inspiring more and more readers, sharpening more and more ears at its expense." </p>
                    <p className="quoteCredit"> Wai Chee Dimok <i> Theory of Resonance </i> </p>
                  </div>
                  
                </div>
            )}
            </WaterWave>
          
        </div>
        <div className="fullSection colorOne">
            <WaterWave className="rippleBody">
            {methods => (
                  <div className="flex centeredSection rowDisplay">

                    <div className="flex columnDisplay" style={{ width: "75%" }}>
                      <p style={{ padding: 25, paddingBottom: 10, fontSize: "2em", opacity: 0.8 }}> "We talk about race and racism and acceptance and inclusivity and equity. We talk at that, but we don’t really listen and engage in a real substantive conversation." </p>
                      <p className="quoteCredit" style={{ paddingLeft: 25 }} > Jocelyn A. Chadwick </p>
                    </div>

                    <span className="flex columnDisplay" style={{ paddingTop: "50px" }}>
                      <img className="headline" style={{opacity: .7}} src={headline}></img>
                      <img className="headline" style={{opacity: .7}} src={headline2}></img>
                    </span>

                  </div>
            )}
            </WaterWave>
        </div>
        <div className="fullSection colorOne" style={{ height: "80vh" }}>
              <WaterWave className="rippleBody">
              { () => (
                <div style={{ height: "80vh", alignItems: "center" }} className="flex columnDisplay">
                  <h1 className="main-quote"> "the unity of a text is not in its origin, it is in its destination." </h1>
                  <p style={{ fontFamily: "Lato", fontSize: "2em" }}> Roland Barthes <i> Death of the Author </i> </p>
                </div>
              )}
              </WaterWave>
        </div>
        <div className="fullSection colorOne">
                <WaterWave className="rippleBody">
                  {() => (
                    <div style={{ height: "100vh" }} className="flex centeredSection columnDisplay">
                      <div className="video-wrapper">
                        <ReactPlayer 
                          url="https://www.youtube.com/watch?v=koPmuEyP3a0" 
                          width="100%"
                          height="100%"
                        /> 
                      </div>
                    </div>
                  )}
                </WaterWave>
        </div>
        <div className="fullSection colorOne" style={{ height: "180vh" }}>
                <WaterWave className="rippleBody">
                    {() => (
                      <div className="flex centeredSection columnDisplay" style={{ height: "120vh" }}>
                        <img style={{opacity: .7, width: "50%", paddingBottom: 100}} src={newsHeadline}></img>
                        <div className="flex rowDisplay" style={{ width: "60%" }} >
                            {/*
                            <img src={tweet1} style={{ width: "25%", height: "100%" }}></img>
                            <img src={tweet2} style={{ width: "35%", height: "100%" }}></img>
                            <img src={tweet3} style={{ width: "30%", height: "100%" }}></img>
                            */}
                            <Gallery photos={photos} />
                        </div>
                      </div>
                    )}
                </WaterWave>
        </div>
        <div className="fullSection colorOne">
                <WaterWave className="rippleBody">
                            {() => (
                              <div className="flex centeredSection columnDisplay" style={{ height: "100vh" }}>
                                <div style={{ width: "50%", opacity: 0.8 }}>
                                  <h4 style={{ width: "100%"}}>
                                    "...issuing from several cultures and entering into dialogue with each other, into parody, into contestation..."
                                  </h4>
                                  <h3 style={{ paddingLeft: "50px", paddingBottom: "40px", paddingTop: "40px" }}>
                                    "...there is one place where this multiplicity is collected, united..."
                                  </h3>
                                  <h2 style={{ paddingLeft: "100px", paddingBottom: "10px", paddingTop: "40px"}}>
                                    "...this place is not the author, as we have hitherto said it was, but the reader."
                                  </h2>
                                  <h4 style={{ paddingLeft: "100px" }}> Roland Barthes <i> Death of the Author </i> </h4>
                                </div>
                              </div>
                            )}
                </WaterWave>
        </div>
      </div>
    );
  }
}

export default App;
