<%@ page import="jakarta.servlet.http.*" %>
<%
    HttpSession sess = request.getSession();
    if (sess.getAttribute("csrfToken") == null) {
        sess.setAttribute("csrfToken", java.util.UUID.randomUUID().toString());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>SkillConnect</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    :root{
      --bg:#071023;
      --card:#0b1220;
      --muted:#9aa4b2;
      --accent:#6ee7b7;
      --secondary:#f97316;
      --radius:14px;
      --shadow:0 6px 18px rgba(2,6,23,0.6);
    }
    body{font-family:Inter, sans-serif;margin:0;background:var(--bg);color:#e6eef6;}

    /* Navbar */
    .navbar{background:var(--card)!important;}
    .navbar-brand{color:var(--accent)!important;font-weight:700;}
    .nav-link{color:#e6eef6!important;cursor:pointer;}

    /* Hero */
    .hero-container{position:relative;height:600px;overflow:hidden;border-radius:var(--radius);margin:20px;}
    .hero-slide{position:absolute;top:0;left:100%;width:100%;height:100%;background-size:cover;background-position:center;transition:left 1s ease-in-out;border-radius:var(--radius);}
    .hero-slide.active{left:0;}
    .hero-slide.prev{left:-100%;}
    .hero-slide::before{content:"";position:absolute;top:0;left:0;width:100%;height:100%;background-color:rgba(0,0,0,0.5);border-radius:var(--radius);}
    .hero-content{position:relative;z-index:2;text-align:center;color:#e6eef6;display:flex;flex-direction:column;justify-content:center;height:100%;padding:0 20px;}
    .hero-content h1{font-size:3rem;font-weight:700;margin-bottom:15px;}
    .hero-content p{font-size:1.25rem;color:var(--muted);}
    .hero-content .btn{background:var(--accent);border:none;color:#042021;font-weight:600;border-radius:var(--radius);}
    .hero-content input{border-radius:var(--radius);border:none;padding:12px;width:50%;margin-right:8px;}

    /* Categories */
    .category-icon{font-size:2rem;color:var(--accent);}
    .card{background:var(--card);border:none;border-radius:var(--radius);color:#e6eef6;}
    .card h5{margin-top:10px;}
    .card p{color:var(--muted);}

    /* Counters */
    .counter-section{display:flex;justify-content:space-around;padding:40px 0;background:var(--card);border-radius:var(--radius);margin:20px;}
    .counter-section h2{color:var(--accent);font-size:2rem;margin-bottom:5px;}
    .counter-section p{color:var(--muted);}

    /* Testimonials */
    .testimonial{background:var(--card);padding:20px;border-radius:var(--radius);font-style:italic;color:#e6eef6;margin-bottom:20px;box-shadow:var(--shadow);}
    .testimonial div{text-align:right;color:var(--accent);margin-top:10px;}

    /* Footer */
    .footer{background:var(--card);padding:30px 0;color:var(--muted);text-align:center;border-radius:var(--radius);margin-top:40px;}

    /* Overlays */
    .overlay{
      position:fixed; top:0; left:0; width:100%; height:100%;
      background:rgba(0,0,0,0.7); backdrop-filter: blur(5px);
      display:flex; justify-content:center; align-items:center; z-index:1000;
      opacity:0; visibility:hidden; transition:0.3s;
    }
    .overlay.active{opacity:1; visibility:visible;}

    .login-box, .register-box{
      background:var(--card); padding:40px; border-radius:var(--radius);
      box-shadow:var(--shadow); width:100%; max-width:400px; position:relative;
    }
    .login-box h3, .register-box h3{ text-align:center; margin-bottom:30px; color:var(--accent);}
    .form-control{background:rgba(255,255,255,0.05);border:none;color:#e6eef6;border-radius:var(--radius); margin-bottom:15px;}
    .form-control::placeholder{color: #9aa4b2; opacity:1;}
    .btn-login, .btn-register{
      background:var(--accent); border:none; color:#042021; font-weight:600; border-radius:var(--radius); width:100%; padding:12px; transition:0.3s;
    }
    .btn-login:hover, .btn-register:hover{background:linear-gradient(90deg,var(--accent),var(--secondary));}
    .close-btn{position:absolute;top:10px;right:15px;font-size:1.5rem;cursor:pointer;color:var(--accent);}
    a.btn-outline-secondary{border-color:var(--accent); color:var(--accent);}
    a.btn-outline-secondary:hover{background:var(--accent); color:#042021;}
  </style>
</head>
<body>

  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg shadow-sm">
    <div class="container">
      <a class="navbar-brand" href="#">SkillConnect</a>
      <div class="navbar-nav ms-auto">
        <a class="nav-link" id="openRegisterBtn"><i class="bi bi-person-plus me-1"></i>Register</a>
        <a class="nav-link" id="openLoginBtn"><i class="bi bi-box-arrow-in-right me-1"></i>Login</a>
      </div>
    </div>
  </nav>

  <!-- Hero Section -->
  <div class="hero-container" id="heroContainer">
    <div class="hero-slide active" style="background-image: url('skillhomepageImage_1.jpg');"></div>
    <div class="hero-slide" style="background-image: url('plumber.jpg');"></div>
    <div class="hero-slide" style="background-image: url('sofacleaning.jpg');"></div>
    <div class="hero-content">
      <h1>Hire Skilled Professionals Near You</h1>
      <p>Electricians, Plumbers, Cleaners, Designers & more — all in one place.</p>
      <form class="d-flex justify-content-center mt-4">
        <input type="text" placeholder="Search for services...">
        <button class="btn">Search</button>
      </form>
    </div>
  </div>

  <!-- Categories -->
  <div class="container py-5">
    <h2 class="text-center mb-4">Popular Categories</h2>
    <div class="row text-center">
      <div class="col-md-3 mb-4">
        <div class="card h-100 shadow-sm">
          <div class="card-body">
            <i class="bi bi-tools category-icon mb-2"></i>
            <h5>Home Repair</h5>
            <p>Electricians, carpenters, and more.</p>
          </div>
        </div>
      </div>
      <div class="col-md-3 mb-4">
        <div class="card h-100 shadow-sm">
          <div class="card-body">
            <i class="bi bi-laptop category-icon mb-2"></i>
            <h5>IT & Tech</h5>
            <p>Software, hardware, and support.</p>
          </div>
        </div>
      </div>
      <div class="col-md-3 mb-4">
        <div class="card h-100 shadow-sm">
          <div class="card-body">
            <i class="bi bi-brush category-icon mb-2"></i>
            <h5>Design & Creative</h5>
            <p>Graphics, branding, and media.</p>
          </div>
        </div>
      </div>
      <div class="col-md-3 mb-4">
        <div class="card h-100 shadow-sm">
          <div class="card-body">
            <i class="bi bi-book category-icon mb-2"></i>
            <h5>Cleaning Services</h5>
            <p>Sofa, carpet, and home cleaning.</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Counters -->
  <div class="counter-section">
    <div><h2><span id="counter1">0</span>+</h2><p>Professionals Registered</p></div>
    <div><h2><span id="counter2">0</span>+</h2><p>Jobs Completed</p></div>
    <div><h2><span id="counter3">0</span>+</h2><p>Happy Clients</p></div>
  </div>

  <!-- Testimonials -->
  <div class="container py-5">
    <h2 class="text-center mb-4">What Clients Say</h2>
    <div class="row">
      <div class="col-md-4">
        <div class="testimonial">“SkillConnect helped me find a reliable electrician in minutes. Great experience!”<div>– Priya S.</div></div>
      </div>
      <div class="col-md-4">
        <div class="testimonial">“I got a freelance designer for my startup logo. Fast and professional.”<div>– Rohan M.</div></div>
      </div>
      <div class="col-md-4">
        <div class="testimonial">“The cleaning service booked through SkillConnect was excellent and fast!”<div>– Neha T.</div></div>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <div class="footer">&copy; 2025 SkillConnect. All rights reserved.</div>

  <!-- Register Overlay -->
  <div class="overlay" id="registerOverlay">
    <div class="register-box">
      <span class="close-btn" id="closeRegisterBtn">&times;</span>
      <h3>Create Account</h3>
      <form action="register" method="POST">
        <input type="hidden" name="csrfToken" value="<%= sess.getAttribute("csrfToken") %>">
        <input type="text" class="form-control" name="fullname" placeholder="Full Name" required>
        <input type="email" class="form-control" name="email" placeholder="you@example.com" required>
        <input type="tel" class="form-control" name="phone" placeholder="+91XXXXXXXXXX">
        <select class="form-select mb-3" name="role" required>
          <option value="">Select Role</option>
          <option value="Worker">Worker</option>
          <option value="Employer">Employer</option>
        </select>
        <input type="text" class="form-control" name="location" placeholder="Location">
        <input type="text" class="form-control" name="skills" placeholder="Skills">
        <input type="password" class="form-control" name="password" placeholder="Password" required>
        <button type="submit" class="btn-register">Register</button>
      </form>
      <p class="text-center mt-3">
        Already have an account? <a href="#" class="btn btn-outline-secondary btn-sm" id="switchToLogin">Login</a>
      </p>
    </div>
  </div>

  <!-- Login Overlay -->
  <div class="overlay" id="loginOverlay">
    <div class="login-box">
      <span class="close-btn" id="closeLoginBtn">&times;</span>
      <h3>Login</h3>
      <form action="login" method="POST">
        <input type="hidden" name="csrfToken" value="<%= sess.getAttribute("csrfToken") %>">
        <input type="email" class="form-control" name="email" placeholder="you@example.com" required>
        <input type="password" class="form-control" name="password" placeholder="Enter password" required>
        <button type="submit" class="btn-login">Login</button>
      </form>
      <p class="text-center mt-3">
        New user? <a href="#" class="btn btn-outline-secondary btn-sm" id="switchToRegister">Register</a>
      </p>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Hero Slider
    const slides = document.querySelectorAll('.hero-slide');
    let current = 0;
    const totalSlides = slides.length;
    setInterval(()=>{
      const prev = current;
      current = (current+1)%totalSlides;
      slides[prev].classList.remove('active');
      slides[prev].classList.add('prev');
      slides[current].classList.add('active');
      setTimeout(()=>slides[prev].classList.remove('prev'),1000);
    },5000);

    // Overlay Logic
    const registerOverlay = document.getElementById('registerOverlay');
    const openRegisterBtn = document.getElementById('openRegisterBtn');
    const closeRegisterBtn = document.getElementById('closeRegisterBtn');
    const switchToLogin = document.getElementById('switchToLogin');

    const loginOverlay = document.getElementById('loginOverlay');
    const openLoginBtn = document.getElementById('openLoginBtn');
    const closeLoginBtn = document.getElementById('closeLoginBtn');
    const switchToRegister = document.getElementById('switchToRegister');

    openRegisterBtn.addEventListener('click', e=>{ e.preventDefault(); registerOverlay.classList.add('active'); });
    closeRegisterBtn.addEventListener('click', ()=>{ registerOverlay.classList.remove('active'); });
    registerOverlay.addEventListener('click', e=>{ if(e.target===registerOverlay) registerOverlay.classList.remove('active'); });
    switchToLogin.addEventListener('click', e=>{ e.preventDefault(); registerOverlay.classList.remove('active'); loginOverlay.classList.add('active'); });

    openLoginBtn.addEventListener('click', e=>{ e.preventDefault(); loginOverlay.classList.add('active'); });
    closeLoginBtn.addEventListener('click', ()=>{ loginOverlay.classList.remove('active'); });
    loginOverlay.addEventListener('click', e=>{ if(e.target===loginOverlay) loginOverlay.classList.remove('active'); });
    switchToRegister.addEventListener('click', e=>{ e.preventDefault(); loginOverlay.classList.remove('active'); registerOverlay.classList.add('active'); });
  </script>
</body>
</html>
