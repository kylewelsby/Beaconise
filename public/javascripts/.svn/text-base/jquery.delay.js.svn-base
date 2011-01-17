// Delay Plugin for jQuery
// - http://james.padolsey.com/javascript/jquery-delay-plugin/
// - © 2009 James Padolsey

jQuery.fn.delay = function(time, callback){
    // Empty function:
    jQuery.fx.step.delay = function(){};
    // Return meaningless animation, (will be added to queue)
    return this.animate({delay:1}, time, callback);
}