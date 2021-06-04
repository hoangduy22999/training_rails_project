// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "bootstrap";
import "../stylesheets/application.scss";
import 'select2'
import 'select2/dist/css/select2.css'
import "@fortawesome/fontawesome-free/css/all.min";
require('admin-lte');
//= require select2

Rails.start()
Turbolinks.start()
ActiveStorage.start()
require("channels")

var jQuery = require("jquery");
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;




