import { createWebHistory, createRouter } from 'vue-router'
import Page_SignIn from './components/SignIn.vue'
import Page_SignUp from './components/SignUp.vue'
import Page_404 from './components/404.vue'
import Page_Home from './components/Home.vue'
import Page_Dashboard from './components/Dashboard.vue'
import Page_Profile from './components/Profile.vue'
import currentUser from './services/UserService'

const routes = [
    { path: '/', component: Page_Home },
    { path: '/signin', component: Page_SignIn },
    { path: '/signup', component: Page_SignUp },
    { path: '/dashboard', component: Page_Dashboard },
    { path: '/profile', component: Page_Profile },
    { path: '/:pathMatch(.*)*', component: Page_404 }
];
const history = createWebHistory();

const router = createRouter({history, routes});

router.beforeEach((to, from, next) => {
    console.log(to.fullPath);
    if (to.fullPath == "/signout") {
        currentUser.disconnect();
        console.log('User disconnected');
        localStorage.clear();
        next('/signin');
    } else if (!currentUser.isConnected() && (to.fullPath == '/dashboard' || to.fullPath == '/profile')) {
        console.log("Unauthorized Route. You need to connect.");
        next('/signin')
    } else if (currentUser.isConnected() && (to.fullPath == '/signup' || to.fullPath == '/signin')) {
        console.log("You are already connected.");
        next('/dashboard')
    } else {
        console.log("Just a regular redirection.");
        next()
    }
});

export default router;