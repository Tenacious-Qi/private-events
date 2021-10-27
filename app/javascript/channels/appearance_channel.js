// app/javascript/channels/appearance_channel.js
import consumer from "./consumer"

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
    const userId = data.user_id
    const radioIcon = document.getElementById(`icon-user-${userId}`)
    const eventType = data.event
    if (radioIcon) {
      switch (eventType) {
        case 'appear':
          addOnlineIconClass(radioIcon);
          break;
        case 'away':
          addAwayIconClass(radioIcon);
          break;
        case 'disappear':
          removeIconClasses(radioIcon);
      }
    }

  },

  // Called when the subscription is rejected by the server.
  rejected() {
    this.uninstall()
  },

  update() {
    documentIsActive() ? this.appear() : this.away()
  },

  appear() {
    // Calls `AppearanceChannel#appear` on the server.
    this.perform("appear")
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
})


function documentIsActive() {
  return document.visibilityState === "visible" && document.hasFocus()
}

function addOnlineIconClass(icon) {
  icon.classList.remove('gray-away-icon')
  icon.classList.add('green-online-icon')
}

function addAwayIconClass(icon) {
  icon.classList.remove('green-online-icon')
  icon.classList.add('gray-away-icon')
}

function removeIconClasses(icon) {
  icon.classList.remove('green-online-icon')
  icon.classList.remove('gray-away-icon')
}