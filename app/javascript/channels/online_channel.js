import consumer from "./consumer"

consumer.subscriptions.create("OnlineChannel", {

  disconnected() {
    this.perform("unsubscribed");
  },

  received(data) {

    console.log(data);
    let online_icons = document.getElementsByClassName("online-icon");

    for (let i=0; i < online_icons.length; i++) {
      if (online_icons[i].getAttribute("data-user-id") == data["user_id"]) {
        //figure out a way to make this less coupled (online_icons[i] = / online_icons.item(i) = both dont work)
        this.changeOnlineIcon(online_icons[i], data["online"]);
      }
    }
  },

  changeOnlineIcon(node, status) {
    (status === true)? node.classList.add("isOnline") : node.classList.remove("isOnline");
  }

  // documentIsActive() {
  //   return document.visibilityState == "visible" && document.hasFocus()
  // }
});
