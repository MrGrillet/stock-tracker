$(document).ready(function(){
  $('#friend-lookup-form').on('ajax:complete', function(event, data, status){
    $('#results').html(data.responseText)
  })
})