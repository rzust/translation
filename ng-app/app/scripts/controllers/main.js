'use strict';

/**
 * @ngdoc function
 * @name ngAppApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the ngAppApp
 */
angular.module('ngAppApp')
  .controller('MainCtrl', function ($scope) {

  }).controller('ContactCtrl', function ($scope, $http, ngProgress) {
    this.formParams = {};
    this.submitted = false;
    var contact = this;
    this.sendMessage = function(isValid){
      ngProgress.color('#35bdf6');
      if (isValid) {
        ngProgress.start();
        // $http({method: 'POST', url: '/api/v1/forward_quote', data: this.formParams})
        // .success(function(data, status) {
        //   contact.sender     = data.name;
        //   contact.submitted  = true;
        //   contact.formParams = {};
        // })
        // .error(function(data, status) {
        //
        // });
        contact.sender     = this.formParams.name;
        contact.submitted  = true;
        contact.formParams = {};
        ngProgress.complete();
      }
    };

    $('.main-flex-slider').flexslider({
      slideshowSpeed: 5000,
      directionNav: false,
      animation: "fade",
      controlNav:false
    });

    var myLatlng;
    var map;
    var marker;

    myLatlng = new google.maps.LatLng(51.4528336, -0.9796824999999671);

    var mapOptions = {
      zoom: 13,
      center: myLatlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      scrollwheel: false,
      draggable: false
    };

    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

    var contentString = '<p style="line-height: 20px;"><strong>Banzhow Template</strong></p><p>123 My Street, Banzhow City, CA 4567</p>';

    var infowindow = new google.maps.InfoWindow({
        content: contentString
    });

    marker = new google.maps.Marker({
        position: myLatlng,
        map: map,
        title: 'Marker'
    });

    angular.element(document).ready(function () {
      google.maps.event.addListener(marker, 'click', function() {
          infowindow.open(map, marker);
      });
    });


  });
