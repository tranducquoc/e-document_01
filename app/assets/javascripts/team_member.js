$( document ).on('turbolinks:load', function() {
  $('#search_team_member_ajax').keyup(function() {
    var user_name = $('#search_team_member_ajax').val();
    var team_id = $('#search_team_id').val();
    load_team_members(user_name,team_id);
  });
});

function load_team_members(user_name, team_id){
  $.ajax({
    url: '/api/team_members/',
    method: "GET",
    data: {
      user_name: user_name,
      team_id: team_id
    },
    success: function(result){
      if($('#list-team-member') !== null) $('#list-team-member').remove();
      $('#table-team-member').append(result);
    }
  });
}
