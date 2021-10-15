import consumer from "./consumer"

const messageChannel = consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const messageDisplay = document.querySelector('#message-display')
    messageDisplay.insertAdjacentHTML('beforeend', this.template(data))
    autoScroll(messageDisplay)
  },

  template(data) {
    const timeOfComment = utcFormattedTime();
    return `<article class="message is-info">
              <div class="message-header">
                <p>${data.user.name}</p>
                <p>${timeOfComment}</p>
              </div>
              <div class="message-body">
                <p>${data.body}</p>
              </div>
            </article>`
  }
});

const autoScroll = (messageDisplay) => {
  messageDisplay.scrollTop = messageDisplay.scrollHeight
}

const utcFormattedTime = () => {
  const today = new Date();
  const date = today.getUTCFullYear()+'-'+(today.getUTCMonth()+1)+'-'+today.getUTCDate();
  const time = today.getUTCHours() + ":" + today.getUTCMinutes() + ":" + today.getUTCSeconds();
  return `${date} ${time} UTC`
}
