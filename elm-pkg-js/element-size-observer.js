
exports.init = async function(app) {

    function observeElementIfExists() {
        const element = document.getElementById('main-map')
        const observer = new ResizeObserver(entries => {
            const entry = entries[0]
            if (entry) {
                const { width, height } = entry.contentRect
                app.ports.receiveElementSize.send({ width, height })
            }
        })

        if (element) {
            observer.observe(element)
        } else {
            requestAnimationFrame(observeElementIfExists)
        }
    }

    requestAnimationFrame(observeElementIfExists)
}