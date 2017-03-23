$(document).on('turbolinks:load', function(){
  $('#serie-name').on('click', function() {
    $('#serie-name').remove();
    input = '<p><input type="text" name="name"  class="form-control" required> <button class="btn btn-primary" type="submit">Submit</button></p>';
    $('#edit_serie').append(input);
  })
});
