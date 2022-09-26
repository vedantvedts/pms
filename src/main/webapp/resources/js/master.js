function myalert(msg){
	
	bootbox.alert({
  			message: "<center>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>"+msg+"</b></center>",
  			size: 'large',
  			buttons: {
			        ok: {
			            label: 'OK',
			            className: 'btn-success'
			        }
			    }
  			
			});
}

function myconfirm(msg,frmid){
	
	 bootbox.confirm({ 
	 		
		    size: "large",
  			message: "<center>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>"+msg+"</b></center>",
		    buttons: {
		        confirm: {
		            label: 'Yes',
		            className: 'btn-success'
		        },
		        cancel: {
		            label: 'No',
		            className: 'btn-danger'
		        }
		    },
		    callback: function(result){	    
		    	
		    	if(result){
		    	
		         $("#"+frmid).submit(); 
		    	}
		    	else{
		    		event.preventDefault();
		    	}
		    } 
		}) 
	
	
}



						
			   
						
