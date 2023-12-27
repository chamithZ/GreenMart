<%@page import="java.text.DecimalFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/stylesheet.css" />
    <link rel="stylesheet" href="css/review.css" />
    <link rel="stylesheet" href="css/checkout.css" />
    <link rel="shortcut icon" href="images/Green.jpg" />
    <script src="https://kit.fontawesome.com/80224b9ef7.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet" />
    <title>GREEN Supermarket</title>
    <style>
* {
  box-sizing: border-box;
}

/* Create two equal columns that floats next to each other */
.column {
  float: left;
  width: 50%;
  padding: 10px;
  height: 300px; /* Should be removed. Only for demonstration */
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}
<%
    DecimalFormat dcf = new DecimalFormat("###.##");
    double balance = (Double)request.getSession().getAttribute("balance");
    %>
</style>

<script>
    // Function to update total price based on quantity
    function updateTotalPrice() {
        // Get the quantity input and total price element
        var quantityInput = document.getElementById('quantity');
        var totalPriceElement = document.getElementById('totalPrice');
        var payNowLink = document.getElementById('payNowLink'); // Get the Pay Now link

        // Get the quantity value and convert it to a number
        var quantity = parseInt(quantityInput.value, 10);

        // Get the price value (replace this with the actual price)
        var price = parseFloat('${price}');

        // Calculate the total price
        var totalPrice = quantity * price;

        // Update the total price element with the calculated value
        totalPriceElement.textContent = 'Total Price: ' + totalPrice;

        // Update the Pay Now link's href with the quantity value
        var userId = '<%= request.getSession().getAttribute("userId") %>'; // Get the userId from the server
        var cartId = '${cartId}';
        payNowLink.href = "order-now?productId=${productId}&productName=${productName}&uid=" + userId + "&cartId=" + cartId + "&price=" + encodeURIComponent(totalPrice) + "&quantity=" + quantity;
        
        // Check form validity and disable Pay Now button if form is not valid
        var form = document.forms[0];
        if (form.checkValidity()) {
            payNowLink.removeAttribute('disabled');
        } else {
            payNowLink.setAttribute('disabled', 'disabled');
        }
    }

    // Add event listener to quantity input
    document.getElementById('quantity').addEventListener('input', updateTotalPrice);

    // Add event listener to form submission to prevent default if form is not valid
    document.forms[0].addEventListener('submit', function (event) {
        if (!this.checkValidity()) {
            event.preventDefault();
        }
    });
</script>



</head>
<body>
    <nav class="navigation">
        <a href="" class="logo"> <span>GREEN&nbsp;</span>Supermarket </a>
     
    </nav>
    
    <div class="row">
        <div class="column">
               <div class="c_us">
                   <h1>Order Details</h1>
     <div class="product-details" >
                <p>Product Name: ${productName}</p>
                 <p>Category: ${category}</p>
                <p>Item Price: ${price} </p>
                  <lable>Quantity:</lable>
               <input type="number" id="quantity" placeholder="quantity" value="${quantity}" min="1" oninput="updateTotalPrice()">
                <p id="totalPrice">Total Price: ${price}</p>
            </div>
           
        
    </div>
                
        </div>
        <div class="column">
          
              <div class="c_us" >
        <h1>Payment</h1>
        <div class="order-details">
         
            <form>
                 <p>Available Balance: ${balance} </p>
                <input type="text" placeholder="Credit/Debit Card No" required>
                <input type="text" placeholder="CVV" required>
                <input type="text" placeholder="Expire Date"oninput="updateTotalPrice()" required>
                

            </form>
          <a id="payNowLink" href="#" disabled>
    <button id="payNowButton" style="display: block;
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 5px;
    background-color: #333;
    color: #fff;
    cursor: pointer;
    transition: 0.3s ease;" onclick="processPayment()">Pay Now</button>
</a>
         
           
            <!-- Add more product details as needed -->
        </div>
    </div> 
        </div>
</div>

   
   
</body>
</html>
