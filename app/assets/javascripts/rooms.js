$(document).on('turbolinks:load', function() {
    submitNewMessage();
});

function submitNewMessage(){
    $('#new_message').keydown(function(event) {
        if (event.keyCode == 13) {
            $('[data-send="message"]').click();
            $('[data-textarea="message"]').val(" ")
            return false;
        }
    });
};
