<template>
    <div>
        <leo-card class="leo-mb-md leo-break-words">{{
            mirrorKey ? mirrorKey : "key..."
        }}</leo-card>
        <leo-card class="leo-mb-md">{{
            mirrorToken ? mirrorToken : "token..."
        }}</leo-card>
        <leo-card class="leo-mb-md">
            <input type="file" @change="onChange" /><button @click="onClick">
                Upload!
            </button>
        </leo-card>
        <leo-card class="leo-mb-md" v-if="isLoading">
            <leo-skeleton-tile-button v-if="isLoading" class="leo-mb-md" />
            <div>generating emoji ...</div>
        </leo-card>
        <leo-card class="leo-mb-md" v-else-if="!isLoading && emoji.face.url">
            <div>ID: {{ emoji.face.id }}</div>
            <img :src="emoji.face.url" :alt="emoji.face.id" width="100%" />
        </leo-card>
        <div v-if="emoji.face.id && !isLoading">
            <sticker
                class="leo-mb-md"
                v-for="(sticker, i) in stickers"
                :key="i"
                :id="emoji.face.id"
                :stickerId="sticker"
            />
        </div>
    </div>
</template>

<script>
import { getToken, getEmoji } from "../api/";
import Sticker from "./Sticker";
export default {
    name: "Avatar",
    props: {},
    components: {
        Sticker,
    },
    beforeMount() {
        console.log("beforeMount");
        console.log("mirrorKey", this.mirrorKey);
        getToken().then((data) => {
            this.mirrorToken = data;
            console.log("mirrorToken", this.mirrorToken);
        });
    },

    data: () => ({
        mirrorKey: process.env.VUE_APP_MIRROR_KEY,
        mirrorToken: "",
        files: {},
        emoji: {
            face: {
                id: "",
                url: "",
                version: "",
            },
        },
        isLoading: false,
        isChanged: false,
        isChangedFaceId: false,
        stickers: [
            "selfie_in_the_elevator",
            "tears_of_happiness",
            "important_person",
            "love_glasses",
            "love_you_cake",
        ],
    }),
    methods: {
        onChange(event) {
            this.files = event.target.files[0];
        },
        onClick() {
            console.log("generating emoji....");
            if (this.files && this.isChanged) {
                this.isLoading = true;
                let formData = new FormData();
                formData.append("photo", this.files, this.files.name);
                getEmoji(this.mirrorToken, formData).then((data) => {
                    this.emoji = data;
                    this.isLoading = false;
                    this.isChanged = false;
                });
            }
        },
    },
    watch: {
        files: function (n, o) {
            this.isChanged = n !== o ? true : false;
        },
    },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
