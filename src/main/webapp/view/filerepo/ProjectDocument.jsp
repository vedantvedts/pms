<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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

<spring:url value="/resources/css/fileRepo/ProjectDocument.css" var="projectDocument" />
<link href="${projectDocument}" rel="stylesheet" />
</head>
<body  >

<%

List<Object[]> DocumentTypeList=(List<Object[]>) request.getAttribute("DocumentTypeList");
String projectid = (String) request.getAttribute("projectid");
List<Object[]> projectlist=(List<Object[]>) request.getAttribute("projectslist");
String projectname="";

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
				<div class="card-header">
					<div class="row">
						<div class="col-md-6">
							<h4 class="control-label" >Project Documents </h4>
						</div>
						<div class="col-md-6 m-minus8" >
							<form  method="post" action="ProjectDocumets.htm" id="myform">	
								<table class="f-right">
									<tr>
										<td><label class="control-label">Project :&nbsp;&nbsp; </label></td>
								    	<td>
								    		<select class="form-control selectdee" id="projectid" required="required"  name="projectid" onchange="$('#myform').submit();">
									    		<option disabled="disabled"   value="">Choose...</option>
									    		<option value="0"  <%if(projectid.equalsIgnoreCase("0")){ projectname="General"; %>selected="selected" <%} %>>General</option>
									    			<% for (Object[] obj : projectlist) {
									    				String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
									    			%>
														<option value="<%=obj[0]%>"  <%if(projectid.equalsIgnoreCase(obj[0].toString())){ projectname=obj[2].toString(); %>selected="selected" <%} %>> <%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%> <%=projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName): " - "%> </option>
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

				<div class="card-body min-height"> 	
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
								            		<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %>
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
							             						<%=obj1[3]!=null?StringEscapeUtils.escapeHtml4(obj1[3].toString()): " - " %>
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
																					<%if(Integer.parseInt(obj2[5].toString())==0){ %>
																						<input class="checkbox" type="checkbox" id="checkbox<%=obj2[0]%>" name="documentid" value="<%=obj2[0]%>_<%=obj2[1]%>" >
																					<%}else if(Integer.parseInt(obj2[5].toString())==1){ %>
																						<input class="checkbox" type="checkbox" disabled="disabled" name="documentid" value="<%=obj2[0]%>_<%=obj2[1]%>" >
																					<%} %>
																				</span><!-- 	class="caret1" onclick="onclickchange(this);" -->
																				<span <%if(Integer.parseInt(obj2[5].toString())==0){ %>														
																						class="noselect cursor"  onclick="onclickcheck('checkbox<%=obj2[0]%>');"
																						<%}else if(Integer.parseInt(obj2[5].toString())==1){ %>
																						class="noselect cursor font-color" 
																						<%}else { %>class="noselect cursor"<%} %> >
																					<%=obj2[3]!=null?StringEscapeUtils.escapeHtml4(obj2[3].toString()): " - " %>(<%=obj2[4]!=null?StringEscapeUtils.escapeHtml4(obj2[4].toString()): " - " %>)
																				</span>
																			</span>
																			<span>
																			<!-- prakarsh -------------------------------------------------------->
																			<%if(Integer.parseInt(obj2[5].toString())==1){ %>
																	 	<button name="FileParentId"   type="button" id="activeButton"   class="btnx btn-fileparentid" formaction="IsActive.htm" value="<%=obj2[0]%>_<%=obj2[1]%>_<%=projectid%>">
																	 	   <i class="fa fa-times" aria-hidden="true"></i></button> 
																	 	<input type="hidden" name="projectid" value="<%=projectid%>">
																	<%} %>
																			
																				
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
/* prakarsh ------------------------------------------------------------------------------------------------------*/

$('.btnx').click(function () {
        	
        	  var $FileParentId = $(this).val();
	       
         $.ajax({
                url: 'IsActive1.htm', 
                type:'GET',
                data:{
                	FileParentId:$FileParentId,
                	Project:<%=projectid%>
                	
                },
                datatype : 'json',
               success: function (result) {
            	   var FileRepUploadId = JSON.parse(result);
            	   
                  if (FileRepUploadId.length > 0) {
                    	
                        if (confirm('Some documents is linked with this are you sure to delete?')) {
                        
                        	$.ajax({
                                url: 'IsActive.htm', 
                                type:'GET',
                                data:{
                                	FileParentId:$FileParentId,
                                	Project:<%=projectid%>,
                                	Flag:'A'
                                	
                                },
                                datatype : 'json',
                                success: function (result) {
                                	var r = JSON.parse(result);
                                	if(r==1){
                                		alert("deleted successfully");
                                		 window.location.reload();
                                	}
                                }
                               
                        	})
                        }
                    } else {
                    	if(confirm('Are you sure to delete?')){
                    			$.ajax({
                                url: 'IsActive.htm', 
                                type:'GET',
                                data:{
                                	FileParentId:$FileParentId,
                                	Project:<%=projectid%>,
                                	Flag:'B'
                                	
                                },
                                datatype : 'json',
                                success: function (result) {
                                	var r = JSON.parse(result);
                                	if(r==1){
                                		alert("deleted successfully");
                                		 window.location.reload();
                                	}
                                }
                        	})
                    	}
                    }
                },
                error: function () {
                    
                    console.error('Error occurred during AJAX call');
                }
            });
        });


</script>
</body>
</html>