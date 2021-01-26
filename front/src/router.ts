import { createWebHistory, createRouter } from 'vue-router'
import Page_SignIn from './components/SignIn.vue'
import Page_SignUp from './components/SignUp.vue'
import Page_404 from './components/404.vue'
import Page_Home from './components/Home.vue'
import Page_Dashboard from './components/Dashboard.vue'

const routes = [
    { path: '/', component: Page_Home },
    { path: '/signin', component: Page_SignIn },
    { path: '/signup', component: Page_SignUp },
    { path: '/dashboard', component: Page_Dashboard },
    { path: '/:pathMatch(.*)*', component: Page_404 }
];
const history = createWebHistory();

const router = createRouter({history, routes});

export default router;