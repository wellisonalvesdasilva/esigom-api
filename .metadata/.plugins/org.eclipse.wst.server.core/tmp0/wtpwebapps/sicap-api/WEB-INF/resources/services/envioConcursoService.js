/*(function () {
    'use strict';

    var serviceId = 'envioConcursoService';

    angular.module('app').factory(serviceId, ['$http', envioConcursoService]);

    function envioConcursoService($http) {

        var urlBase = '';

        var service = {
            consultar: function (dto) {
                var url = urlBase + 'consultar';
                return $http.post(url,dto);
            },
			cadastrar: function (dto) {
                var url = urlBase + 'cadastrar';
                return $http.post(url,dto);
            },
    		excluir: function (cod) {
                var url = urlBase + 'excluir';
                return $http.post(url,cod);
            },
            editar: function (cod) {
                var url = urlBase + 'editar';
                return $http.post(url,cod);
            },
        };

        return service;
    }
})();*/