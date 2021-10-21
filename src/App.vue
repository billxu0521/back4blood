<template>
  <div id="app">
    <el-container>
      <el-header class="header">B4B 配卡器</el-header>
      <el-container class="content">
        <el-main class="main">
          <el-row class="cardresult" :gutter="20">
            <el-col :span="10">
              <h4>選擇卡牌：</h4>
              <el-row  type="flex" justify="center" class="row-bg resultshowcard" :gutter="18" >
                  <el-col  :span="6" v-for="(card,index) in cardselect" :key="index"  class="selectcard">
                    <el-card  @click.native="removeCard(index)" :value="index" shadow="always"> 
                      {{card.Name}}
                    </el-card>
                </el-col>
              </el-row>
            </el-col>
              <el-col :span="10">
              <div id="cardeffect">發動效果：</div>
              <div v-for="(card,index) in cardselect" :key="index" >
                <span style="color:#606266">{{card.Name}}:</span>
                <span :value="index">{{card.EffectDescription}}</span>
              </div>
            </el-col>
          </el-row>
          <el-row class="cardpool" :gutter="20" >
            <el-col :span="4" v-for="(card,index) in cardJson" :key="index" >
              <el-card class="box-card" @click.native="addCard(card)" shadow="hover" >
                <div slot="header" class="clearfix">
                  <span>{{card.Name}}</span>
                </div>
                <div class="text item supplyline">
                  {{card.SuppyLine}}
                </div>
                <div class="text item effectdescription">
                效果：{{card.EffectDescription}}
                </div>
              </el-card>
            </el-col>
          </el-row>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>
import json from './json/data.json'

console.log(json)

export default {
  name: 'app',
  
  data() {
    return {
      cardJson: json.rows,
      cardselect:[],
    }
  },
  mounted() {
    
  },
  methods:{
    removeCard(value){
      if(this.cardselect !== null){
        (this.cardselect).splice(value, 1)
      }
    },
    addCard(value){
      console.log('addcard')
      let _name = value.Name
      if(this.checkCardSelect(_name)) return
      if(this.cardselect.length < 15){
        this.cardselect.push(value)
      }
      
    },
    checkCardSelect(value){
      let checkresult = false
      this.cardselect.forEach(function(values){
        if(values.Name === value){
          checkresult = true
        }
      });
      return checkresult
    }
   
  },
  destroyed () {
  
  }
}
</script>

<style lang="scss">
.header {
  background-color: #0fb0ef;
}
.content {
  height:calc(100vh - 50px);
  .aside {
    width: 200px;
  }
  .main {
    background-color: #e8e5e5;
  }
}

  .image {
    width: 100%;
    display: block;
  }

  .clearfix:before,
  .clearfix:after {
      display: table;
      content: "";
  }
  
  .clearfix:after {
      clear: both
  }

  .cardresult{
    height: 40vh;
    max-height: 40vh;
    overflow: auto;
  }

  .cardpool{
    max-height: 50vh;
    overflow: auto;
  }

  .supplyline{
    background: #E4E7ED;
  }

  .effectdescription{
    color: #303133;
  }

  .resultshowcard{
    flex-wrap: wrap;    
  }
</style>
