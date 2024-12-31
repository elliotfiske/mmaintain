
exports.init = async function(app) {

    requestAnimationFrame(() => {

        const element = document.getElementById('main-map')
        const observer = new ResizeObserver(entries => {
            const entry = entries[0]
            if (entry) {
                const { width, height } = entry.contentRect
                app.ports.receiveElementSize.send({ width, height })
            }
        })

        observer.observe(element)
    })
}