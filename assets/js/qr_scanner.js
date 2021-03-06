import jsQR from 'jsqr'

class QRScanner {
  start() {
    const video = document.createElement('video')
    const canvasElement = document.getElementById('canvas')
    const canvasWrapper = document.getElementById('canvasWrapper')
    const canvas = canvasElement.getContext('2d')
    const loadingMessage = document.getElementById('loadingMessage')
    const scanTitle = document.getElementById('scanTitle')
    const outputContainer = document.getElementById('output')
    const outputMessage = document.getElementById('outputMessage')
    const outputData = document.getElementById('outputData')
    function drawLine(begin, end, color) {
      canvas.beginPath()
      canvas.moveTo(begin.x, begin.y)
      canvas.lineTo(end.x, end.y)
      canvas.lineWidth = 4
      canvas.strokeStyle = color
      canvas.stroke()
    }
    // Use facingMode: environment to attempt to get the front camera on phones
    navigator.mediaDevices
      .getUserMedia({ video: { facingMode: 'environment' } })
      .then(function(stream) {
        video.srcObject = stream
        video.setAttribute('playsinline', true) // required to tell iOS safari we don't want fullscreen
        video.play()
        requestAnimationFrame(tick)
      })
    function tick() {
      loadingMessage.innerText = '⌛ Loading video...'
      if (video.readyState === video.HAVE_ENOUGH_DATA) {
        loadingMessage.hidden = true
        canvasElement.hidden = false
        outputContainer.hidden = false
        canvasElement.height = canvasWrapper.clientHeight
        canvasElement.width = canvasWrapper.clientWidth
        canvas.drawImage(video, 0, 0, canvasElement.width, canvasElement.height)
        const imageData = canvas.getImageData(
          0,
          0,
          canvasElement.width,
          canvasElement.height
        )
        const code = jsQR(imageData.data, imageData.width, imageData.height, {
          inversionAttempts: 'dontInvert',
        })
        if (code) {
          drawLine(
            code.location.topLeftCorner,
            code.location.topRightCorner,
            '#FF3B58'
          )
          drawLine(
            code.location.topRightCorner,
            code.location.bottomRightCorner,
            '#FF3B58'
          )
          drawLine(
            code.location.bottomRightCorner,
            code.location.bottomLeftCorner,
            '#FF3B58'
          )
          drawLine(
            code.location.bottomLeftCorner,
            code.location.topLeftCorner,
            '#FF3B58'
          )
          outputMessage.hidden = true
          outputData.parentElement.hidden = false

          const event = new CustomEvent('scanned', { detail: code.data })
          canvasElement.dispatchEvent(event)
          outputData.innerText = code.data
        } else {
          outputMessage.hidden = false
          outputData.parentElement.hidden = true
        }
      }
      requestAnimationFrame(tick)
    }
  }
}

export default QRScanner
