// app/javascript/channels/appearance_channel.js
import consumer from "./consumer"

// need eventListener and conditional because elements in appearingOn were null until page was fully loaded
document.addEventListener("turbolinks:load", function() {

  let membersPage = document.getElementById('members')
  let eventPage = document.querySelector('[id^="event-"]')

  console.log(eventPage)
  console.log(membersPage)

  if (membersPage || eventPage) {

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
        // console.log('appearance from appearanceChannel', data)
        const userId = data.user_id
        // const currentPage = data.viewing
        const eventType = data.event
        const onlineClassPresent = document.getElementById(`user-${userId}`)
        if (onlineClassPresent && eventType == 'appear') {
          console.log(userId)
          document.getElementById(`user-${userId}`).classList.add('online')
        } else {
          document.getElementById(`user-${userId}`).classList.remove('online')
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
        // Calls `AppearanceChannel#appear(data)` on the server.
        this.perform("appear", { appearing_on: this.appearingOn })
      },
    
      away() {
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
      },
    
      get appearingOn() {
    
        const element = document.querySelector("[data-appearing-on]")
        return element ? element.getAttribute("data-appearing-on") : null
    
      }
    })
  }
});
