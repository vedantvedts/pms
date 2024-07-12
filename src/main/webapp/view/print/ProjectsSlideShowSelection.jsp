<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<style type="text/css">
   .modalcontainer {
      position: fixed;
      bottom: 45%;
      right: 20px;
      width: 300px;
      max-width: 80%;
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      border-radius: 8px;
      z-index: 1000;
      font-family: Arial, sans-serif;
     display: none;
    }


    .modal-container {
      position: fixed;
      bottom: 20px;
      right: 20px;
      width: 300px;
      max-width: 80%;
    
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      border-radius: 8px;
      display: none;
      z-index: 1000;
      font-family: Arial, sans-serif;
     
    }

    .modalheader {
    display: flex;
    align-items: center;
    justify-content: end;
    padding:8px;
      background-color: #FFC436;
      color: #fff;
      border-top-left-radius: 8px;
      border-top-right-radius: 8px;
    }

    .modalcontent {
    
      padding: 10px 10px 10px 10px;
    }

    .modalfooter {
      text-align: right;
      border-bottom-left-radius: 8px;
      border-bottom-right-radius: 8px;
    }

    .modal-close {
      cursor: pointer;
      color: red;
    }

    /* Style for the button */
    .open-modal-button {
      position: fixed;
      bottom: 10px;
      right: 10px;
      background-color: #007bff;
      color: #fff;
      padding: 5px;
      border: none;
      border-radius: 5px;
      font-weight:bold;
      cursor: pointer;
      z-index: 1001; /* Make sure the button is above the modal */
    }
    
.modal-hr{
	margin: 0px 10px -10px 10px !important;
}

.modal-list{
	font-size: 14px;
	text-align: left;
	padding: 0px !important;
	margin-bottom: 5px;
}

.modal-list li{
	display: inline-block;
}

.modal-list li .modal-span{
	font-size: 2rem;
	padding: 0px 7px;
}

.modal-list li .modal-text{
	font-size: 1rem;
	vertical-align: text-bottom;
	font-family: Lato;
}
</style>

</head>
<%
List<Object[]> ProjectHealthData = (List<Object[]>)request.getAttribute("projecthealthdata");
List<Object[]>ProjectList = (List<Object[]>)request.getAttribute("ProjectList"); 

List<String>projectIds=new ArrayList<>();

if(ProjectList!=null){
	for(Object[]obj:ProjectList){
		projectIds.add(obj[0].toString());
	}
}
System.out.println(projectIds.toString());
%>

<!-- Modal -->
	<div class="modal fade bd-example-modal-xl" id="selectProjectsForSlideShowModal" style="width: 100%;display: none;" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg " style="max-width: 1800px" role="document">
	  <form action="GetAllProjectSlide.htm" target="_blank" onsubmit="return checkslidesinput()" method="post" id="slideshowForm">
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	  
	    <div class="modal-content">
	      <div class="modal-header">
	      
	      
	        <h5 class="modal-title" style="width: 600px;text-align: left;" id="exampleModalLabel">
	        	Select Projects for SlideShow
        	<br><br>
        	<div class="row align-items-center">
        		<div class="col-5 align-items-center" style="width: 90%">
      				<div class="row align-items-center" style=" float: left;width: 90%" > 
      					<div class="col-6">
	        			<span style="font-size: 1rem;text-align: left;">Select All</span>
	        			</div>
	        			
	        			<div class="col-4 align-items-center" style="margin: 0 0 0 0;">
	        			<div style="margin: auto;" >
	        				<input  type="checkbox" id="selectallprojects" style="width: 20px;height: 20px;margin-top: 20%;">
	        			</div>
	        			</div>
	        			
	        		</div> 
        		</div>
        		<div class="col align-items-center" >
	        		<div class="row align-items-center">
		        		<div class="col" style="width: 75%;" >
				        	<select id="fav" class="form-control" onchange="isAddFavClicked('select')">
						        <option value="defaultValue" selected="selected">
						        	Favourite
						        </option>
						        <option value="addFav"> 
								  Add Fav
								</option>
							</select>
				       </div>
				       <div class="col" style="width: 20%;" >
				       		<button type="button" class="btn btn-warning btn-sm edit" onclick="isAddFavClicked('button');$('#selectFavProjectList').modal('show');" id="EditFav" style="display: none;">Edit Fav</button>
				       </div>
			       </div>
		       </div>
		    </div>
	        </h5>
	        <div id="alertsection" style="width: 30%"> 
			</div>
	        <button type="button" class="close" style="width: 2%; margin: 0 0 0 0;padding: 0 0 0 0 " data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	       
	      </div>
	      
	      <div class="modal-body" >
	      	<div class="container-fluid">
	        	<% List<Object[]> mainProjectList =  ProjectHealthData!=null && ProjectHealthData.size()>0 ? (ProjectHealthData.stream().filter(e-> e[51]!=null && e[51].toString().equals("1")).collect(Collectors.toList())): new ArrayList<Object[]>();
	        	   List<Object[]> subProjectList =  ProjectHealthData!=null && ProjectHealthData.size()>0 ? (ProjectHealthData.stream().filter(e-> e[51]!=null && e[51].toString().equals("0")).collect(Collectors.toList())): new ArrayList<Object[]>();
	        	%>
	        	<div class="row">
    				<div class="col-md-12">
				        <div align="left">
				        	<h5>
				        		Main Projects: <input type="checkbox" id="selectmainprojects" style="width: 20px;height: 20px;"> 
				        	</h5> 
				        </div>
       	 				<hr>
        				<%int   c = 0;
           					if (mainProjectList != null && mainProjectList.size() > 0) {
               					for (Object[] obj : mainProjectList) { %>
				                   <% if (c == 4 || c == 0) { c=0;%>
		                       <div class="row">
				                   <% } %>
			                       <div class="col-3">
			                           <div style="text-align: left;">
			                               <input <%if(projectIds.contains(obj[2].toString())) {%>  checked<%} %> class="mainprojectlist" name="projectlist" style="text-align: left;margin: 8px;width: 20px; height: 20px;" value="<%=obj[2]%>" type='checkbox'/>
			                               <label for="<%=obj[2]%>">
			                                   <span class="tableprojectname" style="color:black !important;font-size: 13px"> 
			                                       <% if (obj[46] != null) { %><%= obj[46] %><% } else { %>-<% } %> /
			                                       <% if (obj[3] != null) { %><%= obj[3] %><% } else { %>-<% } %> /
			                                       <% if (obj[44] != null) { %><%= obj[44] %><% } else { %>-<% } %>
			                                   </span> 	
			                               </label>
			                           </div>
			                       </div>
				                   <% if (c == 3) { %>
				                       </div>
				                   <% } %>
		                   		<% c++; } } %>
                   		<% if (c <4 && c>0 ) { %>
							</div>
						<% } %>
    				</div>
				</div>

	        	
	        	<div class="row" style="margin-top: 1rem;">
	        		<div class="col-md-12">
	        			<div align="left">
	        				<h5>
	        					Sub Projects: <input type="checkbox" id="selectsubprojects" style="width: 20px;height: 20px;">
	        				</h5>
	        			</div>
	        			<hr>
			        	<%int  c1=0;
			        		if(subProjectList!=null && subProjectList.size()>0) { 
			        		for(Object[] obj : subProjectList){%>
			        	<%if(c1==4||c1==0) {c1=0; %>
			        	<div class="row">
			        	<%} %>
							<div class="col-3" >
								<div style="text-align: left;">
									<input <%if(projectIds.contains(obj[2].toString())) {%>  checked<%} %> class="subprojectlist" name="projectlist" style="text-align: left;margin: 8px;width: 20px; height: 20px;" value="<%=obj[2]%>" type='checkbox'/>
									<label for="<%=obj[2]%>">
										<span class="tableprojectname" style="color:black !important;font-size: 13px"> 
										  	<%if(obj[46]!=null){%><%=obj[46] %><%}else {%>-<%} %> /
										  	<%if(obj[3]!=null){%><%=obj[3] %><%}else {%>-<%} %> /
										  	<%if(obj[44]!=null){%><%=obj[44] %><%}else {%>-<%} %>
									  	</span> 	
									</label>
								</div>
							</div>
						<%if(c1 == 3 ) { %>
						</div><%}%>
						<%c1++;} }%>
						<% if (c1 <4 && c1>0 ) { %>
							</div>
						<% } %>
	        		</div>
	        	</div>
	      	</div>
	      </div>
	      <div class="modal-footer ">
	      <div class="row" style="width: 100%">
	      	<div class="col">
	      		<div class="d-flex justify-content-start" >
	      			<p style="text-align: left"><span style="color: red">Note</span>: Master slide is the combination of latest Data of selected project</p>
	      		</div>
	      	</div>
	      	<div class="col d-flex justify-content-end" >
	        	<button type="button mx-1" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        	<button onclick="checkslideinput()" class="btn btn-primary mx-1" id="slideshowsDiv">Slide Show</button>
	       </div>
	      </div>
	      </div>
	    </div>
	   </form>
	  </div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="selectFavProjectList" style="width: 100%"
		tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
		aria-hidden="true">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
			<div class="modal-dialog modal-lg" style="max-width: 1800px"
				role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Select Fav</h5>
						<button type="button" class="close" onclick="document.getElementById('favTitle').value='';$('#selectFavProjectList').modal('hide')"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<input class="form-control" type="text" placeholder="Favourite Title"
							name="FavouriteSlidesTitle" id="favTitle" style="padding: 10px;max-width: 25%;margin-left: 5%;margin-top: 5px "  required="required">
					<div class="modal-body">
						<div class="container-fluid">
							<div class="row">
								<div class="col-md-12">
									<div align="left">
										<h5>
											Main Projects: <input type="checkbox" id="selectmainproject"
												style="width: 20px; height: 20px;">
										</h5>
									</div>
									<hr>
									<%  c = 0;
           					if (mainProjectList != null && mainProjectList.size() > 0) { 
               					for (Object[] obj : mainProjectList) { %>
									<% if (c == 4 || c == 0) {c=0; %>
									<div class="row">
										<% } %>
										<div class="col-3">
											<div style="text-align: left;">
												<input checked class="mainprojectlis" name="projectlist"
													style="text-align: left; margin: 8px; width: 20px; height: 20px;"
													value="<%=obj[2]%>" type='checkbox' /> <label
													for="<%=obj[2]%>"> <span class="tableprojectname"
													style="color: black !important; font-size: 13px"> <% if (obj[46] != null) { %><%= obj[46] %>
														<% } else { %>-<% } %> / <% if (obj[3] != null) { %><%= obj[3] %>
														<% } else { %>-<% } %> / <% if (obj[44] != null) { %><%= obj[44] %>
														<% } else { %>-<% } %>
												</span>
												</label>
											</div>
										</div>
										<% if (c == 3 ) { %>
									</div>
									<% } %>
									<% c++; } } %>
									<% if (c <4 && c>0 ) { %>
									</div>
									<% } %>
								</div>
							</div>
							<div class="row" style="margin-top: 1rem;">
								<div class="col-md-12">
									<div align="left">
										<h5>
											Sub Projects: <input type="checkbox" id="selectsubproject"
												style="width: 20px; height: 20px;">
										</h5>
									</div>
									<hr>
									<% c1=0;
			        		if(subProjectList!=null && subProjectList.size()>0) { 
			        		for(Object[] obj : subProjectList){%>
									<%if(c1==4||c1==0) {c1=0; %>
									<div class="row">
										<%} %>
										<div class="col-3">
											<div style="text-align: left;">
												<input checked class="subprojectlis" name="projectlist"
													style="text-align: left; margin: 8px; width: 20px; height: 20px;"
													value="<%=obj[2]%>" type='checkbox' /> <label
													for="<%=obj[2]%>"> <span class="tableprojectname"
													style="color: black !important; font-size: 13px"> <%if(obj[46]!=null){%><%=obj[46] %>
														<%}else {%>-<%} %> / <%if(obj[3]!=null){%><%=obj[3] %>
														<%}else {%>-<%} %> / <%if(obj[44]!=null){%><%=obj[44] %>
														<%}else {%>-<%} %>
												</span>
												</label>
											</div>
										</div>
										<%if(c1 == 3 ) { %>
									</div>
									<%}%>
									<%c1++;} }%>
									<% if (c1 <3 && c1>0 ) { %>
									</div>
									<% } %>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							onclick="$('#favTitle').val('');$('#selectFavProjectList').modal('hide');isAddFavClicked('close') ">Close</button>
						<button type="button" id="save" style="display: block;" onclick="SaveEditValues('save');" class="btn btn-primary mx-1">Save Favourite</button>
						<button type="button" id="edit" style="display: none;" onclick="SaveEditValues('edit');" class="btn btn-primary mx-1">Edit favourite</button>
					</div>
				</div>
			</div>
	</div>

	<script>
var options = [];
var values = [];
$.ajax({
	type : "GET",
	url : "GetFavSlides.htm",
	datatype:'json',
	success : function(results){
		var result = JSON.parse(results);
		options = result;
		var newOption = new Option('Option Text','Option Value');
		var selector = document.querySelector('#fav');
		$('#fav').empty();
		newOption = new Option('Favourite','defaultValue');
		selector.add(newOption);
		newOption = new Option('Add Favourite','addFav');
		selector.add(newOption);
		for(var i=0;i<options.length;i++)
		{
			newOption = new Option(options[i][1],options[i][2]);
			selector.add(newOption);
			values.push(options[i][2])
		}
	}
});		
	
	
	
	
$(document).ready(function(){
    // Default: All checkboxes are checked
    $('#selectallprojects, #selectmainprojects, #selectsubprojects').prop('checked', true);

    // Handling click event for Select All checkbox
    $("#selectallprojects").click(function(){
        var isChecked = $(this).prop('checked');
        $('.mainprojectlist, .subprojectlist, #selectmainprojects, #selectsubprojects').prop('checked', isChecked);
    });
    
    // Handling click event for Main Projects checkbox
    $("#selectmainprojects").click(function(){
        var isChecked = $(this).prop('checked');
        $('.mainprojectlist').prop('checked', isChecked);
        // Check if both Main Projects and Sub Projects are checked
        if ($('#selectmainprojects').prop('checked') && $('#selectsubprojects').prop('checked')) {
            $('#selectallprojects').prop('checked', true);
        } else {
            $('#selectallprojects').prop('checked', false);
        }
    });
    
    // Handling click event for Sub Projects checkbox
    $("#selectsubprojects").click(function(){
        var isChecked = $(this).prop('checked');
        $('.subprojectlist').prop('checked', isChecked);
        // Check if both Main Projects and Sub Projects are checked
        if ($('#selectmainprojects').prop('checked') && $('#selectsubprojects').prop('checked')) {
            $('#selectallprojects').prop('checked', true);
        } else {
            $('#selectallprojects').prop('checked', false);
        }
    });

    // Handling click event for individual Main Project checkboxes
    $(".mainprojectlist").click(function() {
    	if (!$(this).prop('checked')) {
            $('#selectmainprojects').prop('checked', false);
            $('#selectallprojects').prop('checked', false);
        } 
        else {
           var allMainChecked = true;
           $('.mainprojectlist').each(function() {
               if (!$(this).prop('checked')) {
                   allMainChecked = false;
               }
           });
           if (allMainChecked) {
               $('#selectmainprojects').prop('checked', true);
               if ($('#selectsubprojects').prop('checked')) {
                   $('#selectallprojects').prop('checked', true);
               }
           }
        }
        var mainProjectsChecked = $('.mainprojectlist:checked').length;
        var mainProjectsTotal = $('.mainprojectlist').length;
        $('#selectmainprojects').prop('checked', mainProjectsChecked === mainProjectsTotal);
        // Check if all Main Projects are checked
        if ($('#selectmainprojects').prop('checked') && $('#selectsubprojects').prop('checked')) $('#selectallprojects').prop('checked', true);
		else $('#selectallprojects').prop('checked', false);
    });

    // Handling click event for individual Sub Project checkboxes
    $(".subprojectlist").click(function() {
        if (!$(this).prop('checked')) {
            $('#selectsubprojects').prop('checked', false);
            $('#selectallprojects').prop('checked', false);
        } else {
            var allSubChecked = true;
            $('.subprojectlist').each(function() {
                if (!$(this).prop('checked')) {
                    allSubChecked = false;
                }
            });
            var subProjectsChecked = $('.subprojectlist:checked').length;
	        var subProjectsTotal = $('.subprojectlist').length;
	        $('#selectsubprojects').prop('checked', subProjectsChecked === subProjectsTotal);
            if (allSubChecked && $('#selectmainprojects').prop('checked')) $('#selectallprojects').prop('checked', true);
            else $('#selectallprojects').prop('checked', false);
        }
        // Check if all Sub Projects are checked
        if ($('#selectmainprojects').prop('checked') && $('#selectsubprojects').prop('checked')) {
            $('#selectallprojects').prop('checked', true);
        } else {
            $('#selectallprojects').prop('checked', false);
        }
    });
    
    
    
    
    //--------------------This is for Favourite Project Edit---------------------
    
    
    
    $('#selectallproject, #selectmainproject, #selectsubproject').prop('checked', true);
    
    // Handling click event for Main Projects checkbox
    $("#selectmainproject").click(function(){
        var isChecked = $(this).prop('checked');
        $('.mainprojectlis').prop('checked', isChecked);
        // Check if both Main Projects and Sub Projects are checked
        if ($('#selectmainproject').prop('checked') && $('#selectsubproject').prop('checked')) {
            $('#selectallproject').prop('checked', true);
        } else {
            $('#selectallproject').prop('checked', false);
        }
    });
    
    // Handling click event for Sub Projects checkbox
    $("#selectsubproject").click(function(){
        var isChecked = $(this).prop('checked');
        $('.subprojectlis').prop('checked', isChecked);
        // Check if both Main Projects and Sub Projects are checked
        if ($('#selectmainproject').prop('checked') && $('#selectsubproject').prop('checked')) {
            $('#selectallproject').prop('checked', true);
        } else {
            $('#selectallproject').prop('checked', false);
        }
    });

    // Handling click event for individual Main Project checkboxes
    $(".mainprojectlis").click(function() {
        if (!$(this).prop('checked')) $('#selectmainproject').prop('checked', false);
        else {
           var allMainChecked = true;
           $('.mainprojectlis').each(function() {
               if (!$(this).prop('checked')) allMainChecked = false;
           });
           if (allMainChecked) {
               $('#selectmainproject').prop('checked', true);
           }
        }
        var mainProjectsChecked = $('.mainprojectlis:checked').length;
        var mainProjectsTotal = $('.mainprojectlis').length;
        $('#selectmainproject').prop('checked', mainProjectsChecked === mainProjectsTotal);
    });

    // Handling click event for individual Sub Project checkboxes
    $(".subprojectlist").click(function() {
        if (!$(this).prop('checked'))  $('#selectsubproject').prop('checked', false);
        else {
            var allSubChecked = true;
            $('.subprojectlis').each(function() {
                if (!$(this).prop('checked'))  allSubChecked = false;
            });
            if (allSubChecked) {
                $('#selectsubproject').prop('checked', true);
            }
        }
        var subProjectsChecked = $('.subprojectlis:checked').length;
        var subProjectsTotal = $('.subprojectlis').length;
        $('#selectsubproject').prop('checked', subProjectsChecked === subProjectsTotal);
    });

});

function checkSelectSubProject()
{
	var subProjectsChecked = $('.subprojectlis:checked').length;
    var subProjectsTotal = $('.subprojectlis').length;
    $('#selectsubproject').prop('checked', subProjectsChecked === subProjectsTotal);
    if ($('#selectmainprojects').prop('checked') && $('#selectsubprojects').prop('checked')) {
        $('#selectallprojects').prop('checked', true);
    } else {
        $('#selectallprojects').prop('checked', false);
    }
}
function checkSelectMainProject()
{
	var mainProjectsChecked = $('.mainprojectlis:checked').length;
	var mainProjectsTotal = $('.mainprojectlist').length;
	$('#selectmainproject').prop('checked', mainProjectsChecked === mainProjectsTotal);
	if ($('#selectmainprojects').prop('checked') && $('#selectsubprojects').prop('checked')) {
        $('#selectallprojects').prop('checked', true);
    } else {
        $('#selectallprojects').prop('checked', false);
    }
}
var prev = "";
function isAddFavClicked(tag)
{
	var Fav = document.getElementById('fav');
	
	var val = Fav.options[Fav.selectedIndex].value;
	
	//if clicked on add
	if(val == 'addFav')//modal popup. select everything in new modal. show save button.
	{
		$(".subprojectlis").each(function(){$(this).prop("checked", true);});
		$(".mainprojectlis").each(function(){$(this).prop("checked", true);});
		
		
		
		checkSelectSubProject();
		checkSelectMainProject();
		$('#selectFavProjectList').modal('show');
		
		document.getElementById('save').style.display='block';
		document.getElementById('edit').style.display='none';
		console.log(prev)
		if(prev == "")
		Fav.selectedIndex=0;
		else
		Fav.selectedIndex=prev;
		
	}
	
	//if clicked on fav pack
	else if(val != "defaultValue" && tag!='close')//select every checkbox of selected pack
	{
		//write code for selecting the checkboxes in slideshow checkbox projects with respect to selected fav
		
		 $(".mainprojectlist").each(function(){
		        // Test if the div element is empty
		        if(val.split(",").includes($(this).val())){
		            $(this).prop("checked", true);
		        }
		        else{
		        	$(this).prop("checked", false);
		        }
		    });
		 $(".subprojectlist").each(function(){
		        // Test if the div element is empty
		        if(val.split(",").includes($(this).val())){
		            $(this).prop("checked", true);
		        }
		        else{
		        	$(this).prop("checked", false);
		        }
		    });
		 
		 $(".mainprojectlis").each(function(){
		        // Test if the div element is empty
		        if(val.split(",").includes($(this).val())){
		            $(this).prop("checked", true);
		        }
		        else{
		        	$(this).prop("checked", false);
		        }
		    });
		 $(".subprojectlis").each(function(){
		        // Test if the div element is empty
		        if(val.split(",").includes($(this).val())){
		            $(this).prop("checked", true);
		        }
		        else{
		        	$(this).prop("checked", false);
		        }
		    });
		 var allSubChecked = true;
         $('.subprojectlis').each(function() {
             if (!$(this).prop('checked')) {
                 allSubChecked = false;
             }
         });
         if (allSubChecked) {
             $('#selectsubproject').prop('checked', true);
         }
         
         allSubChecked = true;
         $('.mainprojectlis').each(function() {
             if (!$(this).prop('checked')) {
                 allSubChecked = false;
             }
         });
         if (allSubChecked) {
             $('#selectsubproject').prop('checked', true);
         }
         
         
         
         var mainProjectsChecked = $('.mainprojectlist:checked').length;
         var mainProjectsTotal = $('.mainprojectlist').length;
         $('#selectmainprojects').prop('checked', mainProjectsChecked === mainProjectsTotal);
         
         var subProjectsChecked = $('.subprojectlist:checked').length;
         var subProjectsTotal = $('.subprojectlist').length;
         $('#selectsubprojects').prop('checked', subProjectsChecked === subProjectsTotal);
		 
         checkSelectSubProject();
         checkSelectMainProject();
		 
		 if(tag != 'select')
		 {
			document.getElementById("favTitle").value=options[Fav.selectedIndex-2][1];
			document.getElementById("edit").style.display='block';
			document.getElementById("edit").value=options[Fav.selectedIndex-2][0];
			document.getElementById("save").style.display='none';
		 }
		 document.getElementById("EditFav").style.display='block';
	}
	
	//if clicked on favourite, it will select every checkbox, removes edit button.
	else if(val == "defaultValue")
	{
		console.log('edit none-ing');
		document.getElementById("EditFav").style.display='none';
		$(".subprojectlist").each(function(){$(this).prop("checked", true);})
		 $(".mainprojectlist").each(function(){$(this).prop("checked", true);});
		var mainProjectsChecked = $('.mainprojectlist:checked').length;
        var mainProjectsTotal = $('.mainprojectlist').length;
        $('#selectmainprojects').prop('checked', mainProjectsChecked === mainProjectsTotal);
        
        var subProjectsChecked = $('.subprojectlist:checked').length;
        var subProjectsTotal = $('.subprojectlist').length;
        $('#selectsubprojects').prop('checked', subProjectsChecked === subProjectsTotal);
        if ($('#selectmainprojects').prop('checked') && $('#selectsubprojects').prop('checked')) {
            $('#selectallprojects').prop('checked', true);
        } else {
            $('#selectallprojects').prop('checked', false);
        }
	}
	prev = Fav.selectedIndex;
}
function SaveEditValues(val)
{
	var subprojids = [];
	$(".subprojectlis").each(function(){if($(this).is(':checked'))subprojids.push($(this).val());});
	$(".mainprojectlis").each(function(){if($(this).is(':checked'))subprojids.push($(this).val())});
	
	urls={'save':'saveFavSlides.htm','edit':'EditFavSlides.htm'}
	console.log("favtitle is ",document.getElementById('favTitle').value!='');
	if(document.getElementById('favTitle').value!=''){
		if(subprojids.length>0)
	$.ajax({
		type : "POST",
		url : urls[val],
		datatype:'json',
		data:
		{
			FavouritId : val=='edit'?options[document.getElementById('edit').value-1][0]:'0',
			name : document.getElementById('favTitle').value,
			projectlist:subprojids.join(","),
			${_csrf.parameterName} : "${_csrf.token}",
		},
		success : function(results){
					if(results=="Success"){
						$.ajax({
							type : "GET",
							url : "GetFavSlides.htm",
							datatype:'json',
							success : function(results){
								
									var result = JSON.parse(results);
									options = result;
									var newOption = new Option('Option Text','Option Value');
									var selector = document.querySelector('#fav');
									$('#fav').empty();
									newOption = new Option('Favourite','defaultValue');
									selector.add(newOption);
									newOption = new Option('Add Favourite','addFav');
									selector.add(newOption);
									for(var i=0;i<options.length;i++)
									{
										newOption = new Option(options[i][1],options[i][2]);
										selector.add(newOption);
										values.push(options[i][2])
									}
									if(val=='save')
									$("#fav option[value='"+values[values.length-1]+"']").prop('selected',true);
									else
									$("#fav option[value='"+subprojids.join(",")+"']").prop('selected',true);									
									isAddFavClicked('select');
									$('#selectFavProjectList').modal('hide');
									$("#addeditsuccessmessage").css("display","block");
									val = val=='save'?'Saved':'Edited';
									document.getElementById('alertsection').innerHTML='<div class="alert alert-success" id="addeditsuccessmessage" style="display:block" role="alert">Favourite Slides '+val+' succesfully </div>';
						            $("#addeditsuccessmessage").delay(5000).slideUp();
						            
								}
							
							});
			}
					else{
					$('#selectFavProjectList').modal('hide');
					isAddFavClicked('select');
					$("#addeditfailuremessage").css("display","block");
					val = val=='save'?'Saved':'Edited';
					document.getElementById('alertsection').innerHTML='<div class="alert alert-danger" id="addeditfailuremessage" style="display:block" role="alert">Favourite Slides '+val+' failed</div>';

		            $("#addeditfailuremessage").delay(5000).slideUp();
			}
		}
	});
		else
			alert('Please Select Favourite Projects');
	}
	else
		alert('Please Enter Favourite Title');
}
function checkslidesinput()
{
	var subprojids = [];
	$(".subprojectlist").each(function(){if($(this).is(':checked'))subprojids.push($(this).val());});
	$(".mainprojectlist").each(function(){if($(this).is(':checked'))subprojids.push($(this).val())});
	if(subprojids.length>0)return true;
	else {alert("Please Select Slides for SlideShow");return false}
}

$('#slideDIv').click(function (){
	$('#slideshowsDiv').click();
	
})
$('#selectProjectsForSlideShowModal').modal('hide');
</script>
</body>
</html>