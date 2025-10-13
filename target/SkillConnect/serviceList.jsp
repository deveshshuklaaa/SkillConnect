<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillconnect.models.User" %>
<%@ page import="com.skillconnect.dao.ServiceDAO" %>
<%@ page import="com.skillconnect.dao.UserDAO" %>
<%@ page import="com.skillconnect.models.Service" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    ServiceDAO serviceDAO = new ServiceDAO();
    UserDAO userDAO = new UserDAO();
    List<Service> services = serviceDAO.getAllActiveServices();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Services - SkillConnect</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">SkillConnect</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link active" href="serviceList.jsp">Services</a>
                <a class="nav-link" href="about.jsp">About</a>
                <a class="nav-link" href="contact.jsp">Contact</a>
                <% if (user != null) { %>
                    <a class="btn btn-danger ms-2" href="logout.jsp">Logout</a>
                <% } else { %>
                    <a class="btn btn-primary ms-2" href="login.jsp">Login</a>
                <% } %>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2>Available Services</h2>
        <div class="mb-4">
            <form class="row g-3">
                <div class="col-md-4">
                    <label for="locationFilter" class="form-label">Filter by Location</label>
                    <select class="form-select" id="locationFilter">
                        <option value="">All Locations</option>
                        <option value="Delhi">Delhi</option>
                        <option value="Mumbai">Mumbai</option>
                        <option value="Bangalore">Bangalore</option>
                        <option value="Chennai">Chennai</option>
                        <option value="Kolkata">Kolkata</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="serviceFilter" class="form-label">Filter by Service Type</label>
                    <select class="form-select" id="serviceFilter">
                        <option value="">All Services</option>
                        <option value="Cleaning">Cleaning</option>
                        <option value="Plumbing">Plumbing</option>
                        <option value="Electrical">Electrical</option>
                        <option value="Carpentry">Carpentry</option>
                        <option value="Painting">Painting</option>
                        <option value="Appliance Repair">Appliance Repair</option>
                        <option value="Pest Control">Pest Control</option>
                        <option value="Home Salon">Home Salon</option>
                        <option value="Car Wash">Car Wash</option>
                        <option value="AC Service">AC Service</option>
                    </select>
                </div>
            </form>
        </div>
        <div class="row" id="servicesContainer">
            <!-- Sample Services for Delhi -->
            <div class="col-md-4 mb-4" data-location="Delhi" data-service="Cleaning">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Home Cleaning</h5>
                        <p class="card-text">Price: ₹500</p>
                        <p class="card-text">Location: Delhi</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="1">
                            <input type="hidden" name="workerId" value="4">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4" data-location="Delhi" data-service="Plumbing">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Plumbing Repair</h5>
                        <p class="card-text">Price: ₹300</p>
                        <p class="card-text">Location: Delhi</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="2">
                            <input type="hidden" name="workerId" value="5">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4" data-location="Delhi" data-service="Electrical">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Electrical Wiring</h5>
                        <p class="card-text">Price: ₹400</p>
                        <p class="card-text">Location: Delhi</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="3">
                            <input type="hidden" name="workerId" value="6">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Sample Services for Mumbai -->
            <div class="col-md-4 mb-4" data-location="Mumbai" data-service="Carpentry">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Furniture Repair</h5>
                        <p class="card-text">Price: ₹350</p>
                        <p class="card-text">Location: Mumbai</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="4">
                            <input type="hidden" name="workerId" value="7">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4" data-location="Mumbai" data-service="Painting">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">House Painting</h5>
                        <p class="card-text">Price: ₹600</p>
                        <p class="card-text">Location: Mumbai</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="5">
                            <input type="hidden" name="workerId" value="8">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4" data-location="Mumbai" data-service="Appliance Repair">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">AC Repair</h5>
                        <p class="card-text">Price: ₹450</p>
                        <p class="card-text">Location: Mumbai</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="6">
                            <input type="hidden" name="workerId" value="9">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Sample Services for Bangalore -->
            <div class="col-md-4 mb-4" data-location="Bangalore" data-service="Pest Control">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Pest Control Service</h5>
                        <p class="card-text">Price: ₹250</p>
                        <p class="card-text">Location: Bangalore</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="7">
                            <input type="hidden" name="workerId" value="10">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4" data-location="Bangalore" data-service="Home Salon">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Home Salon Services</h5>
                        <p class="card-text">Price: ₹800</p>
                        <p class="card-text">Location: Bangalore</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="8">
                            <input type="hidden" name="workerId" value="11">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4" data-location="Bangalore" data-service="Car Wash">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Car Wash</h5>
                        <p class="card-text">Price: ₹200</p>
                        <p class="card-text">Location: Bangalore</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="9">
                            <input type="hidden" name="workerId" value="12">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Sample Services for Chennai -->
            <div class="col-md-4 mb-4" data-location="Chennai" data-service="AC Service">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">AC Installation</h5>
                        <p class="card-text">Price: ₹700</p>
                        <p class="card-text">Location: Chennai</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="10">
                            <input type="hidden" name="workerId" value="13">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4" data-location="Chennai" data-service="Cleaning">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Office Cleaning</h5>
                        <p class="card-text">Price: ₹400</p>
                        <p class="card-text">Location: Chennai</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="11">
                            <input type="hidden" name="workerId" value="14">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4" data-location="Chennai" data-service="Plumbing">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Water Leak Fix</h5>
                        <p class="card-text">Price: ₹250</p>
                        <p class="card-text">Location: Chennai</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="12">
                            <input type="hidden" name="workerId" value="15">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Sample Services for Kolkata -->
            <div class="col-md-4 mb-4" data-location="Kolkata" data-service="Electrical">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Fan Installation</h5>
                        <p class="card-text">Price: ₹300</p>
                        <p class="card-text">Location: Kolkata</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="13">
                            <input type="hidden" name="workerId" value="16">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4" data-location="Kolkata" data-service="Carpentry">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Door Repair</h5>
                        <p class="card-text">Price: ₹400</p>
                        <p class="card-text">Location: Kolkata</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="14">
                            <input type="hidden" name="workerId" value="17">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4" data-location="Kolkata" data-service="Painting">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Wall Painting</h5>
                        <p class="card-text">Price: ₹500</p>
                        <p class="card-text">Location: Kolkata</p>
                        <p class="card-text">Status: active</p>
                        <form action="booking" method="post">
                            <input type="hidden" name="serviceId" value="15">
                            <input type="hidden" name="workerId" value="18">
                            <div class="mb-3">
                                <label class="form-label">Date</label>
                                <input type="date" class="form-control" name="date" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Time</label>
                                <input type="time" class="form-control" name="time" required>
                            </div>
                            <button type="submit" class="btn btn-success">Book Now</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const locationFilter = document.getElementById('locationFilter');
            const serviceFilter = document.getElementById('serviceFilter');
            const serviceCards = document.querySelectorAll('#servicesContainer .col-md-4');

            function filterServices() {
                const selectedLocation = locationFilter.value.toLowerCase();
                const selectedService = serviceFilter.value.toLowerCase();

                serviceCards.forEach(card => {
                    const cardLocation = card.dataset.location.toLowerCase();
                    const cardService = card.dataset.service.toLowerCase();

                    const matchesLocation = selectedLocation === '' || cardLocation.includes(selectedLocation);
                    const matchesService = selectedService === '' || cardService.includes(selectedService);

                    if (matchesLocation && matchesService) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                });
            }

            locationFilter.addEventListener('change', filterServices);
            serviceFilter.addEventListener('change', filterServices);

            // Set filters from URL parameters
            const urlParams = new URLSearchParams(window.location.search);
            const cityParam = urlParams.get('city');
            if (cityParam) {
                locationFilter.value = cityParam;
            }
            const serviceParam = urlParams.get('service');
            if (serviceParam) {
                serviceFilter.value = serviceParam;
            }
            filterServices(); // Apply filters on load
        });
    </script>
</body>
</html>
