$( document ).on('turbolinks:load', function() {
  $('#search_team_request_ajax').keyup(function() {
    var user_name = $('#search_team_request_ajax').val();
    var team_id = $('#search_team_id').val();
    load_team_requests(user_name,team_id);
  });
});

function load_team_requests(user_name, team_id){
  $.ajax({
    url: '/api/team_requests/',
    method: "GET",
    data: {
      user_name: user_name,
      team_id: team_id
    },
    success: function(result){
      if($('#list-team-request') !== null) $('#list-team-request').remove();
      $('#table-team-request').append(result);
    }
  });
}
