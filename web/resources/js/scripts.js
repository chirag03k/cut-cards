document.getElementById("articletext").addEventListener('mouseup', function() {

    if(document.getElementById("highlight").checked == true ) {
        var selection = window.getSelection().getRangeAt(0);
        var selectedText = selection.extractContents();
        if(document.getElementById("articletext").innerText.includes(selection.toString())) {
            var span = $("<b><mark>" + selectedText.textContent + "</mark></b>");
            selection.insertNode(span[0]);

            if (selectedText.childNodes[1] != undefined){
                console.log(selectedText.childNodes[1]);
                $(selectedText.childNodes[1]).remove();
            }

            var txt = $('#articletext').html();
            $('#articletext').html(txt.replace(/<\/b>(?:\s)*<b>/g, '').replace(/<\/mark>(?:\s)*<mark>/g, ''));
        }
    }
});