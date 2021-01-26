class User {
    isAuthentificated: boolean = false;
    jwt: string = "";

    constructor() {
        this.isAuthentificated = false;
        this.jwt = "";
    }

    connect(jwt:string) {
        this.isAuthentificated = true;
        this.jwt = jwt;
    }

    disconnect() {
        this.isAuthentificated = false;
        this.jwt = "";
    }

    isConnected() {
        return this.isAuthentificated;
    }

    getJwt() {
        return this.jwt;
    }
}

let currentUser: User = new User();

export default currentUser;