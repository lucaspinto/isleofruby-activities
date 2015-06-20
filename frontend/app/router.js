import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.resource('activities');
  this.resource('activity', { path: '/activities/:activity_id' });
});

export default Router;
