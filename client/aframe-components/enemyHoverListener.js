AFRAME.registerComponent('enemy-hover-listener', {
  init: function () {
    var enemy = this.el;
    this.el.addEventListener('mouseenter', function() {
      var enemyId = this.getAttribute("data-id");
      var action = {
        type_: "REMOVE_ENEMY_REQUEST",
        payload: enemyId
      };
      window.elmApp.ports.fromJs.send(JSON.stringify(action));
    });
  }
});
