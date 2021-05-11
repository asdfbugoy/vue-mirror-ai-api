module.exports = {
  pluginOptions: {
    cordovaPath: 'src-cordova'
  },
  publicPath: process.env.NODE_ENV === 'production'
    ? '/hello-world/'
    : '/'
}
