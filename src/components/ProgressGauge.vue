<template>
  <div class="progress-gauge">
    <svg class="progress" width="120" height="120" viewBox="0 0 120 120"
      :style="{ strokeDashoffset: dashoffset, strokeDasharray: circumference }">
      <circle class="progress__meter" cx="60" cy="60" r="54" stroke-width="12" />
      <circle class="progress__value" cx="60" cy="60" r="54" stroke-width="12" />
    </svg>
    <!-- <input id="control" type="range" value="60" /> -->
  </div>
</template>

<script>
export default {
  name: 'progress-gauge',
  props: {
    value: Number,
    max: {
      // options
      // set default as 100
    }
    radius: Number
  },
  computed: {
    circumference () {
      return 2 * Math.PI * this.radius
    },
    progress () {
      return this.value / 100
    },
    dashoffset () {
      return this.circumference * (1 - this.progress)
    }
  },
  beforeCreate () {
    // var control = document.getElementById('control');
    // var progressValue = document.querySelector('.progress__value');

    // var RADIUS = 54;
    // var CIRCUMFERENCE = 2 * Math.PI * RADIUS;

    // function progress(value) {
    //   var progress = value / 100;
    //   var dashoffset = CIRCUMFERENCE * (1 - progress);
      
    //   console.log('progress:', value + '%', '|', 'offset:', dashoffset)
      
    //   progressValue.style.strokeDashoffset = dashoffset;
    // }

    // control.addEventListener('input', function(event) {
    //   progress(event.target.valueAsNumber);
    // });

    // progressValue.style.strokeDasharray = CIRCUMFERENCE;
    // progress(60);
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="less" scoped>
.progress-gauge {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  margin: auto;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  
  :first-child {
    margin-bottom: 20px;
  }
}
.progress {
  transform: rotate(-90deg);
}
.progress__meter,
.progress__value {
  fill: none;
}
.progress__meter {
  stroke: #e6e6e6;
}
.progress__value {
  stroke: #f77a52;
  stroke-linecap: round;
}
</style>
