AFRAME.registerComponent('enemy-hover-listener', {
  init: function () {
    var enemy = this.el;
    enemy.addEventListener('mouseenter', function() {
      enemy.parentNode.removeChild(enemy);
    });
  }
});
