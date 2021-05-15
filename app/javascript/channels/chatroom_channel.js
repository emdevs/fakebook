import consumer from "./consumer"

document.addEventListener('turbolinks:load', function() {
    console.log("try to connect to chatroom channel");
    let chatroom_chat = document.getElementsByClassName("chatroom-chat")[0];

    //if there is chatroom found:
    if (chatroom_chat) {
        let club_id = chatroom_chat.getAttribute("data-club-id");

        //scroll to bottom automatically (chat)
        chatroom_chat.scrollTop = chatroom_chat.scrollHeight;

        consumer.subscriptions.create(
            {
                channel: "ChatroomChannel",
                club_id: club_id

            }, {

            received(data) {
                //clear input field (text area)
                document.getElementsByClassName("message-field")[0].value = "";

                //add data
                this.appendLine(data);
            },
        
            appendLine(data) {
                const html = this.createLine(data);
                const element = document.querySelector(`[data-club-id="${club_id}"]`);
                element.insertAdjacentHTML("beforeend", html);

                //smooth scroll to bottom of page
                chatroom_chat.scrollTo({ top: chatroom_chat.scrollHeight, behavior: 'smooth' });
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
    }
    
})



