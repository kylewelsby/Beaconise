$(document).ready(function(){
	if(jQuery.autogrow){
		$("textarea.autogrow").autogrow({
			min_height:'30px'
		});
	}
	
	$("#flash").corner("10px").css({
		left: ($("body:first").width()-$("#flash").width())/2 + 'px'
	}).show().animate({
		bottom : '30px'
	}, 1000, 'easeOutBack').
	delay(2000).
	fadeOut(4000, 'easeInExpo', function(){$(this).remove();});
	
	// helper functions for Ajaxifying standard links and forms, and evaluating returned Javascript
	$("a.rjs").click( function() {
		$.ajax({
			url: this.href,
			dataType: "script",
			beforeSend: function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");}
		});
		return false;
	});

	$("a.rjs-delete").click( function() {
		$.ajax({
			type: "DELETE",
			url: this.href,
			dataType: "script",
			beforeSend: function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");}
		});
		return false;
	});

	
	// requires jQuery.form plugin
	$("form.rjs").ajaxForm({
		dataType: "script",
		beforeSend: function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");},
		resetForm: true
	});

	$('.hide').hide();
	
	$('a.clickDisplay').click(function(){
		$(this).parent().next('.hide').toggle('fast').show();
	});
	
	// Rounded Corners
	$("#advert_scape #widescape").corner("10px");
	$("#advert_scape #shortscape li:first").corner("tr 10px");
	$("#advert_scape #shortscape li:last").corner("br 10px");
	$(".section_container").corner();
	$(".rounded").corner();
	$("fieldset").corner();
	$("ul#footerStats").corner("bl br 10px");
	$(".gallery .title").corner("tl bl");
	$(".toggleButton li:first a").corner("tl bl 5px");
	$(".toggleButton li:last a").corner("tr br 5px");
	
	// Rounded Image
	$(".imgRounded").each(function(){
		$(this).wrap('<span class="imgRoundedWrapper"></span>');
		$(this).parent().prepend('<img src="/images/ui/roundedImage.png" class="imgRoundedSprite"/>');
		$(this).parent().addClass($(this).attr('class'));
		$(this).parent().removeClass('imgRounded');
	});
	
	// Details PopUp
	var distance = 10;
	var time = 400;
	var hideDelay = 500;
	var hideDelayTimer = null;
	var details = null;

	$('.clickable:first').closest("body").prepend('<div id="details_bubble"></div>');
	$('#details_bubble').css({
		display:'none',
		opacity:0
	}).corner("10px").append('<img src="/images/ui/detailsTipBottom.png" width="18" height="10" class="UIBottomTipArr"/>');
	$('.clickable').mouseenter(function(){
		if(hideDelayTimer) clearTimeout(hideDelayTimer);
		if($('body').hasClass('fullProfile')){
			addustX = 140;
			addustY = 80;
		}else{
			addustX = 0;
			addustY = 0;
		}
		left = Math.round($(this).offset().left + ($(this).width() / 2) - addustX);
		// top = Math.round($(this).find('img').offset().top - $(this).parent().get(0).offset().top);
		// top = Math.round($(this).find('img').offset().top - $('#details_bubble').height() - 20);
		var str = $(this).find(".details").html();
		$("#details_bubble").stop(false, true).html(
			str
		).append('<img src="/images/ui/detailsTipBottom.png" width="18" height="10" class="UIBottomTipArr"/>').css({
			position: 'absolute',
			width: '180px',
			marginLeft: '-95px',
			display: 'block',
			opacity: 1
		}).animate({
			left: left,
			top: Math.round($(this).offset().top - $('#details_bubble').height() - 20 - addustY),	
			// opacity: 1
		},time, 'swing');
	}).mouseleave(function(){
		if(hideDelayTimer) clearTimeout(hideDelayTimer);
		
		hideDelayTimer = setTimeout(function(){
			$("#details_bubble").stop(false, true).animate({
				opacity: 0,
				position: 'absolute',
				top: '-300px'
			})
		},hideDelay);
	});
	
	// List Helper
	$('ul li:first-child').addClass("first");
	$('ul li:last-child').addClass("last");
	
	$(function(){
		var path = location.pathname.substring(1);
		if(path){
			// $('ul li a[href="' + path + '"]').parent().attr('class', 'current');
		}
		$('li.current a').corner("bl")
	});
	
	// Clickable List
	$('li.clickable').each(function(){	
		$(this).css('cursor', 'pointer').click(function(){
			window.location = $('a', this).attr('href')
		});
	});
	
	// Form Validation
	$('.required').each(function(){
		var inputID = $(this).attr('id');
		$('label[for='+inputID+']').prepend('<em>*</em>');
	});
	
	// $('form.validate').validate();
	
	// Comment AJAX
	
	// Form Textarea
	
	$('textarea.required').each(function(){
		submit = $(this).offsetParent("form").find('button[type="submit"]');
		submit.attr("disabled", true);
		$(this).attr("rel", $(this).val());
		$(this).focus(function(){
			if($(this).val() == $(this).attr("rel")){
				$(this).attr("value", '').css({color: '#000000', height: '50px'});
				submit.removeAttr("disabled");
			} 
		}).blur(function(){
			if($(this).val() == ''){
				$(this).attr("value", $(this).attr("rel")).css({color: '#7f7f7f', height: '30px'});
				submit.attr("disabled", true);
			}
		});
	});
	
	// Auto Complete
	// $('input.autocomplete').each(function(){
	// 	var $input = $(this);
	// 	$input.autocomplete($input.attr('autocomplete_url'));
	// });
	$('input.autocomplete').each(function(){
		var input = $(this);
		input.autocomplete(input.attr('autocomplete_url'),{
			width: 300
		});
	});

	
	// Navigation settings

	$("#navigation li ul").addClass("navigation_child");
	
	$("ul.navigation_child").parent().append("<span></span>"); //Only shows drop down trigger when js is enabled (Adds empty span tag after ul.subnav*)  
  
    $("ul.navigation_parent li span").click(function() { //When trigger is clicked...  
  
        //Following events are applied to the subnav itself (moving subnav up and down)  
        $(this).parent().find("ul.navigation_child").slideDown('fast').show(); //Drop down the subnav on click  
  
        $(this).parent().hover(function() {  
        }, function(){  
            $(this).parent().find("ul.navigation_child").slideUp('slow'); //When the mouse hovers out of the subnav, move it back up  
        });  
  
        //Following events are applied to the trigger (Hover events for the trigger)  
        }).hover(function() {  
            $(this).addClass("hover"); //On hover over, add class "subhover"  
        }, function(){  //On Hover Out  
            $(this).removeClass("hover"); //On hover out, remove class "subhover"  
    });

});