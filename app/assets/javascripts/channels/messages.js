$(document).on('turbolinks:load', function () {

    console.log('__________load__________');

    var channel = "MessagesChannel";
    var room = $('input#message_room_id').val();

    if (room) {
        if (countSpecifieChannel(channel, room) == 0) {
            createChannel(channel, room);
        }
    }
})

function createChannel(channel, room) {
    console.log('createChannel channel:' + channel + ',room:' + room)

    App.cable.subscriptions.create({channel: channel, room: room}, {
        received: function (data) {
            $("#messages").removeClass('hidden');
            return $('#messages').append(this.renderMessage(data));
        },
        room: function (data) {
            return data.room
        },
        renderMessage: function (data) {
            // 現在のroomとメッセージで指定されてるroomと一致してる場合、
            var current_page_room = $('input#message_room_id').val();
            console.log("current_page_room : " + current_page_room);
            if (current_page_room == data.room) {
                console.log("<p> <b>" + data.user + ": </b>" + data.message + "</p>");
                return ("<div class=\"message\"><ul class=\"up-message\">" + data.user + "<li class=\"up-message__user-name\"></li><li class=\"up-message__date\">" + data.time + "</li></ul><ul class=\"down-message\"><li class=\"down-message__content\">" +data.message + "</li></ul></div>");

            } else {
                return
            }
        },
    });
}

/**
 * すべてのチャンネルの購読を解除する
 */
function removeAllChannel() {
    console.log('removeAllChannel');

    var subscriptions = App.cable.subscriptions['subscriptions'];

    subscriptions.forEach(function (subscription) {
        App.cable.subscriptions.remove(subscription);
    });

}

function removeSpecifiedChannel(channel, room) {
    console.log('removeSpecifiedChannel channel:' + channel + ',room:' + room);

    var subscriptions = App.cable.subscriptions['subscriptions'];

    subscriptions.forEach(function (subscription) {
        var identifier = subscription.identifier;

        obj = JSON.parse(identifier);

        if (channel == obj.channel && room == obj.room) {
            App.cable.subscriptions.remove(subscription);
        }

    });
}

function removeUnspecifiedChannel(channel, room) {
    console.log('removeUnspecifiedChannel channel:' + channel + ',room:' + room);

    var subscriptions = App.cable.subscriptions['subscriptions'];
    subscriptions.forEach(function (subscription) {
        var identifier = subscription.identifier;

        obj = JSON.parse(identifier);

        if (channel != obj.channel || room != obj.room) {
            App.cable.subscriptions.remove(subscription);
        }

    });
}

function countSpecifieChannel(channel, room) {
    console.log('countSpecifieChannel channel:' + channel + ',room:' + room);

    var i = 0;

    var subscriptions = App.cable.subscriptions['subscriptions'];
    subscriptions.forEach(function (subscription) {
        var identifier = subscription.identifier;

        obj = JSON.parse(identifier);

        if (channel == obj.channel && room == obj.room) {
            i += 1;
        }

    });
    return i;
}

function countAllChannel() {
    console.log('countAllChannel');

    var count = App.cable.subscriptions['subscriptions'].length;

    return count;
}
