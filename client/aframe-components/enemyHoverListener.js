AFRAME.registerComponent('enemy-hover-listener', {
  init: function () {
    var enemy = this.el;
    enemy.addEventListener('mouseenter', function() {
      window.elmApp.ports.fromJs.send("[]");
    });
  }
});
