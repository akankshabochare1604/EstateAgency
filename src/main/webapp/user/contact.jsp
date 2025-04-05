<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="../css/styles.css">
<link rel="stylesheet" href="css/all.min.css">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
	margin: 0;
	padding: 20px;
}

 .container {
 
 margin-top:10%;
	display: flex;
	justify-content: space-around;
	
	margin: auto;
	width:100%;
}

.contact-info {
	/* background-color: #fff; */
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	width: 40%;
	margin-left:20px;
}

.contact-info h2 {
	margin: 0 0 15px;
}

.contact-info div {
	margin-bottom: 15px;
	display: flex;
	align-items: center;
}

.contact-info div i {
	 background-color: #28a745; 
	color: white;
	border-radius: 50%;
	padding: 10px;
	margin-right: 10px;
	font-size: 18px;
}

.form-container {
	/* background-color: #fff; */
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	width: 55%;
}

.form-container input, .form-container textarea {
	width: calc(100% - 20px);
	padding: 10px;
	margin: 10px 0;
	border-radius: 5px;
	border: 1px solid #ccc;
}

.form-container button {
	background-color: #28a745;
	color: white;
	border: none;
	padding: 10px 15px;
	border-radius: 5px;
	cursor: pointer;
}

.form-container button:hover {
	background-color: #218838;
}
iframe{
display:block;
width:100%;
/*height:70%;  */
margin:10px;
}


</style>
</head>
<body>



	<div class="navbar">
		<div class="logo">
			Estate<span>Agency</span>
		</div>
		<ul class="nav-links">
			<li><a href="Home.jsp">Home</a></li>
			<li><a href="about.jsp">About</a></li>
			<li><a href="services.jsp">Services</a></li>
			<li><a href="user_properties.jsp">Properties</a></li>

			<!-- Dropdown Menu -->
			<li class="menu-dropdown"><a href="#" id="menu-toggle">Menu
					▼</a>
				<ul class="dropdown">
					<li><a href="register.jsp">Register</a></li>
					<li><a href="login.jsp">Login</a></li>
					<li><a href="dashboard.jsp">Profile</a></li>
					<li><a href="my_bookings.jsp">Bookings</a></li>
					<li><a href="wishlist.jsp">Wishlist</a></li>
				</ul></li>

			<li><a href="contact.jsp">Contact</a></li>
		</ul>
	</div>

	<div>
		<iframe
			src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d475.049023208104!2d73.79894703942213!3d18.632512106354373!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bc2b826af46ba9d%3A0xe30b1c41d9185242!2sASM%20(CSIT)%20College%20of%20Commerce%2C%20Science%20and%20Information%20Technology!5e1!3m2!1sen!2sin!4v1742444615880!5m2!1sen!2sin"
			width="600" height="450" style="border: 0;" allowfullscreen=""
			loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>

	</div>
	<div class="container">
		<div class="contact-info">
			<h2>Contact Information</h2>
			<div>
				<i class="fas fa-map-marker-alt"></i>
				<div>Address: A108 Adam Street, New York, NY 535022</div>
			</div>
			<div>
				<i class="fas fa-phone"></i>
				<div>Call Us: +1 5589 55488 55</div>
			</div>
			<div>
				<i class="fas fa-envelope"></i>
				<div>Email Us: info@example.com</div>
			</div>
		</div>
		<div class="form-container">
			<form action="ContactServlet" method="POST">
				<h2>Send Us a Message</h2>
				<input type="text" name="name" placeholder="Your Name"> <input
					type="email" name="email" placeholder="Your Email"> <input
					type="text" name="subject" placeholder="Subject">
				<textarea rows="4" name="message" placeholder="Message"></textarea>
				<button>Send Message</button>
			</form>
		</div>
	</div>
	
	

<!-- 	<footer class="footer"
		style="background-color: #f8f9fa; padding: 20px 0;">
		<div class="container text-center">
			<div class="row">
				<div class="col-md-4 contact-info" style="margin-bottom: 20px;">
					<h5>Address</h5>
					<p>
						A108 Adam Street<br>New York, NY 535022
					</p>
				</div>
				<div class="col-md-4 contact-info" style="margin-bottom: 20px;">
					<h5>Contact</h5>
					<p>
						Phone: +1 5589 55488 55<br>Email: info@example.com
					</p>
				</div>
				<div class="col-md-4 contact-info " style="margin-bottom: 20px;">
					<h5>Opening Hours</h5>
					<p>
						Mon-Sat: 11AM - 11PM<br>Sunday: Closed
					</p>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<h6>Follow Us</h6>
					<ul class="social-icons" style="list-style: none; padding: 0;">
						<li style="display: inline; margin-right: 10px"><a href="#"
							style="text-decoration: none; color: #007bff;"><i
								class="fab fa-facebook-f"></i></a></li>
						<li style="display: inline; margin-right: 10px"><a href="#"
							style="text-decoration: none; color: #007bff;"><i
								class="fab fa-instagram"></i></a></li>
						<li style="display: inline; margin-right: 10px"><a href="#"
							style="text-decoration: none; color: #007bff;"><i
								class="fab fa-linkedin-in"></i></a></li>
					</ul>
				</div>
			</div>
			<p>&copy; Copyright EstateAgency All Rights Reserved | Designed
				by BootstrapMade</p>
		</div>
	</footer> -->
	<!-- JavaScript for Dropdown -->
	<script>
        document.addEventListener("DOMContentLoaded", function () {
            const menuToggle = document.getElementById("menu-toggle");
            const dropdown = menuToggle.parentElement;

            menuToggle.addEventListener("click", function (event) {
                event.preventDefault();
                dropdown.classList.toggle("active");
            });

            document.addEventListener("click", function (event) {
                if (!dropdown.contains(event.target) && !menuToggle.contains(event.target)) {
                    dropdown.classList.remove("active");
                }
            });

            // Display error or success messages in alert
            const errorMessage = "<%=(request.getSession().getAttribute("error") != null) ? request.getSession().getAttribute("error") : ""%>";
            const successMessage = "<%=(request.getSession().getAttribute("message") != null) ? request.getSession().getAttribute("message") : ""%>
		";

							if (errorMessage !== "") {
								alert(errorMessage);
	<%request.getSession().removeAttribute("error");%>
		// Clear after showing
							}

							if (successMessage !== "") {
								alert(successMessage);
	<%request.getSession().removeAttribute("message");%>
		// Clear after showing
							}
						});
	</script>
</body>
</html>