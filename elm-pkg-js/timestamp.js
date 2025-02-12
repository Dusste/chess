exports.init = async function (app) {
  app.ports.onTimestamp.send(Date.now());
};
