import Vue from 'vue'
import App from './App.vue'
import LeoCommon from '@bit/great-eastern.leo-pattern-library-vue.leo-common';
import LeoCard from '@bit/great-eastern.leo-pattern-library-vue.leo-card';
import LeoSkeletonTileButton from '@bit/great-eastern.leo-pattern-library-vue.leo-skeleton-tile-button';
import Fragment from "vue-fragment";
// import { getToken } from './api/index';

// getToken();
Vue.config.productionTip = false
// Vue.config.devtools = true;
Vue.use(LeoCommon);
Vue.use(Fragment.Plugin);
Vue.component('leo-card', LeoCard);
Vue.component('leo-skeleton-tile-button', LeoSkeletonTileButton);

new Vue({
  render: h => h(App),
}).$mount('#app')
