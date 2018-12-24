document.addEventListener("DOMContentLoaded", function(event) {
    safari.extension.dispatchMessage("Hello World!");
});
//document.addEventListener("script"), function(event) {
//    console.log("asdfal;sdfjkl;as dfj;lasdfj al;sjf l;asdf");
//    document.style.backgroundColor = "red";
//});

safari.self.addEventListener("message", handleMessage);

function handleMessage(event) {
    if (event.name == "close") {
        document.body.innerHTML = '<div style="position:absolute;width:100%;height:100%;opacity:0.3;z-index:100;background:#000;"></div>';
    }
}
