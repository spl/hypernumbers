var formulae = new Array();
var parents  = new Array();
var children = new Array();
var css_attrs = ["font-style","font-weight","text-align","text-decoration","color"];

var url = document.location.href;
var auth = false;

var handle_attr = function(refxml)
{
    var el = $(refxml);
    
    var ref   = el.attr("ref");
    var name  = ((el.children()[0]).nodeName).toLowerCase();
    var value = el.text();
    
    if( jQuery.inArray(name, css_attrs) != -1 )
        $("#hn").spreadsheet("setStyle",ref,name,value);
    
    else if(name == "formula") 
    {
        console.log("yup");
        formulae[ref] = value;  
    }
    
    else if(name == "height")  
        $("#hn").spreadsheet("setHeight",ref,parseInt(value));

    else if(name == "width")   
    {
        console.log(parseInt(value));
        $("#hn").spreadsheet("setWidth",ref,parseInt(value));
    }

    else if(name == "name")    
        $("#hn").spreadsheet("addName",ref,value);

    else if(name == "value")
    {
        $("#hn").spreadsheet("setValue",ref,value);
    }
    else if(name == "parents" || name == "children")
    {
        var arr = new Array();
        
        var find = function()
        {
            if($(this).attr("type") == "remote")
            {
                arr.push($(this).text());
            }
        };

        el.find("url").each(find);
        
        if(name == "parents")       
            parents[ref] = arr;
        
        else if(name == "children") 
            children[ref] = arr;
    }
}
    
$(function()
{
    init();
    
    setTimeout(function()
               {
                   create_spreadsheet();
                   load_data();
                   $(".spreadsheet > .cover").fadeOut("normal");
                   
               },100);
    
    //create_spreadsheet();
});

var init = function()
{
    var so = new SWFObject("/swf/JsSocket.swf", "mymovie", "470", "200", "8", "#FFFFFF");            
    so.addParam("allowScriptAccess", "always");
    so.write("flashcontent");
    
    // Import SpreadSheet
    var importfun = function()
    {
        var onchange = function()
	{
	    $.ajaxFileUpload({url:'?import', 
			      secureuri:false, datatype: "json", 
			      fileElementId:'Filedata'});
	    
	    $("#import").hide();
	};
        
        $("#filemenu ul").hide();
        $("#import").show();
        $("#Filedata").change(onchange);
        
        return false;
    }; 

    $("#m_import").click(importfun);
    
    var auth = readCookie("auth");
    if(auth != null)
    {   
        // TODO : Check auth here
        var logout = function()
        {
            eraseCookie("auth");
            document.location.reload(true);
        };
        var user = auth.split(":");
        $("#loginmsg").show().find("#user").text(user[0]);
        $("#logoutbutton").show().children("a").click(logout);
    }
    else
    {
        var loginshow = function()
        {
            $("#loginform").toggle();
        };
        $("#loginbutton").show().children("a").click(loginshow);

        var login = function()
        {
            var email = $("#email").val();
            var pass = $("#pass").val();
            
            if(pass!="" && email!="")
            {
                var xml = "<login>"
                    +"<email>"+ $("#email").val() +"</email>"
                    +"<password>"+ $("#pass").val() +"</password>"
                    +"</login>";
              
                var callback = function(data)
                {
                    if($(data).find("unauthorised").length == 1)
                    {
                        $("#feedback").text("Invalid Details");
                    }
                    else 
                    {
                        var token = $(data).find("token").text();
                        createCookie("auth",token,30);
                        window.location.reload( true );
                    }
                }
              $.post("/",xml,callback,xml);
            }
            else
            {
                $("#feedback").text("Enter full details");
            }
            return false;
        };
        $("#login").submit(login);
    }
};

var create_spreadsheet = function(user)
{
    var range = "a1:z50";
    
    var defaults = {
        fullscreen : true,
        range      : range,
        fmargin    : 24,
        cellChange  : function(x,y,val)
        {
            var fullurl = url+$.fn.to_b26(x+1)+y+"?attr";
            
            if(val == "")
            {
                $.post(fullurl,
                       "<delete><formula /><value/></delete>",null,"xml");
            }
            else
            {
                $.post(fullurl,
                       "<create><formula><![CDATA["+val+"]]></formula></create>",null,"xml");
            }
        },
        formatChange  : function(range,val)
        {
            $.post(url+range,
                   "<create><format><![CDATA["+val+"]]></format></create>",null,"xml");
        },
        cellSelect : function(x,y,el)
        {
            var x = $.fn.to_b26(x+1).toUpperCase();
            
            var f = formulae[(x+y)];
            el.val( (typeof f != "undefined") ? f : "");
        },
        colResize : function(col,width)
        {
            $.post(url+$.fn.to_b26(col)+"?attr",
                   "<create><width>"+width+"</width></create>",null,"xml");
        },
        rowResize : function(row,height)
        {
            $.post(url+row+"?attr",
                   "<create><height>"+height+"</height></create>",null,"xml");
        },
        cssChange : function(el,attr,val)
        {
            var ref = $.fn.cell_index(el);
            $.post(url+$.fn.to_b26((ref[0]+1))+(ref[1]+1)+"?attr",
                   "<create><"+attr+">"+val+"</"+attr+"></create>",null,"xml");
        },
        setName : function(range,name)
        {
            $.post(url+range+"?attr",
                   "<create><name>"+name+"</name></create>",null,"xml");
        }
    };
    
    $("#hn").spreadsheet(defaults);
    
    $.get("/funs.xml", function(data)
	  {
	    $(data).find("functions > category").each(function()
	    {
	        var category = $(this).attr("name");
	        $(this).children("function").each(function()
	        {
                var label = $(this).attr("label");
                var data  = $(this).attr("data");
                
	             $("#hn").spreadsheet("addFunction",
	                category,label,data);
	        }); 
	    });
	});
            
    $.clipboardReady(function()
    {
        $("#context").bind("contextmenu", function(e) 
        { 
            return false; 
        });
        
        $('#hn .data').bind("contextmenu", function(e)
        {
            if($(e.target).is("div.cell"))
            {
		var ref = $.fn.cell_index(e.target);
		var refstr = $.fn.to_b26(ref[0]+1)+(ref[1]+1);
                $("#texttocopy").text("=hn(\""+url+refstr+"?hypernumber\")");
                
                $("#contextlinks").empty();
 
                var get_base_url = function(url) 
                {
                    return url.substring(0,url.lastIndexOf("/"));
                };
                
                if(typeof parents[refstr] != "undefined")
                {
                    var par = $("<div id='parents'><strong>Parents"
                        +"</strong><div></div></div>").appendTo($("#contextlinks"));

                    $.each(parents[refstr],function()
                    {
                        par.find("div").append($("<a href='"
                            +get_base_url(this)+"'>"+this+"</a><br/>"));
                    }); 
                }
                
                if(typeof children[refstr] != "undefined")
                {
                    var par = $("<div id='children'><strong>Children"
                        +"</strong><div></div></div>").appendTo($("#contextlinks"));
                                  
                    $.each(children[refstr],function()
                    {
                        par.find("div").append($("<a href='"
                            +get_base_url(this)+"'>"+this+"</a><br/>"));
                    }); 
                }
                        
                var menu = $("#context");
                menu.css("top",e.clientY+"px").css("left",e.clientX);
                menu.show();   
                
                $("body").one('click', function()
                {
                    $("#context").hide();    
                });
            }
            
            return false;
        });
        
        $("#copyhypernumber").click(function()
        {
            $.clipboard($("#texttocopy").text());    
        });
        
        $("#formatcell").click(function()
        {
            $.clipboard($("#texttocopy").text());    
        });
                             
    },{swfpath: "/swf/jquery.clipboard.swf"}); 
}

load_data = function()
{
    $.get(url+"?pages&format=xml", function(data)
	  {
              var add = function(root,dir,path)
	      {
		  var list = $("<ul />").appendTo(root);
		    
		  $(dir).children().each(function()
			                 {
			                     var npath = $(this).attr("path");
				             npath = (npath == "/") ? "" : npath;
			                     var parent = $("<li><a href=\""+path+npath+"/\">/"+npath+"</a></li>").appendTo(list);
			                     if($(this).children().size() > 0)
			    {
				parent.children("a").addClass("x");
				add(parent,this,path+npath+"/");
			    }
			                 });
	      }
		
	      var show = function(el)
	      {
		  var x = $(el);
		  var list = x.next("ul");
		  var hide = function()
		    {
		        list.hide();
		        $(this).unbind();
		        x.one('mouseup',function() 
		              {
		                  x.one('click',function() { show(x); });
		        });
		    };
		
		    list.show();
		    x.one('mouseup',function() 
		    {
		        x.one('click',function() { hide(); });
		    });
		}
		
		$("#menu > ul li h2").one('click',function()
		{
		    show(this);
		});
		
		add($("#browse"),$(data),"");
	});    
	
	$.get(url+"?attr", function(data) 
	      {
		  $(data).find("ref").each(function(y)
		                           {
		                               handle_attr(this);
		                           });
	      });
}

function createCookie(name,value,days) 
{
	if (days) 
	{
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) 
{
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

function eraseCookie(name) 
{
	createCookie(name,"",-1);
}

