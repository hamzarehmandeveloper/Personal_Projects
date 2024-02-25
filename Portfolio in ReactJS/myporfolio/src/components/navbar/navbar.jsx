import React from "react";
import { Navbar, Nav, Container } from "react-bootstrap";
import "./navbar.css";

const NavBar = () => {
  return (
    <Navbar className="nav" expand="lg" style={{ paddingTop: 20 }}>
      <Container className="main_navbar_container">
        <Navbar.Toggle aria-controls="basic-navbar-nav" />
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="nav_header me-auto d-flex justify-content-center align-items-center">
            <Nav.Link className="links" href="#home">
              Home
            </Nav.Link>
            <Nav.Link className="links" href="#about">
              About
            </Nav.Link>
            <Nav.Link className="links" href="#services">
              Services
            </Nav.Link>
            <Nav.Link className="links" href="#portfolio">
              Portfolio
            </Nav.Link>
            <Nav.Link className="links" href="#contact">
              Contact
            </Nav.Link>
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
};

export default NavBar;
