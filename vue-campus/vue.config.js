const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  /*devServer: {
    proxy: {
      /!* '/oyx':  （紧跟端口号后面）
        指的是你发送给代理服务器的请求为
        http://localhost:8081/oyx/api/axiosTest
        该代理服务器才给你把请求转发给服务器
      *!/
      '/campus': {
        target: 'http://localhost:8888',
        pathRewrite: {'^/campus': ''}, //去掉路劲中的/oyx 最终给服务器的请求为http://localhost:8081/api/axiosTest
        //以下两配置默认为true
        ws: true, //用于支持websocket
        changeOrigin: true //为true，则表示该代理服务器会撒谎，服务器是多少端口号，代理服务器也说是多少。false则是实话实说
      }
    }
  }*/
})
