<template>
    <leo-card class="leo-mb-md" v-if="isLoading">
        <leo-skeleton-tile-button class="leo-mb-md" />
        <div>generating sticker ...</div>
    </leo-card>
    <leo-card v-else class="leo-mb-md">
        <div>{{ id }}</div>
        <div class="leo-mb-md">STICKER ID: {{ stickerId }}</div>
        <div><img width="100%" v-if="url" :src="url" :alt="stickerId" /></div>
    </leo-card>
</template>

<script>
import { getSticker } from "../api/";
export default {
    name: "Sticker",
    props: {
        id: String,
        stickerId: String,
    },
    components: {},
    beforeMount() {
        this.isLoading = true;
        getSticker(localStorage.getItem("mirror-token"), this.getParams()).then(
            (data) => {
                this.url = data.ok && data.url;
                this.isLoading = false;
            }
        );
    },

    data: () => ({
        url: "",
        isLoading: false,
    }),
    methods: {
        getParams() {
            return {
                face_id: this.id,
                sticker: this.stickerId,
            };
        },
    },
    watch: {
        id: function (n, o) {
            if (n !== o) {
                alert("id was changed!");
                this.isLoading = true;
                getSticker(
                    localStorage.getItem("mirror-token"),
                    this.getParams()
                ).then((data) => {
                    this.url = data.ok && data.url;
                    this.isLoading = false;
                });
            } else {
                alert("id is same!");
            }
        },
    },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
