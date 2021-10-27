<template>
    <el-container>
      <el-header class="header">
        <h2>Back4Blood 牌組模擬器v1.1</h2>
      </el-header>
        <el-container class="content">
            <el-main class="main">
            <el-button type="text" @click="centerDialogVisible = true">分享牌組</el-button>
                <el-dialog
                title="請複製以下資訊"
                :visible.sync="centerDialogVisible"
                width="30%"
                center>
                <el-input
                type="textarea"
                :rows="10"
                placeholder="请输入内容"
                v-model="shareCaddSet" >
                </el-input>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="centerDialogVisible = false">關閉</el-button>
                </span>
            </el-dialog>
            
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
                  <h4>正面增益：</h4>
                  <div class="selecteffect" v-for="(card,index) in cardselect" :key="'selectedbuff_'+index" >
                      <span style="color:#606266;" v-if="card.Buff !== 0">{{card.Name}}:</span>
                      <span :value="'selectedbuff_'+index" v-if="card.Buff !== 0">{{card.Buff}}</span>
                  </div>  
                  <h4>負面增益：</h4>
                  <div class="selecteffect" v-for="(card,index) in cardselect" :key="'selecteddebuff_'+index" >
                      <span style="color:#606266;" v-if="card.DeBuff !== 0">{{card.Name}}:</span>
                      <span :value="'selecteddebuff_'+index" v-if="card.DeBuff !== 0">{{card.DeBuff}}</span>
                  </div>   
                  <h4>原始發動效果：</h4>
                  <div class="selecteffect" v-for="(card,index) in cardselect" :key="'selected_'+index" >
                      <span style="color:#606266;">{{card.Name}}:</span>
                      <span :value="'selected_'+index">{{card.EffectDescription}}</span>
                  </div>                 
                </el-col>
            </el-row>
            <span>目前總牌數：{{countCard}}/{{allcardcount}}</span>
            <el-row class="cardfilter" :gutter="24">
              <el-col :span="12">
                <el-checkbox-group v-model="cardfiltersGroup">
                <el-checkbox-button v-for="filter in cardfilters" :label="filter" :key="filter">{{filter}}</el-checkbox-button>
                </el-checkbox-group>
              </el-col>
              <el-col :span="12">
                <el-checkbox-group v-model="supplyfiltersGroup">
                <el-checkbox-button v-for="filter in supplyfilter" :label="filter" :key="filter">{{filter}}</el-checkbox-button>
                </el-checkbox-group>
              </el-col>
            </el-row>
            <el-row class="cardpool" :gutter="24" >
                <el-col :span="checkCardSpan()" v-for="(card,index) in cardJsonFilter" :key="index">
                    <el-card class="box-card" :class="[checkCardSelect(card.Name) ? 'active' : '']" :value="index" @click.native="selectCard(card)" shadow="hover" >
                        <div slot="header" class="clearfix">
                        <span class="cardname">{{card.Name}}</span>
                        </div>
                        <div class="text item supplyline">
                        補給線:{{card.SuppyLine}} 花費點數:<span style="color:red">{{card.CardCost}}</span>
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
import supplyline_json from '../json/supplyline.json'
const CarfiltersOption = ["進攻","防禦","實用","機動性","反射","紀律","腕力","運氣"]
const supplyfilterOption = ["上層補給線","中間補給線","下層補給線","其他"]

export default {
  name: 'app',
  data() {
    return {
      cardJson: json.rows,
      supplyJson: supplyline_json[0],
      cardselect:[],
      fullWidth: 0,
      fullHeight: 0,
      centerDialogVisible: false,
      allcardcount : 156,
      cardfilters:CarfiltersOption,
      supplyfilter:supplyfilterOption,
      cardfiltersGroup:["進攻","防禦","實用","機動性","反射","紀律","腕力","運氣"],
      supplyfiltersGroup:["上層補給線","中間補給線","下層補給線","其他"]
    }
  },
  watch:{
    supplyfiltersGroup(){
      
    },
    cardfiltersGroup(){
        //this.cardJsonFilter()
    },
    cardJson(){
    }
  },
  computed: {
    cardJsonTypeList () {
        return this.cardJson.map(card => card.Type)
    },
    countCard (){
      let count = 0
      count = this.cardJsonFilter.length
      return count
    },
    cardJsonFilter () {
      var filtercard = this.cardJson.filter((card) => {
        return this.cardfiltersGroup.indexOf(card.Type) > -1 && this.cardfiltersGroup.indexOf(card.Affinity) > -1
      })
      let resultfiltercard = []
      for(let filteritem of this.supplyfiltersGroup){
        let _filtercard = filtercard.filter((card) => {
          return this.supplyJson[filteritem].indexOf(card.SuppyLine) > -1 
        })
        resultfiltercard = resultfiltercard.concat(_filtercard)
      }
      return resultfiltercard
    },
    supplyJsonFilter () {
      return this.supplyfilter.filter(item =>{
        return this.cardJson.filter(card => {
          
          return this.supplyJson[item].indexOf(card.SuppyLine) > -1 
        })
      })
    },
    shareCaddSet () {
        let shareString = ''
        if(this.cardselect.length === 0) shareString = '請選擇卡片。'
        shareString += "《分享牌組》\n"
        this.cardselect.forEach(function(card,index){
            shareString += index + " " + card.Name + "\n"
        })
        shareString += "《正面增益》\n"
        this.cardselect.forEach(function(card,index){
          if(card.Buff !== 0){
            shareString += index + " " + card.Buff + "\n"
          }
        })
        shareString += "《負面增益》\n"
        this.cardselect.forEach(function(card,index){
          if(card.DeBuff !== 0){
            shareString += index + " " + card.DeBuff + "\n"
          }
        })
        shareString += "《全部牌組效果》\n"
        this.cardselect.forEach(function(card,index){
            shareString += index + " " + card.EffectDescription + "\n"
        })
        return shareString
    },
  },
  mounted() {
    const vm = this;
    vm.fullWidth = window.innerWidth
    vm.fullHeight = window.innerHeight
    window.onresize = () => {
      vm.fullWidth = window.innerWidth
      vm.fullHeight = window.innerHeight
    }
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
  height:calc(100vh - 30px);
  .aside {
    width: 200px;
  }
  .main {
    background-color: #e8e5e5;
  }
}
.cardresult{
    height: 25vh;
    max-height: 25vh;
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

@media (max-width: 992px) { 
.el-col-20{
    width: 100% !important;
}
.el-dialog{
    width: 80vw !important;
}

}

@media (min-width: 1200px) { 


}

</style>
