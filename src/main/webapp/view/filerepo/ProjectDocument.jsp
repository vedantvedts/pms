<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
	
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">


<jsp:include page="../static/header.jsp"></jsp:include>


<style>

.control-label{
	font-weight: bold !important;
}


.table thead th{
	
	vertical-align: middle !important;
}

.header{
        position:sticky;
        top: 0 ;
        background-color: #346691;
    }
    
    .table button{
    	background-color: background !important;
    	font-size: 12px;
    }
    
.col-form-label{
	font-weight: 600!important;
	
}
 
.title ul {
    -moz-column-count: 3;
    -moz-column-gap: 10px;
    -webkit-column-count: 3;
    -webkit-column-gap: 10px;
    column-count: 3;
    column-gap: 10px;
}
 
 .fa-upload{
 	color:#007bff;
 }
 
.documenttitle label{
	font-size: 15px;
	font-family: 'Lato',sans-serif;
}

.fa-file-text{
	color:green;
}

.version{
	color:#145374;
	font-size: 14px;
    font-weight: 600;
    font-family: 'Muli';

}

.noselect {
  -webkit-touch-callout: none; /* iOS Safari */
    -webkit-user-select: none; /* Safari */
     -khtml-user-select: none; /* Konqueror HTML */
       -moz-user-select: none; /* Firefox */
        -ms-user-select: none; /* Internet Explorer/Edge */
            user-select: none; /* Non-prefixed version, currently
                                  supported by Chrome and Opera */
}

 
</style>
<!-- --------------  tree   ------------------- -->
<style>
ul, #myUL {
  list-style-type: none;
}

#myUL {
  margin: 0;
  padding: 0;
}

.caret {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret-last {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}


.caret-last::before {
  content: "\25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret::before {
  content: "\25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down::before {
  content: "\25B6  ";
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.nested {
  display: none;
}

.active {
  display: block;
}
</style>

<!-- ---------------- tree ----------------- -->

</head>
<body style="background-color: #e2ebf0" >

<%

List<Object[]> DocumentTypeList=(List<Object[]>) request.getAttribute("DocumentTypeList");
String projectid = (String) request.getAttribute("projectid");
List<Object[]> projectlist=(List<Object[]>) request.getAttribute("projectslist");
String projectname="";

%>

<%String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>


	<center>
	
		<div class="alert alert-danger" role="alert">
		
			<%=ses1 %>
		</div>
	</center>
	<%}if(ses!=null){ %>
	<center>
		<div class="alert alert-success" role="alert">
		
			<%=ses %>
		</div>

	</center>
	<%} %>


<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">	
			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row">
						<div class="col-md-6">
							<h4 class="control-label" >Project Documents </h4>
						</div>
						<div class="col-md-6" style="margin-top: -8px;">
							<form  method="post" action="ProjectDocumets.htm" id="myform">	
								<table style="float: right;">
									<tr>
										<td><label class="control-label">Project :&nbsp;&nbsp; </label></td>
								    	<td>
								    		<select class="form-control selectdee" id="projectid" required="required"  name="projectid" onchange="$('#myform').submit();">
									    		<option disabled="disabled"   value="">Choose...</option>
									    		<option value="0"  <%if(projectid.equalsIgnoreCase("0")){ projectname="General"; %>selected="selected" <%} %>>General</option>
									    			<% for (Object[] obj : projectlist) {
									    				String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
									    			%>
														<option value="<%=obj[0]%>"  <%if(projectid.equalsIgnoreCase(obj[0].toString())){ projectname=obj[2].toString(); %>selected="selected" <%} %>> <%=obj[4]+projectshortName%> </option>
													<%} %>
								  			</select>
								  			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
								  		</td>
								  	</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
			<!-- card header -->

				<div class="card-body" style="min-height: 31rem; "> 	
<!----------------------------------- tree Start ---------------------------------------------- -->
						<div class="row" >
							<form action="ProjectDocumetsSubmit.htm" method="post" id="prodocsadd">
								<div class="col-md-12">		
									<ul>	
									<%for(Object[] obj :DocumentTypeList)
									{ 
										if(Long.parseLong(obj[2].toString())==1)
										{%>  
										<li >
											<span class="caret"  onclick="onclickchange(this);" >
								            		<%=obj[3] %>
								            	</span>
											 <ul  class="nested">
												<li>
								<!-- ----------------------------------------level 1------------------------------------- -->	
													<%for(Object[] obj1 :DocumentTypeList)
													{ 
													if(Long.parseLong(obj1[2].toString())==2 && Long.parseLong(obj1[1].toString())==Long.parseLong(obj[0].toString()) )
													{%>  
													<li>
															<span class="caret" onclick="onclickchange(this);" >
							             						<%=obj1[3] %>
							             					</span>
															
														<ul  class="nested">
															<li>
											<!-- ----------------------------------------level 2------------------------------------- -->	
													 		<%for(Object[] obj2 :DocumentTypeList)
																{ %>
																	<%if( Long.parseLong(obj2[2].toString())==3 && Long.parseLong(obj2[1].toString())==Long.parseLong(obj1[0].toString())) 
																	/* if( Long.parseLong(stageobj2[1].toString())==Long.parseLong(obj1[0].toString())) */
																	{%>
																		<li>
																			<span>
																				<span>
																					<%if(obj2[5].equals("0")){ %>
																						<input class="checkbox" type="checkbox" id="checkbox<%=obj2[0]%>" name="documentid" value="<%=obj2[0]%>_<%=obj2[1]%>" >
																					<%}else if(obj2[5].equals("1")){ %>
																						<input class="checkbox" type="checkbox" disabled="disabled" name="documentid" value="<%=obj2[0]%>_<%=obj2[1]%>" >
																					<%} %>
																				</span><!-- 	class="caret1" onclick="onclickchange(this);" -->
																				<span class="noselect"	<%if(obj2[5].equals("0")){ %>														
																						 style= "cursor: pointer;" onclick="onclickcheck('checkbox<%=obj2[0]%>');"
																						<%}else if(obj2[5].equals("1")){ %>
																						 style="font-weight: 700; color: black; cursor: pointer;" 
																						<%} %> >
																					<%=obj2[3] %>(<%=obj2[4] %>)
																				</span>
																			</span>
																			<span>
																			
																			
																				<%-- <button type="button" class="btn"  style="background-color: transparent;margin: -5px 0px;"  >                    
																					<i class="fa fa-upload" style="color: #007bff" aria-hidden="true"></i>
																				</button>
																				<%if(stageobj2[4].toString() !="0"){ %>
																				<span class="version">Ver <%=stageobj2[8]+"."+stageobj2[6] %>
																					<button type="submit" class="btn"  style="background-color: transparent;;margin: -5px 0px;" onclick="fileunpack('<%=stageobj2[4] %>')">
																					   	<i class="fa fa-download" aria-hidden="true"></i>
																					</button>
																				</span>
																				<%} %> --%>
																			</span>
																		</li>	
																	<%}
																} %>			
											<!-- ----------------------------------------level 2------------------------------------- -->
															</li>
														</ul>
														
												<%}
												} %>
												</li>	
								<!-- ----------------------------------------level 1------------------------------------- -->
												</li>
											</ul> 
										</li>	
									<%}
									} %>
									</ul>							
								</div>
								<script type="text/javascript">
									function onclickcheck (boxid) {
										
										if ($('#'+boxid).is(':checked')) 
										{											
											$('#'+boxid).prop('checked', false); 
					                    } else {
					                    	$('#'+boxid).prop('checked', true); 
					                    }
									}
								</script>
								<div class="col-md-12" align="center" >
									<input type="hidden" name="projectid" value="<%=projectid%>">
									<button type="button" class="btn btn-primary btn-sm submit" onclick="submitaddform();">SUBMIT</button>
									<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
								</div>							
							</form>
						</div>
						<form method="POST" action="FileUnpack.htm"  id="downloadformnew" target="_blank"> 
							<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
							<input type="hidden" name="FileUploadId" id="downloadformid" value="" />
						</form>
			

			   </div> 
			   

			</div> 
			
		</div>
	</div>

	</div>
	

<script type="text/javascript">
function submitaddform()
{ var checkcount=0;
	$("#prodocsadd").find(".checkbox").each(function(){
	    if ($(this).prop('checked')==true){
	    	checkcount++;
	    }
	});
	
	console.log(checkcount);
	if(checkcount>0){
		if(confirm('Are You Sure To Add Document(s) ?'))
		{
			$('#prodocsadd').submit(); 
		}
	} else 
	{
		alert('Please Select Atleast one Document');
	}
	
}
</script>







<script type="text/javascript">

var toggler = document.getElementsByClassName("caret");
var i;
for (i = 0; i <toggler.length; i++) {
  toggler[i].addEventListener("click", function() {	
	this.parentElement.querySelector(".nested").classList.toggle("active");   
    this.classList.toggle("caret-down");
  });
}


function onclickchange(ele)
{
	elements = document.getElementsByClassName('caret');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
    elements = document.getElementsByClassName('caret1');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
$(ele).css("color", "green");
$(ele).css("font-weight", "700");

}


</script>
</body>
</html>