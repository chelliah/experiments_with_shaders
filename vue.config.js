module.exports = {
  chainWebpack: config => {
    // GraphQL Loader
    config.module
      .rule('glsl')
      .test(/\.glsl$/)
      .use('webpack-glsl-loader')
      .loader('webpack-glsl-loader')
      .end()
  }
}
