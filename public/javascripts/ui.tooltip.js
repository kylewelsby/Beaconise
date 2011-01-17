/*
 * jQuery UI Tooltip
 *
 * Depends:
 *	    ui.core.js
 */
 
(function($) {
$.widget("ui.tooltip", {
    
    init: function() {
        if(this.options.mode == 'hover'){
            $(this.element).hover(hoverHandler,outHandler);
        }
        else if(this.options.mode == 'focus'){
            $(this.element).focus(hoverHandler);
            $(this.element).blur(outHandler);
        }
        else if(this.options.mode == 'manual'){
        }
    },
    
    show: function(){
        var o = this.options;
        
        if(o.mode=='manual'){
            prepare(this.element,o);
        }
        
        $(o.tooltip).show();
    },
    
    hide: function(){
        var o = this.options;
        $(o.tooltip).hide();
    }
});    

$.extend($.ui.tooltip, {
    defaults: {
        tooltip: '',
        onShow: undefined,
        onHide: undefined,
        mode: 'hover',
        // provide a speed for the animation
        speed: 1000,
        // provide a period for the popup to keep showing
        period: 2000, 
        // default the animation algorithm to the basic slide
        animation:'slide'
    },
    animations: {
        slide: function(e, options) {
            
        },
        fade: function(e, options) {
            
        }
    }
});

function hoverHandler(event)
{
    //Fetch Options
    var o = $.data(this,'tooltip').options;
    
    //Element who raised the event
    var $this = $(this);
    
    //Helper functon for Positioning and Calling Callback function
    prepare($this,o);
    
    //Call Show method of the tooltip Widget,
    //Show method should play on any required animations
    $.data(this,'tooltip').show();
};
function outHandler(event)
{
    //Fetch Options
    var o = $.data(this,'tooltip').options;
    
    //Get tooptip Element
    var $tooltip =  $(o.tooltip);
    
    //If call back method defined, initiate the call
    if($.data(this,'tooltip').options.onHide){
	    $.data(this,'tooltip').options.onHide.call(this, {target:$(this)});
	}
    
    //Call Hide method of the tooltip Widget,
    //Hide method should play on any required animations
    $.data(this,'tooltip').hide();
};
function prepare(jObj, options)
{
    var $tooltip =  $(options.tooltip);
    var element = jObj[0];
    var offset = jObj.offset();
    
    var left = offset.left + jObj.width();
    var top = offset.top-5;
    
    if(options.onShow){
	    options.onShow.call(this, {target:jObj});
	}
	
	if($(window).width()-offset.left <= $tooltip.width()) {
	    left = offset.left - $tooltip.width();
	}	
	else{
	    left += 5;
	}
	$tooltip.css({position:'absolute', top:top+'px', left:left+'px'});
};

})(jQuery);