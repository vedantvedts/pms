<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
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
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Briefing </title>


 <style type="text/css">
 
 p{
  text-align: justify;
  text-justify: inter-word;
}

  
 th
 {
 	border: 0;
 	text-align: center;
 	padding: 5px;
 }
 
 td
 {
 	border: 0;
 	padding: 5px;
 }
 
  }
 .textcenter{
 	
 	text-align: center;
 }
 .border
 {
 	border: 1px solid black;
 }
 .textleft{
 	text-align: left;
 }

summary[role=button] {
  background-color: white;
  color: black;
  border: 1px solid black ;
  border-radius:5px;
  padding: 0.5rem;
  cursor: pointer;
  
}
summary[role=button]:hover
 {
color: white;
border-radius:15px;
background-color: #4a47a3;

}
 summary[role=button]:focus
{
color: white;
border-radius:5px;
background-color: #4a47a3;
border: 0px ;

}
summary::marker{
	
}
hr {
	margin-top: -2px;
	margin-bottom: 12px;
	
}
details { 
  margin-bottom: 5px;  
}
details  .content {
background-color:white;
padding: 0 1rem ;
align: center;
border: 1px solid black;
}

.fill {
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden
}
.fill img {
    flex-shrink: 0;x`
    min-width: 100%;
    min-height: 100%
}

  label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 
  
</style>


<meta charset="ISO-8859-1">

</head>
<body >
<%

FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat(); 
int addcount=0; 
NFormatConvertion nfc=new NFormatConvertion();

List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectlist");
String projectid=(String)request.getAttribute("projectid");
String[] projectdatarevdata=(String[])request.getAttribute("projectdatarevdata");

List<String[]> projectdatarevlist=(List<String[]>)request.getAttribute("projectdatarevlist");
String projectdatarevid=(String)request.getAttribute("projectdatarevid");


%>
<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>

<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="row card-header">
			   			<div class="col-md-6">
							<h3>Project Revision Data </h3>
						</div>
						<!-- <div class="col-md-2"></div> -->						
						<div class="col-md-6 justify-content-end" style="float: right;">
							<table style="float: right;"  >
								<tr>
									<td ><h4>Project:</h4></td>
									<td >
										<form method="post" action="ProjectDataRevList.htm" id="projectchange">
											<select class="form-control items" name="projectid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="submitForm('projectchange');">
												<option disabled  selected value="">Choose...</option>
												<%for(Object[] obj : projectslist){ 
											     String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
												%>
												<%-- <option <%if(projectid.equals(obj[0].toString())){ %> selected <%} %> value="<%=obj[0] %>" ><%=obj[4] %></option> --%>
												<option <%if(projectid!=null && projectid.equals(obj[0].toString())) { %>selected <%} %>value="<%=obj[0]%>" ><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "+projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName): " - " %></option>
												<%} %>
											</select>
											<button type="submit" class="btn  btn-sm back" formaction="ProjectData.htm" >Back</button>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form>
									</td>
								</tr>
							</table>							
						</div>
					 </div>    
					 
				<%if(Long.parseLong(projectid)>0){ %>
					<div class="card-body">	
						<div class="row">		
						   <div class="col-md-12">
						   		
							    <%if(projectdatarevdata[3]!=null){ %>
							    <div class="row">
							    	<div class="col-md-12">
									    	<table style="float: right;"  >
											<tr>
												<td ><h4>Revision:</h4></td>
												<td >
									    		<form method="post" action="ProjectDataRevList.htm" id="revchange" style="float: right;">
													<select class="form-control items" name="projectdatarevid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="submitForm('revchange');">
														<option disabled  selected value="">Choose...</option>
														<%for(Object[] obj : projectdatarevlist){ %>
														<option <%if(projectdatarevid.equals(obj[0].toString())){ %> selected <%} %> value="<%=obj[0] %>" >REV - <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %> (<%=sdf.format(sdf1.parse(StringEscapeUtils.escapeHtml4(obj[3].toString())) )%>)</option>
														<%} %>
													</select>
													<input type="hidden" name="projectid" value="<%=projectid %>" >												
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												</form>
												</td>
											</tr>
										</table>
							    </div>
							 </div>
							   
							    	<table  style="border-collapse: collapse; border: 0px; width:100%; ">
							    		<tr>
							    			<td colspan="4" align="center"><label>Revision Date: &nbsp;<%=projectdatarevdata[4]!=null?StringEscapeUtils.escapeHtml4(projectdatarevdata[4]): " - " %></label></td>
							    		</tr>
							    		<tr>
							    			<td>
							    				<form method="post" action="ProjectDataSystemSpecsRevFileDownload.htm" target="_blank">
							    					<label> System Configuration</label>
							    					<button  type="submit" class="btn btn-sm "  style="margin-left: 3rem;"  ><i class="fa fa-download fa-lg" ></i></button>
							    					<input type="hidden" name="projectdatarevid" value="<%=projectdatarevdata[3]%>"/>
							    					<input type="hidden" name="filename" value="sysconfig"/>
							    					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							    				</form>	
											</td>
							    			<td>
							    				<form method="post" action="ProjectDataSystemSpecsRevFileDownload.htm" target="_blank">
							    					<label> Product Tree</label>
							    					<button  type="submit" class="btn btn-sm "  style="margin-left: 3rem;"  ><i class="fa fa-download fa-lg" ></i></button>
							    					<input type="hidden" name="projectdatarevid" value="<%=projectdatarevdata[3]%>"/>
							    					<input type="hidden" name="filename" value="protree"/>
							    					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							    				</form>
							    			</td>
							    			<td>
							    				<form method="post" action="ProjectDataSystemSpecsRevFileDownload.htm" target="_blank">
							    					<label> PEARL/TRL</label>
							    					<button  type="submit" class="btn btn-sm "  style="margin-left: 3rem;"  ><i class="fa fa-download fa-lg" ></i></button>
							    					<input type="hidden" name="projectdatarevid" value="<%=projectdatarevdata[3]%>"/>
							    					<input type="hidden" name="filename" value="pearl"/>
							    					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							    				</form>	
							    			</td>
							    			
							    		</tr>
							    		<%-- <tr>
							    			<td><figure class="fill"><img style="width: 10cm; height: 10cm" <%if(projectdatarevdata[0]!=null && projectdatarevdata[0].length()>0){ %> src="data:image/*;base64,<%=projectdatarevdata[0]%>" alt="Configuration"<%}else{ %> alt="File Not Found" <%} %> ></figure></td>
							    			<td><figure class="fill"><img style="width: 10cm; height: 10cm" <%if(projectdatarevdata[1]!=null && projectdatarevdata[1].length()>0){ %> src="data:image/*;base64,<%=projectdatarevdata[1]%>" alt="Product Tree/WBS"<%}else{ %> alt="File Not Found" <%} %>  ></figure></td>
							    			<td><figure class="fill"><img style="width: 10cm; height: 10cm" <%if(projectdatarevdata[2]!=null && projectdatarevdata[2].length()>0){ %> src="data:image/*;base64,<%=projectdatarevdata[2]%>"  alt="PEARL/TRL"<%}else{ %> alt="File Not Found" <%} %> ></figure></td>							    			
							    		</tr> --%>
							    		<tr>
							    			<td><label>Project Stage :</label>
							    				<%=projectdatarevdata[5]%>
							    			</td>
							    			<td>
							    				<form method="post" action="ProjectDataSystemSpecsRevFileDownload.htm" target="_blank">
							    					<label> System Specification</label>
							    					<button  type="submit" class="btn btn-sm "  style="margin-left: 3rem;"  ><i class="fa fa-download fa-lg" ></i></button>
							    					<input type="hidden" name="projectdatarevid" value="<%=projectdatarevdata[3]%>"/>
							    					<input type="hidden" name="filename" value="sysspecs"/>
							    					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							    				</form>	
							    				
							    									    			
							    			</td>
							    		
							    		</tr>
							    		
							    		
							    	
							    		
							    								
									</table>
								<%}else{ %>
									<label>No Revision Data Found</label>
							    <%} %>
							  
							</div>
						</div>
					</div>
					
				<%} %>
				
				
					
					
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">

function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 

$('.edititemsdd').select2();
$('.items').select2();
</script>

<script type="text/javascript">
function appendrev(frmid){
	 
	      $("<input />").attr("type", "hidden")
	          .attr("name", "rev")
	          .attr("value", "1")
	          .appendTo('#'+frmid);
	     if(confirm('Are You Sure To Revise?')){
	    	 $('#'+frmid).submit();
	     }
	      
	      
	 	
	}
</script>


<!-- <script type="text/javascript">

$('.edititemsdd').select2();
$('.items').select2();
$("table").on('click','.tr_clone_addbtn' ,function() {
   $('.items').select2("destroy");        
   var $tr = $('.tr_clone').last('.tr_clone');
   var $clone = $tr.clone();
   $tr.after($clone);
   $('.items').select2();
   $clone.find('.items' ).select2('val', '');    
   $clone.find("input").val("").end();
   /* $clone.find("input:number").val("").end();
   	  $clone.find("input:file").val("").end() 
   */  
});
</script>
	 -->


<!-- <script type="text/javascript">

		var coll = document.getElementsByClassName("collapsiblediv");
		var i;
		
		for (i = 0; i < coll.length; i++) {
		  coll[i].addEventListener("click", function() {
		    this.classList.toggle("activea");
		    var content = this.nextElementSibling;
		    if (content.style.display === "block") {
		      content.style.display = "none";
		    } else {
		      content.style.display = "block";
		    }
		  });
		}
		
		

</script> -->


</body>
</html>