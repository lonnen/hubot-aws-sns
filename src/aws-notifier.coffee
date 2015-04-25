# Description:
#   receives messages from AWS SNS topic for cloudwatch
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# URLS:
#   POST /aws-sns/:room
#
# Author:
#   jasonthomas
#   lonnen

irc = require('irc')
SNSClient = require('aws-snsclient')

module.exports = (robot) ->
    robot.router.post '/aws-sns/:room', (req, res) ->
        room = req.params.room
        auth =
            verify: false

        client = SNSClient(auth, (err, message) ->
            throw err if err

            if message.Subject.match /OK/
                state_color = 'light_green'
            else if message.Subject.match /ALARM/
                state_color = 'light_red'
            else
                state_color = 'orange'

            state = irc.colors.wrap(state_color, message.Subject)
            reason = irc.colors.wrap('white', JSON.parse(message.Message).NewStateReason)

            robot.messageRoom "##{room}", "#{state}: #{reason}"
        )

        client(req, res)
        res.end()
        
