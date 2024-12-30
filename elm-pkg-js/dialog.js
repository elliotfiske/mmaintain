
customElements.define('modal-dialog',
    class extends HTMLElement {
        static observedAttributes = ['open']
        #isConnected = false

        connectedCallback() {
            this.#setContent()
            this.#isConnected = true
        }

        attributeChangedCallback() {
            if (this.#isConnected) this.#setContent()
        }

        #setContent() {
            const isOpen = this.getAttribute('open') !== null
            const dialog = this.querySelector('dialog')
            if (dialog) {
                if (isOpen) {
                    dialog.showModal()
                } else {
                    dialog.close()
                }
            }
        }
    }
)

exports.init = async function(app) {
    console.log("Instantiated custom modal dialog component")
}