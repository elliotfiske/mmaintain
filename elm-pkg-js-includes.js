
const sizeObserver = require('./elm-pkg-js/element-size-observer.js')
const dialogHelper = require('./elm-pkg-js/dialog.js')

exports.init = async function init(app) {
    await sizeObserver.init(app)
    await dialogHelper.init(app)
}