'use strict';
var libQ = require('kew');

module.exports = ControllerBluetoothSwitch;

function ControllerBluetoothSwitch(context) {
	var self = this;
	self.context = context;
	self.commandRouter = self.context.coreCommand;
}

ControllerBluetoothSwitch.prototype.onVolumioStart = function() {
	var self = this;
	var configFile = self.commandRouter.pluginManager.getConfigurationFile(self.context, 'config.json');
	return libQ.resolve();
};

ControllerBluetoothSwitch.prototype.onStart = function() {
    // Aquí podrías poner lógica extra, pero el install.sh ya hizo todo el trabajo
	var self = this;
	return libQ.resolve();
};

ControllerBluetoothSwitch.prototype.onStop = function() {
	var self = this;
	return libQ.resolve();
};