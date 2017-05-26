AFRAME.registerComponent('model-animation', {
  init: function () {
    this.el.addEventListener('model-loaded', function(evt) {
      evt.detail.model.traverse(function(child) {
        if (child instanceof THREE.SkinnedMesh) {
          var animation = new THREE.Animation( child, child.geometry.animation );
          animation.play();
        }
      });
    });
  },

  tick: function (t, dt) {
    if (THREE.AnimationHandler) {
      THREE.AnimationHandler.update(dt / 1000);
    }
  }
});
