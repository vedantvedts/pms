
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <spring:url value="/resources/js/exporting.js" var="export" />
<spring:url value="/resources/js/highcharts-gantt.js" var="highchartsgantt" /> --%>
<spring:url value="/resources/css/sweetalert2.min.css" var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- 	<script src="${export}"></script>
	<script src="${highchartsgantt}"></script> --%>
 	<link href="${sweetalertCss}" rel="stylesheet" />
	<script src="${sweetalertJs}"></script>
 

<title>Gantt Chart</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}

 #containers {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
}

.anychart-credits {
   display: none;
}

.flex-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}
</style>
</head>
<body>
<%
Object[] ProjectDetails=(Object[])request.getAttribute("ProjectDetails");

String projectName = ProjectDetails!=null ? ProjectDetails[2].toString():"";


String mstaskList=(String)request.getAttribute("mstaskList");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
String ProjectId=(String)request.getAttribute("ProjectId");
%>

	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
		
			<div class="card-header" style="background-color: transparent;height: 3rem;">
 				<div class="row">
 					<div class="col-md-7">
 						<h3 class="text-dark" style="font-weight: bold;">Critical Paths - <%=ProjectDetails!=null?(ProjectDetails[3]+" ("+ProjectDetails[1]+")"):"" %> </h3>
 					</div>
 					<div class="col-md-3"></div>
 					<div class="col-md-2 right">
	 					<a class="btn btn-sm btn-info" href="MSProjectMilestone.htm?ProjectId=<%=ProjectId%>">Back</a>
 					</div>
 					
 				</div>
       		</div>
       		
       		<div class="card-body">
       			<div id="container"></div>
       			<form method="post" action ="MSProjectMilestone.htm">
					<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
					<input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
					<input type="hidden" name="ProjectId" value="<%=ProjectId%>">
				</form>
       		</div>
       	</div>
	</div>

	<script>
			 var mstaskListJs=  <%=mstaskList%>;
			 var filteredList = mstaskListJs.filter(item => item[16] === true);
		 var projectNameJs = "<%=projectName%>"; 
		 
		 console.log(mstaskListJs)
		 console.log(filteredList)
		  
	var dynamicData = [];
	if(filteredList.length>0){
		 for (var i=0;i<filteredList.length;i++){
			 var startdate = new Date(filteredList[i][11]);
			 var endDate = new Date(filteredList[i][12]);
			 
			 var year1 = startdate.getUTCFullYear();
			    var month1 = startdate.getUTCMonth(); // Months are zero-based
			    var day1 = startdate.getUTCDate()+1;
			 
			  var year2 = endDate.getUTCFullYear();
			  var month2 = endDate.getUTCMonth();
			  var day2 = endDate.getUTCDate()+1;
			    
			 dynamicData.push({
				 id : filteredList[i][6],
				 name : filteredList[i][10],
				  start: Date.UTC(year1, month1, day1),
	                end: Date.UTC(year2, month2, day2),
	                dependency:filteredList[i][7],
	                completed: parseInt(filteredList[i][15])/100
			 })
		 }
	console.log(dynamicData) 

    Highcharts.ganttChart('container', {
    	
        title: {
            text: 'Gantt Chart with Critical Path for '+projectNameJs
        },
        series: [{
            name: projectNameJs,
            data: dynamicData
        },
        
        ]
    });
	}else{
		Swal.fire({
			  icon: "error",
			  title: "Oops...",
			  text: "No Data Found for Project "+projectNameJs,
			  allowOutsideClick :false
			});
	}
$('.swal2-confirm').click(function (){
	console.log("GHagshgaj")
	$('#submit').click(); 
})
</script>
		
</body>
</html>