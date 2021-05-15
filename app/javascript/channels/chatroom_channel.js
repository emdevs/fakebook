import consumer from "./consumer"
//its like consumer isnt even subscribed doesnt matter if subsribes tow rong channel,
//issue is it isnt subscribing at ALL
//will chatroom model info be passed here? in params etc?

//might need to specify room in chatroom channel 
consumer.subscriptions.create({ channel: "ChatroomChannel", club_id: 4 }, {
    connected(){
        console.log("connected!");
    },

    received(data) {
        console.log(data);
        this.appendLine(data)
    },

    appendLine(data) {
        const html = this.createLine(data);
        // const element = document.querySelector("[data-chat-room='chatroom-1']")
        const element = document.getElementById("chatroom-1");
        element.insertAdjacentHTML("beforeend", html)
    },

    createLine(data) {
        return `
            <div class="message">
                <div class="text">
                    <p class="name">${data["user"]["name"]}</p>
                    <p>${data["message"]["message"]}</p>
                </div>
            </div>
        `
    }
})



// $(document).on("turbolinks:load", function() {
// <img src="${data["img"]}" alt="user profile pic">
// })
