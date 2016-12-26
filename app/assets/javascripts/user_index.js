$(document).on('ready page:load', function(event) {
  $(document).on('click', '#user_list_users .pagination a', function (event) {
    event.preventDefault();
    $.getScript($(this).attr('href'));
    return false;
  });
});
