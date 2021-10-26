<template>
  <div id="app">
    
    <Card/>
  </div>
</template>

<script>
import Card from './components/Card.vue'

export default {
  name: 'App',
  components: {
    Card
  },
  metaInfo: {
    title: 'Back4Blood 卡片配置工具',
    titleTemplate: '%s',
    htmlAttrs: {
      lang: 'zh'
    }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #303133;
}
</style>
