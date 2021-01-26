class User {
    isAuthentificated: boolean = false;
    username: string = "";
    email: string = "";

    constructor() {
        this.isAuthentificated = false;
        this.username = "";
        this.email = "";
    }

    connect() {
        this.isAuthentificated = true;
    }

    disconnect() {
        this.isAuthentificated = false;
    }

    isConnected() {
        return this.isAuthentificated;
    }
}

let currentUser: User = new User();

export default currentUser;