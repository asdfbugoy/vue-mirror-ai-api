import axios from 'axios';
// import mine from 'mime';
const host = 'mirror-ai.p.rapidapi.com';
const key = process.env.VUE_APP_MIRROR_KEY;
export const fetchToken = async () => {
    const url = 'https://mirror-ai.p.rapidapi.com/token';
    // const url = 'https://jsonplaceholder.typicode.com/todos/1';
    try {
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'X-Rapidapi-Key': key,
                'X-rapidapi-Host': host,
            },
        });
        const data = await response.json();
        if (!response.ok) throw new Error(response.status);
        return data;
    } catch (err) {
        // console.error(err);
        throw new Error(err);
    }
};

export const getToken = async () => {
    if (localStorage.getItem('mirror-token')) return await localStorage.getItem('mirror-token');
    else
        return await fetchToken().then(data => {
            data.ok && localStorage.setItem('mirror-token', data.token);
            return data.token;
            // return localStorage.getItem('token');
        })
}

export const getEmoji = async (token, form) => {
    const url = 'https://mirror-ai.p.rapidapi.com/generate';
    try {
        let response = await fetch(url, {
            method: 'POST',
            headers: {
                'X-Rapidapi-Key': key,
                'X-Rapidapi-Host': host,
                "X-Token": token,
                // "Content-Type": "multipart/form-data",
            },
            body: form
        });
        const data = await response.json();
        if (!response.ok) throw new Error(response.status);
        return await data;
    } catch (err) {
        // console.error(err);
        throw new Error(err);
    }
};

export const getEmojiAxios = async (form) => {
    const url = 'https://mirror-ai.p.rapidapi.com/generate';
    let response = await axios(url, {
        method: "POST",
        headers: {
            "x-rapidapi-host": host,
            "x-rapidapi-key": key,
            // "content-type": "multipart/form-data",
            "x-token": getToken()
        },
        data: form
    });
    console.log(response);
};

export const getSticker = async (token, params) => {
    let url = 'https://mirror-ai.p.rapidapi.com/sticker';
    url += '?' + (new URLSearchParams(params)).toString();
    console.log(url);
    try {
        let response = await fetch(url, {
            method: 'GET',
            headers: {
                'X-Rapidapi-Key': key,
                'X-Rapidapi-Host': host,
                "X-Token": token,
                // "Content-Type": "multipart/form-data",
            },
        });
        const data = await response.json();
        if (!response.ok) throw new Error(response.status);
        return await data;
    } catch (err) {
        // console.error(err);
        throw new Error(err);
    }
};