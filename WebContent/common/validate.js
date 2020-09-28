$.validator.addMethod("passwordCk",  function( value, element ) {
   return this.optional(element) ||  /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/.test(value);
});

//유효성 체크
$.validator.addMethod("telnum", function(telnum, element){
  var pattern = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
  if(!pattern.test(telnum)){
    return this.optional(element)||false;
  }
  return true;
});

$.validator.addMethod("consecutively", function(value, element) {
	var t = "";
    var c = 0;
    for(var i=0; i<value.length; i++){
        var v = value.charAt(i);
        if( t == v ){
            c++;           
        }else{
            c = 0;
        }
        t = v;

        if(c >= 2){
            return this.optional(element) || false;
            break;
        }
    }
    return this.optional(element) || true;
});

	
$(function(){
	$("#admin_form").validate({
        /* focusCleanup:true,*/
        errorClass:"help-block",
        errorElement:"span",
        onfocusout: function(element){
            $(element).valid();
        },
        rules:{                 
	        admin_id:{
	            required:true,
	        },
	        admin_nick_name:{
	            required:true,
	        },
	        admin_pwd:{
	            required:true,
	            minlength: 9,
	            consecutively:true,
	            passwordCk: true	         
	        },
	        admin_phone : {
	        	required:true,
	        	telnum:true
	        }
        },
        messages:{
            admin_id:{
                required:"아이디를 입력해주세요.",
            },
            admin_nick_name:{
                required:"관리자 이름을 입력해주세요.",
            },
            admin_pwd:{
                required:"비밀번호를 입력해주세요.",
                minlength:"비밀번호는 최소 9자리 이상으로 설정해주세요.",
                consecutively:"동일한 문자는 3번 연속 사용 할 수 없습니다.",
                passwordCk:"비밀번호는 숫자, 영문, 특수문자(!@#$%^*+=-) 조합으로 설정해주세요."
            },
	        admin_phone : {
	        	required:"휴대폰 번호를 입력해 주세요.",
	        	telnum:"올바른 휴대폰 번호형식(예: 010-0000-0000)으로 입력해 주세요."
	        }
        }
       
    });
});

$(function(){
	$("#edit_admin_form").validate({
        /* focusCleanup:true,*/
        errorClass:"help-block",
        errorElement:"span",
        onfocusout: function(element){
            $(element).valid();
        },
        rules:{ 
	        admin_id:{
	            required:true,
	        },
	        admin_nick_name:{
	            required:true,
	        },
	        admin_phone : {
	        	required:true,
	        	telnum:true
	        }
        },
        messages:{
            admin_id:{
            	required:"아이디를 입력해주세요.",
            },
            admin_nick_name:{
            	required:"관리자 이름을 입력해주세요.",
            },
	        admin_phone : {
	        	required:"휴대폰 번호를 입력해 주세요.",
	        	telnum:"올바른 휴대폰 번호형식(예: 010-0000-0000)으로 입력해 주세요."
	        }
        }
       
    });
});
$(function(){
    $("#admin_edit_pwd").validate({
        /* focusCleanup:true,*/
        errorClass:"help-block",
        errorElement:"span",
        onfocusout: function(element){
            $(element).valid();
        },

        rules:{ 
	        admin_new_pwd:{
	        	required:true,
	            minlength: 9,
	            consecutively:true,
	            passwordCk: true
	        },
	        confirm_admin_new_pwd:{
	            required:true,
	            equalTo:"#admin_new_pwd",
	        }                               
        },
        messages:{                    
            admin_new_pwd:{
            	required:"비밀번호를 입력해주세요.",
                minlength:"비밀번호는 최소 9자리 이상으로 설정해주세요.",
                consecutively:"동일한 문자는 3번 연속 사용 할 수 없습니다.",
                passwordCk:"비밀번호는 숫자, 영문, 특수문자(!@#$%^*+=-) 조합으로 설정해주세요."
            },
            confirm_admin_new_pwd:{
                equalTo:"비밀번호가 일치하지 않습니다.",
            }                       
        }
       
    });
});
$(function(){
    $("#admin_chg_pwd").validate({
        /* focusCleanup:true,*/
        errorClass:"help-block",
        errorElement:"span",
        onfocusout: function(element){
            $(element).valid();
        },

        rules:{ 
	        admin_new_pwd:{
	        	required:true,
	            minlength: 9,
	            consecutively:true,
	            passwordCk: true
	        },
	        confirm_admin_new_pwd:{
	            required:true,
	            equalTo:"#admin_new_pwd",
	        }                               
        },
        messages:{                    
            admin_new_pwd:{
            	required:"비밀번호를 입력해주세요.",
                minlength:"비밀번호는 최소 9자리 이상으로 설정해주세요.",
                consecutively:"동일한 문자는 3번 연속 사용 할 수 없습니다.",
                passwordCk:"비밀번호는 숫자, 영문, 특수문자(!@#$%^*+=-) 조합으로 설정해주세요."
            },
            confirm_admin_new_pwd:{
                equalTo:"비밀번호가 일치하지 않습니다.",
            }                       
        }
       
    });
});
$(function(){
    $("#admin_person_edit").validate({
        /* focusCleanup:true,*/
        errorClass:"help-block",
        errorElement:"span",
        onfocusout: function(element){
            $(element).valid();
        },
        rules:{ 
    
	        admin_id:{
	            required:true,
	        },
	        admin_nick_name:{
	            required:true,
	        }
                   
        },
        messages:{
            admin_id:{
                required:"Enter Admin ID",
            },
            admin_nick_name:{
                required:"Enter Admin Nick Name",
            }                    
        }
       
    });
});
$(function(){
                
                $("#board_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    board_name:{
                        required:true,
                    }
                               
                },
                
                messages:{
                    board_name:{
                        required:"Enter Board Name",
                    }                     
                },
               
               
            });
        });

$(function(){
                
                $("#material_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    material_name:{
                        required:true,
                    }
                               
                },
                
                messages:{
                    material_name:{
                        required:"Enter Material Name",
                    }                     
                },
               
               
            });
        });

 $(function(){
                
                $("#edit_board_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    board_name:{
                        required:true,
                    }
                               
                },
                
                messages:{
                    board_name:{
                        required:"Enter Board Name",
                    }                    
                },
                
               
            });
        });

 $(function(){
                
                $("#edit_material_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    material_name:{
                        required:true,
                    }
                               
                },
                
                messages:{
                    material_name:{
                        required:"Enter Material Name",
                    }                    
                },
                
               
            });
        });
 $(function(){
                $("#category_board_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    category_board_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    category_board_name:{
                        required:"Enter Category Board Name",
                    }                    
                }
               
            });
        });

 $(function(){
                $("#category_material_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    category_material_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    category_material_name:{
                        required:"Enter Category Material Name",
                    }                    
                }
               
            });
        });
 $(function(){
                $("#edit_category_board_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    category_board_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    category_board_name:{
                        required:"Enter Category Board Name",
                    }                    
                }
               
            });
        });
 $(function(){
                $("#edit_category_material_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    category_material_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    category_material_name:{
                        required:"Enter Category Material Name",
                    }                    
                }
               
            });
        });

 $(function(){
                $("#lable_material_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    lable_material_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    lable_material_name:{
                        required:"Enter Lable Material Name",
                    }                    
                }
               
            });
        });
 $(function(){
                $("#edit_lable_material_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    lable_material_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    lable_material_name:{
                        required:"Enter Lable Material Name",
                    }                    
                }
               
            });
        });

 $(function(){
                $("#lable_board_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    lable_board_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    lable_board_name:{
                        required:"Enter Lable Board Name",
                    }                    
                }
               
            });
        });
 $(function(){
                $("#edit_lable_board_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    lable_board_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    lable_board_name:{
                        required:"Enter Lable Board Name",
                    }                    
                }
               
            });
        });

 $(function(){
                $("#lable_contents_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    lable_contents_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    lable_contents_name:{
                        required:"Enter Lable Contents Name",
                    }                    
                }
               
            });
        });
 $(function(){
                $("#edit_lable_contents_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    lable_contents_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    lable_contents_name:{
                        required:"Enter Lable Contents Name",
                    }                    
                }
               
            });
        });


 $(function(){
                $("#category_contents_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    category_contents_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    category_contents_name:{
                        required:"Enter Category Contents Name",
                    }                    
                }
               
            });
        });

	$(function(){
                $("#category_culture_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    category_culture_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    category_culture_name:{
                        required:"Enter Category Culture Name",
                    }                    
                }
               
            });
    });
 $(function(){
                $("#edit_category_contents_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    category_contents_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    category_contents_name:{
                        required:"Enter Category Contents Name",
                    }                    
                }
               
            });
        });
	 $(function(){
                $("#edit_category_culture_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    category_culture_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    category_culture_name:{
                        required:"Enter Category Culture Name",
                    }                    
                }
               
            });
        });
 $(function(){
               
                $("#contents_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    contents_name:{
                        required:true,
                    }
                               
                },
                
                messages:{
                    contents_name:{
                        required:"Enter Contents Name",
                    }                      
                },
                
               
            });
        });
	$(function(){
               
                $("#culture_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    culture_name:{
                        required:true,
                    }
                               
                },
                
                messages:{
                    culture_name:{
                        required:"Enter Culture Name",
                    }                      
                },
                
               
            });
        });
 $(function(){
                
                $("#edit_contents_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    contents_name:{
                        required:true,
                    }
                               
                },
               
                messages:{
                    contents_name:{
                        required:"Enter Contents Name",
                    }                    
                },
               
               
            });
        });
	$(function(){
                
                $("#edit_culture_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    culture_name:{
                        required:true,
                    }
                               
                },
               
                messages:{
                    culture_name:{
                        required:"Enter Culture Name",
                    }                    
                },
               
               
            });
        });
 $(function(){
                $("#category_pop_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    category_pop_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    category_pop_name:{
                        required:"Enter Category Pop Name",
                    }                       
                }
               
            });
        });
 $(function(){
                $("#edit_category_pop_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    category_pop_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    category_pop_name:{
                        required:"Enter Category Pop Name",
                    }                       
                }
               
            });
        });
 $(function(){

                $("#pop_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    
                    onfocusout: function(element){
                        $(element).valid();                    
                    },
                    
                    rules:{ 
                
                    pop_name:{
                        required:true,
                    }
                       
                               
                },

                messages:{
                    pop_name:{
                        required:"Enter Pop Name",
                    }                    
                },
                
               
            });
        });
  $(function(){
                $("#edit_pop_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    
                    onfocusout: function(element){
                        $(element).valid();                    
                    },
                    
                    rules:{ 
                
                    pop_name:{
                        required:true,
                    } 
                               
                },
                
                messages:{
                    pop_name:{
                        required:"Enter Pop Name",
                    }                     
                }
               
            });
        });
  $(function(){
                $("#category_slide_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    category_slide_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    category_slide_name:{
                        required:"Enter Category Slide Name",
                    }                            
                }
               
            });
        });
  $(function(){
                $("#edit_category_slide_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    category_slide_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    category_slide_name:{
                        required:"Enter Category Slide Name",
                    }                          
                }
               
            });
        });
  $(function(){
                $("#slide_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    slide_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    slide_name:{
                        required:"Enter Slide Name",
                    }                      
                }
               
            });
        });
   $(function(){
                $("#edit_slide_form").validate({
                    /* focusCleanup:true,*/
                    errorClass:"help-block",
                    errorElement:"span",
                    onfocusout: function(element){
                        $(element).valid();
                    },

                    rules:{ 
                
                    slide_name:{
                        required:true,
                    }
                               
                },
                messages:{
                    slide_name:{
                        required:"Enter Slide Name",
                    }                     
                }
               
            });
        });
   $(function(){
 $("select[name=category_pop_index]").bind("change",function(){
  if($(this).val()=="1"){
   $("#a").show();
   $("#b").hide();
   $("#c").hide();
  }else if($(this).val()=="2"){
   $("#a").hide();
   $("#b").show();
   $("#c").hide();
  }else{
   $("#a").hide();
   $("#b").hide();
   $("#c").show();
  }    
 });
});