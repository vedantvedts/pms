<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>PD Action Reports</title>
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


</style>
</head>
 
<body>
  <%
  FormatConverter fc=new FormatConverter(); 
  SimpleDateFormat sdf=fc.getRegularDateFormat();
  List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectslist");
  String projectid=(String)request.getAttribute("projectid");

 %>






<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header ">  

					<div class="row">
						<h3 class="col-md-8">Meetings Status Reports</h3>  
							<div class="col-md-4" style="float: right;">
							<table >
					   					<tr>
					   					<td >
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;">Project : </label>
					   						</td>
					   						<td style="max-width: 500px; padding-right: 50px">
					   						<form method="post" action="MeetingStatusWiseReport.htm" name="ststusform" id="ststusform">
                                                        <select class="form-control selectdee " name="projectid" id="projectid" required="required"  data-live-search="true"  >
                                                           <option value="0" <%if(projectid.equalsIgnoreCase("0")){ %> selected="selected" <%} %>>General</option>	
                                                           <%
                                                           for(Object[] obj:projectslist){ %>
														   <option value="<%=obj[0] %>" <%if(projectid.equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[4] %></option>	
														<%} %>
																</select>	
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
													<input type="hidden" name="projectid"  id="ProId" /> 
													<input type="hidden" name="statustype"  id="StatusType" />			
											</form>			
																		   						</td>
					   						
					   						</tr>
					   						</table>
					   							</div>
		   				</div>	   							

					</div>
						<div class="card-body "> 
						<div class="row" style="margin-top: -18px;">
						<div class="col-md-6" style="float: right;" align="center">
							
					   	<div id="container" style="min-width: 440px; max-width: 440px; height: 400px;"></div>
					   <div >	
					   <button onclick="submitForm('UP');" class="btn btn-sm " style="margin-right:30px;background-color: #A4DD74;color:white; padding: 4px 13px; "> <b id="upcoming"></b> </button>
                       <button onclick="submitForm('CO');" class="btn btn-sm " style="margin-left:55px;margin-right:55px;background-color: #448fea;color:white; padding: 4px 13px; "> <b id="completed"></b> </button>
                        <button onclick="submitForm('CA');" class="btn btn-sm " style="margin-left:30px;background-color: #e85342;color:white; padding: 4px 13px; "> <b id="cancelled"></b> </button>
                      
					</div>
                        </div>
					   	<div class="col-md-6" style="float: right;">
		                <div id="container2" style="width: 500px; height: 430px;"></div>
                      
                         </div>
        
					   	</div>
						 <div class="row">
						<div class="col-md-6" style="float: right;">
					   	<div id="chart_div"></div>
                        </div>
					   	<div class="col-md-6" style="float: right;">
		               
                      
                         </div>
        
					   	</div>
						</div>
					
						<div class="card-footer" align="right">&nbsp;</div>
					</div>
					
		
					
					
					
				</div>
			</div>
		</div>


			
		

	
<script type='text/javascript'> 
var Id2="<%=projectid%>";
function draw(Id){
	$("#ProId").val(Id);
	$
	.ajax({

		type : "GET",
		url : "MeetingsCount.htm",
		data : {
			projectid : Id
		},
		datatype : 'json',
		success : function(result) {

			var result = JSON.parse(result);
			var values = Object.keys(result).map(function(e) {
				  return result[e]
				});
			
			   var name=values[0];
               var cancelled=values[1];
               var upcoming=values[2];
               var completed=values[3];
          
               PieChart(name,upcoming,cancelled,completed);
               document.getElementById('upcoming').innerHTML = upcoming ;
               document.getElementById('cancelled').innerHTML = cancelled ;
               document.getElementById('completed').innerHTML = completed ;
            
		}

	});
	
}
$(document).ready(function() {
	  draw(Id2);
	   $('#projectid').on('change', function() {
		   
		   draw($("#projectid").val());

	   });
	});
function PieChart(name,upcoming,cancelled,completed) {
	$('#container div').remove();
	$('#container2 div').remove();
	anychart.onDocumentReady(function() {
		var data1 = [
			 {x: "Upcoming", value: upcoming, fill:"#A4DD74"},		      
		      {x: "Completed", value: completed,fill:"#448fea"},
		      {x: "Cancelled", value: cancelled,fill:"#e85342"}
			];
		  // set the data
		  var data = [
			 {x: "Upcoming", value: upcoming,state:"selected", fill:"#A4DD74"},		     
		      {x: "Completed", value: completed,fill:"#448fea"},
		      {x: "Cancelled", value: cancelled,fill:"#e85342"}
			];


		  // create the chart
		  var chart1 = anychart.pie3d(data);
		 // var chart = anychart.pie3d(data);
		  // set the chart title
		  //chart.title(name+" Action Report");
		 // chart.labels().position("outside");
		
		  // add the data
		  // create a 3d bar chart
         var chart2 = anychart.line();

          // create a bar series and set the data
         var series = chart2.column(data1);
         anychart.format.locales.default.numberLocale.decimalsCount = 0;
   
		  chart2.container('container');
		  chart2.draw();
		  chart1.title(name+" Project Meetings Report");
		  chart1.labels().position("outside");
		  chart1.innerRadius("30%");
		  chart1.container('container2');
		  chart1.draw();
		});
}
function submitForm(type)
{ 
   $("#StatusType").val(type);
   document.getElementById('ststusform').submit(); 
} 




$('#fdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	"maxDate" : new Date(),
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});





$('#tdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	"maxDate" : new Date(),
	
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});



function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}
	 
	
	
		 
	
		  return true;
	 
			
	}







</script>

</body>
</html>