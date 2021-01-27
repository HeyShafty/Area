class User {
    isAuthenticated: boolean = false;
    jwt: string = "";

    constructor() {
        const storedJwt = localStorage.getItem("jwt");

        if (storedJwt != null) {
            this.isAuthenticated = true;
            this.jwt = storedJwt;
        } else {
            this.isAuthenticated = false;
            this.jwt = "";
        }
    }

    connect(jwt:string) {
        this.isAuthenticated = true;
        this.jwt = jwt;
        localStorage.setItem("jwt", jwt);
    }

    disconnect() {
        this.isAuthenticated = false;
        this.jwt = "";
        localStorage.removeItem("jwt");
    }

    isConnected() {
        return this.isAuthenticated;
    }

    getJwt() {
        return this.jwt;
    }
}

let currentUser: User = new User();

export default currentUser;