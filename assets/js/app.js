// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from '../css/app.css'

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import 'phoenix_html'
import { Socket } from 'phoenix'
import LiveSocket from 'phoenix_live_view'

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
import QRScanner from './qr_scanner'
window.QRScanner = QRScanner

let Hooks = {}

// Would be great if these hooks were in a file related to where it is used
// Doesn't seem possible however
Hooks.Scanner = {
  mounted() {
    this.el.addEventListener('scanned', event => {
      this.pushEvent('scanned', event.detail)
    })
  },
}

Hooks.Seats = {
  mounted() {
    document.dispatchEvent(new Event('seats-shuffled'))
  },
  updated() {
    document.dispatchEvent(new Event('seats-shuffled'))
  },
}

let liveSocket = new LiveSocket('/live', Socket, { hooks: Hooks })
liveSocket.connect()
