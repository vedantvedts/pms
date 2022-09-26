<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>	
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title>PFMS</title>
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
    	
    	font-size: 12px;
    }
    
 label{
 	font-size: 15px !important;
 }
 
 td
{
    text-align: center; 
    vertical-align: middle;
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

.caret::before {
  content: "  \25B7";
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


.nested {
  display: none;
}

.active {
  display: block;
}
</style>
<!-- ---------------- tree ----------------- -->
<!-- -------------- model  tree   ------------------- -->
<style>

.caret-1 {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret-last-1 {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}


.caret-last-1::before {
  content: "\25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-1::before {
  content: "  \25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down-1::before {
  content: "\25B6  ";
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.nested-1 {
  display: none;
}

.active-1 {
  display: block;
}
</style>
<!-- ---------------- model tree ----------------- -->

</head>
<body>


<%

List<Object[]> ProjectList=(List<Object[]>) request.getAttribute("ProjectList");
String projectid = (String) request.getAttribute("projectid");
List<Object[]> filerepmasterlistall=(List<Object[]>) request.getAttribute("filerepmasterlistall");



String systemids = (String)request.getAttribute("systemids");
String docids = (String)request.getAttribute("docids");

String projectname="";
%>




<%
String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>
	</div>
<%} %>

<div class="container-fluid"> 
	<div class="row">
		<div class="col-md-12">	
			<div class="card shadow-nohover" style="min-height: 34rem;">
			<form  method="post" action="ProjectSystems.htm" id="myform">	
				<div class="card-header">
						<div class="row">
								<div class="col-md-6">
									<h3 class="control-label" >Documents</h3>
								</div>
								<div class="col-md-6">
									<table style="float: right;">
										<tr>
											<td><label class="control-label">Project :&nbsp;&nbsp; </label></td>
									    	<td>
									    		<select class="form-control selectdee" id="ProjectId" required="required"  name="projectid" onchange="$('#myform').submit();">
										    		<option disabled="disabled"   value="">Choose...</option>
										    		<option value="0"  <%if(projectid.equalsIgnoreCase("0")){ projectname="General"; %>selected="selected" <%} %>>General</option>
										    			<% for (Object[] obj : ProjectList) {%>
															<option value="<%=obj[0]%>"  <%if(projectid.equalsIgnoreCase(obj[0].toString())){ projectname=obj[4].toString(); %>selected="selected" <%} %>> <%=obj[4]%>  </option>
														<%} %>
									  			</select>
									  			<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
									  		</td>
									  	</tr>
									</table>
								</div>
						</div>
					</div>
				</form>
		



				<div class="card-body"> 
					<div class="row">
<!-- --------------------------------------------left page ----------------------------------------------------->
					<div class="col-md-5" >		
<!-- -------------------------------- tree ----------------------------- -->
						<div class="row" style="height: 28rem; overflow-y:auto;verflow-x:auto; ">		
							<ul>	
							<%for(Object[] obj :filerepmasterlistall)
							{ 
								if(Long.parseLong(obj[1].toString())==0)
								{ %>  
								<li>
									<span class="caret" id="system<%=obj[0]%>" onclick="doclist('<%=obj[0]%>','<%=obj[3] %>','-','','-','','-','','-','',0,this)" >
					             		<%=obj[3] %>
					             	</span>
					             	<span>
							            <%-- <button type="button" class="btn"  style="background-color: transparent;margin: -5px 0px" onclick="batchdownload('<%=obj[0]%>')">                                     
											<i class="fa fa-download" aria-hidden="true"></i>
										</button> --%>
					             	</span>
									<ul  class="nested">
										<li>
						<!-- ----------------------------------------level 1------------------------------------- -->	
											<%for(Object[] obj1 :filerepmasterlistall)
											{ 
												if(Long.parseLong(obj1[1].toString())==Long.parseLong(obj[0].toString()))
												{%>  
												<li>
													<span class="caret" id="system<%=obj1[0]%>" onclick="doclist('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','-','','-','','-','',1,this)" >
					             						<%=obj1[3] %>
					             					</span>
													<span>
														<button type="button" id="upbutton<%=obj1[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','-','','-','','-','',1)">
							             					<i class="fa fa-plus" style="color: #007bff" aria-hidden="true"></i>
							             				</button>
							             				<%-- <button type="button" class="btn"  style="background-color: transparent;margin: -5px -10px" onclick="batchdownload('<%=obj1[0]%>')">                                     
															<i class="fa fa-download" aria-hidden="true"></i>
														</button> --%>
					             					</span>
													<ul  class="nested">
														<li>
										<!-- ----------------------------------------level 2------------------------------------- -->	
																<%for(Object[] obj2 :filerepmasterlistall)
																{ 
																	if(Long.parseLong(obj2[1].toString())==Long.parseLong(obj1[0].toString()))
																	{ %>  
																	<li>
																		<span class="caret" id="system<%=obj2[0]%>" onclick="doclist('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','-','','-','',2,this)" >
																			<%=obj2[3] %>
																		</span>
																		<span>
																			<button type="button" id="upbutton<%=obj2[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','-','','-','',2)">
											             						<i class="fa fa-plus" style="color: #007bff" aria-hidden="true"></i>
											             					</button>
											             					<%-- <button type="button" class="btn"  style="background-color: transparent;margin: -5px -10px" onclick="batchdownload('<%=obj2[0]%>')">                                     
																				<i class="fa fa-download" aria-hidden="true"></i>
																			</button> --%>
											             					
									             						</span>
																		<ul  class="nested">
																			<li>
															<!-- ----------------------------------------level 3------------------------------------- -->	
																					<%for(Object[] obj3 :filerepmasterlistall)
																					{ 
																						if(Long.parseLong(obj3[1].toString())==Long.parseLong(obj2[0].toString()))
																						{%>  
																						<li>
																							<span class="caret" id="system<%=obj3[0]%>" onclick="doclist('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','<%=obj3[0]%>','<%=obj3[3] %>','-','',3,this)" >
																								<%=obj3[3] %>
																							</span>
																							<span>
																								<button type="button" id="upbutton<%=obj3[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','<%=obj3[0]%>','<%=obj3[3] %>','-','',3)">
																             						<i class="fa fa-plus" style="color: #007bff;" aria-hidden="true" ></i>
																             					</button>
																             					<%-- <button type="button" class="btn"  style="background-color: transparent;margin: -5px -10px" onclick="batchdownload('<%=obj3[0]%>')">                                     
																									<i class="fa fa-download" aria-hidden="true"></i>
																								</button> --%>
														             						</span>
																							<ul  class="nested">
																								<li>
																				<!-- ----------------------------------------level 4------------------------------------- -->	
																									<%for(Object[] obj4 :filerepmasterlistall)
																									{ 
																										if(Long.parseLong(obj4[1].toString())==Long.parseLong(obj3[0].toString()))
																										{%>  
																										<li>
																											
																												<span class="caret-last"  id="system<%=obj4[0]%>" onclick="doclist('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','<%=obj3[0]%>','<%=obj3[3] %>','<%=obj4[0]%>','<%=obj4[3] %>',4,this)">
																													<%=obj4[3] %>
																												</span>
																												<span> 
																													<button type="button" id="upbutton<%=obj4[0]%>" class="btn" data-target="#exampleModalCenter" style="background-color: transparent;margin: -5px 0px;" onclick="modalbox('<%=obj[0]%>','<%=obj[3] %>','<%=obj1[0]%>','<%=obj1[3] %>','<%=obj2[0]%>','<%=obj2[3] %>','<%=obj3[0]%>','<%=obj3[3] %>','<%=obj4[0]%>','<%=obj4[3] %>',4)">
																					             						<i class="fa fa-plus" style="color: #007bff" aria-hidden="true"></i>
																					             					</button>
																					             					
																					             					<%-- <button type="button" class="btn"  style="background-color: transparent;margin: -5px -10px" onclick="batchdownload('<%=obj4[0]%>')">                                     
																														<i class="fa fa-download" aria-hidden="true"></i>
																													</button>  --%>
																					             					
																			             						</span>
																											
																										</li>	
																									<%}
																									} %>			
																							
																				<!-- ----------------------------------------level 4------------------------------------- -->
																								</li>
																							</ul>
																						</li>	
																					<%}
																					} %>	
																		
															<!-- ----------------------------------------level 3------------------------------------- -->
																			</li>
																		</ul>
																	</li>	
																<%}
																} %>		
													
										<!-- ----------------------------------------level 2------------------------------------- -->
														</li>
													</ul>
												</li>	
											<%}
											} %>
									
						<!-- ----------------------------------------level 1------------------------------------- -->
										</li>
									</ul>
								</li>	
							<%}
							} %>
							</ul>							
						</div>
<!-- -------------------------------- tree end ----------------------------- -->				
					</div>
<!-- ------------------------------------------left page end --------------------------------------------- -->	



						<div class="col-md-7 border" >
							<div  style="font-size: 17px;padding-top :10px !important;padding-bottom: 25px !important ;" align="center">
								<span id="tablehead" style="display:inline;color: black;font-style: italic;"></span>
							</div>
							<div style="overflow-y: auto;width: 100%; max-height: 35rem;"  >
								<div class="table-responsive " >
				   					<table class="table table-bordered " style="width: 100%;"  id="MyTable1" > 
										<thead>
											<tr>
												<th style="width: 4%;text-align: center;" >SN</th>
												<th style="width: 10%;text-align: center;">DocId</th>
												<th style="width: 60%;text-align: center;">Name</th>
												<th style="width: 15%;text-align: center;" >UpdateOn</th>
												<th style="width: 5%;text-align: center;" >Ver</th>
												<th><i class="fa fa-download" aria-hidden="true"></th>
												<th><i class="fa fa-history" aria-hidden="true"></th>	
											</tr>
										</thead>
										<tbody id="flisttbody">
										
										</tbody>
									</table>		
								</div>	
							</div>			
						</div>	
					</div> 
				</div> 
			</div>
		</div>
	</div>
</div>			

<!-- --------------------------------- Modal Start ---------------------------------------------- -->
	
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 1000px !important">
					<div class="modal-content">
						<div class="modal-header" style="background-color: rgba(0,0,0,.03);">
							<h4 class="modal-title" id="exampleModalLongTitle" style="color: #145374">Document History</h4>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
					          <span aria-hidden="true">&times;</span>
					        </button>
						</div>
						<div class="modal-body"  style="padding: 0.5rem !important">
							<div class="card shadow-nohover">
								<div class="card-body">
									<h5 style="display:inline;color: black;font-style: italic;" align="center">
										<span id="modelhead"></span>
									</h5>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">	
									<div class="card shadow-nohover">
										<div class="card-body"> 
											<table class="table table-bordered " style="width: 100%;"  id="MyTable" > 
												<thead>
													<tr>
														<th>SN</th>
														<th>DocId</th>
														<th>Doc Name</th>
														<th>Updated Date</th>
														<th>Version</th>
														<th>Download</th>
													</tr>
												</thead>
												<tbody id="fhislisttbody">
												
												</tbody>
											</table>
										</div> 
									</div> <!-- card end -->
								</div>
							</div> 
						</div>
					</div>
					
				</div>
			</div>
			
<!-----------------------------------------------Modal End ----------------------------------------  -->
<!-- --------------------------------------------  model start  -------------------------------------------------------- -->	

		<div class="modal fade" id="exampleModalCenter1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 93% !important;">
		
				<div class="modal-content" >
					   
				    <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				      
				    	<h4 class="modal-title" id="model-card-header" style="color: #145374"></h4>
	
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
				          <span aria-hidden="true">&times;</span>
				        </button>
				        				        
				    </div>
					<div class="modal-body"  style="padding: 0.5rem !important;">
							
							<div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
				
								<div class="row">
										<div class="col-md-8">
											<div style="margin-top: 5px;" id="fileuploadlist">
							
											</div>
										</div>
										<div class="col-md-4">
											
										</div>
				             		</div>					
							</div>
						
					</div>
				</div>
			</div> 
		</div>
	
					
<form method="post" action="DocumentTempContent.htm" id="form1">
	<input type="hidden" name="projectid" value="<%=projectid %>" />
	
	<input type="hidden" name="filerepmasterid" id="f1-filerepmasterid" value="" />
	<input type="hidden" name="fileuploadmasterid" id="f1-fileuploadmasterid" value="" />
	
	<input type="hidden" name="systemids" id="f1-systemids" value="" />
	<input type="hidden" name="docids" id="f1-docids" value="" />
	
	<input type="hidden" name="headertext1" id="f1-headertext1" value="" />
	<input type="hidden" name="headertext2" id="f1-headertext2" value="" />
	
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
	
</form>
	<input type="hidden" name="projectname" id="projectname" value="<%=projectname %>" />
	



<!-- --------------------------------------------  model end  -------------------------------------------------------- -->
<script type="text/javascript">


function showuploadbox(a,b,c,docl3,docl1,docl2,fileuploadmasterid)
{
	console.log(a,b,c,docl3,docl1,docl2);
	$('#f1-docids').val(docl1+'-'+docl2+'-'+docl3 );
	$('#f1-fileuploadmasterid').val(fileuploadmasterid );	
	$('#f1-headertext2').val( c	);  /* a+'  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+b+'  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+ */
	
	$('#form1').submit();  
}

function doclist(mid,mname,l1,lname1,l2,lname2,l3,lname3,l4,lname4,lev,ele){
	elements = document.getElementsByClassName('caret');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
    elements = document.getElementsByClassName('caret-last');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
$(ele).css("color", "green");
$(ele).css("font-weight", "700");
}
</script>




<!-- ------------------------------------------------- basic script ---------------------------------------------------------------  -->
 <script type="text/javascript">

$(document).ready(function(){

	var toggler = document.getElementsByClassName("caret");
	var i;
	for (i = 0; i <toggler.length; i++) {
	  toggler[i].addEventListener("click", function() {	
		this.parentElement.querySelector(".nested").classList.toggle("active");   
	    this.classList.toggle("caret-down");
	  });
	}


	$('#tablehead').html($('#projectname').val());
	
	  $("#MyTable1").DataTable({		 
		 "lengthMenu": [5,10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 5,
		 "language": {
		      "emptyTable": "Files not Found"
		    }
	});
	  
}); 




$('input:radio[name="isnewver"]').change(function(){	
    if($(this).val() == 'Y'){
    	var ver=Number($('#Ver').val())+1;
    	$('#submitversion').val("Upload Version "+ver+'.0');
    }
    if($(this).val() == 'N'){
    	var ver=Number($('#Ver').val());
    	var rel=Number($('#Ver').val());
    	$('#submitversion').val("Upload Version "+ver+'.'+rel);
    }
});


function onclickchange(ele)
{
	elements = document.getElementsByClassName('caret-1');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
    elements = document.getElementsByClassName('caret-last-1');
    for (var i1 = 0; i1 < elements.length; i1++) {
    	$(elements[i1]).css("color", "black");
    	$(elements[i1]).css("font-weight", "");
    }
$(ele).css("color", "green");
$(ele).css("font-weight", "700");

}




function setmodelheader(m,l1,l2,l3,l4,lev,project,divid){
	
	var modelhead=project+'  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+m;
	
	if(lev>=1)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l1;
	}
	if(lev>=2)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l2;
	}
	if(lev>=3)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l3;
	}
	if(lev>=4)
	{
		modelhead +='  <i class="fa fa-long-arrow-right" aria-hidden="true"></i>  '+l4;
	}
	$('#'+divid).html(modelhead);
	$('#f1-headertext1').val(modelhead);
}

</script>
<!-- ------------------------------------------------- basic script ---------------------------------------------------------------  -->
	
<!-- ------------------------------------------------- modal box -------------------------------------------------------------------  -->
<script type="text/javascript">
<%-- var $docids=<%=docids%>;

var $docl1=$docids.split('-')[0];
var $docl2=$docids.split('-')[1];
var $docl3=$docids.split('-')[2]; --%>

function sysidslist(mid,mname,l1,lname1,l2,lname2,l3,lname3,l4,lname4,lev)
{
	var sysids=lev+'-'+mid;
	
	if(lev>=1)
	{
		sysids += '-'+l1;
	}
	if(lev>=2)
	{
		sysids += '-'+l2;
	}
	if(lev>=3)
	{
		sysids += '-'+l3;
	}
	if(lev>=4)
	{
		sysids += '-'+l4;
	}
	return sysids;
	
}

function modalbox(mid,mname,l1,lname1,l2,lname2,l3,lname3,l4,lname4,lev)
{
	
	var $projectid=$('#ProjectId').val();		
	$('#f1-systemids').val(  sysidslist(mid,mname,l1,lname1,l2,lname2,l3,lname3,l4,lname4,lev)  );
	setmodelheader(mname,lname1,lname2,lname3,lname4,lev,$('#projectname').val(),'model-card-header');		
	
	if(lev===1)
	{
		$('#f1-filerepmasterid').val(l1);
	}
	if(lev===2)
	{
		$('#f1-filerepmasterid').val(l2);
	}
	if(lev===3)
	{
		$('#f1-filerepmasterid').val(l3);
	}
	if(lev===4)
	{
		$('#f1-filerepmasterid').val(l4);
	}
	sysidslist
	
	$.ajax({
			type : "GET",
			url : "ProjectDocsListAjax.htm",
			data : {
				projectid : $projectid,
							
			},
			datatype: 'json',
			success : function(result)
				{
					var result= JSON.parse(result);
					var values= Object.keys(result).map(function(e){
					return result[e];
				})			
					
				
				/* --------------------------------------------ajax nested--------------------------------------- */		
						
						 $.ajax({
								type : "GET",
								url : "FileDocMasterListAll.htm",
								data : {
									projectid : $projectid,		
								},
								datatype: 'json',
								success : function(result1)
										{
											var result1= JSON.parse(result1);
											var values1= Object.keys(result1).map(function(e){
												return result1[e];
											})
													
											var values2=values1;
											/* --------------------------------------------------tree making--------------------------------------------------------- */			
												var str='<ul>';
												for(var v1=0;v1<values1.length;v1++)
												{ 
													if(values1[v1][2]===1)
													{  
														str +='<li> <span class="caret-1" id="docsysl1'+values1[v1][0]+'" onclick="onclickchange(this);" >'+values1[v1][3] +'</span> <ul  class="nested-1"> <li>'; 
												 /* ----------------------------------------level 1------------------------------------- */	
															for(var v2=0;v2<values2.length;v2++)
															{ 
																if(values1[v2][2]===2 && values2[v2][1]==values1[v1][0] )
																{  
																	str += '<li> <span class="caret-1" id="docsysl2'+values2[v2][0]+'" onclick="onclickchange(this);" >' +values2[v2][3]+'</span> <ul  class="nested-1"> <li>'; 
															/* ----------------------------------------level 2------------------------------------- */
																		
																		for(var v3=0;v3<values.length;v3++)
																		{ 
																			if(  values[v3][1]==values2[v2][0])
																			{
																				str +='<li> <span class="caret-last-1" id="docsysl3'+values[v3][0]+'" onclick="onclickchange(this);">'+values[v3][2]+'('+values[v3][3]+')</span>';
																					
																				str +='<span><button type="button" class="btn"  style="background-color: transparent;margin: -3px 0px;" onclick="showuploadbox(\''+values1[v1][3]+'\',\''+values2[v2][3]+'\',\''+values[v3][2]+'\',\''+values[v3][0]+'\',\''+values1[v1][0]+'\',\''+values2[v2][0] +'\',\''+values[v3][0] +'\')" >';
																				
																				str +=		'<i class="fa fa-eye" style="color: #007bff" aria-hidden="true"></i>';
																				str +=		'</button>';		
																				str +='	</span> </li>';
																					
																			}
																		}										
																		
															/* ----------------------------------------level 2------------------------------------- */			
																	str +=	'</li> </ul> </li>';
																}
															} 
														
											 	/* ----------------------------------------level 1------------------------------------- */
																		
														str +='</li> 	</ul> 	</li>';	
													} 
												} 
											/* --------------------------------------------------tree making--------------------------------------------------------- */
												str += '</ul>';
												
												$('#fileuploadlist').html(str);
												
												var toggler = document.getElementsByClassName("caret-1");
												$('#s1').val(l1);
												$('#s2').val(l2);
												$('#s3').val(l3);
												$('#s4').val(l4);
												$('#mainsystemval').val(mid);
												$('#sublevel').val(lev);
												$('#Path').val(mname+'/'+lname1);
												
												var i;
												for (i = 0; i <toggler.length; i++) {
												  toggler[i].addEventListener("click", function() {	
													this.parentElement.querySelector(".nested-1").classList.toggle("active-1");   
												    this.classList.toggle("caret-down-1");
												  });
												}
												$('#exampleModalCenter1').modal('show');
												/* 	
												console.log($docl1,$docl2,$docl3);
												if($docl1>0)
												{
													$('#docsysl1'+$docl1).click();
												}
												if($docl2>0)
												{
													$('#docsysl2'+$docl2).click();
												}
												if($docl3>0)
												{
													$('#docsysl3'+$docl3).click();
													 $('#docsysl3'+$docl3).css("font-weight", "700"); 
												}
												
												$docl1=0;
												$docl2=0;
												$docl3=0;
														 */
												
										},
										error: function(XMLHttpRequest, textStatus, errorThrown) {
											alert("Internal Error Occured !!");
								            alert("Status: " + textStatus);
								            alert("Error: " + errorThrown); 
								        }  
										
						 		})
						 
					/* --------------------------------------------ajax nested--------------------------------------- */
					
				
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				alert("Internal Error Occured !!");
	            alert("Status: " + textStatus);
	            alert("Error: " + errorThrown); 
	        }  
	 })
			
}

</script>
<!-- ------------------------------------------------- modal box ---------------------------------------------------------------  -->
 
<%if(systemids!=null){ %>
<script type="text/javascript">
$(document).ready(
	function (){
		
		var systemids ='<%=systemids%>';	
		var level=Number(systemids.split('-')[0])+1;
		
		for(var i=1;i<=level;i++)
		{
			if(i<level){
				$('#system'+systemids.split('-')[i]).click();
			}else if(i===level){
				$('#upbutton'+systemids.split('-')[i]).click();
				
			}			
		} 
	}	
);

</script>
<%} %>
 
 

</body>
</html>	