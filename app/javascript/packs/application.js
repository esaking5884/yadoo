// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
//Turbolinks.start()
ActiveStorage.start()
require("jquery")

$(function() {
  $('.slider').slick({
    dots: true,
    autoplay: true,
    autoplaySpeed: 3000,
    infinite: true,
    speed: 500,
    fade: true,
    cssEase: 'linear',
    pauseOnHover: false,//マウスホバーで一時停止
    pauseOnDotsHover: false//ドットナビをマウスホバーで一時停止
  });
});