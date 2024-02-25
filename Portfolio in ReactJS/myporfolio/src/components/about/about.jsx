import React from "react";
import { Container, Col, Row } from "react-bootstrap";
import "../about/about.css";
import SkillPic from "../../Assets/skills-pic.png";

const toolListData = [
  { text: "Flutter / Dart - Mobile App Development Framework" },
  { text: "Firebase-Backend as a Service Platform" },
  { text: "ReactJS-Front End Library for Web Development" },
  { text: "Node.js-Server Side Rendering Environment" },
  { text: "Express-Lightweight Node.js Web Framework" },
  { text: "MongoDB-NoSQL Database for Data Storage" },
  { text: "MySQL-Open Source RDMBS for data management" },
  { text: "Git-Version Control System for Code Repository" },
];

export default function about() {
  return (
    <>
      <Container
        className="aboutcontainer"
        style={{ paddingTop: 30, paddingBottom: 30 }}
      >
        <Col>
          <h1 id="about">About</h1>
        </Col>
        <Col>
          <h1 style={{ padding: 0, marginTop: 50 }}>
            Professional <span>Problem Solutions</span> For Digital Products
          </h1>
        </Col>
        <Row className="skills-con">
          <Col className="para-con" sm={12} lg={6}>
            <p id="paragraph" style={{ paddingBottom: 0, marginBottom: 0 }}>
              A dedicated Software Developer with expertise in Flutter, Dart,
              Firebase, React, and a strong foundation in JavaScript, CSS, HTML,
              MUI, Bootstrap, and Git. Passionate about creating efficient and
              innovative solutions, I thrive in collaborative environments where
              my skills in mobile and web development can contribute to
              impactful projects.
            </p>
          </Col>
          <Col sm={12} lg={6}>
            <Container className="skills-pic" style={{ padding: 0 }}>
              <img src={SkillPic} alt="skills" />
            </Container>
          </Col>
        </Row>
        <Row className="skills-con">
          {/* <Col sm={12} lg={6}>
            <Container className="skills">
              <h4 className="tools">Skills & Tools</h4>
              {toolListData.map((item, index) => (
                <Row key={index} style={{ padding: 5 }}>
                  <Col className="toolsList">
                    <img className="tick" src={tick} alt="tick" />
                    <p style={{ padding: 0, marginBottom: 0, fontSize: 22 }}>
                      {item.text}
                    </p>
                  </Col>
                </Row>
              ))}
            </Container>
          </Col> */}
        </Row>
      </Container>
    </>
  );
}
