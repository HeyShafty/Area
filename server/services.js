class Action {
    constructor(name, description) {
        this.name = name;
        this.description = description;
    }
}

class Reaction {
    constructor(name, description) {
        this.name = name;
        this.description = description;
    }
}

class Service {
    constructor(name, actions, reactions) {
        this.name = name;
        this.actions = actions;
        this.reactions = reactions;
    }
}

const AREA_SERVICES = [
    new Service('microsoft', [
        new Action('incoming_mail', 'Triggers when receiving an email')
    ], [
        new Reaction('send_mail', 'Sends an email')
    ]),
    new Service('twitter', [
        new Action('new_tweet_from', 'Triggers when a user tweets'),
        new Action('new_follower', 'Triggers when someone starts following you')
    ], [
        new Reaction('post_tweet', 'Post a new tweet'),
        new Reaction('update_bio', 'Updates your bio')
    ]),
    new Service('discord', [], [
        new Reaction('post_message', 'Posts a message in a specific location')
    ]),
    new Service('github', [
        new Action('new_issue', 'Triggers when a new issue is added'),
        new Action('new_repository', 'Triggers when a repository is created'),
        new Action('new_pull_request', 'Triggers when a new pull request is posted'),
        new Action('issue_closes', 'Triggers when an issue is closed')
    ], [
        new Reaction('open_issue', 'Opens a new issue')
    ]),
    new Service('timer', [
        new Action('every_hour', 'Triggers every hour'),
        new Action('every_day', 'Triggers everyday')
    ], [])
];

module.exports = AREA_SERVICES;
