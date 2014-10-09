describe 'home controller', ( ) ->
	# Load the module with MainController
	beforeEach(module('jsworkshop'))

	# inject needed dependencies
	ctrl = null
	scope = null
	beforeEach inject( ($controller, $rootScope )->
		scope = $rootScope.$new()
		# Create the controller
		ctrl = $controller('HomeCtrl',
			$scope: scope
		)
	)

	it 'show get all results', ( ) ->
		expect( scope.search ).should.have.been.called
		#expect(scope.data.results).to.have.length.below(1000)
		#expect( true ).to.be.true


