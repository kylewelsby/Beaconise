jQuery.fn.datetimepicker = function(o) {
	
	return this.each(function(){
		var options = o || {dateFormat: 'yy-mm-dd'};
		markerClass = "hasDatetimepicker";

		function render(){
			if(!$('#ui-datetimepicker').length){
				var template = '<div id="ui-datetimepicker" style="display:none;">';
				template += '<div id="ui-datepicker-render"></div>'
				template += '<div class="ui-timepicker ui-corner-all">';
				template += '	<div class="ui-timepicker-header ui-widget-header ui-helper-clearfix ui-corner-all">';
				template += '		<div class="ui-timepicker-title">Time <span class="ui-timepicker-hour">00</span>:<span class="ui-timepicker-minute">00</span></div>';
				template += '	</div>';
				template += '	<table class="ui-timepicker-sliders" border="0">';
				template += '		<thead>';
				template += '			<tr>';
				template += '				<th width="50%"><span title="Hour">Hour</span></th>';
				template += '				<th width="50%"><span title="Minute">Minute</span></th>';
				template += '			</tr>';
				template += '		</thead>';
				template += '		<tbody>';
				template += '			<tr>';
				template += '				<td align="center">';
				template += '					<div id="hourSlider"></div>';
				template += '				</td>';
				template += '				<td align="center">';
				template += '					<div id="minuteSlider"></div>';
				template += '				</td>';
				template += '			</tr>';
				template += '		</tbody>';
				template += '	</table>';
				// template += '<a href="#" class="ui-close-button">Close</a>';
				template += '</div>';
				template += '</div>';

				$('body').append(template);
				
				$("#hourSlider").slider({
					orientation: "vertical",
					range: 'min',
					min:0,
					max:23,
					step:1,
					slide: function(event, ui){
						writeDate(writeTime(ui.value,'hour'),'time')
					},
					change: function(event, ui){
						$(".ui-timepicker-hour").effect('highlight',1000);
					}
				});

				$("#minuteSlider").slider({
					orientation: "vertical",
					range: 'min',
					min:0,
					max:50,
					step:10,
					slide: function(event, ui){
						writeDate(writeTime(ui.value,'minute'),'time')
					},
					change: function(event, ui){
						$(".ui-timepicker-minute").effect('highlight',1000);
					}
				});
				
				options.onSelect = function(date){
					writeDate(date);
				};

				$("#ui-datepicker-render").datepicker(options);
				
			} // endif 
		} // end render()
		
		render();
		
		
		$(this).bind('focus',function(){
			var top = $(this).offset().top+$(this).outerHeight(),
			left = $(this).offset().left;
			parseTime(this);
			
			$('#ui-datetimepicker').css({
				left: left+'px',
				top: top+'px'
			}).fadeIn('normal').addClass(markerClass);

			el = $('#ui-datetimepicker');
			el.data('inputfield',this);
			// console.log($(options.minEl).attr('value'));
			// console.log($(el.data('inputfield')));
			if($(options.maxEl).attr('id') == $(el.data('inputfield')).attr('id')){
				date = $.datepicker.parseDate('yy-mm-dd',$(options.minEl).val());
				// date = $('#ui-datetimepicker').data("lastdate");
				console.log($(options.minEl).attr('value'));
				$('#ui-datepicker-render').datepicker("option",'minDate',date);
			}
			el.mouseleave(closeElement).find('.ui-close-button').click(closeElement);
		}); // end Bind Focus

		function closeElement(){
			el = $('#ui-datetimepicker');
			if(el.hasClass(markerClass)){
				el.fadeOut('fast',function(){
					// el.remove();
					
				});
				return false;
			}
		}
		
		function parseTime (obj) {

			var time = ($(obj).val() || $(this).val()).split(" "),
			storeEl = $('#ui-datetimepicker'),
			today = new Date();
			today = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
			
			if (time.length < 2) {
				time = [today,'00:00:00'];
			}

			storeEl.data('lastdate',time[0]);
			storeEl.data('lasttime',time[1]);					
			time = time[1].split(":");					

			if (time.length < 2) {
				time = ['00','00','00'];
			}

			var hour	= time[0] || '00';
			var minute 	= time[1] || '00';

			writeTime(hour,'hour');
			writeTime(minute,'minute');

			$('.hourSlider').slider('option', 'value', hour);
			$('.minuteSlider').slider('option', 'value', minute);
				
			result = storeEl.data('lastdate')+' '+storeEl.data('lasttime');
			$("#ui-datepicker-render").datepicker('setDate', $.datepicker.parseDate('yy-mm-dd',storeEl.data('lastdate')));
		}

		function writeTime(fragment,type) {
			var time = '',
			hourEl = $('.ui-timepicker-hour'),
			minEl = $('.ui-timepicker-minute');
			switch (type) {
				case 'hour':
					var hours = parseInt(fragment,10);

					if (hours < 10) {
						hours = '0'.concat(hours);
					}
					if (fragment < 10) {
						fragment = '0'.concat(parseInt(fragment));
					}

					hourEl.text(hours);

					time = fragment+':'+minEl.text();						
					break;
				case 'minute':
					minutes = ((fragment < 10) ? '0' :'') + parseInt(fragment,10);
					minEl.text(minutes);

					time = hourEl.text()+':'+minutes;  						
					break;
			}
			return time;
		}

		function writeDate (text,type) {
			var storeEl = $('#ui-datetimepicker');
			switch (type) {
				case 'time':
					storeEl.data('lasttime',text+':00');						
					break;	
				default:
					storeEl.data('lastdate',text);												
			}
			datetime = storeEl.data('lastdate')+' '+storeEl.data('lasttime');
			$(storeEl.data('inputfield')).val(datetime);
			
		}

	});
}