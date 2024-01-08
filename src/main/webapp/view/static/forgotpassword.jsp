<%@page import="com.vts.pfms.model.LabMaster"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>


<html>
<head>
<title>PMS </title>

<jsp:include page="../static/dependancy.jsp"></jsp:include>
<spring:url value="/resources/css/LoginPage.css" var="loginPageCss" />
<link href="${loginPageCss}" rel="stylesheet" />

<style>

.fa-file-text{
	color:rgba(255,222,0,1);
}

.scroll {
    max-height: 390px;
    overflow-y: auto;
}

.scrollpolicy{
 	/* max-height: 515px; */
    overflow-y: auto !important;
}

     .container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 500px;
            height:50vh;
            text-align: center;
        }

        h2 {
            color: #333;
        }

        label {
            display: block;
            margin: 10px 0 5px;
            color: #555;
        }

        input {
            width: 60%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }
        
               #main {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 66vh;
        }
</style>


</head>

<body class="home" >

<!--  forgot password Page  -->  
  
<section class="loginpage">
	<header id="header" class="clearfix">
  		<div class="btmhead clearfix">
    		<div class="widget-guide clearfix">
      			<div class="header-right clearfix">
        			<div class="float-element">
        				<a class="" href="" target="_blank">
        					<img  class ="drdologo" src="view/images/drdologo.png"alt=""></a>
        			</div>
      			</div>
     			<div class="logo">
     				<a href="#" title="PMS"><span class="c"  style="margin-top: 2% !important;font-size: 113% !important;">PROJECT MANAGEMENT SYSTEM</span></a>
     			</div>
    		</div>
  		</div>
	</header>
 </section> 
 <div id="main">
 <div class="container">
    <h2>Find Your Account</h2>
    <form action="#" method="post">
        <label></label>
        <input class="form-control" type="text" id="username" name="username" required placeholder="Enter username here" >
		 <div class="text-danger mb-2" id="textdiv" style="display: none;"> The user name is not available ! </div>
		<button type="button" id="search" style="" onclick="searchUserName()">Search</button>
        <button type="submit" id="reset" style="display:none">Reset Password</button>
    </form>
</div>
</div>
   <div id="footer">
	<footer class="footer"  >
	
		<section id="fontSize" class="clearfix" style="font-size: 100%;margin-bottom: -1%;">
		  <section id="page" class="body-wrapper clearfix" style="">
		    	<!-- Blue Border for Login Page -->  
		    <div class="support-row clearfix" id="swapper-border" style="">
		      	<div class="widget-guide clearfix">
		        </div>
		    </div> 
		    	
		  </section>  
		</section>
		<div class="widget-guide clearfix">
       		<div class="footr-rt">
            	<div class="copyright-content"> 
            		<p>Website maintained by Vedant Tech Solutions<br><b>Site best viewed at 1360 x 768 resolution in I.E 11+, Mozilla 70+, Google Chrome 79+</b>	</p> 
            	</div>
    		</div>
  		</div>
	</footer>
	</div> 
	<script type="text/javascript">
	function searchUserName(){
		var username=$('#username').val();
		console.log(username);
		if(username.length<1){
			alert("please type the username !")
		}else{
			$.ajax({
				type:'GET',
				url:'FindUserName.htm',
				datatype:'json',
				data:{
					username:username
				},
				success:function(result){
					var ajaxresult=JSON.parse(result);
					console.log(typeof ajaxresult+"---"+ajaxresult);
					if(result==0){
						  $("#textdiv").show();
					}else{
						$("#search").hide();
						$('#reset').show();
					}
					setTimeout(delayedFunction, 3000);
				}
			})
	
		}
	}
	function delayedFunction() {
		$("#textdiv").hide();
	}
	
	function checkLength(element){
		console.log(element)
	}
	</script>
</body>
</html>