<%@page import="java.util.stream.Collectors"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@ page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.text.ParseException,java.math.BigInteger"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.vts.pfms.master.dto.ProjectSanctionDetailsMaster"%>
<%@page import="com.vts.pfms.IndianRupeeFormat" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<style type="text/css">
input[type=checkbox] {
	accent-color: green;
}
</style>
</head>

<%
List<Object[]>ProjectList = (List<Object[]>)request.getAttribute("ProjectList"); 
List<Object[]>DashBoardsList = (List<Object[]>)request.getAttribute("DashBoardsList"); 
String DashBoardId = (String) session.getAttribute("DashBoardId");
ObjectMapper objectMapper = new ObjectMapper();
String DashBoardsListArray = objectMapper.writeValueAsString(DashBoardsList);
List<Object[]>MainProjectList = new ArrayList<>(); 
List<Object[]>subProjectList = new ArrayList<>(); 
if(ProjectList!=null && ProjectList.size()>0){
	MainProjectList = ProjectList.stream().filter(e -> e[22].toString().equalsIgnoreCase("1")).collect(Collectors.toList());
	subProjectList = ProjectList.stream().filter(e -> e[22].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
}

%>
<!-- Modal -->

<div class="modal fade bd-example-modal-lg" id="DashboardProjectModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document" style="max-width: 1440px;">
    <div class="modal-content">
      <div class="modal-header bg-primary text-light">
        <h5 class="modal-title" id="exampleModalLabel">Dashboard Projects</h5>
        <button type="button" class="close" style="text-shadow: none!important" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" style="color:red;">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <hr>
      <div class="row ml-2 mt-2 mb-2"> 
      
      <div class="col-md-2" style="font-size: 1.2 rem;">Favourites</div>
      <div class="col-md-3">
      <select class="form-control" id="favs" name="favs" >
      <option disabled="disabled" selected="selected">SELECT</option>
      <option value="-1" <%if(DashBoardId!=null && DashBoardId.equalsIgnoreCase("0")) {%> selected <%} %>>Default</option>
      <%if(DashBoardsList!=null && DashBoardsList.size()>0) {
      for(Object[]obj:DashBoardsList){
      %>
      <option value="<%=obj[0].toString()%>" <%if(DashBoardId!=null && obj[0].toString().equalsIgnoreCase(DashBoardId)) {%> selected <%} %>><%=obj[1].toString() %></option>
      <%}} %>
      <option value="0">Add Favourites</option>
      </select>
      </div>
      <div class="col-md-5" id="addFavDiv" style="display: none;">
      Favourite Name : <input id="addFav" class="form-control" style="width:60%;display: inline" maxlength="200" placeholder="max 255 character">
      </div>
      </div>
      
      <hr>
      <% if(MainProjectList!=null && MainProjectList.size()>0){%>
      <div class="row ml-2 mb-3 mt-2" >
      Main projects : <input id="mainProject" style="transform:scale(1.5)" type="checkbox"  > 
      </div>
      <%} %>
      <div class="row" style="">
      <% 
      if(MainProjectList!=null && MainProjectList.size()>0){
      for(Object[]obj:MainProjectList) {%>
      <div class="col-md-2 ml-4 mt-3">
      <input class="mainProject" type="checkbox" name="projectId" style="transform:scale(1.5)" value="<%=obj[0].toString()%>"> <span ><%=obj[4].toString() %>&nbsp;/&nbsp;<%=obj[17].toString() %></span>
      </div>
       <%}} %>
       </div> 
        <hr class="mt-2">
       <%if(subProjectList!=null && subProjectList.size()>0){ %>
      <div class="row ml-2 mb-3 mt-2" >
     		 Sub projects :       <input id="subProject" style="transform:scale(1.5)" type="checkbox"  > 
     		 
      </div>
      <%} %>
      <div class="row" style="">
      <%if(subProjectList!=null && subProjectList.size()>0){
      for(Object[]obj:subProjectList) {%>
       <div class="col-md-2 ml-4 mt-3" >
       <input class="subProject" style="transform:scale(1.5)" type="checkbox" name="projectId" value="<%=obj[0].toString()%>"> <%=obj[4].toString() %>&nbsp;/&nbsp;<%=obj[17].toString() %>
      </div>
      <%}} %>
      </div>
      
     
          <div class="mt-3 mb-3" align="center" id="addDiv" style="display: none;">
        	<form action="DashboardFavAdd.htm" method="post">
        	<input type="hidden" name="addFav" id="addFavvalue">
        	<input type="hidden" name="projects" id="projects">
        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
        	<button type="submit" class="btn btn-sm submit" onclick="return DashFavAdd()">SUBMIT</button>
        	<button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">CLOSE</button>
        	</form>
        
      </div>
      
      	<div class="mt-3 mb-3" align="center" id="updateDiv" style="display: none;">
        	<form action="UpdateDashboardFav.htm" method="post">
        	<input type="hidden" name="dashboardId" id="dashboardId" value="">
        	<input type="hidden" name="favProjects" id="favProjects" value="">
        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
        	<button type="submit" class="btn btn-sm edit" onclick="return updateDashBoard()">UPDATE</button>
        <button type="button" class="btn btn-sm btn-secondary" data-dismiss="modal">CLOSE</button>
        	</form>
      </div>
       
      </div>
 
     
    </div>
  </div>
</div>

<script type="text/javascript">
$( document ).ready(function() {
	$("#favs").change();
});



$("#favs").change(function(){
	 var value = $('#favs').val();
	 $("input:checkbox[name=projectId]").prop('checked',false);
	 $('input:checkbox#mainProject').prop('checked', false);
	 $('input:checkbox#subProject').prop('checked', false);
	$('#dashboardId').val(value);
	 if(value==0){
		
		 $('#addFavDiv').show();
		 $('#addDiv').show();
		 $('#updateDiv').hide();
		 $('input:checkbox#mainProject').prop('checked', true);
		    $('input:checkbox#subProject').prop('checked', true);
		 $("input:checkbox[name=projectId]").prop('checked',true);
	 }else{
		 
		 $('#addFavDiv').hide();
		 $('#addDiv').hide();
		 $('#updateDiv').show();
		 $('#projects').val('');
		 
		 if(value==-1){
			 $('input:checkbox#mainProject').prop('checked', true);
			    $('input:checkbox#subProject').prop('checked', true);
				$("input:checkbox[name=projectId]").prop('checked',true);
		 }else{
			 var valuesToMatch = [];
			 $.ajax({
				 type:'GET',
				 url:'getDashBoardProjects.htm',
				 datatype:'json',
				 data:{
					 DashBoardId:value,
				 },
			 success:function(result){
				 var valuesToMatch = JSON.parse(result);
				 /* for(var i=0;i<ajaxresult.length;i++){
					 valuesToMatch.push(ajaxresult[i][2]+"");
				 } */
			
				 $('#favProjects').val(valuesToMatch);
				 $.each(valuesToMatch, function(index, value) {
					    $('input:checkbox[name="projectId"][value="' + value + '"]').prop('checked', true);
					});
			 }
			 });
		
			 
		 }
		 
		 
		 
	 }
	 
	 
	});

var DashBoardsList= '<%=DashBoardsListArray%>';
var DashBoardsListArray = JSON.parse(DashBoardsList);

var dasboardNames=[];
for(var i=0;i<DashBoardsListArray.length;i++){
	dasboardNames.push(DashBoardsListArray[i][1].toLowerCase());
}

function DashFavAdd(){
	var projectArray=[];
	 $("input:checkbox[name=projectId]:checked").each(function() { 
		 projectArray.push($(this).val()); 
     }); 
	 
	 
	 if(projectArray.length==0){
		 alert("Please, select some projects!")
		 return false;
	 }
	 $('#projects').val(projectArray)
	
	 
	 
	 
	var addFavValue= $('#addFav').val().trim();
	 if(addFavValue.length==0){
		 alert("Please, give a favourite name!")
		 return false;
	 }
		if(dasboardNames.includes(addFavValue.toLowerCase())){
			 alert("This name is already in your Favourites.")
			 return false;
		}
	 
	 $('#addFavvalue').val(addFavValue)
	 
 if(confirm('Are you sure to submit?')){
		 
	 }else{
		 
		 event.preventDefault();
		 return false;
	 }
}

function showDashboardProjectModal(){
	$('#DashboardProjectModal').modal('show');
}



function updateDashBoard(){
	var projectArrays=[];
	 $("input:checkbox[name=projectId]:checked").each(function() { 
		 projectArrays.push($(this).val()); 
    }); 
	
	 if(projectArrays.length==0){
		 alert("Please, select some projects!")

		 return false;
	 }
	 $('#favProjects').val(projectArrays);
	 
 if(confirm('Are you sure to update?')){
		 
	 }else{
	
		 event.preventDefault();
		 return false;
	 }
	
}

$(document).ready(function() {
    // When the checkbox with id "subProject" is changed
    $('#subProject').change(function() {
    
      var isChecked = $(this).prop('checked');
      
    
      $('input:checkbox.subProject').prop('checked', isChecked);
    });
    
    var initialChecked = $('#subProject').prop('checked');
    $('input:checkbox.subProject').prop('checked', initialChecked);
  });
  
  
$(document).ready(function() {
    // When the checkbox with id "subProject" is changed
    $('#mainProject').change(function() {
    
      var isChecked = $(this).prop('checked');
      
    
      $('input:checkbox.mainProject').prop('checked', isChecked);
    });
    
    var initialChecked = $('#mainProject').prop('checked');
    $('input:checkbox.mainProject').prop('checked', initialChecked);
  });
  
  
function sendMail(a){
	Swal.fire({
	    title: 'Sending...',
	  
	    didOpen: () => {
	        Swal.showLoading()
	    }
	});
	
	
	$.ajax({
		type:'get',
		url:'sendMails.htm',
		datatype:'json',
		data:{
			scheduledate:a,
		},
		 success:function(result){
			 var ajaxresult = JSON.parse(result);
			
			if(ajaxresult<0){
				   Swal.close();
					Swal.fire({
		    			  icon: "error",
		    			  text: "Mail Authentication Failed!",
		    			 
		    			}); 
			}else if(ajaxresult===111){
				  Swal.close();
					Swal.fire({
		    			  icon: "warning",
		    			  text: "No meetings sceduled for today!",
		    			 
		    			}); 
			}
			else{
				  Swal.close();
					Swal.fire({
		    			  icon: "success",
		    			  text: "Mail sent!",
		    			 
		    			}); 
			}
		 }
		
	});
	
	
	
}
</script>
</html>