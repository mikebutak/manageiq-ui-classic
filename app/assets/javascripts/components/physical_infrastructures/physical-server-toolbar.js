ManageIQ.angular.app.component('physicalServerToolbar', {
  bindings: {
    physicalServerId: '=?',
  },
  controllerAs: 'toolbar',
  controller: physicalServerToolbarController,
});

physicalServerToolbarController.$inject = ['API', 'miqService'];

function physicalServerToolbarController(API, miqService) {
  var toolbar = this;

  ManageIQ.angular.rxSubject.subscribe(function(event) {
    toolbar.action = event.type;

    if (toolbar.action) {
      if (toolbar.physicalServerId) {
        toolbar.servers = _.union(toolbar.servers, [toolbar.physicalServerId]);
      } else {
        toolbar.servers = ManageIQ.gridChecks;
      }
      postPhysicalServerAction();
    }
  });

  // private functions
  function postPhysicalServerAction() {
    _.forEach(toolbar.servers, function(serverId) {
      API.post('/api/physical_servers/' + serverId, { action: toolbar.action })
        .then(postAction)
        .catch(miqService.handleFailure);
    });
  }

  function postAction(response) {
    miqService.miqFlashLater({ message: response.message });
    miqService.miqFlashSaved();

    // To be used later when testing with real Physical servers is complete
    // if (vm.servers.length > 1) {
    //   miqService.miqFlash('success', sprintf(__("Requested Server state %s for the selected servers"), vm.action));
    // } else {
    //   miqService.miqFlash('success', sprintf(__("Requested Server state %s for the selected server"), vm.action));
    // }
  }
}
