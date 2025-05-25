<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Error Page</title>
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css'>
  <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Arvo'>
  <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
  <%
    Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
    String errorMessage = (String) request.getAttribute("javax.servlet.error.message");
    String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");

    String description = "";

    switch (statusCode) {
        case 400: description = "Something went wrong with your request. Please check and try again."; break;
        case 401: description = "You need to log in to access this resource."; break;
        case 402: description = "This feature requires payment. Please check your account."; break;
        case 403: description = "You don’t have permission to access this resource."; break;
        case 404: description = "The page or resource you are looking for cannot be found."; break;
        case 405: description = "This action is not allowed on the requested resource."; break;
        case 406: description = "The server cannot provide a response in a format you can accept."; break;
        case 407: description = "You need to authenticate with your proxy server."; break;
        case 408: description = "The server took too long to respond. Please try again later."; break;
        case 409: description = "There is a conflict with your request. Please resolve it and try again."; break;
        case 410: description = "The resource you’re looking for is no longer available."; break;
        case 411: description = "The server requires a valid content length in your request."; break;
        case 412: description = "One or more conditions in your request were not met."; break;
        case 413: description = "The request is too large for the server to process."; break;
        case 414: description = "The URL you entered is too long for the server to handle."; break;
        case 415: description = "The type of file you uploaded is not supported."; break;
        case 416: description = "The part of the file you requested is not available."; break;
        case 417: description = "The server could not meet the expectation specified in your request."; break;
        case 426: description = "You need to upgrade your connection (e.g., to HTTPS)."; break;
        case 500: description = "Internal Server Error!"; break;
        case 501: description = "This feature is not available on the server."; break;
        case 502: description = "There was a problem communicating with the server. Please try again."; break;
        case 503: description = "The server is temporarily unavailable. Please try again later."; break;
        case 504: description = "The server didn’t get a timely response. Please try again."; break;
        case 505: description = "The HTTP version used in your request is not supported."; break;
        default: description = "An unknown error occurred."; break;
    }
  %>

  <!-- Error page content -->
  <section class="page_404">
    <div class="container">
      <div class="row">
        <div class="col-sm-12">
          <div class="col-sm-10 col-sm-offset-1 text-center">
            <div class="four_zero_four_bg">
              <h1 class="text-center">Error <%= statusCode %></h1>
            </div>
            <div class="contant_box_404">
              <h3 class="h2">Looks like there's an issue</h3>
              <h4><%= description %></h4>
              <h4>The page you are looking for is not available or an error occurred.</h4>
              <a href="login.jsp" class="link_404">Go to Home</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</body>
</html>
