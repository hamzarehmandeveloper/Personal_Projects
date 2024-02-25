import { React } from "react";
import "../main_page/mainScreen.css";
import NavBar from "../navbar/navbar.jsx";
import myImage from "../../Assets/myimage.png";
import CVpdf from "../../Assets/HamzaCV.pdf";
import linkedin from "../../Assets/linkedIn.png";
import github from "../../Assets/github.png";
import { Row, Col, Container, Button } from "react-bootstrap";
import About from "../about/about.jsx";

const MainScreen = () => {
  return (
    <>
      <Container id="mainSection">
        <NavBar />
        <Row className="main-container">
          <Col xs={12} md={6} className="left-column">
            <p style={{ padding: 0, marginBottom: 0 }}>Hello, I'm</p>
            <h1 style={{ padding: 0, marginBottom: 0 }} id="name">
              HAMZA REHMAN
            </h1>
            <p style={{ padding: 0 }}>SOFTWARE ENGINEER</p>
            <Container style={{ padding: 0 }}>
              <Row>
                <ul className="stackList">
                  <li>React</li>
                  <li>JavaScript</li>
                  <li>HTML</li>
                  <li>CSS</li>
                  <li>Bootstrap</li>
                  <li>Flutter</li>
                  <li>Dart</li>
                  <li>Firebase</li>
                  <li>MongoDB</li>
                  <li>Git</li>
                </ul>
              </Row>
              <Row id="logocontainer">
                <Col>
                  <a
                    href="https://www.linkedin.com/in/hamzarehmandeveloper/"
                    target="_blank"
                  >
                    <img className="logo" src={linkedin} alt="linkedIn" />
                  </a>
                  <a
                    href="https://github.com/hamzarehmandeveloper"
                    target="_blank"
                  >
                    <img className="logo" src={github} alt="linkedIn" />
                  </a>
                </Col>
              </Row>
              <Row>
                <Col>
                  <Button
                    className="button"
                    style={{ marginTop: 20 }}
                    variant="outline-dark"
                    size="lg"
                    href={CVpdf}
                    download
                  >
                    Download CV
                  </Button>
                </Col>
              </Row>
            </Container>
          </Col>
          <Col md={6} className="right-column">
            <img className="myImage" src={myImage} alt="My Image" />
          </Col>
        </Row>
      </Container>
      <Col sm={12}>
        <About />
      </Col>
    </>
  );
};

export default MainScreen;
