import { BrowserRouter, Routes, Route, Link } from "react-router-dom";
import About from "./About";
import Contact from "./Contact";
import Home from "./Home";

function App() {
  return (
    <BrowserRouter>
      <div>
        {/* Header text */}
        <h1>Welcome to My Website!</h1>
        <p>This is a simple React app with routing.</p>

        {/* Navigation Links */}
        <nav>
          <Link to="/">Home</Link> |{" "}
          <Link to="/about">About</Link> |{" "}
          <Link to="/contact">Contact</Link>
        </nav>

        {/* Routes */}
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/about" element={<About />} />
          <Route path="/contact" element={<Contact />} />
        </Routes>

        {/* Footer text */}
        <footer>
          <p>© 2026 My Website. All rights reserved.</p>
        </footer>
      </div>
    </BrowserRouter>
  );
}

export default App;
