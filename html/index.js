$(function () {
    function display(bool) {
        if (bool) {
            $(".container").show();
        } else {
            $(".container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "FalconStorenui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://Falcon/close', JSON.stringify({}));
            return
        }
    };
    $("#Gun").click(function () {
        $.post('https://Falcon/Gun', JSON.stringify({}));
        return;
    })
})