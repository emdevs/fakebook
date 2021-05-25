import consumer from "./consumer"

consumer.subscriptions.create("OnlineChannel", {

  disconnected() {
    this.perform("unsubscribed");
  },

  received(data) {
    let online_icons = document.getElementsByClassName("online-icon");

    for (let i=0; i < online_icons.length; i++) {
      if (online_icons[i].getAttribute("data-user-id") == data["user_id"]) {
        this.changeOnlineIcon(online_icons[i], data["online"]);
      }
    }
  },

  changeOnlineIcon(node, status) {
    let [current_status, old_status] = (status === true)?
    ["isOnline", "isOffline"] :
    ["isOffline", "isOnline"];

    node.classList.add(current_status);
    node.classList.remove(old_status);
  }

  // documentIsActive() {
  //   return document.visibilityState == "visible" && document.hasFocus()
  // }
});
