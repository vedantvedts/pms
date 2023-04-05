<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../static/header.jsp"></jsp:include>
<meta charset="ISO-8859-1">
<title>PMS</title>
<style>
#projectname {
	display: flex;
	align-items: center;
	justify-content: flex-start;
}

#div1 {
	display: flex;
	align-items: center;
	justify-content: center;
}

h5{
font-size: 18px;

}
.point>h5{
text-align: left;
    background: white;
    padding: 5px;
    color: balck;
	font-family: 'FontAwesome';
    box-shadow: 2px 2px 2px cadetblue;
    border-radius: 5px;
	margin-left:10%;
}
.details>h5{
color: #013220;
    border: 1px solid lightslategray;
    padding: 5px;
    font-family: 'FontAwesome';
    border-radius: 5px;
    box-shadow: 2px 2px 2px;
    background: aliceblue;
}
.point,.details{
margin-top: 1%;
}
</style>
</head>
<body>
<%
    List<Object[]> ProjectIntiationList=(List<Object[]>)request.getAttribute("ProjectIntiationList"); 
    Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes"); 
 	String projectshortName=(String)request.getAttribute("projectshortName");
	String initiationid=(String)request.getAttribute("initiationid");
	String projectTitle=(String)request.getAttribute("projectTitle");
	NFormatConvertion nfc=new NFormatConvertion();
	%>
		<form class="form-inline" method="POST"
			action="ProjectSanction.htm">
			<div class="row W-100" style="width: 80%; margin-top: -0.5%;">
				<div class="col-md-2" id="div1">
					<label class="control-label"
						style="font-size: 15px; color: #07689f;"><b>Project Name :</b></label>
				</div>
				<div class="col-md-2" style="margin-top: 3px;" id="projectname">
					<select class="form-control selectdee" id="project"
						required="required" name="project">
						<%if(!ProjectIntiationList.isEmpty()) {
                                        for(Object[]obj:ProjectIntiationList){%>
						<option value="<%=obj[0]+"/"+obj[4]+"/"+obj[5]%>"
							<%if(obj[4].toString().equalsIgnoreCase(projectshortName)) {%>
							selected <%} %>><%=obj[4] %></option>
						<%}} %>
					</select>
				</div>
				
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input id="submit" type="submit"
					name="submit" value="Submit" hidden="hidden">
			</div>
		</form>
				<div class="container-fluid" style="display: block;" id="main">
			<div class="row">
				<div class="col-md-12">
					<div class="card shadow-nohover" style="margin-top: 5px;">
						<div class="row card-header"
							style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
					<%-- 			<div class="col-md-2" id="addReqButton">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden"
									name="projectshortName" value="<%=projectshortName %>" /> <input
									type="hidden" name="IntiationId" value="<%=initiationid %>" />
							</div> --%>
							<div class="col-md-12" id="projecthead" align="center">
								<h5 style="margin-left: 1%;">
									STATEMENT OF CASE FOR SANCTION OF PROJECT/PROGRAMME
								</h5>
							</div>
						
						</div>
						
							
						<div class="card-body" id="cardbody" style="background: white;padding-top: 0%">
							<div class="row">
							<%if(ProjectDetailes!=null){%>
							<div class="col-md-6">
							<div class="row">
							<div class="col-md-6 point">
							<h5 >1. Name of laboratory:</h5>
							</div>
							<div class="col-md-4 details">
							<h5 >MTRDC</h5>
							</div>
							<div class="col-md-6 point">
							<h5 >2. Title of the Project/Programme: </h5>
							</div>
							<div class="col-md-6 details">
							<h5 ><%=ProjectDetailes[7] %></h5>
							</div>
							<div class="col-md-6 point">
							<h5 >3. Category of Project: </h5>
							</div>
							<div class="col-md-6 details">
							<h5 ><%=ProjectDetailes[4] %></h5>
							</div>
							<div class="col-md-6 point">
							<h5 >4. Security classification of Project/Programme: </h5>
							</div>
							<div class="col-md-6 details">
							<h5 ><%=ProjectDetailes[5] %></h5>
							</div>
								<div class="col-md-6 point">
							<h5 >5. Name of the Project Director/Programme Director (for approval of Competent Authority) : </h5>
							</div>
							<div class="col-md-6 details">
							<h5 ><%=ProjectDetailes[1] %></h5>
							</div>
								<div class="col-md-6 point">
							<h5 >6. Cost(Lakhs): </h5>
							</div>
								<div class="col-md-6 details">
							<h5 ><%if(ProjectDetailes[8]!=null && Double.parseDouble(ProjectDetailes[8].toString())>0){%><%=nfc.convert(Double.parseDouble( ProjectDetailes[8].toString())/100000 )%> &nbsp;&nbsp;Lakhs<%} else if(ProjectDetailes[20]!=null &&  Double.parseDouble( ProjectDetailes[20].toString())>0 ){%><%=nfc.convert(Double.parseDouble( ProjectDetailes[20].toString())/100000 )%>&nbsp;&nbsp;Lakhs<%}else{ %>-<%} %></h5>
							</div>
							<div class="col-md-6 point">
							<h5 >7. Schedule (Months): </h5>
							</div>
								<div class="col-md-6 details">
							<h5 ><%if(ProjectDetailes[9]!=null && Integer.parseInt(ProjectDetailes[9].toString())>0){ %><%=ProjectDetailes[9]%><%}else if(ProjectDetailes[18]!=null){ %><%=ProjectDetailes[18]%><%}else{ %>-<%} %></h5>
							</div>
							</div>
							</div>
							
								<div class="col-md-6">
							<div class="row">
							
							</div>
							</div>
							
							</div>
							
							
					</div>
					
					<%}%>
					</div>
				</div>
			</div>
		</div>
		
	
				
				
					
		
		<script>
		$(document).ready(function() {
			   $('#project').on('change', function() {
				   var temp=$(this).children("option:selected").val();
				   $('#submit').click(); 
			   });
			});
		
		
		</script>
</body>
</html>