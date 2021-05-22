import consumer from "./consumer"

document.addEventListener('turbolinks:load', function() {

    //check if this is chats page (if not and subscribed, probably unsubscribe)
    const chats_page = document.getElementById("chats");

    if (chats_page) {
        const chat_partners = document.getElementById("chat-partners");

        //check for ajax success events from chat_partners column. (which renders another convo partial, which user needs to subscibe to )
        chat_partners.addEventListener("ajax:success", function() {

            let private_chat = document.getElementsByClassName("private-chat")[0];

            //if there is private chat found:
            if (private_chat) {
                let chat_id = private_chat.getAttribute("data-chat-id");
                private_chat.scrollTop = private_chat.scrollHeight;

                consumer.subscriptions.create(
                    {
                        channel: "ChatChannel",
                        chat_id: chat_id

                    }, {

                    received(data) {
                        //clear input field (text area)
                        document.getElementsByClassName("message-field")[0].value = "";
                        //add data
                        this.appendLine(data);
                    },
                
                    appendLine(data) {
                        const html = this.createLine(data);
                        const element = document.querySelector(`[data-chat-id="${chat_id}"]`);
                        element.insertAdjacentHTML("beforeend", html);

                        //smooth scroll to bottom of page
                        private_chat.scrollTo({ top: private_chat.scrollHeight, behavior: 'smooth' });
                    },
                
                    createLine(data) {
                        let styling = (data["current_user_id"] == data["message"]["user_id"])? "me" : "them";

                        return `
                            <div class="message p-2 my-2 ${styling}">
                                <div class="text">
                                    <div class="meta-info d-flex">
                                        <p class="name">${data["user"]["name"]}</p>
                                        <p class="datetime">${data["datetime"]}</p>
                                    </div>
                                    <p class="msg">${data["message"]["message"]}</p>
                                </div>
                            </div>
                        `
                    }
                })    
            }
        })
    } 
})
