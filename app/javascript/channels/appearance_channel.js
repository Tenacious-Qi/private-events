// app/javascript/channels/appearance_channel.js
import consumer from "./consumer"

// need eventListener and conditional because elements in appearingOn were null until page was fully loaded
document.addEventListener("turbolinks:load", function() {

    consumer.subscriptions.create("AppearanceChannel", {

      // Called once when the subscription is created.
      initialized() {
        this.update = this.update.bind(this)
      },
    
      // Called when the subscription is ready for use on the server.
      connected() {
        this.install()
        this.update()
      },
    
      // Called when the WebSocket connection is closed.
      disconnected() {
        this.uninstall()
      },

      received(data) {
        const eventType = data.event
        const userId = data.user_id
        const radioIcon = document.getElementById(`icon-user-${userId}`)
        if (radioIcon) {
          switch (eventType) {
            case 'appear':
              radioIcon.classList.add('green-online-icon')
              break;
            case 'away':
              radioIcon.classList.remove('green-online-icon')
              radioIcon.classList.add('gray-away-icon')
              break;
            case 'disappear':
              radioIcon.classList.remove('green-online-icon')
              radioIcon.classList.remove('gray-away-icon')
          }
        }
      },
    
      // Called when the subscription is rejected by the server.
      rejected() {
        this.uninstall()
      },  
    
      update() {
        this.documentIsActive ? this.appear() : this.away()
      },
    
      appear() {
        // Calls `AppearanceChannel#appear` on the server.
        this.perform("appear")
      },
    
      away() {
        console.log('AWAY CALLED!!!')
        // Calls `AppearanceChannel#away` on the server.
        this.perform("away")
      },
    
      install() {
        window.addEventListener("focus", this.update)
        window.addEventListener("blur", this.update)
        document.addEventListener("turbolinks:load", this.update)
        document.addEventListener("visibilitychange", this.update)
      },
    
      uninstall() {
        window.removeEventListener("focus", this.update)
        window.removeEventListener("blur", this.update)
        document.removeEventListener("turbolinks:load", this.update)
        document.removeEventListener("visibilitychange", this.update)
      },
    
      get documentIsActive() {
        return document.visibilityState == "visible" && document.hasFocus()
      }
    })
});
