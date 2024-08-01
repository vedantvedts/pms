
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*"%>
<%@ page import="java.time.LocalDate"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>PMS</title>

<link rel="shortcut icon" type="image/png"
	href="view/images/drdologo.png">
<meta charset="UTF-8">


<spring:url value="/resources/css/dashboard.css" var="dashboardCss" />
<link href="${dashboardCss}" rel="stylesheet" />

<spring:url value="/resources/css/newfont.css" var="NewFontCss" />
<link href="${NewFontCss}" rel="stylesheet" />

<spring:url value="/resources/css/master.css" var="masterCss" />
<link href="${masterCss}" rel="stylesheet" />


<jsp:include page="dependancy.jsp"></jsp:include>


<style>
.dropdown-item {
	font-weight: 600 !important;
	font-size: 15px;
}

.fa-circle {
	font-size: 7px !important;
	color: #43658b;
}

.nav-link {
	font-weight: 200;
}

/* Multi level dropdown */
@media ( min-width : 992px) {
	.dropdown-menu .dropdown-toggle:after {
		border-top: .3em solid transparent;
		border-right: 0;
		border-bottom: .3em solid transparent;
		border-left: .3em solid;
	}
	.dropdown-menu .dropdown-menu {
		margin-left: 0;
		margin-right: 0;
	}
	.dropdown-menu li {
		position: relative;
	}
	.nav-item .submenu {
		display: none;
		position: absolute;
		left: 100%;
		top: -7px;
	}
	.nav-item .submenu-left {
		right: 100%;
		left: auto;
	}
	.dropdown-menu>li:hover {
		background-color: #f1f1f1
	}
	.dropdown-menu>li:hover>.submenu {
		display: block;
	}
}

hr {
	margin: 0px 12px !important;
	opacity: 0.2;
	border-top: 1px solid black !important;
}

.megamenu {
	position: static
}

.megamenu .dropdown-menu {
	background: none;
	border: none;
	width: 100%
}

.megamenu .nav-item .nav-link {
	color: black;
	font-family: 'Lato', sans-serif;
	font-size: 15px;
	font-weight: bold;
}

.megamenu .nav-item .nav-link:hover {
	color: blue;
}

.col-lg-6 h6 {
	text-decoration: underline;
	color: #145374;
	font-family: 'Muli', sans-serif;
}

.side-borders {
	border-bottom: 1px solid black;
	border-left: 1px solid black;
	border-right: 1px solid black;
	border-bottom-right-radius: 5px !important;
	border-bottom-left-radius: 5px !important;
}

.list-unstyled .fa-calendar {
	font-size: 1.00 rem !important;
}

.list-unstyled li {
	margin-left: 20px;
}

.generate:focus {
	color: black !important;
}

.second-nav .nav-link {
	color: black !important;
}

.second-nav {
	background-color: #007bff;
}

.custom-button:hover {
	color: white !important;
}

#content .navbar .container-fluid {
	padding-right: 0px !important;
	padding-left: 0px !important;
}

@media ( max-width :1390px) {
	.second-nav #module button {
		font-size: 0.85rem !important;
	}
}

#uppermodule .dropdown-menu-right {
	width: 185px !important;
}
</style>

</head>


<% String Logintype= (String)session.getAttribute("LoginType");
String labcode= (String)session.getAttribute("labcode");
//int ProjectInitSize = (Integer) session.getAttribute("ProjectInitiationList");

%>

<body>

	<div class="wrapper" id="wrapper">

		<div id="content-wrapper" class=" flex-column">

			<div id="content">
				<% String Username =(String)session.getAttribute("Username");  %>
				<% String EmpName =(String)session.getAttribute("EmpName");  %>
				<% long FormRole =(Long)session.getAttribute("FormRole");  %>
				<% String FormRoleName =(String)session.getAttribute("LoginTypeName");  %>
				<% String IsDG =(String)session.getAttribute("IsDG");  %>

				<nav
					class="navbar navbar-expand-lg navbar-dark mx-background-top-linear header-top">


					<div class="container-fluid">

						<a class="navbar-brand" id="brandname"
							style="font-family: 'Montserrat', sans-serif; color: white; text-align: initial; width: 40%">
							<span id="p1"
							style="font-family: Lato, sans-serif; font-size: 19px; font-weight: 700; color: orange;"></span>
							<span
							style="font-family: Lato, sans-serif; font-size: 15px; padding: 0px 16px 0px 10px; text-transform: capitalize !important;"><%=LocalDate.now().getMonth() %>
								&nbsp; <%=LocalDate.now().getYear() %> </span> <img style="width: 4%"
							src="view/images/project.png" alt=""><b> &nbsp;
								PMS&nbsp;<span style="font-size: 13px;">(<%=labcode %>) -
									<%=EmpName %> (<%=FormRoleName %>)
							</span>
						</b>
						</a>


						<button class="navbar-toggler" type="button"
							data-toggle="collapse" data-target="#navbarResponsive"
							aria-controls="navbarResponsive" aria-expanded="false"
							aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>

<!-- Button trigger modal -->
						

						<!-- Modal -->
							<div class="modal fade bd-example-modal-xl" id="smartsearch"
								tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
								aria-hidden="true">

								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<div class="container">
												<div class="row">
													<div class="col-lg">
														<input autocomplete="off" autofocus
															placeholder="Enter Module Name To Navigate"
															required="required" oninput="changed()" id="projectids"
															class="form-control" type="text">
													</div>
												</div>
											</div>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body" id="targets"></div>
									</div>
								</div>
							</div>

						<div class="collapse navbar-collapse" id="navbarResponsive">
							<ul class="navbar-nav ml-auto ">

								<li class="nav-item active">
								<button type="button" class="btn btn-light"
									onclick="opensmartsearch()" >
									<b>Smart Search </b>&#x1F50D;
								</button>
								<a class="btn custom-button "
									href="MainDashBoard.htm" type="button" aria-haspopup="true"
									aria-expanded="false" style="background-color: transparent"><i
										class="fa fa-home" aria-hidden="true"
										style="font-size: 1.20rem"></i> Home</a></li>

								<%-- <%if(!IsDG.equalsIgnoreCase("Yes") ){ %>

								<li class="nav-item dropdown">


									<button class="btn dropdown-toggle custom-button" type="button"
										value="" id="" data-toggle="dropdown" aria-haspopup="true"
										aria-expanded="false" style="background-color: transparent">Initiation</button>

									<ul class="dropdown-menu">
										<li><a class="dropdown-item"
											href="ProjectIntiationList.htm"> List</a></li>



										<%if( Logintype.equalsIgnoreCase("E") || Logintype.equalsIgnoreCase("Z") || Logintype.equalsIgnoreCase("A") || Logintype.equalsIgnoreCase("Y")  || Logintype.equalsIgnoreCase("C")|| Logintype.equalsIgnoreCase("I") ) {%>

										<li>
											<form action="ProjectIntiationListSubmit.htm" method="POST"
												name="myfrm" style="display: inline">
												<button class="dropdown-item">Initiate</button>
												<input type="hidden" name="sub" value="add" /> <input
													type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
											</form>
										</li>

										<%} %>

										<li>
											<form action="ProjectIntiationListSubmit.htm" method="POST"
												name="myfrm1" style="display: inline">
												<input type="hidden" name="sub" value="status" /> <input
													type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
												<button class="dropdown-item">Status</button>
											</form>
										</li>
										<li>
											<!-- <form action="ProjectOverAllRequirement.htm" method="POST" -->
											<form action="Requirements.htm" method="POST"
												name="myfrm2" style="display: inline">
												<input type="hidden" name="sub" value="requirements" /> <input
													type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
												<button class="dropdown-item">Requirements</button>
											</form>
										</li>


																			  			<li>
										  		<form action="ProjectRequirement.htm" method="POST" name="myfrm2"  style="display: inline">
										  			<input type="hidden" name="sub" value="requirements"/>
										  			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
										 	 		<button class="dropdown-item" >Requirements</button>
										  	 	</form>
									  		</li>
																						<li>
										  		<form action="ProjectSanction.htm" method="POST" name="myfrm3"  style="display: inline">
										  			<input type="hidden" name="sub" value="sanction"/>
										  			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
										 	 		<button class="dropdown-item" >SOC of Project</button>
										  	 	</form>
									  		</li>

										<li>
											<form action="ProjectProcurement.htm" method="POST"
												name="myfrm3" style="display: inline">
												<input type="hidden" name="sub" value="Procurement" /> <input
													type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
												<button class="dropdown-item">Procurement Plan</button>
											</form>
										</li>


									</ul>
								</li>


								<%} %>
 --%>
								<!-- New Content from table start --------------------------------->

								<li class="nav-item dropdown"><input type="hidden"
									value="<%=Logintype %>" name="logintype" id="logintype">

									<ul class="navbar-nav" id="uppermodule">

									</ul></li>



								<li class="nav-item"><a class="nav-link" href="#">&nbsp;&nbsp;&nbsp;</a>
								</li>

								<li class="nav-item">

									<div class="btn-group  ">

										<a style="color: white" class="nav-link dropdown-toggle"
											href="#" id="alertsDropdown" role="button"
											data-toggle="dropdown" aria-haspopup="true"
											aria-expanded="false"> <i class="fa fa-bell fa-fw "
											aria-hidden="true" style="color: white"></i> <span
											class="badge badge-counter" id="NotificationCount"></span>
										</a>

										<div
											class="dropdown-list dropdown-menu dropdown-menu-right custombell"
											style="padding: 0px !important; font-size: 15px !important"
											aria-labelledby="">
											<h6 class="dropdown-header">
												<img src="view/images/notification.png">
												&nbsp;&nbsp;&nbsp;&nbsp;Notifications
											</h6>


											<div id="Notification"></div>



											<a
												class="dropdown-item text-center small text-gray-500 showall"
												href="NotificationView.htm">Show All Alerts </a>
										</div>
									</div>

								</li>


								<li class="nav-item">


									<div class="btn-group   ">

										<a class="nav-link dropdown-toggle" href="#" id="userDropdown"
											role="button" data-toggle="dropdown" aria-haspopup="true"
											aria-expanded="false"> <span
											class="mr-2 d-none d-lg-inline text-gray-600 "
											style="color: white"><b><%=Username %></b></span> <i
											class="fa fa-user-o" aria-hidden="true" style="color: white"></i>
										</a>

										<div
											class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
											aria-labelledby="userDropdown">
											<a class="dropdown-item" href="PasswordChange.htm"> <img
												src="view/images/key.png" /> &nbsp;&nbsp; Password Change
											</a> <a class="dropdown-item" href="UserManualDoc.htm"
												target="_blank"> <img src="view/images/handbook.png" />
												&nbsp;&nbsp; Manual
											</a> <a class="dropdown-item" href="WorkFlow.htm" target="_blank">
												<img src="view/images/work.png" /> &nbsp;&nbsp; Work Flow
											</a> <a class="dropdown-item" href="MilestoneManual.htm"
												target="_blank"> <img src="view/images/milestone.png" />
												&nbsp;&nbsp; Milestone Manual
											</a> <a class="dropdown-item" href="AuditStampingView.htm"> <img
												src="view/images/stamping.png" /> &nbsp;&nbsp;
												Audit Stamping
											</a> <a class="dropdown-item" href="RunBatchFile.htm"> <img
												src="view/images/backup.png"
												style="height: 13%; width: 16%;" /> &nbsp;&nbsp;DB Back-up
											</a> <a class="dropdown-item" href="DelegationFlow.htm"> <img
												src="view/images/workflow.png" /> &nbsp;&nbsp; Delegation
												Flow
											</a> <a class="dropdown-item" href="FeedBack.htm"> <img
												src="view/images/feedback.png" /> &nbsp;&nbsp; Feedback
											</a> <a class="dropdown-item" href="AboutPFM.htm" target="_blank">
												<img src="view/images/work.png" /> &nbsp;&nbsp; About PMS
											</a>


											<div class="dropdown-divider"></div>
											<form id="logoutForm" method="POST"
												action="${pageContext.request.contextPath}/logout">
												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
												<button class="dropdown-item " href="#"
													data-target="#logoutModal">
													&nbsp;&nbsp;<img src="view/images/logout.png" />
													&nbsp;Logout
												</button>
											</form>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</nav>

				<!------------------------------------------------ new navbar  ---------------------------------------->

				<nav
					class="navbar navbar-expand-lg navbar-light second-nav header-top ">

					<a class="navbar-brand" href="#"></a>
					<button class="navbar-toggler" type="button" data-toggle="collapse"
						data-target="#navbarSupportedContent"
						aria-controls="navbarSupportedContent" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>

					<input type="hidden" value="<%=Logintype %>" name="logintype"
						id="logintype">

					<div class="collapse navbar-collapse justify-content-end"
						id="navbarSupportedContent" style="margin-right: 1%;">

						<ul class="navbar-nav" id="module">

						</ul>

					</div>
				</nav>

				<!------------------------------------------------ new navbar end ------------------------------------->

<button type="button" style="display: none;" id="storeSessionData"></button>
			</div>


			<script type="text/javascript">
	$(document).ready(function() {
		
		$('.selectdee').select2();
		
		$.ajax({
			type : "GET",
			url : "HeaderModuleList.htm",
			
			datatype : 'json',
			success :  function(result){
				
				var result = JSON.parse(result);
				var values = Object.keys(result).map(function(e){
					return result[e]
				})
				var module= "";
				var logintype= $('#logintype').val();
				var uppermodule = "";
				
				for(i=0; i<values.length;i++){
					
					if(values[i][3]=='L'){
			
					var name=values[i][1].replace(/ /g,'');

					module+="<li class='nav-item dropdown uppernav ' style='padding: 0rem 1rem'><button class='btn dropdown-toggle custom-button' type='button' value='"+values[i][0]+"_"+values[i][2]+"' id='"+name+"'  data-toggle='dropdown' aria-haspopup='true' aria-expanded='false' onmouseover='checkme(\"" +name+ "\")' >"+values[i][1]+"</button> <div class='dropdown-menu dropdown-menu-right' id='scheduledropdown"+name+"' style='width:13rem'> </div></li>";
					
					}
					
					if(values[i][3]=='U'){
						
						var name=values[i][1].replace(/ /g,'');

						uppermodule+="<li class='nav-item dropdown '><button class='btn dropdown-toggle custom-button' type='button'  style='background-color:transparent' value='"+values[i][0]+"_"+values[i][2]+"' id='"+name+"'  data-toggle='dropdown' aria-haspopup='true' aria-expanded='false' onmouseover='checkme(\"" +name+ "\")' >"+values[i][1]+"</button> <div class='dropdown-menu dropdown-menu-right' id='scheduledropdown"+name+"' > </div></li>";
						
					}
					
					
					
				}
				$('#module').html(module); 
				$('#uppermodule').html(uppermodule); 

			}
			
			
		})
		
		
		

	});
	
	
	function checkme(value){

		  var result = $("#"+value).val().split('_'); 
		
		  var $url = result[1];
		  
		  var $formmoduleid = result[0];
				
	      var $logintype = $('#logintype').val(); 
	      	      
						$
						.ajax({

							type : "GET",
							url :  "HeaderMenu.htm" ,
							data : {
								logintype : $logintype,
								formmoduleid : $formmoduleid
							},
							datatype : 'json',
							success : function(result) {

								var result = JSON.parse(result);
							
								
								var values = Object.keys(result).map(function(e) {
								  return result[e]
								})
								
								var s = '';
								for (i = 0; i < values.length; i++) {
									s += '<a class="dropdown-item" href="'+values[i][1]+'">' +values[i][0]+ '</a>';

								}
								
								$('#scheduledropdown'+value).html(s);
				
							}
						});
		
		}
	


         $('span.navbar-btn').click(function() {
             $('#navbar').toggle();
         });
         
		

function english_ordinal_suffix(dt)
{
  return dt.getDate()+(dt.getDate() % 10 == 1 && dt.getDate() != 11 ? 'st' : (dt.getDate() % 10 == 2 && dt.getDate() != 12 ? 'nd' : (dt.getDate() % 10 == 3 && dt.getDate() != 13 ? 'rd' : 'th'))); 
}

dt= new Date();
document.getElementById("p1").innerHTML = english_ordinal_suffix(dt);

/* $(document).ready(function(){
	
	$.ajax({
		type : "GET",
		url : "NotificationList.htm",
		
		datatype : 'json',
		success : function(result) {
			
			var result = JSON.parse(result);
			var values = Object.keys(result).map(function(e) {
				  return result[e]
				});
			var module = "";
			for (i = 0; i < values.length; i++) {
			
				module+="<a class='dropdown-item d-flex align-items-center' id='"+values[i][5]+"'  onclick='test("+values[i][5]+")' href='"+values[i][4]+"'  style=' font-family:'Quicksand', sans-serif; '> <div> <i class='fa fa-arrow-right' aria-hidden='true' style='color:green'></i></div> <div style='margin-left:20px'> " +values[i][3]+" </div> </a>";
				if(i>4){
					break;
				}
		   
			}
		
			if(values.length==0){
				
				var info="No Notifications to display !";
				var empty="";
				 empty+="<a class='dropdown-item d-flex align-items-center' href=# style=' font-family:'Quicksand', sans-serif; '> <div> <i class='fa fa-comment-o' aria-hidden='true' style='color:green;font-weight:800'></i></div> <div style='margin-left:20px'>" +info+" </div> </a>";

				$('#Notification').html(empty); 
				$('.showall').hide();
				$('#NotificationCount').addClass('badge-success');
			}
			
			if(values.length>0){
 			
				$('#Notification').html(module);
				$('.showall').show();
				
			
			}
			
			
			
			$('#NotificationCount').html(values.length); 
		}
	});
	
}); */
//new anil code
$(document).ready(function(){
	
	
	$.ajax({
		type : "GET",
		url : "NotificationList.htm",
		
		datatype : 'json',
		success : function(result) {
			
			var result = JSON.parse(result);
			var values = Object.keys(result).map(function(e) {
				  return result[e]
				});
			
			var module = "";
			for (i = 0; i < values.length; i++) {
			
				module+="<a class='dropdown-item d-flex align-items-center' id='"+values[i][5]+"'   onclick='deleteNoti()' href='"+values[i][4]+"'  style=' font-family:'Quicksand', sans-serif; '> <div> <i class='fa fa-arrow-right' aria-hidden='true' style='color:green'></i></div> <div style='margin-left:20px'> " +values[i][3]+" </div> </a>";
				if(i>4){
					break;
				}
		   
			}
		
			if(values.length==0){
				
				var info="No Notifications to display !";
				var empty="";
				 empty+="<a class='dropdown-item d-flex align-items-center' href=# style=' font-family:'Quicksand', sans-serif; '> <div> <i class='fa fa-comment-o' aria-hidden='true' style='color:green;font-weight:800'></i></div> <div style='margin-left:20px'>" +info+" </div> </a>";

				$('#Notification').html(empty); 
				$('.showall').hide();
				$('#NotificationCount').addClass('badge-success');
			}
			
			if(values.length>0){
 			
				$('#Notification').html(module);
				$('.showall').show();
				
			
			}
			
			
			
			$('#NotificationCount').html(values.length); 
		}
	});
	
});

// new code by anil
function deleteNoti() {
	$.ajax({
		type : "GET",
		url : "getAllNoticationId.htm",
	
		datatype : 'json',
		success : function(result) {
			
		}
	});
}

function test(img){
	
	var notificationid=img;
	
	$.ajax({
		type : "GET",
		url : "NotificationUpdate.htm",
		data : {
				notificationid : notificationid,
				
			},
		datatype : 'json',
		success : function(result) {
			
		}
	});
	
	
}


	
	
	$(document).on('click', '.dropdown-menu', function (e) {
		  e.stopPropagation();
		});

		// make it as accordion for smaller screens
		if ($(window).width() < 992) {
		  $('.dropdown-menu a').click(function(e){
		    e.preventDefault();
		      if($(this).next('.submenu').length){
		        $(this).next('.submenu').toggle();
		      }
		      $('.dropdown').on('hide.bs.dropdown', function () {
		     $(this).find('.submenu').hide();
		  })
		  });
		}
		
		
		window.setTimeout(function() {
            $(".alert").fadeTo(500, 0).slideUp(500, function(){
                $(this).remove(); 
            });
        }, 4000);
		



function myalert(msg){
	
	bootbox.alert({
  			message: "<center>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>"+msg+"</b></center>",
  			size: 'large',
  			buttons: {
			        ok: {
			            label: 'OK',
			            className: 'btn-success'
			        }
			    }
  			
			});
}

function myconfirm(msg,frmid){
	
	 bootbox.confirm({ 
	 		
		    size: "large",
  			message: "<center>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>"+msg+"</b></center>",
		    buttons: {
		        confirm: {
		            label: 'Yes',
		            className: 'btn-success'
		        },
		        cancel: {
		            label: 'No',
		            className: 'btn-danger'
		        }
		    },
		    callback: function(result){	    

		    	console.log("#"+frmid);
		    	if(result){
		 
		         $("#"+frmid).submit(); 
		    	}
		    	else{
		    		event.preventDefault();
		    	}
		    } 
		}) 
	
	
}


</script>








</body>








<script>

function changed() {

					$.ajax({
						type : "GET",
						url : "SmartSearch.htm",
						data : {
							search : document.getElementById('projectids').value
						},
						datatype : 'json',
						success : function(result) {
							var result = JSON.parse(result);
							console.log(result);

							var printOutDiv = document
									.getElementById("targets");
							while (printOutDiv.firstChild) {
								printOutDiv.removeChild(printOutDiv.lastChild);
							}
							console.log(result.length);
							for (let i = 0; i < result.length; i++) {
								var amountPrintOutDiv = document
										.createElement("div");
								amountPrintOutDiv.innerHTML = "<a href='"
										+ result[i][3] + "' id='"
										+ result[i][0]
										+ "+id' onclick=searchForRole("
										+ result[i][0] + ") >" + result[i][2]
										+ "</a>";
								printOutDiv.appendChild(amountPrintOutDiv);
							}
						}
					});
				}

				function searchForRole(formname) {
					console.log("clicked!!!!!!!!");
					var currentloc = "";
					currentloc += String(window.location.href);
					currentloc = currentloc.split("").reverse().join("")
					currentloc = currentloc.substring(0, currentloc
							.indexOf("/"));
					$
							.ajax({
								type : "GET",
								url : "searchForRole.htm",
								data : {
									search : formname
								},
								datatype : 'json',
								success : function(result) {
									var result = JSON.parse(result);

									if (result)
										return true;
									else {
										window
												.alert("\"Sorry\", You don't have access to this module.\nPlease contact Administrator");
										window.location.href = currentloc
												.split("").reverse().join("");
									}
								}
							});
				}


				function opensmartsearch() {
					$('#smartsearch').modal('show')
				}
				
				$('#smartsearch').on('shown.bs.modal', function() {
					  $(this).find('[autofocus]').focus();
					});
				
				$(document).ready(function() {
					$('#storeSessionData').click();
					
				});
				$('#storeSessionData').click(function(){
				
					var DashBoardId = "<%=(String)session.getAttribute("DashBoardId")%>";
					var path = window.location.pathname.split("/").includes("MainDashBoard.htm");
					console.log("DashBoardId  "+DashBoardId)
					console.log("path  "+path)
					if(path){
						$.ajax({
							type:'GET',
							url:'storeSlideData.htm',
							datatype:'json',
							data:{
								DashBoardId:DashBoardId,
							},
							 success:function(result){
								 
							 }
						})
					}
					
				
				})
</script>


</html>