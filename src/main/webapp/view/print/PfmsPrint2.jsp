	<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/dependancy.jsp"></jsp:include>

<title>Project Proposal</title>

<style>
@media print {
  #pdfdown {
    display: none;
  } 
  
  #print{
  	display:none;
  }
 
} 

@media print {

   tfoot 
   {
  	 display: table-footer-group;
   }
   
   .page-footer, .page-footer-space {
  	height: 50px;

	}

	.page-footer {
	  position: fixed;
	  bottom: 0;
	  width: 100%;
	  border-top: 3px solid grey; 
	  background: white; 
	  display: block !important	;
	  margin: 0px 50px;
	  font-size: 18px !important;
	}
	
	.tfoot_hide{
		display: none !important;
	}
   
   
}  



</style>




<div id="PrintContainer">


<style type="text/css">
 

  .break {
    page-break-before: always;
      }
     
 
 @page {
 counter-increment:page;
       @bottom-left {
            content: counter(page) ; }
     } 
     @page {
      size: landscape; 
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
       margin-top: 0.75in !important;
    	margin-bottom: 0.35in !important;
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

.border_r{
 border-right: 1px solid black;
}
.border_l{
	border-left: 1px solid black;
}
.border_t{
	border-top: 1px solid black;
}
.border_b{
	border-bottom: 1px solid black;
} 

.grey{
	    background-color: rgba(0,0,0,.05);
}


.page-footer{
	font-size: 1px;
}

.page-footer p{
	 text-transform: lowercase;
} 	

.page-footer p:first-line{
	text-transform: capitalize;
}


</style>




  


<meta charset="ISO-8859-1">
<title> Project Proposal </title>
</head>
<body >
<%

SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
NFormatConvertion nfc=new NFormatConvertion();

List<Object[]> PfmsInitiationList=(List<Object[]>)request.getAttribute("PfmsInitiationList");
List<Object[]> DetailsList=(List<Object[]>)request.getAttribute("DetailsList");
List<Object[]> CostDetailsList=(List<Object[]>)request.getAttribute("CostDetailsList");
List<Object[]> ScheduleList=(List<Object[]>)request.getAttribute("ScheduleList");
List<Object[]> LabList=(List<Object[]>)request.getAttribute("LabList");

%>

<div  align="center">
	<form action="ProjectProposalDownload.htm" method="post" target="_blank"  >
		<input type="hidden" name="htmlstring" value="" id="htmlstring"  >
		<br>
		<button type="submit" class="btn btn-sm prints" id="pdfdown" ><i class="fa fa-file-text-o" aria-hidden="true" style="color: white" ></i> &nbsp; Generate PDF</button>
		<button type="button" class="btn btn-sm prints" id="print"  >Print</button>
		
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form> 
</div>


<div id="container-fluid" align="center">

  <div class="page-footer" style="display: block" align="center" > 
	<div class="row">
	
	<%for(Object[] obj : LabList){ %>
	
		<div class="col-md-10" style="text-align: left">
			<p style="text-transform: capitalize;"><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %>Lab Name<%} %></p>
		</div>
		
	<%} %>
		
	</div> 
  </div>


<!-- <table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >

<tbody>
<br>
<tr>
<th colspan="4"  style="text-align:left;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
<th colspan="4"  style="text-align:right;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
</tr>
<tr>
<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
</tr>
<tr>
<th colspan="8"  style="text-align:center;font-size:30px;font:black">Content</th>
</tr>






</table>

 <h1 class="break"></h1> -->
 

<!-- 1st page -->



<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >

<tbody>
<br>
<tr>
<th colspan="4"  style="text-align:left;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
<th colspan="4"  style="text-align:right;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
</tr>
<tr>
<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
</tr>
<tr>
<% for (Object[] obj : PfmsInitiationList){ %>

<th colspan="8" style="  text-align: center; padding: 0 5px 5px;font-size:35px"><%if(obj[5]!=null){ %><%=obj[5] %><%}else{ %><i>Project Title</i><%} %>
</th>
</tr>
<tr>
<th colspan="8" style="text-align: center; font-weight: 700;font-size: 35px"><br><br><br><br><br><br>Meeting</th>
</tr>
<tr>
<th colspan="8" style="text-align: center; font-weight: 700;font-size: 35px">Date Month Year</th>
</tr>

<%} %>

<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
 	<tr class="tfoot_hide" style="display: block">
		<th colspan="8" ><br>
			
				<hr style="font-size:30px;border-bottom: 3px solid grey">
			
		</th>
	</tr>
	
	<%for(Object[] obj : LabList){ %>
	
	<tr class="tfoot_hide" style="display: block;border-top: 3px solid grey">
		<td >
			<div class="row" >
				<div class="col" style="text-align: left;" >
					<p style=""><%if(obj[1]!=null){ %><%=obj[1].toString() %><%}else{ %>Lab Name<%} %></p>
				</div>
			</div> 
		</td>	
	</tr> 	
	
	<%} %>
	
</tbody>

<tfoot>
      <tr>
        <td>
          <!--place holder for the fixed-position footer-->
          <div class="page-footer-space">
          	
          
          </div>
        </td>
      </tr>
 </tfoot>

</table>



</table>

 <h1 class="break"></h1>
 

<!-- 2nd page -->

<% for (Object[] obj : PfmsInitiationList){ %>

<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
<tbody>
<br>
<tr>
<th colspan="2"  style="text-align:left;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
<th colspan="4"  style="text-align:center;font-size:26px">Brief of Proposed Project</th>
<th colspan="2"  style="text-align:right;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
</tr>
<tr>
<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey;"></th>
</tr>

<table  style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:820px; font-size: 22px; ">
<tbody>
<tr>
<td colspan="8"   class="border_r border_l border_t left grey" style=" padding: 0 5px 5px;font-size:18px;vertical-align: top;font-weight: bold">Title of the Project &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;&nbsp;<%if(obj[5]!=null){ %><%=obj[5] %><%}else{ %><i></i><%} %></td>
</tr>
<tr>
<td colspan="8"   class="border_l border_r left grey" style=" padding: 0 5px 5px;font-size:18px;vertical-align: top;font-weight: bold;"><br></td>
</tr>
<tr>
<td colspan="8"   class="border_l border_r border_b left grey" style=" padding: 0 5px 5px;font-size:18px;vertical-align: top;font-weight: bold;"><br></td>
</tr>

<tr>
<td colspan="8"   class="border_r border_l border_t left" style=" padding: 0 5px 5px;font-size:18px;vertical-align: top;font-weight: bold">Cost &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;&nbsp;<%if(obj[6]!=null){ %>&#8377; <%=obj[6] %><%}else{ %><i></i><%} %></td>
</tr>
<tr>
<td colspan="8"   class="border_l border_r border_b left" style=" padding: 0 5px 5px;font-size:18px;vertical-align: top;font-weight: bold;"><br></td>
</tr>

<tr>
<td colspan="8"   class="border_r border_l border_t left grey" style=" padding: 0 5px 5px;font-size:18px;vertical-align: top;font-weight: bold">PDC &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;&nbsp;<%if(obj[7]!=null){ %><%=obj[7] %> Months<%}else{ %><%} %></td>
</tr>
<tr>
<td colspan="8"   class="border_l border_r border_b left grey" style=" padding: 0 5px 5px;font-size:18px;vertical-align: top;font-weight: bold;"><br></td>
</tr>

<tr>
<td colspan="8"   class="border_r border_l border_t left" style=" padding: 0 5px 5px;font-size:18px;vertical-align: top;font-weight: bold">Security Classification &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;<%if(obj[3]!=null){ %><%=obj[3] %><%}else{ %><%} %></td>
</tr>
<tr>
<td colspan="8"   class="border_l border_r border_b left" style=" padding: 0 5px 5px;font-size:18px;vertical-align: top;font-weight: bold;"><br></td>
</tr>

<tr>
<td colspan="8"   class="border_r border_l border_t left grey" style=" padding: 0 5px 5px;font-size:18px;vertical-align: top;font-weight: bold">Whether Plan/Non-Plan &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;<%if(obj[8]!=null){ if(obj[8].toString().equalsIgnoreCase("P")){%> Plan <%}if(obj[8].toString().equalsIgnoreCase("N")){ %>Non-Plan<%}}else{ %><%} %></td>
</tr>
<tr>
<td colspan="8"   class="border_l border_r border_b left grey" style=" padding: 0 5px 5px;font-size:18px;vertical-align: top;font-weight: bold;"><br></td>
</tr>


<%} %>
<!-- end of the loop from first page  -->

</tbody>
</table>

<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
 
 <tr class="tfoot_hide" style="display: block">
		<th colspan="8" ><br>
			
				<hr style="font-size:30px;border-bottom: 3px solid grey">
			
		</th>
	</tr>
	<%for(Object[] obj : LabList){ %>
	
	<tr class="tfoot_hide" style="display: block;border-top: 3px solid grey">
		<td >
			<div class="row" >
				<div class="col" style="text-align: left;" >
					<p style="text-transform: capitalize;"><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %>Lab Name<%} %></p>
				</div>
			</div> 
		</td>	
	</tr> 	
	
	<%} %>	

</tbody>

<tfoot>
      <tr>
        <td>
          <!--place holder for the fixed-position footer-->
          <div class="page-footer-space">
          	
          
          </div>
        </td>
      </tr>
 </tfoot>

</table>

<h1 class="break"></h1>

<!-- 3rd page -->

<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
<thead>
</thead>
<tbody>
<br>
<tr>
<th colspan="2"  style="text-align:left;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
<th colspan="4"  style="text-align:center;font-size:26px">Objective, Scope & Deliverables</th>
<th colspan="2"  style="text-align:right;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
</tr>
<tr>
<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
</tr>

<%if(!DetailsList.isEmpty()){
	
	for(Object[] obj: DetailsList){
	
	%>


<tr>
<th colspan="8" style="  text-align: left; padding: 0 5px 5px;font-size:20px"><br>Objective : 
</tr>
<tr>
<%if(obj[1]!=null){  %>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><%=obj[1] %></td>
<%}else{ %>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled</i></td>
<%} %>
</tr>

<tr>
<th colspan="8" style="  text-align: left; padding: 0 5px 5px;font-size:20px"><br>Scope : 
</tr>
<tr>
<%if(obj[2]!=null){  %>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><%=obj[2] %></td>
<%}else{ %>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled</i></td>
<%} %>
</tr>

<%}}else{ %>

<tr>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
</tr>

<%} %>


<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
 
 <tr class="tfoot_hide" style="display: block">
		<th colspan="8" ><br>
			
				<hr style="font-size:30px;border-bottom: 3px solid grey">
			
		</th>
	</tr>
	<%for(Object[] obj : LabList){ %>
	
	<tr class="tfoot_hide" style="display: block;border-top: 3px solid grey">
		<td >
			<div class="row" >
				<div class="col" style="text-align: left;" >
					<p style="text-transform: capitalize;"><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %>Lab Name<%} %></p>
				</div>
			</div> 
		</td>	
	</tr> 	
	
	<%} %>

</tbody>

<tfoot>
      <tr>
        <td>
          <!--place holder for the fixed-position footer-->
          <div class="page-footer-space">
          	
          
          </div>
        </td>
      </tr>
 </tfoot>


</table>
 <h1 class="break"></h1>
 
<!-- 4th page -->
 
<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
<thead>
</thead>
<tbody>
<br>
<tr>
<th colspan="2"  style="text-align:left;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
<th colspan="4"  style="text-align:center;font-size:26px">..... Objective, Scope & Deliverables</th>
<th colspan="2"  style="text-align:right;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
</tr>



<tr>
<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
</tr>

<tr>
<th colspan="8" style="  text-align: left; padding: 0 5px 5px;font-size:20px"><br>Deliverables : 
</th>
</tr>
<%if(!PfmsInitiationList.isEmpty()){
	
	for(Object[] obj: PfmsInitiationList){
	
	%>
<tr>
<%if(obj[11]!=null){  %>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><%=obj[11] %></td>
<%}else{ %>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled</i></td>
<%} %>
</tr>

<%}} %>


<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
 
 <tr class="tfoot_hide" style="display: block">
		<th colspan="8" ><br>
			
				<hr style="font-size:30px;border-bottom: 3px solid grey">
			
		</th>
	</tr>
	<%for(Object[] obj : LabList){ %>
	
	<tr class="tfoot_hide" style="display: block;border-top: 3px solid grey">
		<td >
			<div class="row" >
				<div class="col" style="text-align: left;" >
					<p style="text-transform: capitalize;"><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %>Lab Name<%} %></p>
				</div>
			</div> 
		</td>	
	</tr> 	
	
	<%} %>

</tbody>

<tfoot>
      <tr>
        <td>
          <!--place holder for the fixed-position footer-->
          <div class="page-footer-space">
          	
          
          </div>
        </td>
      </tr>
 </tfoot>

</table>
 
 <h1 class="break"></h1>

<!-- 5th page -->


<%for(Object[] obj : PfmsInitiationList){

	if(obj[9]!=null){ if(obj[9].toString().equalsIgnoreCase("Y")){
	
	%>


<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
<thead>
</thead>
<tbody>
<br>
<tr>
<th colspan="2"  style="text-align:left;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
<th colspan="4"  style="text-align:center;font-size:26px">Participating Labs with Work Share (if any) </th>
<th colspan="2"  style="text-align:right;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
</tr>
<tr>
<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
</tr>

<%for(Object[] obj1 : DetailsList){ %>

<tr>
<td colspan="8" style="  text-align: center; padding: 0 5px 5px;font-size:20px"><br><%if(obj1[3]!=null){%><%=obj1[3]%><%}else{%>To be filled<%} %>
</td>
</tr>

<%} %>

<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
 
 <tr class="tfoot_hide" style="display: block">
		<th colspan="8" ><br>
			
				<hr style="font-size:30px;border-bottom: 3px solid grey">
			
		</th>
	</tr>
	<%for(Object[] obj2 : LabList){ %>
	
	<tr class="tfoot_hide" style="display: block;border-top: 3px solid grey">
		<td >
			<div class="row" >
				<div class="col" style="text-align: left;" >
					<p style="text-transform: capitalize;"><%if(obj2[1]!=null){ %><%=obj2[1] %><%}else{ %>Lab Name<%} %></p>
				</div>
			</div> 
		</td>	
	</tr> 	
	
	<%} %>

</tbody>

<tfoot>
      <tr>
        <td>
          <!--place holder for the fixed-position footer-->
          <div class="page-footer-space">
          	
          
          </div>
        </td>
      </tr>
 </tfoot>

</table>
 
 <%}}}%>
 
 
 <h1 class="break"></h1>

<!-- 6th page -->

<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
<thead>
</thead>
<tbody>
<br>
<tr>
<th colspan="2"  style="text-align:left;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
<th colspan="4"  style="text-align:center;font-size:26px">Brief work Done Earlier </th>
<th colspan="2"  style="text-align:right;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
</tr>
<tr>
<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
</tr>

<%
if(!DetailsList.isEmpty()){
for(Object[] obj : DetailsList){ %>

<tr>
<%if(obj[4]!=null){  %>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><%=obj[4] %></td>
<%}else{ %>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled</i></td>
<%} %>
</tr>

<%}}else {%>
<tr>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
</tr>

<%} %>



<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
 
 <tr class="tfoot_hide" style="display: block">
		<th colspan="8" ><br>
			
				<hr style="font-size:30px;border-bottom: 3px solid grey">
			
		</th>
	</tr>
	<%for(Object[] obj : LabList){ %>
	
	<tr class="tfoot_hide" style="display: block;border-top: 3px solid grey">
		<td >
			<div class="row" >
				<div class="col" style="text-align: left;" >
					<p style="text-transform: capitalize;"><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %>Lab Name<%} %></p>
				</div>
			</div> 
		</td>	
	</tr> 	
	
	<%} %>

</tbody>

<tfoot>
      <tr>
        <td>
          <!--place holder for the fixed-position footer-->
          <div class="page-footer-space">
          	
          
          </div>
        </td>
      </tr>
 </tfoot>

</table>
 
 <h1 class="break"></h1>

<!-- 7th page -->

<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
<thead>
</thead>
<tbody>
<br>
<tr>
<th colspan="2"  style="text-align:left;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
<th colspan="4"  style="text-align:center;font-size:26px">Technology Challenges</th>
<th colspan="2"  style="text-align:right;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
</tr>
<tr>
<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
</tr>
<tr>
<th colspan="8" style="  text-align: left; padding: 0 5px 5px;font-size:20px"><br>Technology Challenges/Issues Foreseen : 
</th>
</tr>

<%
if(!DetailsList.isEmpty()){
for(Object[] obj : DetailsList){ %>

<tr>
<%if(obj[7]!=null){  %>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><%=obj[7] %></td>
<%}else{ %>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled</i></td>
<%} %>
</tr>

<%}}else {%>
<tr>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled<br><br></i></td>
</tr>

<%} %>


<tr>
<th colspan="8" style="text-align: left; font-weight: 700;font-size: 20px">Risk Mitigation : 
</tr>
<%
if(!DetailsList.isEmpty()){
for(Object[] obj : DetailsList){ %>
<tr>
<%if(obj[8]!=null){  %>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><%=obj[8] %></td>
<%}else{ %>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal">To be filled</i></td>
<%} %>
</tr>
<%}}else {%>
<tr>
<td colspan="8" style="text-align:justify; padding: 0 5px 5px;font-size:20px"><i class="normal"><br>To be filled</i></td>
</tr>

<%} %>

<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
 
 <tr class="tfoot_hide" style="display: block">
		<th colspan="8" ><br>
			
				<hr style="font-size:30px;border-bottom: 3px solid grey">
			
		</th>
	</tr>
	<%for(Object[] obj : LabList){ %>
	
	<tr class="tfoot_hide" style="display: block;border-top: 3px solid grey">
		<td >
			<div class="row" >
				<div class="col" style="text-align: left;" >
					<p style="text-transform: capitalize;"><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %>Lab Name<%} %></p>
				</div>
			</div> 
		</td>	
	</tr> 	
	
	<%} %>

</tbody>

<tfoot>
      <tr>
        <td>
          <!--place holder for the fixed-position footer-->
          <div class="page-footer-space">
          	
          
          </div>
        </td>
      </tr>
 </tfoot>

</table>
 <h1 class="break"></h1>
 
 <!-- 8th page -->
 
 <table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
<thead>
</thead>
<tbody>
<br>
<tr>
<th colspan="2"  style="text-align:left;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
<th colspan="4"  style="text-align:center;font-size:26px">Cost Breakup as per proposal</th>
<th colspan="2"  style="text-align:right;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
</tr>
<tr>
<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
</tr>


<%if(!CostDetailsList.isEmpty()){ %>

<table  class="executive" style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:820px; font-size: 20px; ">

<tr>
<th colspan="1" class="border_black 700 left" style=";width:9%"><span >SN</span></th>
<th colspan="3" class="border_black 700 center" style=";width:40%"><span >Item</span></th>
<th colspan="2" class="border_black 700 center" style=";width:30%"><span >Head Code</span></th>
<th colspan="2" class="border_black 700 center"style=";width:20%"> <span >Cost (in Cr.)</span></th>
</tr>
<%
int count=1;
for(Object[] obj : CostDetailsList){ %> 
<tr>
<td colspan="1" class="border_black 700 center" style=";width:7%"><span ><%=count %>.</span></td>
<td colspan="3" class="border_black 700 left" ><span ><%=obj[1] %></span></td>
<td colspan="2" class="border_black 700 left" ><span ><%=obj[2] %></span></td>
<td colspan="2" class="border_black 700 right" ><span >&#8377; <%=nfc.convert(Double.parseDouble(obj[3].toString()))%></span></td>
</tr> 
<%
count++;
} %>
</table>

<%}else{ %>
<table  class="executive" style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:820px; font-size: 22px; ">

<tr>
<th colspan="1" class="border_black 700 left" style=";width:9%"><span >SN</span></th>
<th colspan="5" class="border_black 700 center" style=";width:60%"><span >Item</span></th>
<th colspan="2" class="border_black 700 center" ><span >Cost (in Cr.)</span></th>
</tr> 
<tr>
<th colspan="1" class="border_black 700 left" style=";width:7%"><span >1.</span></th>
<th colspan="5" class="border_black 700 left" ><span ></span></th>
<th colspan="2" class="border_black 700 left" ><span ></span></th>
</tr> 
<tr>
<th colspan="1" class="border_black 700 left" style=";width:7%"><span >2.</span></th>
<th colspan="5" class="border_black 700 left" style="padding-top: 100px" ><span ></span></th>
<th colspan="2" class="border_black 700 left" ><span ></span></th>
</tr> 
<tr>
<th colspan="1" class="border_black 700 left" style=";width:7%"><span ></span></th>
<th colspan="5" class="border_black 700 left" style="padding-top: 30px" ><span ></span></th>
<th colspan="2" class="border_black 700 left" ><span ></span></th>
</tr> 
<tr>
<th colspan="1" class="border_black 700 left" style=";width:7%"><span ></span></th>
<th colspan="5" class="border_black 700 left" style="padding-top: 30px" ><span ></span></th>
<th colspan="2" class="border_black 700 left" ><span ></span></th>
</tr> 
<tr>
<th colspan="1" class="border_black 700 left" style=";width:7%"><span ></span></th>
<th colspan="5" class="border_black 700 left" style="padding-top: 30px" ><span ></span></th>
<th colspan="2" class="border_black 700 left" ><span ></span></th>
</tr> 
<tr>
<th colspan="1" class="border_black 700 left" style=";width:7%"><span ></span></th>
<th colspan="5" class="border_black 700 left" style="padding-top: 30px" ><span >Total</span></th>
<th colspan="2" class="border_black 700 left" ><span ></span></th>
</tr> 


</table>

<%} %>


<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
 
 <tr class="tfoot_hide" style="display: block">
		<th colspan="8" ><br>
			
				<hr style="font-size:30px;border-bottom: 3px solid grey">
			
		</th>
	</tr>
	<%for(Object[] obj : LabList){ %>
	
	<tr class="tfoot_hide" style="display: block;border-top: 3px solid grey">
		<td >
			<div class="row" >
				<div class="col" style="text-align: left;" >
					<p style="text-transform: capitalize;"><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %>Lab Name<%} %></p>
				</div>
			</div> 
		</td>	
	</tr> 	
	
	<%} %>

</tbody>

<tfoot>
      <tr>
        <td>
          <!--place holder for the fixed-position footer-->
          <div class="page-footer-space">
          	
          
          </div>
        </td>
      </tr>
 </tfoot>

</table>
 <h1 class="break"></h1>
 
  <!-- 9th page -->
  
<table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
<thead>
</thead>
<tbody>
<br>
<tr>
<th colspan="2"  style="text-align:left;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
<th colspan="4"  style="text-align:center;font-size:26px">Proposed Schedule/Timelines</th>
<th colspan="2"  style="text-align:right;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
</tr>
<tr>
<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
</tr>

<%if(!ScheduleList.isEmpty()){ %>

	<table  class="executive" style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:820px; font-size: 22px; ">

<tr>
<th colspan="1" class="border_black 700 left grey" style=";width:9%"><span >SN</span></th>
<th colspan="5" class="border_black 700 center grey" style=";width:80%"><span >Milestone Activity</span></th>
<th colspan="2" class="border_black 700 center grey" ><span >Time(Months)</span></th>
</tr> 
<%
int count=1;
for(Object[] obj : ScheduleList){ %> 
<tr>
<td colspan="1" class="border_black 700 center" style=";width:7%"><span ><%=count %>.</span></td>
<td colspan="5" class="border_black 700 left" ><span ><%=obj[1] %></span></td>
<td colspan="2" class="border_black 700 center" ><span ><%=obj[2]%></span></td>
</tr> 
<%
count++;
} %>

</table>
	
<%}else{ %>	


<table  class="executive" style="margin-top:10px; margin-bottom: 10px;margin-left: 35px;width:820px; font-size: 22px; ">

<tr>
<th colspan="1" class="border_black 700 left grey" style=";width:9%"><span >SN</span></th>
<th colspan="5" class="border_black 700 center grey" style=";width:80%"><span >Milestone Activity</span></th>
<th colspan="2" class="border_black 700 center grey" ><span >Time(Months)</span></th>
</tr> 
<tr>
<td colspan="1" class="border_black 500 left" style=";width:7%"><span >1.</span></td>
<td colspan="5" class="border_black 500 left" ><span >Project Sanction</span></td>
<th colspan="2" class="border_black 500 left" ><span ></span></th>
</tr> 
<tr>
<td colspan="1" class="border_black 700 left" style=";width:7%"><span >2.</span></td>
<th colspan="5" class="border_black 700 left" style="padding-top: 100px" ><span ></span></th>
<th colspan="2" class="border_black 700 left" ><span ></span></th>
</tr> 
<tr>
<th colspan="1" class="border_black 700 left" style=";width:7%"><span ></span></th>
<th colspan="5" class="border_black 700 left" style="padding-top: 30px" ><span ></span></th>
<th colspan="2" class="border_black 700 left" ><span ></span></th>
</tr> 
<tr>
<th colspan="1" class="border_black 700 left" style=";width:7%"><span ></span></th>
<th colspan="5" class="border_black 700 left" style="padding-top: 30px" ><span ></span></th>
<th colspan="2" class="border_black 700 left" ><span ></span></th>
</tr> 
<tr>
<th colspan="1" class="border_black 700 left" style=";width:7%"><span ></span></th>
<th colspan="5" class="border_black 700 left" style="padding-top: 30px" ><span ></span></th>
<th colspan="2" class="border_black 700 left" ><span ></span></th>
</tr> 
<tr>
<th colspan="1" class="border_black 700 left" style=";width:7%"><span ></span></th>
<td colspan="5" class="border_black 500 left" style="padding-top: 10px" ><span >Project Closure Activities</span></td>
<th colspan="2" class="border_black 700 left" ><span ></span></th>
</tr> 

</table>

<%} %>


<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
 
 <tr class="tfoot_hide" style="display: block">
		<th colspan="8" ><br>
			
				<hr style="font-size:30px;border-bottom: 3px solid grey">
			
		</th>
	</tr>
	<%for(Object[] obj : LabList){ %>
	
	<tr class="tfoot_hide" style="display: block;border-top: 3px solid grey">
		<td >
			<div class="row" >
				<div class="col" style="text-align: left;" >
					<p style="text-transform: capitalize;"><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %>Lab Name<%} %></p>
				</div>
			</div> 
		</td>	
	</tr> 	
	
	<%} %>

</tbody>

<tfoot>
      <tr>
        <td>
          <!--place holder for the fixed-position footer-->
          <div class="page-footer-space">
          	
          
          </div>
        </td>
      </tr>
 </tfoot>


</table>
 <h1 class="break"></h1>
 
  <!-- 10th page -->
  
   <table  style="margin-top:10px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
<thead>
</thead>
<tbody>
<br>
<tr>
<th colspan="4"  style="text-align:left;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
<th colspan="4"  style="text-align:right;font-size:30px"><img src="view/images/drdologo.png" width="80" ></th>
</tr>
<tr>
<th colspan="8"  style="text-align:center;font-size:30px;border-bottom: 3px solid grey"></th>
</tr>

<tr>
<th colspan="8" style="text-align: center; font-weight: 700;font-size: 55px"><br><br>Thank You<br><br><br></th>
</tr>


<table  style="margin-top:00px; margin-bottom: 0px;margin-left: 30px;width:920px; font-size: 18px;border-collapse: collapse;font-family:Gadugi ;" >
 
 <tr class="tfoot_hide" style="display: block">
		<th colspan="8" ><br>
			
				<hr style="font-size:30px;border-bottom: 3px solid grey">
			
		</th>
	</tr>
	<%for(Object[] obj : LabList){ %>
	
	<tr class="tfoot_hide" style="display: block;border-top: 3px solid grey">
		<td >
			<div class="row" >
				<div class="col" style="text-align: left;" >
					<p style="text-transform: capitalize;"><%if(obj[1]!=null){ %><%=obj[1] %><%}else{ %>Lab Name<%} %></p>
				</div>
			</div> 
		</td>	
	</tr> 	
	
	<%} %> 
</tbody>

</table>

  
  
  
</div>
</div>


</div>


<script type="text/javascript">

$("button").click(function(){
	  $("a").remove();
	});
	
 $('#pdfdown').click(function(){
	
	$('h1').removeClass('break');
	$('#page-num').css('color','white');
	
	 var htmlcode=$('#PrintContainer').html();
	  document.getElementById("htmlstring").value = htmlcode;
	
}) 


$('#print').click(function(){
	
	$('h1').addClass('break');
	window.print();
})	
	
</script>


</body>
</html>