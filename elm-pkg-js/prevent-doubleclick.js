exports.init = function () {

    if (window.alreadyPreventsDoubleClick) {
        return
    }

    window.alreadyPreventsDoubleClick = true

    // Prevent double click to zoom, which is annoying on mobile
    let lastTouchEnd = 0;
    document.addEventListener('touchend', function (event) {
        let now = (new Date()).getTime();
        if (now - lastTouchEnd <= 300) {
            event.preventDefault();
        }
        lastTouchEnd = now;
    }, false);
}