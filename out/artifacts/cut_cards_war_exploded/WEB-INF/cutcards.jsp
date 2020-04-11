
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mycss.css">
    <title>Cut Cards! - Chirag Kawediya</title>

</head>
<body>

<nav class="navbar sticky-top navbar-expand-md navbar-dark bg-dark container" style="margin-bottom: 5px !important;">
    <a href="${pageContext.request.contextPath}/" class="navbar-brand" id="main-logo" >Chirag Kawediya</a>
    <button class="navbar-toggler" data-toggle="collapse" data-target="#navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navigation">
        <ul class="navbar-nav ml-auto mr-2">
            <li class="nav-item"><a href="https://www.chiragkawediya.com/blog" class="nav-link">international movie blog</a></li>
            <li class="nav-item"><a href="https://www.chiragkawediya.com/my-stuff" class="nav-link">stuff i made</a></li>
        </ul>
    </div>
</nav>

<div class="container">

    <div class="row">
        <div class="col-12 bg-dark text-white pt-3">
            <h2 style="text-align: center;">Card Cutter</h2>
            <p>You can Cut Debate Cards Here!</p>
        </div>
    </div>

    <div class="row">
        <div class="col-12 bg-white pt-3">
            <input id="url" type="text" size="100" />
            <input type="button" id="gobutton" value="Go!" onclick="new function () {
                if(document.getElementById('url').value != null) {
                window.location.href = '${pageContext.request.contextPath}' + '/cut/' + document.getElementById('url').value;
                }
                console.log(document.getElementById('url').value);
            };"/>
            <br>

            <br>
                <input type="checkbox" id="highlight" name="vehicle1" value="highlighting" />
                <label for="highlight">Check box to enable Highlighting</label>
            <br>
            <div id="articletext">
                <div id="citation">${citation}</div>
                ${text}
            </div>

            <br>
            <input type="button" id="copy" value="Copy the card" onclick ="new function() {

                var str = document.getElementById('articletext').innerHTML;
                function listener(e) {
                    e.clipboardData.setData('text/html', str);
                    e.clipboardData.setData('text/plain', str);
                    e.preventDefault();
                    }
                document.addEventListener('copy', listener);
                document.execCommand('copy');
                document.removeEventListener('copy', listener);

            }">

        </div>
    </div><!-- END container-wrap -->
</div>

<footer class="container">
    <div class="row" style="margin-bottom: 0 !important;">
        <div class="col-lg-4 col-md-4 bg-dark text-white pt-3 pl-4">
            <b>Links</b>
            <nav class="navbar navbar-dark bg-dark ml-n3">
                <ul class="navbar-nav" style="line-height: 0.5 !important;">
                    <li class="nav-item"><a href="https://www.chiragkawediya.com/" class="nav-link">Homepage</a></li>
                    <li class="nav-item"><a href="https://www.chiragkawediya.com/blog" class="nav-link">International Movie Blog</a></li>
                    <li class="nav-item"><a href="https://www.chiragkawediya.com/my-stuff" class="nav-link">Stuff I Made</a></li>
                </ul>
            </nav>
        </div>
        <div class="col-lg-4 col-md-4 bg-dark text-white pt-3 pl-4">
            <b>Contact Information</b>
            <p>Phone: +1 (916) 586-6898</p>
            <p>Email: chirag03kawediya@gmail.com</p>
        </div>
        <div class="col-lg-4 col-md-4 bg-dark text-white pt-3 pl-4 pr-auto">
            <b>Other Stuff</b>
            <nav class="navbar navbar-dark bg-dark ml-n3">
                <ul class="navbar-nav" style="line-height: 0.5 !important;">
                    <li class="nav-item"><a href="https://rajavelu.org" class="nav-link">Aditya Rajavelu's Website</a></li>
                    <li class="nav-item"><a href="http://spechron.com" class="nav-link">Spechron</a></li>
                </ul>
            </nav>
        </div>
    </div>
</footer>
</div>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js" type="text/javascript"></script>

<script type="text/javascript">

    document.onload = function() {
        var el = document.getElementById("gobutton");
        el.addEventListener("mousedown", getStuff, false);
    };


    function getStuff() {
        if(document.getElementById("url").value != null) {
            window.location.href = "${pageContext.request.contextPath}" + "/cut/" + document.getElementById("url").value;
        }
        console.log(document.getElementById("url").value);
    }
</script>
</body>
</html>


