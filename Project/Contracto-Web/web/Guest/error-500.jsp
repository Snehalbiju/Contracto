<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500</title>
    <link rel="stylesheet" href="../Assets/Templates/Homepage/css/main/app.css">
    <link rel="stylesheet" href="../Assets/Templates/Homepage/css/pages/error.css">
    <link rel="icon" href="../Assets/Templates/Homepage/images/logo/cover.png" type="image/x-icon"> 
</head>
<body>
    <div>
        <div class="error-page container">
            <div class="col-md-8 col-12 offset-md-2">
                <div class="text-center">
                    <img class="img-error w-50" src="../Assets/Templates/Homepage/images/samples/error-500.svg" alt="Not Found">
                    <h1 class="error-title">System Error</h1>
                    <p class="fs-5 text-gray-600">The website is currently unaivailable. Try again later or contact the developer.</p>
                    <button class="btn btn-lg btn-outline-primary mt-3" onclick="goHome()">Go Home</button>
                </div>
            </div>
        </div>
        <script>
            function goHome(){
                window.location.replace("../Guest/Login.jsp");
            }
        </script>
    </div>
</body>
</html>