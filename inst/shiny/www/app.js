panelCollapse = function(obj) {
  $panel = $(obj).parent()
  $content = $panel.children(".panel-body, .panel-footer")
  if($panel.hasClass("open")) {
    $content.stop().slideUp(500, function(){$panel.removeClass("open")})
  }
  else {
    $content.stop().slideDown(500, function(){$panel.addClass("open")})
  }
}

Shiny.addCustomMessageHandler('setInputState', function(message) {
  $input = $("#" + message.id)
  $input.removeClass("has-error has-warning has-success")
  if(typeof message.state == "string") $input.addClass("has-" + message.state)
});
