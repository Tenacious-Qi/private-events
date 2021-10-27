// app/javascript/channels/appearance_channel.js
import consumer from "./consumer"

const messageInput = document.getElementById('message-input')
const membersList = document.getElementById('members-list')

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
    // event pages may contain more than one icon associated with a single user 
    // if a user is both invited and attending
    const radioIcons = document.querySelectorAll(`#icon-user-${userId}`)
    if (radioIcons) {
      const eventType = data.event
      radioIcons.forEach(icon => {
        switch (eventType) {
          case 'appear':
            addOnlineIconClass(icon);
            break;
          case 'away':
            addAwayIconClass(icon);
            break;
          case 'disappear':
            removeIconClasses(icon);
        }
      })
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
    if (messageInput && membersList) {
      messageInput.addEventListener("click", this.update)
      membersList.addEventListener("click", this.update)
    }
    window.addEventListener("focus", this.update)
    window.addEventListener("blur", this.update)
    document.addEventListener("turbolinks:load", this.update)
    document.addEventListener("visibilitychange", this.update)
  },

  uninstall() {
    if (messageInput && membersList) {
      messageInput.removeEventListener("click", this.update)
      membersList.removeEventListener("click", this.update)
    }
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