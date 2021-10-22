<template>
    <el-container>
      <el-header class="header"><h2>Back4Blood 牌組模擬器v1.0</h2></el-header>
        <el-container class="content">
            <el-main class="main">
            <el-row class="cardresult" :gutter="24">
                <el-col :span="12">
                <h4>選擇卡牌：</h4>
                <el-row  type="flex" justify="center" class="row-bg resultshowcard" :gutter="24" >
                    <el-col  :span="checkSelectedCardSpan()" v-for="(card,index) in cardselect" :key="index"  class="selectcard">
                        <el-card class="selectcard"  @click.native="removeCard(index)" :value="index" shadow="always"> 
                        <span style="color:red;">No.{{index + 1}}</span>:{{card.Name}} 
                        </el-card>
                    </el-col>
                </el-row>
                </el-col>
                <el-col :span="12">
                <h4>發動效果：</h4>
                <div class="selecteffect" v-for="(card,index) in cardselect" :key="index" >
                    <span style="color:#606266;">{{card.Name}}:</span>
                    <span :value="index">{{card.EffectDescription}}</span>
                </div>
                </el-col>
            </el-row>
            <el-row class="cardfilter" :gutter="24">
            <div>
                <el-checkbox-group v-model="cardfiltersGroup">
                <el-checkbox-button v-for="filter in cardfilters" :label="filter" :key="filter">{{filter}}</el-checkbox-button>
                </el-checkbox-group>
            </div>
      
            </el-row>
            <el-row class="cardpool" :gutter="24" >
                <el-col :span="checkCardSpan()" v-for="(card,index) in cardJsonFilter" :key="index">
                    <el-card class="box-card" :class="[checkCardSelect(card.Name) ? 'active' : '']" :value="index" @click.native="selectCard(card)" shadow="hover" >
                        <div slot="header" class="clearfix">
                        <span class="cardname">{{card.Name}}</span>
                        </div>
                        <div class="text item supplyline">
                        補給線:{{card.SuppyLine}}
                        </div>
                        <el-row  :gutter="24" >
                            <el-col :span="12" >
                                屬性:<span style="color:Crimson">{{card.Type}}</span>
                            </el-col>
                            <el-col :span="12" >
                                類型:<span style="color:Chocolate">{{card.Affinity}}</span>
                            </el-col>
                        </el-row>
                        <h4>效果：{{card.EffectDescription}}</h4>
                    </el-card>
                </el-col>
            </el-row>
            </el-main>
            <el-footer>
            本網站內所記載之遊戲相關稱呼、所引用之圖片以及資料之相關財產權皆歸屬於原始公司及單位。
            copyright 2021 橫隔膜
        </el-footer>
        </el-container>
        
    </el-container>
   
</template>

<script>
import json from '../json/data.json'

console.log(json)
const CarfiltersOption = ["進攻","防禦","實用","機動性","反射","紀律","腕力","運氣"]
export default {
  name: 'app',
  
  data() {
    return {
      cardJson: json.rows,
      cardselect:[],
      fullWidth: 0,
      fullHeight: 0,
      cardfilters:CarfiltersOption,
      cardfiltersGroup:["進攻","防禦","實用","機動性","反射","紀律","腕力","運氣"]
      
    }
  },
  watch:{
      cardfiltersGroup(){
          //this.cardJsonFilter()
      },
  },
  computed: {
    cardJsonTypeList () {
        return this.cardJson.map(card => card.Type)
    } ,
    cardJsonFilter () {
        return this.cardJson.filter(item => {
            return this.cardfiltersGroup.indexOf(item.Type) > -1 || this.cardfiltersGroup.indexOf(item.Affinity) > -1 
        })
    }
  },
  mounted() {
    const vm = this;
    vm.fullWidth = window.innerWidth
    vm.fullHeight = window.innerHeight
    window.onresize = () => {
      vm.fullWidth = window.innerWidth
      vm.fullHeight = window.innerHeight
    }

    console.log(this.cardJsonFilter)
  },
  methods:{
    selectCard(value){
      let _name = value.Name
      if(this.checkCardSelect(_name)){
        if(this.cardselect !== null){
          this.cardselect = (this.cardselect).filter(function(item) {
              return item.Name !== _name
          });
        }
      }else{
        if(this.cardselect.length < 15){
          this.cardselect.push(value)
        }
      }
    },
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
      })
      return checkresult
    },
    checkCardSpan(){
      let sapncount = 4
      if(this.fullWidth > 1200){
        sapncount = 4
        return sapncount
      }else if(this.fullWidth < 992){
        sapncount = 24
        return sapncount
      }
    },
    checkSelectedCardSpan(){
      let sapncount = 6
      if(this.fullWidth > 1200){
        sapncount = 8
        return sapncount
      }else if(this.fullWidth < 992){
        sapncount = 24
        return sapncount
      }
    }
  },
  destroyed () {
  
  }
}
</script>

<style lang="scss">
.header , .el-footer {
  background-color:#000;
  color: #ffff;
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
.cardresult{
    height: 35vh;
    max-height: 35vh;
    overflow: auto;
  }

.cardfilter{
    margin: 1%;
}

.cardpool{
    max-height: 40vh;
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

.box-card.active{
border-color: red;
}

.el-col-4 {
height: 400px;
}

.cardname{
font-size: 2em;
}

.supplyline{
font-size: 0.7em;
}

.selectcard .el-card__body{
padding: 2%;
}

.selecteffect{
font-size: 0.9em;
}

/* 中型設備（臺式電腦，992px 起） */
@media (max-width: 992px) { 
.el-col-20{
    width: 100% !important;
}

}

/* 大型設備（大臺式電腦，1200px 起） */
@media (min-width: 1200px) { 


}

</style>
