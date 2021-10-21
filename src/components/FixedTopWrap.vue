<template lang="html">
  <!--置頂條目父佈局-->
  <div id="fix-scroll-watch" ref="fixScrollWatch" class="fixScrollWatch" :style="fixStyle"> <!--用於監聽滾動位置-->
    <div ref="topFixBarFixed" :class="topFixBarFixed ? 'topFixBarFixed' : ''" class="fix-index"> <!--用於固定位置-->
      <slot/> <!--實際內容-->
    </div>
  </div>
</template>

<script>
/**
  * 〖Author〗 MiWi.LIN ＾＾＾＾〖E-mail〗 80383585@qq.com
  * ======================================================== Copyright(c) 2018/11/23 ==
  * 〖Version〗 1.0 <BR/>
  * 〖Date〗 2018/11/23_下午4:31 <BR/>
  * 〖Desc〗 自動固頂 <BR/>
  * 〖Modify By〗 <BR/>
  */
export default {
  data() {
    return {
      topFixBarFixed: false,
      isMounted: false,
    };
  },
  computed: {
    fixStyle() {
      if (this.isMounted) {
        const h = this.$refs.topFixBarFixed.offsetHeight;
        return { height: `${h}px` };
      }
      return {};
    },
  },
  methods: {
    handleScroll() {
      const scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop;
      // const fix = document.querySelector('#fix-scroll-watch');
      const fix = this.$refs.fixScrollWatch;
      const offsetTop = fix ? fix.offsetTop : 0;
      this.topFixBarFixed = scrollTop > offsetTop;
    },
  },
  mounted() {
    this.isMounted = true;
    window.addEventListener('scroll', this.handleScroll);
  },
  destroyed() {
    window.removeEventListener('scroll', this.handleScroll);
  },
};
</script>

<style scoped lang="postcss">
  .fixScrollWatch {
    & .fix-index {
        z-index: 99;
        background-color: white;
      }
    & .topFixBarFixed {
      width: 100%;
      position: fixed;
      top: 0;
    }
  }