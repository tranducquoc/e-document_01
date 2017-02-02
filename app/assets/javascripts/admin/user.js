$( document ).on('turbolinks:load', function() {
  $('#search_user').keyup(function() {
    var user_name = $('#search_user_ajax').val();
    load_users(user_name);
  });
});

function load_users(user_name){
  if($('#users-list-admin') !== null) $('#users-list-admin').remove();
  $.ajax({
    url: '/api/users/',
    method: "GET",
    data: {
      user_name: user_name
    },
    success: function(result){
      $('#table-users-admin').append(result);
    }
  });
}
