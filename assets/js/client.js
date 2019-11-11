let client = {

    init(socket) {
        let channel = socket.channel('room:lobby', {})
        channel.join()
        this.listenForChats(channel)
    },

    listenForChats(channel) {

        document.getElementById('btnPost').addEventListener('click', function(e) {
            e.preventDefault()
            let userMsg = document.getElementById('user-msg').value
            channel.push('shout', { body: userMsg })
            document.getElementById('user-msg').value = '';
        })

        channel.on('shout', payload => {
            let chatBox = document.querySelector('#chat-box')
            let msgBlock = document.createElement('p')

            msgBlock.insertAdjacentHTML('beforeend', `${payload.body}`)
            chatBox.appendChild(msgBlock)
        })
    }
}

export default client;