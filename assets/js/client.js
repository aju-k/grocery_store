let client = {

    init(socket) {
        let channel = socket.channel('room:lobby', {})
        channel.join()
        this.listenForChats(channel)
    },

    listenForChats(channel) {

        document.getElementById('btnPost').addEventListener('click', function(e) {
            e.preventDefault()
            let userMsg = document.getElementById('user-msg').value;
            let senderId = document.getElementById('sender-id').value;
            // let receiverId = document.getElementById('receiver-id').value;
            let payloadObj = { body: userMsg, sender_id: senderId }
            channel.push('shout', payloadObj)
            let senderMsgHtml = `<div class="outgoing_msg">
                                <div class="sent_msg">
                                    <p>${payloadObj.body}</p>
                                    <span class="time_date"> 11:01 AM    |    June 9</span> </div>
                                </div>`;
            $('.msg_history').append(senderMsgHtml);
            document.getElementById('user-msg').value = '';
        })

        channel.on('shout', payload => {
            console.log("== REPLY ==", payload)
            let loggedInUserId = $('#current_user_id').val();
            if (payload.sender_id == loggedInUserId) {
                return false
            }
            let messageHtml = `<div class="incoming_msg">
                 <div class="incoming_msg_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                    <div class="received_msg">
                    <div class="received_withd_msg">
                        <p>${payload.body}</p>
                        <span class="time_date"> 11 AM    |    June 9</span></div>
                    </div>
                </div>`
            $('.msg_history').append(messageHtml);
        })
    }
}

export default client;