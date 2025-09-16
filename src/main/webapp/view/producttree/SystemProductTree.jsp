<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="java.util.stream.Collectors"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/css/producttree/SystemProductTree.css" var="systemProductTree" />
<link href="${systemProductTree}" rel="stylesheet" />

<title>Product Tree</title>
</head>
<body>
<%
List<Object[]>systemList = (List<Object[]>)request.getAttribute("systemList");
List<Object[]>ProductTreeList = (List<Object[]>)request.getAttribute("ProductTreeList");
String sid=(String)request.getAttribute("sid");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");

%>

 <form class="form-inline"  method="POST" action="SystemProductTree.htm">
  <div class="row w-100">
                                    <div class="col-md-2">
                            		<label class="control-label">System Name :</label>
                            		</div>
                            		<div class="col-md-2 mt-minus-7">
                              		<select class="form-control selectdee" id="sid" required="required" name="sid">
    									<option disabled selected value="">Choose...</option>
    										<% for (Object[] obj : systemList) {
    										
    										%>
											<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(sid)){ %>selected="selected" <%} %>> <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%>  </option>
											<%} %>
  									</select>
  									</div>
  									<div class="col-md-4 mt-minus-7 ml-75" >
  										<div align="center" class="mb-2">
	
<!-- 	<button type="button" class="btn viewbtn" id="treeViewBtn" onclick="showDiv('treeView','listView')">Tree View</button>
	<button type="button" class="btn viewbtn" id="listViewBtn" onclick="showDiv('listView','treeView')">List view</button> -->
	</div>
  	</div>
  									
<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
 <button type="submit" class="btn btn-sm" formaction="ProductreeDownload.htm" formmethod="GET">
 <i class="fa fa-download" aria-hidden="true"></i>
  </button>
 </div>

</form>
<div class="bg-white body genealogy-body genealogy-scroll">
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
	
        
        <div id="listView">
 <div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				
				<div class="card shadow-nohover" >
			
		
				<div class="row card-header">
				
			     <div class="col-md-11">
					<h5 ><%if(sid!=null){	
				        Object[] systemListDetail=systemList.stream().filter(e->e[0].toString().equalsIgnoreCase(sid)).collect(Collectors.toList()).get(0);%>  
			           <%=systemListDetail[2]!=null?StringEscapeUtils.escapeHtml4(systemListDetail[2].toString()):"-" %>(<%=systemListDetail[1]!=null?StringEscapeUtils.escapeHtml4(systemListDetail[1].toString()):"-" %>)
	                      <%} %>
					</h5>
					</div>
					<div class="col-md-1" >
					<button class="btn add mt-minus-7" onclick="EditModal('0')">ADD </button>
					</div>
				
					 </div>
				
					<div class="card-body">
                       
                       	<div class="col-md-12 mb-2 text-right">
                              	      		<span class="software"></span><span>&nbsp; Software  </span>
                              		<span class="hardware"></span><span> &nbsp;Hardware </span>
                              		<span class="firmware"></span><span> &nbsp;Firmware  </span>
                              		</div>
                       
                        <div  align="center">
									<table class="table  table-hover table-bordered w-50"  id="modal_progress_table">
													<thead>

													<tr>
														<th class="text-center">SN</th> 
														<th class="text-center">Level Name</th> 
														<th class="text-center w-20">Level Code</th> 
														<th class="text-center w-20">Level Type</th> 
														<th class="text-center w-40" >Action</th>
														</tr>
													</thead>
													<tbody>
														<% int  countx=0;
															
														 	if(ProductTreeList!=null&&ProductTreeList.size()>0){
														 		for(Object[]obj:ProductTreeList){%>
														 		<tr>
														 		<td class="text-center" ><%=++countx %>. </td>
														 		<td> <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()):"-" %></td>
														 		<td><%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()):"-" %> </td>
														 		
														 		<%if(obj[11]!=null){ %>
														 		<%if(obj[11].toString().equalsIgnoreCase("S")) {%>
														 		<td class="bg-software">Software</td>
														 		<%}else if(obj[11].toString().equalsIgnoreCase("F")) {%>
														 		<td class="bg-firmware">Firmware </td>
														 		<%}else if(obj[11].toString().equalsIgnoreCase("H")){ %>
														 		<td class="bg-hardware">Hardware</td>
														 		<%}else{ %>
														 		<td>-</td>
														 		<%} %>
														 		<%}else{ %>
														 		<td>-</td>
														 		<%} %>
														 		
														 		<td>
													<div class="div-flex">
														<button class="btn btn-sm"
															onclick="EditModal('<%=obj[0]%>','<%=obj[3]%>','<%=obj[10]%>','<%=obj[11]%>','<%=obj[12]%>')"   data-toggle="tooltip" data-placement="right"
								title="Edit">
															<img src="view/images/edit.png">
														</button>
														<div>
														<form action="SystemProductTreeEditDelete.htm"
															method="get" class="d-inline">
															<input type="hidden" name="sid" value="<%=sid%>">
															<input type="hidden" name="Action" value="TD">
															<button   class="btn btn-sm" name="Mainid"
																value="<%=obj[0]%>" data-toggle="tooltip" data-placement="right"
								title="Delete"
																onclick="return confirm ('Are you sure you want to delete? ')">
																<img src="view/images/delete.png">
															</button>
														</form>
														</div>
													</div>

												</td>
														 		</tr>
														 		<% }}else{%>
												<tr >
													<td colspan="9" class="text-center">No List Found</td>
												</tr>
												<%} %>
												
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

 <div class="modal" id="EditModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered mx-w-720" role="document" >
    <div class="modal-content">
      <div class="modal-header">
<!--         <h5 class="modal-title" id="exampleModalLongTitle">Edit Level Name</h5> -->
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" align="center">
        <form action="SystemProductTreeEditDelete.htm" method="get" id="myform">
        	<table class="w-100">
        		<tr>
        			<th>Level Name : &nbsp; </th>
        			<td><input type="text" class="form-control" name="LevelName" id="levelname" required></td>
        		</tr>
        		<tr></tr>
        		<tr>
        			<th>Level Code : &nbsp; </th>
        			<td ><input type="text" class="form-control w-50" name="LevelCode" id="levelCode" maxlength="3" required ></td>
        			
        		</tr>
        		<tr></tr>
        		<tr id="issoftwareTr">
        		<th>
        		Level Type:
        		</th>
        		<td>
        		
        		<input type="radio" name="LevelType" checked="checked" value="N">&nbsp;  Not Specified &nbsp;
        		<input type="radio" name="LevelType"  value="S">&nbsp; Software &nbsp;
        		<input type="radio" name="LevelType"  value="F"> &nbsp; Firmware &nbsp;
        		<input type="radio" name="LevelType"  value="H">  &nbsp; Hardware &nbsp;

        		</td>
        		</tr>
        		<tr>
        			<td colspan="2" class="text-center">
        				<br>
        				<button type="button" class="btn btn-sm btn-danger" data-dismiss="modal"><b>Close</b></button>
        				<button class="btn btn-sm submit" formaction="SystemProductTreeEditDelete.htm" id="editbtn"   onclick="return confirm('Are You Sure to Edit?');">SUBMIT</button>
        				<button class="btn btn-sm submit" formaction="SystemLevelNameAdd.htm" id="addbtn"   onclick="return confirm('Are You Sure to Add?');">SUBMIT</button>
        			</td>
        		</tr>
        	</table>
        	
        	<input type="hidden" id="Mainid" name="Mainid" value="" >
          <input type="hidden" id="" name="Action" value="TE" > 
          <input type="hidden" name="sid" value="<%=sid %>">
        	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
        </form>
      </div>
     
    </div>
  </div>
</div> 




<script>
$(document).ready(function() {
	   $('#sid').on('change', function() {
	     $('#submit').click();

	   });
	});
$(function () {
    $('.genealogy-tree ul').hide();
    $('.genealogy-tree>ul').show();
    $('.genealogy-tree ul.active').show();
    
    $('.genealogy-tree li .action-box-header').on('click', function (e) {
	
        
     var children = $(this).parent().parent().parent().find('> ul');
        if (children.is(":visible")) {
        	children.hide('fast').removeClass('active');
        	$(this).find('i').removeClass('fa fa-caret-down');
        	$(this).find('i').addClass('fa fa-caret-up');
        } else {
        	children.show('fast').addClass('active');
        	$(this).find('i').removeClass('fa fa-caret-up');
        	$(this).find('i').addClass('fa fa-caret-down');
    	}
        e.stopPropagation(); 
    });
});
/* showDiv('treeView','listView')
function showDiv(a,b){
	
	
	$('#'+a).show();
	$('#'+b).hide();
	
	
	$('#'+a+'Btn').css('background-color','green');
	$('#'+a+'Btn').css('color','white');
	$('#'+b+'Btn').css('background-color','grey');
	$('#'+b+'Btn').css('color','black');
	$(".genealogy-body").css("white-space", "normal");
} */

/* function ChangeButton(id) {
	  
	//console.log($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString());
	if($( "#btn"+id ).hasClass( "btn btn-sm btn-success" ).toString()=='true'){
	$( "#btn"+id ).removeClass( "btn btn-sm btn-success" ).addClass( "btn btn-sm btn-danger" );
	$( "#fa"+id ).removeClass( "fa fa-plus" ).addClass( "fa fa-minus" );
	$( ".row"+id).show();
    }else{
	$( "#btn"+id ).removeClass( "btn btn-sm btn-danger" ).addClass( "btn btn-sm btn-success" );
	$( "#fa"+id ).removeClass( "fa fa-minus" ).addClass( "fa fa-plus" );
	$( ".row"+id).hide();
    }
} */

	function EditModal(mainid,levelname,levelCode,IsSoftware,IsSoftwareMain){
	if(mainid!=='0'){
	$('#Mainid').val(mainid);			
	$('#levelname').val(levelname);
	$('#levelCode').val(levelCode);
	//console.log(mainid,levelname,levelCode,IsSoftware);

	$('input[name="LevelType"][value="' + IsSoftware + '"]').prop('checked', true).trigger('change');
  /*if(IsSoftware!=='N' && (IsSoftware===IsSoftwareMain)){
  		$('#issoftwareTr').hide();
  	}else{
  		$('#issoftwareTr').show();
  	} */
  	
  	if(IsSoftwareMain==='N'){
  		$('#issoftwareTr').show();
  	}else{
  		$('#issoftwareTr').hide();
  	}
		
  	var sid = $('#sid').val();
  $('#editbtn').show();
  $('#addbtn').hide();
	}else{
		 $('#editbtn').hide();
		  $('#addbtn').show();
		$('#levelname').val('');
		$('#levelCode').val('');
		$('input[name="LevelType"][value="N"]').prop('checked', true).trigger('change');
	}
	$('#EditModal').modal('toggle');

	
} 

$("#modal_progress_table").DataTable({
	"lengthMenu": [ 25, 50, 75, 100 ],
	"pagingType": "simple",
	"pageLength": 25
});


$(function () {
$('[data-toggle="tooltip"]').tooltip()
})



</script>
</body>
</html>