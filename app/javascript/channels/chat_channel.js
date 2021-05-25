import consumer from "./consumer"

//keep track of all chat ids already subscribed to. prevent from subscribing to same channel multiple times.
let subscribed_chat_ids = [];

//need to save a current_Id when first subscribed

document.addEventListener('turbolinks:load', function() {
    const chats_page = document.getElementById("chats");

    if (chats_page) {
        const chat_partners = document.getElementById("chat-partners");

        //check for ajax success events from chat_partners column. (ajax success signals a convo partial being displayed)
        chat_partners.addEventListener("ajax:success", function() {
            let private_chat = document.getElementsByClassName("private-chat")[0];

            if (private_chat) {
                //scroll to bottom of chat
                private_chat.scrollTop = private_chat.scrollHeight;
                let chat_id = private_chat.getAttribute("data-chat-id");
                let partner_id = private_chat.getAttribute("data-partner-id");

                //if not subscribed to channel then subscribe
                if (!subscribed_chat_ids.includes(chat_id)) {
                    consumer.subscriptions.create(
                        {
                            channel: "ChatChannel",
                            chat_id: chat_id
    
                        }, {
    
                        connected() {
                            subscribed_chat_ids.push(chat_id);
                        },
    
                        received(data) {
                            document.getElementById("message-form").reset();
                            this.appendLine(data);
                        },
                    
                        appendLine(data) {
                            //need to update private_chat for scroll to work, or else height will result in 0
                            let private_chat = document.getElementsByClassName("private-chat")[0];
                            const html = this.createLine(data);
                            const element = document.querySelector(`[data-chat-id="${chat_id}"]`);
                            element.insertAdjacentHTML("beforeend", html);
                
                            private_chat.scrollTo({ top: private_chat.scrollHeight, behavior: 'smooth' });
                        },
                    
                        createLine(data) {
                            let styling = (partner_id == data["message"]["user_id"])? "them" : "me";
    
                            return `
                                <div class="message rounded shadow-sm px-2 py-1 m-2 ${styling}">
                                    <div class="text">
                                        <div class="meta-info">
                                            <p class="datetime text-muted m-0">${data["datetime"]}</p>
                                        </div>
                                        <p class="msg">${data["message"]["message"]}</p>
                                    </div>
                                </div>
                            `
                        }
                    })    
                }
            }            
        })
    } 
})