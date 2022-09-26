<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/dependancy.jsp"></jsp:include> 
<title>PFMS Print</title>

<style>

@media print {
  #pdfdown {
    display: none;
  } 
  
  #print{
  	display:none;
  }
  
  .executive{
  	width:90% !important;
  	margin-left: 20px;
  	margin-right: 20px;
  }
  
  .title{
  	font-size: 50px !important;
  }
  
  .projecttitle{
  
  	font-size: 35px !important;
  }
  
  .projectdate{
  
  	font-size: 35px !important;
  
  }
 
  .logo{
  
  	height:140px !important;
  	width:140px !important;
  
  }
 
} 


</style>

<style type="text/css">
  

  .break {
    page-break-before: always;
      }
     
 @page {
 counter-increment:page;
       @bottom-left {
            content: counter(page) ;
             }
     } 
     
     @page {
      size: 7.27in 11.69in; 
       margin: .2in .2in .2in .2in; 
    }
    
    .article td{
    	padding:9px 5px 9px !important;
    }
 
 	.article{
 		font-family:Gadugi
 	}
 	
 	.lineheight td{
 		line-height: 40px;
 	}
 	
 	.Page6 td{
 		padding:9px 45px  !important;
 		font-family:Gadugi
 	}
 	
 	.articledesc{
 		line-height: 30px;
 		margin-top:00px;
 		margin-bottom: 30px;
 		margin-left: 80px;
 		margin-right:50px !important;
 	}
 	
 	.break{
  page-break-before:always;
  }
  
  @page {
       margin-top: 0.35in !important;
    	margin-bottom: 0.15in !important;
    }
    
    table tbody b{
	background-color: #ADFF2F;
}

#container-fluid{
	background-color: white !important;
	margin-top: -14px;
}
    
.left{
	text-align: left
}

.right{
	text-align: right
}

.center{
	text-align: center
}

.700{
	font-weight: 700;
}

.500{
	font-weight: 500;
}

.normal{
	font-weight: normal;
}

.border_black{
	border:1px solid black;
}
 	
.executive th{
	padding:10px 5px;
}

.executive td{
	padding-left: 5px;
}

.top{
	vertical-align: top
}
 	
 
</style>
  




<meta charset="ISO-8859-1">
<title>Executive Summary</title>
</head>
<body >
<%

SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
SimpleDateFormat sdf2=new SimpleDateFormat("MMMM yyyy");
NFormatConvertion nfc=new NFormatConvertion();

Object[] LabList=(Object[])request.getAttribute("LabList");
Object[] PfmsInitiation=(Object[])request.getAttribute("PfmsInitiationList");
List<Object[]> DetailsList=(List<Object[]>)request.getAttribute("DetailsList");
List<Object[]> CostDetailsList=(List<Object[]>)request.getAttribute("CostDetailsList");
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
String lablogo=(String)request.getAttribute("lablogo");


%>

<div id="PrintContainer">

<div  align="center">
	<form action="ExecutiveSummaryDownload.htm" method="post" target="_blank"  >
		<input type="hidden" name="htmlstring" value="" id="htmlstring"  >
		<br>
		<button type="submit" class="btn btn-sm prints" id="pdfdown" ><i class="fa fa-file-text-o" aria-hidden="true" style="color: white" ></i> &nbsp; Generate PDF</button>
		<button type="button" class="btn btn-sm prints" id="print"  >Print</button>
		
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form> 
</div>


<div id="container-fluid" align="center">

<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:600px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
<thead>
</thead>
<tbody>
<br><br><br><br>
<tr>
<th colspan="8" style="text-align:center;font-size:30px" class="title">Executive Summary
</th>
</tr>
<tr>
<th colspan="8" style="vertical-align: top;  text-align: center; padding: 0 5px 5px;font-size:30px"><br>on
</th>
</tr>

<%if(PfmsInitiation!= null) { Object[] obj = PfmsInitiation; %>

<tr>
<th colspan="8" style="text-align: center; font-weight: 700;font-size:22px" class="projecttitle"><br><%if(obj[5]!=null){%><%=obj[5] %><%}else{ %>". . . . . . . ." (Project Title)<%} %></th>
</tr>	
<tr>
<th colspan="8" style="text-align: center; font-weight: 700;font-size:22px" class="projectdate"><br><%if(obj[10]!=null){%> <%=sdf2.format(obj[10])%><%}else{ %>Month Year<%} %></th>
</tr>


<%} %>


<%
if(LabList !=null){
Object[] obj = LabList ;  %>

<tr>

<th colspan="8" style="text-align: center; font-weight: 700;">
<br><br><br><br><br><br>
<img class="logo" style="width:100px;height: 100px;margin-bottom: 5px"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >

</th>
</tr>
<tr>
<th colspan="8" style="text-align: center; font-weight: 700;font-size:22px">(ISO 9001-2015 Certified Establishment)</th>
</tr>
<tr>
<th colspan="8" style="text-align: center; font-weight: 700;font-size: 26px"><br><br><br><br><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %>LAB NAME<%} %></th>
</tr>

<%}else{ %>

<tr>
<th colspan="8" style="text-align: center; font-weight: 700;"><br><br><br><br><br><br> 
<img class="logo"  style="width:100px;height: 100px" alt="Lab Logo"  <%if(lablogo!=null ){ %> src="data:image/*;base64,<%=lablogo%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> >
</th>
</tr>
<tr>
<th colspan="8" style="text-align: center; font-weight: 700;font-size:22px">(ISO 9001-2015 Certified Establishment)</th>
</tr>
<tr>
<th colspan="8" style="text-align: center; font-weight: 700;font-size: 26px"><br><br><br><br>LAB NAME</th>
</tr>

<%} %>

<tr>
<th colspan="8" style="text-align: center; font-weight: 700;font-size:22px"><br>Government of India, Ministry of Defence</th>
</tr>
<tr>
<th colspan="8" style="text-align: center; font-weight: 700;font-size:22px">Defence Research & Development Organization</th>
</tr>
<tr>
<th colspan="8" style="text-align: center; font-weight: 700;font-size:22px">CV Raman Nagar, Bangalore - 560 093</th>
</tr>


<tr>
<th  id="page-num" colspan="8" style="text-align: right;"><br><br><br><br><br><br><br><br>Page 1 of 2</th>
</tr> 



</tbody>
</table>
<table  style=" ">
<tr >
<td align="center" style="color: black;padding-top: 50px;margin-top: 50px"></td>
</tr>
</table>

 <h1 class="break"></h1>
 
 
 <table  style="margin-top:0px;margin-left: 30px; margin-bottom: 0px;width:600px; font-size: 22px;border-collapse: collapse;font-family:Gadugi ;" >
<thead>
</thead>
<tbody>





<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 30px;width:600px; font-size: 22px; ">
<tbody>

<tr>
<th colspan="8" style="text-align: center;font-size:22px">Executive Summary (ES) </th>
</tr>


<%if(PfmsInitiation!= null) { 
	Object[] obj = PfmsInitiation; %>


<table class="executive" style="border-collapse: collapse;width:100%;margin-bottom: 20px;">

<tr>
<th colspan="1" class="border_black 700 left" style=";width:7%"><span >SN</span></th>
<th colspan="2" class="border_black 700 left" style=";width:30%"><span >Content</span></th>
<th colspan="5" class="border_black 700 left" ><span >Inputs</span></th>
</tr> 

<tr>
<th rowspan="3" colspan="1" class="border_black normal center" style="vertical-align:top;width:7%"><span >1.</span></th>
<th colspan="2" class="border_black normal left" ><span >Name of the Main project</span></th>
<th colspan="5" class="border_black normal left" ><span > <%if(obj[12].toString().equalsIgnoreCase("N")){ %><%=obj[13]%><%} else{ %> <i> NA </i> <%} %></span></th>
</tr> 

<tr>
<th colspan="2" class="border_black normal left" ><span >Main Project Sanction Date</span></th>
<th colspan="5" class="border_black normal left" ><span ><%if(obj[12].toString().equalsIgnoreCase("N")){ %>To Be Obtained<%} else{ %> <i> NA </i> <%} %></span></span></th>
</tr>

<tr>

<th colspan="2" class="border_black normal left" ><span >Main Project PDC</span></th>
<th colspan="5" class="border_black normal left" ><span ><%if(obj[12].toString().equalsIgnoreCase("N")){ %>To Be Obtained<%} else{ %> <i> NA </i> <%} %></span></span></th>
</tr>

<tr>
<th colspan="1" class="border_black normal center" style=";width:7%"><span >2.</span></th>
<th colspan="2" class="border_black normal left" ><span >Title of the Project / Name of sub project</span></th>
<th colspan="5" class="border_black normal left" ><span ><%if(obj[5]!=null){ %><%=obj[5] %><%}else{ %><i></i><%} %></span></th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center" style=";width:7%"><span >3.</span></th>
<th colspan="2" class="border_black normal left" ><span >Security Classification</span></th>
<th colspan="5" class="border_black normal left" ><span ><%if(obj[3]!=null){ %><%=obj[3] %><%}else{ %><i></i><%} %></span></th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center" style=";width:7%"><span >4.</span></th>
<th colspan="2" class="border_black normal left" ><span >Cost (In Lakhs)</span></th>

<th colspan="5" class="border_black normal left" >
	<span >
		<%if(obj[6]!=null){ 
			String split = obj[6].toString().split("\\.")[0]; 
				int length = split.length();
					String value= "0";
						if(length>2){
							Double cost= Double.parseDouble(obj[6].toString())/100000;
							value= cost.toString().substring(0, 3);
									}
						%>&#8377;  <%=value%>  Lakhs<%}else{ %><i></i><%} %></span>
</th>

</tr> 

<tr>
<th colspan="1" class="border_black normal center" style=";width:7%"><span >5.</span></th>
<th colspan="2" class="border_black normal left" ><span >PDC (In Months)</span></th>
<th colspan="5" class="border_black normal left" ><span ><%if(obj[7]!=null){ %><%=obj[7] %><%}else{ %><i></i><%} %></span></th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center" style=";width:7%"><span >6.</span></th>
<th colspan="2" class="border_black normal left" ><span >Whether Plan/Non Plan Project</span></th>
<th colspan="5" class="border_black normal left" ><span ><%if(obj[8]!=null){ if(obj[8].toString().equalsIgnoreCase("P")){%> Plan <%}if(obj[8].toString().equalsIgnoreCase("N")){ %>Non-Plan -> <%if(obj[14]!=null){ %> <%=obj[14]%> <%}else{ %> No  Remarks <%} %> <%}}else{ %><%} %></span></th>
</tr> 

<%} %>



<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >7.</span></th>
<th colspan="2" class="border_black normal left top" ><span >Requirements</span></th>
<th colspan="5" class="border_black normal left" >
	<%for (Object[] obj : DetailsList){ %>
		<span ><%if(obj[0]!=null){ %><%=obj[0] %><%}else{ %><i></i><%} %></span>
	<%} %>	
</th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >8.</span></th>
<th colspan="2" class="border_black normal left top" ><span >Objective</span></th>
<th colspan="5" class="border_black normal left" >
	<%for (Object[] obj : DetailsList){ %>
		<span ><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %><i></i><%} %></span>
	<%} %>
</th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >9.</span></th>
<th colspan="2" class="border_black normal left top" ><span >Scope</span></th>
<th colspan="5" class="border_black normal left" >
	<%for (Object[] obj : DetailsList){ %>
		<span ><%if(obj[2]!=null){ %><%=obj[2] %><%}else{ %><i></i><%} %></span>
	<%} %>
</th>
</tr> 




<%if(PfmsInitiation!= null) { Object[] obj = PfmsInitiation; %>

<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >10.</span></th>
<th colspan="2" class="border_black normal left top" ><span >Deliverables/Output</span></th>
<th colspan="5" class="border_black normal left" ><span ><%if(obj[11]!=null){ %><%=obj[11] %><%}else{ %><i></i><%} %></</span></th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >11.</span></th>
<th colspan="2" class="border_black normal left top" ><span >Participating Labs with Work share</span></th>
<th colspan="5" class="border_black normal left" ><span ><%if(obj[3]!=null){ %><%=obj[3] %><%}else{ %><i></i><%} %></span></th>
</tr> 


<%} %>


<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >12.</span></th>
<th colspan="2" class="border_black normal left top" ><span >Brief of earlier work done</span></th>
<th colspan="5" class="border_black normal left" >
<%for (Object[] obj : DetailsList){ %>
	<span ><%if(obj[4]!=null){ %><%=obj[4] %><%}else{ %><i></i><%} %></span>
<%} %>
</th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >13.</span></th>
<th colspan="2" class="border_black normal left top" ><span >Competency Established</span></th>
<th colspan="5" class="border_black normal left" >
<%for (Object[] obj : DetailsList){ %>
	<span ><%if(obj[5]!=null){ %><%=obj[5] %><%}else{ %><i></i><%} %></span>
<%} %>
</th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >14.</span></th>
<th colspan="2" class="border_black normal left top" ><span >Need of the Project</span></th>
<th colspan="5" class="border_black normal left" >
<%for (Object[] obj : DetailsList){ %>
	<span ><%if(obj[6]!=null){ %><%=obj[6] %><%}else{ %><i></i><%} %></span>
<%} %>
</th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >15.</span></th>
<th colspan="2" class="border_black normal left top" ><span >Technology Challenges/issues foreseen</span></th>
<th colspan="5" class="border_black normal left" >
<%for (Object[] obj : DetailsList){ %>
	<span ><%if(obj[7]!=null){ %><%=obj[7] %><%}else{ %><i></i><%} %></span>
<%} %>
</th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >16.</span></th>
<th colspan="2" class="border_black normal left top" ><span >Risk involved and Mitigation Plan</span></th>
<th colspan="5" class="border_black normal left" >
<%for (Object[] obj : DetailsList){ %>
	<span ><%if(obj[8]!=null){ %><%=obj[8] %><%}else{ %><i></i><%} %></span>
<%} %>
</th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >17.</span></th>
<th colspan="2" class="border_black normal left top" ><span >Proposal</span></th>
<th colspan="5" class="border_black normal left" >
<%for (Object[] obj : DetailsList){ %>
	<span ><%if(obj[9]!=null){ %><%=obj[9] %><%}else{ %><i></i><%} %></span>
<%} %>
</th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >18.</span></th>
<th colspan="2" class="border_black normal left top" ><span >Cost estimate/Break-up</span></th>
<th colspan="5" class="border_black normal left" > <span >Attached as Annexure - A</span></th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >19.</span></th>
<th colspan="2" class="border_black normal left top" ><span >Major milestone/Project schedule</span></th>
<th colspan="5" class="border_black normal left" ><span >Attached as Annexure - B</span></th>
</tr> 

<tr>
<th colspan="1" class="border_black normal center top" style=";width:7%"><span >20.</span></th>
<th colspan="2" class="border_black normal left top	" ><span >Realization Plan</span></th>
<th colspan="5" class="border_black normal left" >
<%for (Object[] obj : DetailsList){ %>
	<span ><%if(obj[10]!=null){ %><%=obj[10] %><%}else{ %><i></i><%} %></span>
<%} %>
</th>
</tr> 

<!-- <tr>
<th colspan="8" style="text-align: right;"><br><br><br>Page 2 of 2</th>
</tr> -->


</table>


</tbody>
</table>
</tbody>
</table>
<table  style=" ">
<tr >
<td align="center" style="color: black;padding-top: 10px"></td>
</tr>
</table>


<!-- <!--  New Code  Annexure -  A --> 


 <h1 class="break"></h1>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 30px;width:600px; font-size: 22px; ">
<tbody>

<tr>
<th colspan="8" style="text-align: center;font-size:22px">Annexure - A </th>
</tr>

<table class="executive" style="border-collapse: collapse;width:100%;margin-bottom: 20px;">

<tr>
<td colspan="1" class="border_black  left" style=";width:7%;font-weight: 600"><span >SN</span></td>
<td colspan="2" class="border_black  center" style="font-weight: 600;width:25%;"><span >Head Code</span></td>
<td colspan="5" class="border_black  center" style=";width:30%;font-weight: 600" ><span >Budget Item</span></td>
<td colspan="2" class="border_black  center" style=";width:25%;font-weight: 600"><span >Item Cost</span></td>

</tr>

<%
if(!CostDetailsList.isEmpty()){

int count=1;
for (Object[] obj: CostDetailsList) {%>
 
<tr>
<td colspan="1" class="border_black  center" style=";width:7%"><span ><%=count %>. </span></td>
<td colspan="2" class="border_black  left" ><span ><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %> - <%} %></span></td>
<td colspan="5" class="border_black  left" ><span ><%if(obj[0]!=null){ %><%=obj[0] %><%}else{ %> - <%} %></span></td>
<td colspan="2" class="border_black right"  ><span ><%if(obj[3]!=null){ %>&#8377; <%=nfc.convert(Double.parseDouble(obj[3].toString()))%> <%}else{ %> - <%} %></span></td>
</tr> 

<%
count++;} }%>

<%if(PfmsInitiation!= null) { Object[] obj = PfmsInitiation; %>

<tr>
	<td colspan="12" class="border_black right"  ><span ><%if(obj[6]!=null){ %>Total Cost : &#8377; <%=nfc.convert(Double.parseDouble(obj[6].toString()))%> <%}else{ %> - <%} %></span></td>
</tr>

<%} %>

</table> 



</tbody>
</table>

<table  style=" ">
<tr >
<td align="center" style="color: black;padding-top: 10px"></td>
</tr>
</table>


<!-- Annexure -B  -->


<h1 class="break"></h1>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 30px;width:600px; font-size: 22px; ">
<tbody>

<tr>
<th colspan="8" style="text-align: center;font-size:22px">Annexure - B</th>
</tr>

<table class="executive" style="border-collapse: collapse;width:100%;margin-bottom: 20px;">

<tr>
<td colspan="1" class="border_black  left" style=";width:7%;font-weight: 600"><span >Mil No</span></td>
<td colspan="5" class="border_black  center" style=";width:35%;font-weight: 600" ><span >Milestone Activity</span></td>
<td colspan="2" class="border_black  center" style="font-weight: 600"><span >Milestone Month</span></td>
<td colspan="2" class="border_black  center" style="font-weight: 600"><span >Milestone Remarks</span></td>
</tr>

<%
if(!ScheduleList.isEmpty()){

for (Object[] obj: ScheduleList) {%>
 
<tr>
<td colspan="1" class="border_black  left" ><span ><%if(obj[0]!=null){ %><%=obj[0] %><%}else{ %> - <%} %></span></td>
<td colspan="5" class="border_black  left" ><span ><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %> - <%} %></span></td>
<td colspan="2" class="border_black center" ><span ><%if(obj[2]!=null){ %><%=obj[2] %><%}else{ %> - <%} %></span></td>
<td colspan="2" class="border_black  left" ><span ><%if(obj[4]!=null){ %><%=obj[4] %><%}else{ %> - <%} %></span></td>
</tr> 

<%
} }%>

</table> 



</tbody>
</table>

<table  style=" ">
<tr >
<td align="center" style="color: black;padding-top: 10px"></td>
</tr>
</table>


</div>

</div>


</body>


<script type="text/javascript">
$("button").click(function(){
	  $("a").remove();
	});

 $('#pdfdown').click(function(){
	
	//$('h1').removeClass('break');
	$('#page-num').css('color','white');
	
	
	 var htmlcode=$('#PrintContainer').html();
	  document.getElementById("htmlstring").value = htmlcode;
	
}) 


$('#print').click(function(){
	
	$('h1').addClass('break');
	window.print();
})

	

	

</script>


</html>