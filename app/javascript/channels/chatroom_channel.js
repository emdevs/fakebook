import consumer from "./consumer"

//keep track of subscribed club ids. dont allow user to subscribe more than once to same club. 
let subscribed_club_ids = [];

document.addEventListener('turbolinks:load', function() {
    let chatroom_chat = document.getElementsByClassName("chatroom-chat")[0];

    //if there is chatroom found:
    if (chatroom_chat) {
        //automatically scroll to bottom.
        chatroom_chat.scrollTop = chatroom_chat.scrollHeight;
        let club_id = chatroom_chat.getAttribute("data-club-id");

        //is chatroom already subscribed to?
        if (!subscribed_club_ids.includes(club_id)){
            //not subscribed yet;
            consumer.subscriptions.create(
                {
                    channel: "ChatroomChannel",
                    club_id: club_id

                }, {

                connected() {
                    subscribed_club_ids.push(club_id);
                },

                received(data) {
                    //clear input field (text area)
                    document.getElementById("message-form").reset();
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
                        <div class="message bg-light shadow-sm p-2 m-2 rounded">
                            <div class="text">
                                <div class="meta-info d-flex">
                                    <p class="name m-0 text-primary">${data["user"]["name"]}</p>
                                    <p class="datetime m-0 px-2 text-muted">${"a few seconds ago"}</p>
                                </div>
                                <p class="msg m-0">${data["message"]["message"]}</p>
                            </div>
                        </div>
                    `
                }
            })    
        }
    }
    
})